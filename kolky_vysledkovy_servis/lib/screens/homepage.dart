import 'package:flutter/material.dart';
import 'package:kolky_vysledkovy_servis/all_assets.dart';
import 'package:kolky_vysledkovy_servis/all_widgets.dart';
import 'package:kolky_vysledkovy_servis/all_models.dart';
import '../widgets/navigation_drawer.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime fisrtDate = DateTime(2016);
  DateTime lastDate = DateTime.now().add(const Duration(days: 365));
  DateTime selectedDate = DateTime.now();
  late CalendarAgendaController controller;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    controller = CalendarAgendaController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Domov'),
        bottom: CalendarAgenda(
          controller: controller,
          firstDate: fisrtDate,
          initialDate: selectedDate,
          lastDate: lastDate,
          onDateSelected: (date) => {
            setState(() {
              selectedDate = date;
            })
          },
          selectedDayPosition: SelectedDayPosition.center,
          indicatorColor: scaffoldBackgroudColor,
          dateColor: Colors.white.withOpacity(0.6),
          selectedDateColor: secondaryColor,
          locale: 'sk',
        ),
        elevation: 0,
        actions: [
          TextButton(
              onPressed: () async {
                DateTime? newDate = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: fisrtDate,
                  lastDate: lastDate,
                );
                if (newDate == null || newDate == selectedDate) return;
                setState(() {
                  selectedDate = newDate;
                });
                controller.goToDay(selectedDate);
              },
              child: Row(
                children: [
                  Text(
                    capitalize(DateFormat.yMMMM('sk').format(selectedDate)),
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .apply(color: Colors.white),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    Icons.edit_calendar_outlined,
                    color: Colors.white,
                  ),
                ],
              ))
        ],
      ),
      drawer: NavigationDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(assetsPadding),
          child: FutureBuilder(
            future: dao.getMatchesByDate(selectedDate),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return matchesByLeague(snapshot.requireData);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return const SizedBox(
                  height: 150,
                  child: Center(child: CircularProgressIndicator()));
            },
          ),
        ),
      ),
      floatingActionButton: DateTime.now().toString().substring(0, 10) ==
              selectedDate.toString().substring(0, 10)
          ? Container()
          : FloatingActionButton(
              onPressed: () => {
                setState(() {
                  selectedDate = DateTime.now();
                }),
                controller.goToDay(selectedDate)
              },
              child: const Icon(Icons.today_outlined),
            ),
    );
  }

  Widget matchesByLeague(List<Match> matches) {
    matches.sort(((a, b) => a.leagueId.compareTo(b.leagueId)));
    Map<int, List<Match>> map = {};
    for (Match match in matches) {
      map.putIfAbsent(match.leagueId, () => List<Match>.empty(growable: true));
      List<Match>? temp = map[match.leagueId];
      temp!.add(match);
      map.update(match.leagueId, (value) => temp);
    }
    List<Widget> list = [];
    map.forEach((key, value) => {
          list.add(
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              convertRoundToText(value.first.round),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .apply(color: secondaryColor),
            ),
            Text(
              value.first.leagueName,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .apply(color: primaryColor),
            ),
            SizedBox(
              height: assetsPadding / 4,
            ),
            CustomContainer(child: MatchesWidget(matches: value)),
            SizedBox(
              height: assetsPadding,
            ),
          ]))
        });

    return list.isNotEmpty
        ? Column(children: list)
        : const SizedBox(
            height: 50,
            child:
                Center(child: Text("Vo vybran?? de?? sa nehraj?? ??iadne z??pasy")));
  }
}
