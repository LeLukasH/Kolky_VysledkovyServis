export 'assets/colors.dart';
export 'assets/widget_assets.dart';

double assetsPadding = 20.0;

String convertDateTime(DateTime dateTime) {
  dateTime = dateTime.add(dateTime.timeZoneOffset);
  String convertedTime =
      "${dateTime.day.toString().padLeft(2, '0')}.${dateTime.month.toString().padLeft(2, '0')}.${dateTime.year.toString()} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  return convertedTime;
}

class Tuple<T1, T2> {
  final T1 item1;
  final T2 item2;

  Tuple({
    required this.item1,
    required this.item2,
  });
}

String capitalize(String str) {
  return "${str[0].toUpperCase()}${str.substring(1).toLowerCase()}";
}
