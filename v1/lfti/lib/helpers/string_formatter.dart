extension ListToString on List {
  String parse() {
    if (this.length == 0) return '';
    String formattedString = '';
    this.forEach((element) {
      formattedString += (element.toString() + ', ');
    });
    // remove last comma
    return formattedString.substring(0, formattedString.length - 2);
  }
}
