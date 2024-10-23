class FuncHelper {
  FuncHelper._();
  static final FuncHelper funcHelper = FuncHelper._();

  int? answer;
  int? addOfNumbers({required int a, required int b}) {
    answer = a + b;
    return answer;
  }

  int? subOfNumbers({required int a, required int b}) {
    answer = a - b;
    return answer;
  }

  int? mulOfNumbers({required int a, required int b}) {
    answer = a * b;
    return answer;
  }

  int? divOfNumbers({required int a, required int b}) {
    answer = a ~/ b;
    return answer;
  }
}
