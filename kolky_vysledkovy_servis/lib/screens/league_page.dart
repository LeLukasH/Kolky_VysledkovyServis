import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kolky_vysledkovy_servis/all_assets.dart';
import 'package:kolky_vysledkovy_servis/all_models.dart';
import 'package:kolky_vysledkovy_servis/all_widgets.dart';

class LeaguePage extends StatelessWidget {
  LeaguePage({super.key, required this.leagueId, this.initialIndex});

  final int leagueId;
  int? initialIndex;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: dao.getLeagueDetail(leagueId, [
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
                width: 150,
                child: Tab(
                  icon: Center(
                    child: Text(
                      convertRoundToText(round),
                      style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.titleMedium!.fontSize,
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
        bool showTable = round % 999 <= lastTableIndex + 1;
        tabsContent.add(SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(assetsPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FutureBuilder(
                    future: dao.getComment([], leagueId, round),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        String text = snapshot.data!.content;
                        if (text != "") {
                          return Padding(
                              padding: EdgeInsets.only(bottom: assetsPadding),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const NameWidget(
                                      icon: Icons.comment_outlined,
                                      name: 'Komentár',
                                    ),
                                    CustomContainer(
                                      child: CommentWidget(text: text),
                                    )
                                  ]));
                        }
                        return Container();
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return Container();
                    }),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const NameWidget(icon: Icons.sports_outlined, name: 'Zápasy'),
                  CustomContainer(
                      child: MatchesWidget(matches: matchesMap[round]!)),
                ]),
                leagueDetail.defaultTables && showTable
                    ? LeagueTableChooser(leagueId: leagueId, round: round)
                    : Container(),
                leagueDetail.defaultTables && showTable
                    ? BestResultsChooser(leagueId: leagueId, round: round)
                    : Container(),
                leagueDetail.defaultAverages && showTable
                    ? Padding(
                        padding: EdgeInsets.only(top: assetsPadding),
                        child: Column(
                          children: [
                            const NameWidget(
                                icon: Icons.signal_cellular_alt_outlined,
                                name: 'Poradie jednotlivcov'),
                            CustomContainerWithOutPadding(
                              child: FutureBuilder(
                                future:
                                    dao.getInidividualResults(leagueId, round),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return LeagueIndividualsWidget(
                                        individualResults:
                                            snapshot.requireData);
                                  } else if (snapshot.hasError) {
                                    return Text("${snapshot.error}");
                                  }
                                  return const Center(
                                      child: CircularProgressIndicator());
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container()
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
    List<Match> matches = await dao.getMatches([leagueId], i);
    if (matches.isEmpty) {
      i = 1000;
      matches = await dao.getMatches([leagueId], i);
    }
    while (matches.isNotEmpty) {
      map.putIfAbsent(i, () => matches);
      i++;
      matches = await dao.getMatches([leagueId], i);
    }

    return map;
  }
}
