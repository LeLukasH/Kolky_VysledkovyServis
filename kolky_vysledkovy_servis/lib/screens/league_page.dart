import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kolky_vysledkovy_servis/colors.dart';
import 'package:kolky_vysledkovy_servis/models/all_models.dart';
import 'package:kolky_vysledkovy_servis/widgets/all_widgets.dart';
import 'package:kolky_vysledkovy_servis/DAO.dart';

class LeaguePage extends StatelessWidget {
  LeaguePage({super.key, required this.id, required this.name});

  int id;
  String name;

  final _dao = DAO();

  @override
  Widget build(BuildContext context) {
    /*
    List<Widget> tabsContent = [];

    const String komentar =
        'Překvapení kola se odehrálo vziříčí. Překvapení kola se odehrálo vziříčí Překvapení kola se odehrálo vziříčí PřekvPřekvapení kola se odehrálo vziříčíPřekvapení kola se odehrálo vziříčíPřekvapení kola se odehrálo vziříčíPřekvapení kola se odehrálo vziříčíapení kola se odehrálo vziříčí Překvapení kola se odehrálo vziříčí Překvapení kola se odehrálo vziříčí Překvapení kola se odehrálo vziříčí Překvapení kola se odehrálo vziříčí.';
    List<Zapas> zapasy = [];

    tabsContent.add(Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          komentar.isNotEmpty ? const Komentar(text: komentar) : Container(),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Zapasy(zapasy: zapasy),
          )
        ],
      ),
    ));*/
    return FutureBuilder(
        future: getMatches(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return getLeaguePage(snapshot.requireData);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Scaffold(
              appBar: AppBar(
                title: Text(name),
              ),
              body: const Center(child: CircularProgressIndicator()));
        });
  }

  DefaultTabController getLeaguePage(Map<int, List<Match>> map) {
    int getInitialIndex() {
      DateTime now = DateTime.now();
      for (var entry in map.entries) {
        if (entry.value.first.startDate.compareTo(now) >= 0) {
          return max(0, entry.key - 2);
        }
      }
      return map.length - 1;
    }

    List<Widget> getTabs() {
      List<Widget> tabs = [];
      for (var key in map.keys) {
        tabs.add(SizedBox(
            width: 25,
            child: Tab(
              text: '$key.',
            )));
      }
      return tabs;
    }

    List<Widget> getTabsContent() {
      List<Widget> tabsContent = [];

    }

    return DefaultTabController(
      length: map.length,
      initialIndex: getInitialIndex(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(name),
          bottom: TabBar(
            isScrollable: true,
            tabs: getTabs(),
            indicator: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: secondaryColor),
          ),
        ),
        //body: TabBarView(children: tabsContent),
      ),
    );
  }

  Future<Map<int, List<Match>>> getMatches() async {
    Map<int, List<Match>> map = {};
    int i = 1;
    List<Match> matches = await _dao.getMatches([id], i);
    while (matches.isNotEmpty) {
      map.putIfAbsent(i, () => matches);
      i++;
      matches = await _dao.getMatches([id], i);
    }
    return map;
  }
}
