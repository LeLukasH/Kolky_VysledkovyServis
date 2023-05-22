import 'package:flutter/material.dart';
import 'package:kolky_vysledkovy_servis/assets/colors.dart';
import 'package:kolky_vysledkovy_servis/widgets/other_widgets.dart';

import '../assets/other_assets.dart';
import '../models/team.dart';
import '../models/team_result.dart';

class TeamDetailPage extends StatelessWidget {
  final int teamId;
  const TeamDetailPage({super.key, required this.teamId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Tímu'),
        ),
        body: FutureBuilder(
            future: dao.getTeam(teamId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.all(assetsPadding),
                      child: FutureBuilder(
                          future: dao.getLeagueDetail(
                              snapshot.requireData.leagueId, ["season"]),
                          builder: (context2, snapshot2) {
                            if (snapshot2.hasData) {
                              return Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${snapshot2.requireData.name} ${snapshot2.requireData.season!.name}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .apply(color: secondaryColor),
                                          textAlign: TextAlign.left,
                                        ),
                                        Text(
                                          snapshot.requireData.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .apply(color: primaryColor),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  ),
                                  FutureBuilder(
                                      future: dao.getTeamResults(teamId),
                                      builder: (context3, snapshot3) {
                                        if (snapshot3.hasData) {
                                          return getTeamPage(
                                              context3,
                                              snapshot.requireData,
                                              snapshot3.requireData);
                                        } else if (snapshot3.hasError) {
                                          return Text("${snapshot3.error}");
                                        }
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }),
                                ],
                              );
                            } else if (snapshot2.hasError) {
                              return Text("${snapshot2.error}");
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          })),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }
}

Widget getTeamPage(
    BuildContext context, Team team, List<TeamResult> teamResults) {
  return Container();
}
