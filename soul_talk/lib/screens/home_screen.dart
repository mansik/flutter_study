import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:soul_talk/consts/gemini_api.dart';
import 'package:soul_talk/models/message_model.dart';
import 'package:soul_talk/widgets/chat_text_field.dart';
import 'package:soul_talk/widgets/date_divider.dart';
import 'package:soul_talk/widgets/logo.dart';
import 'package:soul_talk/widgets/message.dart';

final sampleData = [
  MessageModel(
    id: 1,
    isMine: true,
    message: "Recommend me something to eat for dinner tonight.",
    point: 1,
    date: DateTime(2025, 03, 05),
  ),
  MessageModel(
    id: 2,
    isMine: false,
    message: "How about kimchi stew?",
    point: null,
    date: DateTime.now(),
  ),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController textController = TextEditingController();

  // 코드로 자동으로 스크롤하기 위해 scrollController 선언한다.
  final ScrollController scrollController = ScrollController();

  // 로딩여부를 확인하는 변수
  bool isRunning = false;

  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // MessageModel 컬렉션에 업데이트가 있을 때마다
            // ListView를 다시 그리기 위해서 StreamBuilder를 사용한다.
            Expanded(
              child: StreamBuilder<List<MessageModel>>(
                // 모든 데이터를 가져오는 쿼리에 대해(where()), 스트림을 만들고(watch()),
                // 스트림이 시작되는 즉시 현재 데이터 스냅샷을 방출하고(fireImmediately: true),
                // 이후에는 데이터가 변경될 때마다 변경된 데이터를 스트림을 통해 방출한다(fireImmediately: true).
                stream: GetIt.I<Isar>().messageModels.where().watch(
                  fireImmediately: true,
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error loading messages: ${snapshot.error}'),
                    );
                  }

                  final messages = snapshot.data ?? [];

                  // WidgetsBinding.instance.addPostFrameCallback() 함수를 사용하여
                  // 현재 build()가 끝나고 딱 한 번만 콜백 함수를 실행한다.
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) async => scrollToBottom(),
                  );

                  return buidMessageList(messages);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 32.0,
              ),
              child: ChatTextField(
                controller: textController,
                onSend: handleSendMessage,
                errorText: errorMessage,
                loading: isRunning,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ListView의 가장 아래로 이동하는 함수
  void scrollToBottom() {
    // 현재 위치가 최대 스크롤 가능 위치가 아닐 때만 실행한다.
    if (scrollController.position.pixels !=
        scrollController.position.maxScrollExtent) {
      // 원하는 위치까지 스크롤을 가능하도록 하는 함수
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        // 300ms에 걸쳐서 스크롤 애니메이션을 실행한다.
        curve: Curves.easeOut, // 애니메이션이 끝날수록 느려지는 유형으로 실행한다.
      );
    }
  }

  /// 1. 내가 제미나이에 보낸 메시지를 Isar에 저장
  /// 2. 제미나이에 보낼 데이터를 만들기
  ///
  // 메시지 보내기 버튼을 누르면 실행할 함수
  handleSendMessage() async {
    // TextField에 입력된 메시지가 없으면 에러 보여주기
    if (textController.text.isEmpty) {
      setState(() => errorMessage = 'please enter a message!');
      return;
    }

    // 현재 응답받고 있는 메시지 ID(스트림으로 지속적으로 업데이트하기)
    int? currentModelMessageId;

    // 내가 보낸 메시지에 배정된 ID(에러가 발생하면 삭제)
    int? currentUserMessageId;

    // Isar 인스턴스 가져오기
    final isar = GetIt.I<Isar>();

    // TextField에 입력된 값 가져오기
    final currentPrompt = textController.text;

    try {
      // 로딩 중으로 상태 변경
      setState(() {
        isRunning = true;
      });

      // TextField에 입력된 값 모두 삭제
      textController.clear();

      // 현재 데이터베이스에 저장되어 있는 내가 보낸 메시지 숫자 세기(포인터용)
      final currentUserMessageCount =
          await isar.messageModels.filter().isMineEqualTo(true).count();

      // 내가 보낸 메시지 Isar에 저장하기
      currentUserMessageId = await isar.writeTxn(() async {
        return await isar.messageModels.put(
          MessageModel(
            isMine: true,
            message: currentPrompt,
            point: currentUserMessageCount + 1,
            date: DateTime.now(),
          ),
        );
      });

      // 최근 5개의 메시지만 불러오기
      final recentMessages =
          await isar.messageModels.where().limit(5).findAll();

      // 최근 메시지를 Content로 변환하기
      final List<Content> promptContext =
          recentMessages
              .map(
                (e) => Content(
                  // Role 지정하기
                  e.isMine ? 'user' : 'model',
                  // 문자 메시지를 제공하려면 TextPart 클래스를 사용
                  [TextPart(e.message)],
                ),
              )
              .toList();

      // https://ai.google.dev/gemini-api/docs
      // https://pub.dev/packages/google_generative_ai
      final model = GenerativeModel(
        // 사용하려는 모델을 정의
        model: 'gemini-2.0-flash',
        apiKey: GeminiApi.geminiApiKey,
        // 제미나이가 어떤 역할을 해야 하는지 정의
        systemInstruction: Content.system(
          "From now on, you'll be a kind and friendly friend.",
        ),
      );

      /// 3. 제미나이에게 메시지를 보내고 응답을 Isar에 저장
      ///
      // Stream으로 받아지는 메시지를 지속적으로 추가할 문자열
      String responseMessage = '';

      // generateContentStream을 실행하면 Stream으로 응답을 받을 수 있다.
      model
          .generateContentStream(promptContext)
          .listen(
            (event) async {
              // 응답 메시지가 있다면 message 변수를 추가한다.
              if (event.text != null) {
                responseMessage += event.text!;
              }

              // message 변수를 기반으로 MessageModel을 생성한다.
              final modelMessage = MessageModel(
                isMine: false,
                message: responseMessage,
                //point: null,
                date: DateTime.now(),
              );

              /// Stream으로 데이터를 받아오면 한 번에 응답이 오지 않고 부분 부분으로 나워서 응답을 받는다.
              /// Isar 데이터베이스의 put() 함수는 id를 제공하지 않을 경우 새로운 데이터를 생성하고
              /// id를 제공할 경우 기존 Irar 데이터를 업데이트 한다.
              /// 응답이 부분 부분 올 때마다 새로운 Isar 데이터를 매번 생성하면 안 되니 처음 데이터를 생성한 후에는
              /// 존재하는 데이터에 메시지를 업데이트 한다.
              ///
              // 이미 메시지를 생성한 적이 있다면 model 변수에 id 퍼로퍼티를 추가한다.
              if (currentModelMessageId != null) {
                modelMessage.id = currentModelMessageId!;
              }

              // 메시지를 저장하고 반환받은 ID값을 currentModelMessageId에 할당한다.
              currentModelMessageId = await isar.writeTxn<int>(
                () => isar.messageModels.put(modelMessage),
              );
            },

            // Stream이 끝나면 로딩 상태를 변경한다.
            onDone:
                () => setState(() {
                  isRunning = false;
                }),

            // Stream이 끝나면 로딩 상태를 변경한다.
            onError: (e) async {
              await isar.writeTxn(() async {
                return isar.messageModels.delete(currentUserMessageId!);
              });
              setState(() {
                isRunning = false;
                errorMessage = e.toString();
              });
            },
          );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  // 화면에 보여줄 메시지 리스트
  Widget buidMessageList(List<MessageModel> messages) {
    return ListView.separated(
      controller: scrollController, // ListView의 스크롤을 제어하는 컨트롤러
      itemCount: messages.length + 1,
      itemBuilder:
          (context, index) =>
              index == 0
                  ? buildLogo()
                  : buildMessageItem(
                    prevMessage: index > 1 ? messages[index - 2] : null,
                    message: messages[index - 1],
                    index: index - 1,
                  ),
      separatorBuilder: (_, _) => const Divider(height: 16.0),
    );
  }

  /// buildLogo Widget
  Widget buildLogo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: const Padding(
        padding: EdgeInsets.only(bottom: 60.0),
        child: Logo(),
      ),
    );
  }

  Widget buildMessageItem({
    MessageModel? prevMessage,
    required MessageModel message,
    required int index,
  }) {
    final isMine = message.isMine;
    // DataDivider 위젯을 그려야 하는지 판단하기
    final shouldDrawDateDivider =
        prevMessage == null || shouldDrawDate(prevMessage.date, message.date);

    return Column(
      children: [
        // DateDivider 위젯을 그려야 하는지 판단하기
        if (shouldDrawDateDivider)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: DateDivider(date: message.date),
          ),

        // 정렬 위치에 따라 패팅 다르게 제공해주기
        Padding(
          padding: EdgeInsets.only(
            left: isMine ? 64.0 : 16.0,
            right: isMine ? 16.0 : 64.0,
          ),
          child: Message(
            alignLeft: !isMine,
            message: message.message.trim(),
            point: message.point,
          ),
        ),
      ],
    );
  }

  // String으로 반환된 날짜가 다를 경우 true 반환
  bool shouldDrawDate(DateTime dateTime1, DateTime dateTime2) {
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime1) != formatter.format(dateTime2);
  }
}
