import 'package:flutter/material.dart';
import 'package:kolky_vysledkovy_servis/dao.dart';
import 'package:kolky_vysledkovy_servis/all_assets.dart';
import 'package:kolky_vysledkovy_servis/screens/league_page.dart';

import '../all_models.dart';

class ArchivePage2 extends StatefulWidget {
  ArchivePage2({super.key});

  final DAO _dao = DAO();

  @override
  State<StatefulWidget> createState() => ArchiveState2();
}

class ArchiveState2 extends State<ArchivePage2> {
  String defaultString = "...";

  late String _selectedItemSeason;
  late String _selectedItemLeague;

  Map<String, int> seasonMap = {"...": -1};
  Map<String, int> leagueMap = {"...": -1};

  @override
  void initState() {
    super.initState();
    _selectedItemSeason = defaultString;
    _selectedItemLeague = "...";
  }

  Widget chooseLeague = Container();

  void updateChooseLeague() {
    _selectedItemLeague = defaultString;
    updateGoButton();
  }

  Widget goButton = Container();

  void updateGoButton() {
    leagueMap[_selectedItemLeague] == -1
        ? goButton = Container()
        : goButton = ElevatedButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => LeaguePage(
                      leagueId: leagueMap[_selectedItemLeague]!,
                    ))),
            style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor, elevation: assetsPadding / 2),
            child: SizedBox(
                height: assetsPadding * 3,
                width: assetsPadding * 3,
                child: Center(
                    child: Icon(
                  Icons.navigate_next_outlined,
                  size: assetsPadding * 2,
                ))),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Archív'),
      ),
      body: Padding(
        padding: EdgeInsets.all(assetsPadding * 2),
        child: SizedBox(
          child: Column(
            children: [
              CustomContainer(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: assetsPadding),
                    child: Text(
                      'Sezóna:',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  FutureBuilder(
                    future: widget._dao.getSeasons(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        seasonMap
                            .addAll(getMap(snapshot.requireData.sublist(1)));
                        List<String> seasonList = [];

                        seasonMap.keys.forEach((element) {
                          seasonList.add(element);
                        });

                        return DropdownButton<String>(
                          value: _selectedItemSeason,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedItemSeason = newValue!;
                              updateChooseLeague();
                            });
                          },
                          items: seasonList.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        );
                      }

                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  )
                ],
              )),
              SizedBox(
                height: assetsPadding,
              ),
              seasonMap[_selectedItemSeason] == -1
                  ? Container()
                  : CustomContainer(
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: assetsPadding),
                          child: Text(
                            'Súťaž:',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        FutureBuilder(
                          future: widget._dao
                              .getLeagues(seasonMap[_selectedItemSeason]!),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<League> leagues = snapshot.requireData;
                              leagues.sort(((a, b) =>
                                  a.categoryId.compareTo(b.categoryId)));
                              leagueMap = {"...": -1};

                              leagueMap.addAll(getMap(leagues));

                              List<String> leagueList = [];

                              leagueMap.keys.forEach((element) {
                                leagueList.add(element);
                              });

                              return DropdownButton<String>(
                                value: _selectedItemLeague,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedItemLeague = newValue!;
                                    updateGoButton();
                                  });
                                },
                                items: leagueList.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: SizedBox(
                                      width: 150,
                                      child: SingleChildScrollView(
                                        child: Text(
                                          value,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              );
                            }

                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        )
                      ],
                    )),
              SizedBox(
                height: assetsPadding * 2,
              ),
              goButton
            ],
          ),
        ),
      ),
    );
  }

  Map<String, int> getMap(List<dynamic> list) {
    Map<String, int> map = {};
    if (list is List<Season>) {
      for (var element in list) {
        map.putIfAbsent(element.name, () => element.id);
      }
    } else if (list is List<League>) {
      for (var element in list) {
        map.putIfAbsent(element.name, () => element.id);
      }
    }
    return map;
  }
}