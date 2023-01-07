import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kolky_vysledkovy_servis/all_assets.dart';
import 'package:kolky_vysledkovy_servis/all_models.dart';
import 'package:kolky_vysledkovy_servis/DAO.dart';
import 'package:kolky_vysledkovy_servis/all_widgets.dart';

class LeaguePage extends StatelessWidget {
  LeaguePage(
      {super.key,
      required this.leagueId,
      required this.name,
      required this.seasonName});

  final int leagueId;
  final String name;
  final String seasonName;

  final _dao = DAO();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getMatches(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return getLeaguePage(context, snapshot.requireData);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Scaffold(
              appBar: AppBar(
                title: Text(name),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: assetsPadding),
                    child: Center(
                        child: Text(
                      seasonName,
                    )),
                  )
                ],
                titleTextStyle: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .apply(color: Colors.white),
              ),
              body: const Center(child: CircularProgressIndicator()));
        });
  }

  DefaultTabController getLeaguePage(
      BuildContext context, Map<int, List<Match>> map) {
    int getInitialIndex() {
      DateTime now = DateTime.now();
      for (var entry in map.entries) {
        if (entry.value.first.startDate.compareTo(now) >= 0) {
          return max(0, entry.key - 2);
        }
      }
      return map.length - 1;
    }

    int initialIndex = getInitialIndex();

    List<Widget> getTabs() {
      List<Widget> tabs = [];
      for (var key in map.keys) {
        tabs.add(SizedBox(
            width: 35,
            child: Tab(
              icon: Center(
                child: Text(
                  '$key.',
                  style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.titleLarge!.fontSize,
                      fontWeight: FontWeight.w500),
                ),
              ),
            )));
      }
      return tabs;
    }

    List<Widget> getTabsContent() {
      List<Widget> tabsContent = [];
      for (int round = 1; round <= map.length; round++) {
        tabsContent.add(SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(assetsPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FutureBuilder(
                    future: _dao.getComment([], leagueId, round),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return CommentWidget(text: snapshot.data!.content);
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return const SizedBox(
                          height: 120,
                          child: Center(child: CircularProgressIndicator()));
                    }),
                FutureBuilder(
                  future: _dao.getMatches([leagueId], round),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return MatchesLeaguePageWidget(matches: snapshot.data!);
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return const SizedBox(
                        height: 150,
                        child: Center(child: CircularProgressIndicator()));
                  },
                ),
                FutureBuilder(
                  future: _dao.getTable([], leagueId, round, "total"),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return TableWidget(
                          table: snapshot.data!.tableOfRoundRows,
                          showTable: round <= initialIndex + 1);
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return const SizedBox(
                        height: 150,
                        child: Center(child: CircularProgressIndicator()));
                  },
                ),
              ],
            ),
          ),
        ));
      }
      return tabsContent;
    }

    return DefaultTabController(
      length: map.length,
      initialIndex: initialIndex,
      child: Scaffold(
        appBar: AppBar(
          title: Text(name),
          elevation: 0,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: assetsPadding),
              child: Center(
                  child: Text(
                seasonName,
              )),
            )
          ],
          bottom: TabBar(
            isScrollable: true,
            tabs: getTabs(),
            indicator: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              color: scaffoldBackgroudColor,
            ),
            labelColor: secondaryColor,
            unselectedLabelColor: Colors.white.withOpacity(0.6),
          ),
        ),
        body: TabBarView(children: getTabsContent()),
      ),
    );
  }

  Future<Map<int, List<Match>>> getMatches() async {
    Map<int, List<Match>> map = {};
    int i = 1;
    List<Match> matches = await _dao.getMatches([leagueId], i);
    while (matches.isNotEmpty) {
      map.putIfAbsent(i, () => matches);
      i++;
      matches = await _dao.getMatches([leagueId], i);
    }
    return map;
  }
}
