abstract class GeminiApi {
  // private constructor로 개발자가 실수로 인스턴스화 하는 코드를 작성하는 것을 방지한다.
  GeminiApi._();

  static const geminiModel = 'gemini-2.0-flash';
  static const geminiApiKey = 'your gemini api key';
}
