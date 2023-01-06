import 'package:flutter/material.dart';
import 'package:kolky_vysledkovy_servis/DAO.dart';
import '../widgets/navigation_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _test() async {
    var _dao = DAO();
    var seasons = await _dao.getSeasons();
    print(seasons);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Domov'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _test,
      ),
      drawer: NavigationDrawer(),
    );
  }
}
