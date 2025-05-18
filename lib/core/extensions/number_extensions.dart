extension NumberTo on num? {
  String toMoney() {
    int? number = int.tryParse("$this");
    if (number == null) {
      return "0";
    }
    String result = "";
    for (int i = 0; i < number.toString().length; i++) {
      result += number.toString()[i];
      if ((number.toString().length - i) % 3 == 1) {
        result += " ";
      }
    }
    return result;
  }
}
