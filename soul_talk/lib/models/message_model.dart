import 'package:isar/isar.dart';

// builder_runner에 의해서 생성됨
// terminal-> dart run build_runner build
part 'message_model.g.dart';

@collection
class MessageModel {
  // message ID
  Id id = Isar.autoIncrement;

  // is user message or AI message?, true: user, false: AI
  bool isMine;

  // message text
  String message;

  // message point
  int? point;

  // message date
  DateTime date;

  MessageModel({
    required this.isMine,
    required this.message,
    required this.date,
    this.id = Isar.autoIncrement,
    this.point,
  });
}
