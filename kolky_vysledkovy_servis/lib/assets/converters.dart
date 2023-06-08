String convertDateTime(DateTime dateTime) {
  dateTime = dateTime.add(dateTime.timeZoneOffset);
  String convertedTime =
      "${dateTime.day.toString().padLeft(2, '0')}.${dateTime.month.toString().padLeft(2, '0')}.${dateTime.year.toString()} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  return convertedTime;
}

String capitalize(String str) {
  return "${str[0].toUpperCase()}${str.substring(1).toLowerCase()}";
}

String getVideoID(String url) {
  url = url.replaceAll("https://www.youtube.com/watch?v=", "");
  return url;
}

int convertRoundToOrder(int round) {
  if (round < 1000) return round;
  return round - 999;
}

String convertRoundToText(int round) {
  if (round < 1000) return "$round. kolo";
  return "${round - 999}. kolo Play-Off";
}


