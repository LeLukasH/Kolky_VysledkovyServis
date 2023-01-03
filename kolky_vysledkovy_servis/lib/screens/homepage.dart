import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kolky_vysledkovy_servis/API.dart';
import 'package:kolky_vysledkovy_servis/DAO.dart';
import '../widgets/navigation_drawer.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _test() async {
    var _api = API();
    var _dao = DAO(_api);
    var seasons = await _dao.getSeasons();
    print(seasons);
    var m = await _api.send('match/list', body: {
      "leagueIds": [308],
      "dateFrom": "2023-01-02",
      "dateTo": "2023-02-03"
    });
    print(m.body);
    var matches = await _dao.getMatches([308], "2023-01-02", "2023-02-03");
    print(matches);
    /*
    var leagues = await _dao.getLeagues(9);
    print(leagues.length);*/
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
      drawer: const NavigationDrawer(),
    );
  }
}
