import 'package:kolky_vysledkovy_servis/DAO.dart';

double assetsPadding = 20.0;

final DAO dao = DAO();

class Tuple<T1, T2> {
  final T1 item1;
  final T2 item2;

  Tuple({
    required this.item1,
    required this.item2,
  });
}
