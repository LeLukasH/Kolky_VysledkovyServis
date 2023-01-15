enum Status { FINISHED, CONTUMATED, NEW, CANCELED, INPROGRESS }

final statusValues = EnumValues({
  "canceled": Status.CANCELED,
  "contumated": Status.CONTUMATED,
  "finished": Status.FINISHED,
  "new": Status.NEW,
  "inprogress": Status.INPROGRESS,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => MapEntry(v, k));
    }
    return reverseMap;
  }
}
