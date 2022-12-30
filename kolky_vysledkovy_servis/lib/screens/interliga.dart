import 'package:flutter/material.dart';
import 'package:kolky_vysledkovy_servis/colors.dart';
import 'package:kolky_vysledkovy_servis/widgets/komentar.dart';
import 'package:kolky_vysledkovy_servis/widgets/zapasy.dart';

class Interliga extends StatelessWidget {
  const Interliga({super.key});

  @override
  Widget build(BuildContext context) {
    const numberOfTabs = 12;
    List<Widget> tabs = [];
    List<Widget> tabsContent = [];

    const initialIndex = 0;

    for (var i = 1; i <= numberOfTabs; i++) {
      tabs.add(SizedBox(
          width: 25,
          child: Tab(
            text: '$i.',
          )));

      const String komentar = 'Překvapení kola se odehrálo vziříčí. .';
      List<Zapas> zapasy = [];
      zapasy.add(const Zapas(
        domaci: 'KK zlata Klasy',
        hostia: 'Priatelia Bratislava',
        hasBeenPlayed: true,
        date: '1969-07-20 20:18:04Z',
        domaciBody: 10.0,
        hostiaBody: 7.1,
        domaciSpolu: 3485,
        hostiaSpolu: 3225,
      ));
      zapasy.add(const Zapas(
        domaci: 'KK zlata Klasy',
        hostia: 'Priatelia Bratislava',
        hasBeenPlayed: true,
        date: '1969-07-20 20:18:04Z',
        domaciBody: 10.0,
        hostiaBody: 7.1,
        domaciSpolu: 3485,
        hostiaSpolu: 3225,
      ));
      zapasy.add(const Zapas(
        domaci: 'KK zlata Klasy',
        hostia: 'Priatelia Bratislava',
        hasBeenPlayed: false,
        date: '1969-07-20 20:18:04Z',
      ));
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
      ));
    }

    return DefaultTabController(
      length: numberOfTabs,
      initialIndex: initialIndex,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Interliga'),
          bottom: TabBar(
            isScrollable: true,
            tabs: tabs,
            indicator: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: secondaryColor),
          ),
        ),
        body: TabBarView(children: tabsContent),
      ),
    );
  }
}
