import 'package:flutter/material.dart';
import 'package:kolky_vysledkovy_servis/colors.dart';

class Interliga extends StatelessWidget {
  const Interliga({super.key});

  @override
  Widget build(BuildContext context) {
    const numberOfTabs = 21;
    List<Widget> tabs = [];
    List<Widget> tabsContent = [];

    for (var i = 1; i <= numberOfTabs; i++) {
      tabs.add(SizedBox(
          width: 25,
          child: Tab(
            text: '$i.',
          )));
      tabsContent.add(Text('$i'));
    }

    return DefaultTabController(
      length: numberOfTabs,
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
