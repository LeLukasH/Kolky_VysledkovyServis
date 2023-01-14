import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kolky_vysledkovy_servis/all_assets.dart';
import 'package:kolky_vysledkovy_servis/all_models.dart';
import 'package:kolky_vysledkovy_servis/DAO.dart';
import 'package:kolky_vysledkovy_servis/all_widgets.dart';

class LeaguePage extends StatelessWidget {
  LeaguePage({super.key, required this.leagueId, this.initialIndex});

  final int leagueId;
  int? initialIndex;

  final _dao = DAO();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _dao.getLeagueDetail(leagueId, [
          "season",
          "playoff",
          "tables",
          "averages",
        ]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            LeagueDetail leagueDetail = snapshot.requireData;
            return FutureBuilder(
                future: getMatches(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return getLeaguePage(
                        context, snapshot.requireData, leagueDetail);
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return Scaffold(
                      appBar: AppBar(
                        title: Text(leagueDetail.name),
                        actions: [
                          Padding(
                            padding: EdgeInsets.only(right: assetsPadding),
                            child: Center(
                                child: Text(
                              leagueDetail.season.name,
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
          return AppBar();
        });
  }

  DefaultTabController getLeaguePage(BuildContext context,
      Map<int, List<Match>> map, LeagueDetail leagueDetail) {
    int getInitialIndex() {
      DateTime now = DateTime.now();
      for (var entry in map.entries) {
        if (entry.value.first.startDate.compareTo(now) >= 0) {
          return max(0, entry.key - 2);
        }
      }
      return map.length - 1;
    }

    int lastTableIndex = getInitialIndex();
    initialIndex ??= lastTableIndex;

    List<Widget> getTabs() {
      List<Widget> tabs = [];
      for (var round in map.keys) {
        round < 1000
            ? tabs.add(SizedBox(
                width: 35,
                child: Tab(
                  icon: Center(
                    child: Text(
                      '$round.',
                      style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.titleLarge!.fontSize,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )))
            : tabs.add(SizedBox(
                width: 60,
                child: Tab(
                  icon: Center(
                    child: Text(
                      '${round - 999}. kolo Play-Off',
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

    List<Widget> getTabsContent(Map<int, List<Match>> matchesMap) {
      List<Widget> tabsContent = [];
      for (var round in matchesMap.keys) {
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
                MatchesLeaguePageWidget(matches: matchesMap[round]!),
                leagueDetail.defaultTables
                    ? FutureBuilder(
                        future: _dao.getTable([], leagueId, round, "total"),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return TableWidget(
                                table: snapshot.data!.tableOfRoundRows,
                                showTable: round < 1000
                                    ? round <= lastTableIndex + 1
                                    : round - 1000 <= lastTableIndex);
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          return const SizedBox(
                              height: 150,
                              child:
                                  Center(child: CircularProgressIndicator()));
                        },
                      )
                    : Container(),
              ],
            ),
          ),
        ));
      }

      return tabsContent;
    }

    return DefaultTabController(
      length: map.length,
      initialIndex: initialIndex!,
      child: Scaffold(
        appBar: AppBar(
          title: Text(leagueDetail.name),
          elevation: 0,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: assetsPadding),
              child: Center(
                  child: Text(
                leagueDetail.season.name,
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
        body: TabBarView(children: getTabsContent(map)),
      ),
    );
  }

  Future<Map<int, List<Match>>> getMatches() async {
    Map<int, List<Match>> map = {};
    int i = 1;
    List<Match> matches = await _dao.getMatches([leagueId], i);
    if (matches.isEmpty) {
      i = 1000;
      matches = await _dao.getMatches([leagueId], i);
    }
    while (matches.isNotEmpty) {
      map.putIfAbsent(i, () => matches);
      i++;
      matches = await _dao.getMatches([leagueId], i);
    }
    print(map);
    return map;
  }
}
