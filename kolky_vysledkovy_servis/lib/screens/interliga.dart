import 'package:flutter/material.dart';
import 'package:kolky_vysledkovy_servis/colors.dart';
import 'package:kolky_vysledkovy_servis/screens/komentar.dart';

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

      const String komentar =
          'Překvapení kola se odehrálo ve Valašském Meziříčí. Domácí borci porazili favorita soutěže z Podbrezové, když bodově vyrovnané utkání, o 13 kuželek získali pro sebe. Je to již druhá prohra Podbrezové v tomto ročníku. Přitom v sobotu se Podbrezová prezentovala na drahách Husovic o téměř 130 kuželek lepším výsledkem. Však také v Brně vyhrála celkem jasně poměrem 7:1. Rokycany zdá se našli optimální formu. Výsledkově se jim daří podle představ a nic na tom nezměnili ani hostující Rakovice. Dva slabší výsledky v sestavě je stáli lepší výsledek. Vyrovnané utkání se hrálo také v Jihlavě, kam zajížděla Trstená Stárek. Hosté byli o 51 kuželek lepší v konečném součtu a upevnili si vedoucí pozici na čele tabulky. Domácím snad k remíze chybělo 10 kuželek u čtvrtého hráče sestavy. Valašské Meziříčí v sobotu o pouhých 6 kuželek prohráli na kuželně Slavoje Praha. Vysoké výkony na obou stranách předvedli Jaroslav Hažva a Tomáš Cabák. Oba shodně 664 p.k. v Posledním utkání kola porazili Vrútky kanárem Tatran Sučany. Marián Ruttkaj výkonem 651 p.k  potvrdil dominanci domácích a byl nejlepším hráčem utkání. Příští kolo je volno, které vyplní pohárové soutěže.';

      tabsContent.add(Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            komentar.isNotEmpty ? const Komentar(text: komentar) : Container()
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
