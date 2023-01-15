import 'package:flutter/material.dart';
import 'package:kolky_vysledkovy_servis/models/tournament_detail.dart';
import 'package:kolky_vysledkovy_servis/widgets/tournament_results_widget.dart';

import '../all_assets.dart';
import '../widgets/tournament_group_results_widget.dart';

class TournamentPage extends StatelessWidget {
  const TournamentPage({super.key, required this.tournamentId});

  final int tournamentId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: dao.getTournamentDetail(
        tournamentId,
        [
          "club",
          "hall",
          "tournamentRounds",
          "tournamentRounds.hall",
          "tournamentRounds.results",
          "tournamentRounds.results.lanes"
        ],
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          TournamentDetail tournamentDetail = snapshot.requireData;
          return TournamentPageDetail(tournamentDetail: tournamentDetail);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Scaffold(
          appBar: AppBar(),
          body: const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

class TournamentPageDetail extends StatelessWidget {
  const TournamentPageDetail({super.key, required this.tournamentDetail});

  final TournamentDetail tournamentDetail;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tournamentDetail.tournamentRounds!.length,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text(tournamentDetail.name!),
          elevation: 0,
          bottom: TabBar(
            isScrollable: true,
            tabs: getTabs(context, tournamentDetail),
            indicator: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              color: scaffoldBackgroudColor,
            ),
            labelColor: secondaryColor,
            unselectedLabelColor: Colors.white.withOpacity(0.6),
          ),
        ),
        body: TabBarView(children: getTabsContent(context, tournamentDetail)),
      ),
    );
  }
}

List<Widget> getTabs(BuildContext context, TournamentDetail tournamentDetail) {
  List<Widget> tabs = [];
  for (TournamentRound round in tournamentDetail.tournamentRounds!) {
    tabs.add(SizedBox(
        width: 130,
        child: Tab(
          icon: Center(
            child: Text(
              '${round.name}',
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                  fontWeight: FontWeight.w500),
            ),
          ),
        )));
  }
  return tabs;
}

List<Widget> getTabsContent(
    BuildContext context, TournamentDetail tournamentDetail) {
  List<Widget> tabsContent = [];
  for (TournamentRound round in tournamentDetail.tournamentRounds!) {
    tabsContent.add(SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(assetsPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomContainer(
              child: SizedBox(
                height: 15,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(round.dateFrom!
                                .add(const Duration(days: 1))
                                .compareTo(round.dateTo!) >
                            0
                        ? convertDateTime(round.dateFrom!).substring(0, 10)
                        : "${convertDateTime(round.dateFrom!).substring(0, 6)} - ${convertDateTime(round.dateTo!).substring(0, 10)}"),
                    const VerticalDivider(
                      color: Color.fromARGB(255, 66, 66, 66),
                    ),
                    Text(round.hall!.name),
                  ],
                ),
              ),
            ),
            const Divider(
              height: 1,
            ),
            round.results!.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.only(top: assetsPadding),
                    child: CustomContainer(
                        child:
                            TournamentResultsWidget(results: round.results!)),
                  )
                : Container(),
            round.groupResults!.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.only(top: assetsPadding),
                    child: CustomContainer(
                        child: TournamentGroupResultsWidget(
                      groupResults: round.groupResults!,
                    )),
                  )
                : Container()
          ],
        ),
      ),
    ));
  }

  return tabsContent;
}
