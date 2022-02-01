String intToDoubleNum(int i) {
  if (i < 10) {
    return "0$i";
  }
  return "$i";
}

String formatDate(DateTime start) {
  return "${formatDateWithoutHour(start)} at ${intToDoubleNum(start.hour)}h${intToDoubleNum(start.minute)}";
}

String formatDateWithoutHour(DateTime start) {
  return "${intToDoubleNum(start.day)}/${intToDoubleNum(start.month)}/${intToDoubleNum(start.year)}";
}
