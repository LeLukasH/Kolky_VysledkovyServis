import 'package:flutter/material.dart';
import 'screens/screens.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ));

  Widget buildHeader(BuildContext context) => Container(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Image.asset(
          'images/logo200x200.png',
          height: 200,
        ),
      ));

  Widget buildMenuItems(BuildContext context) => Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Domov'),
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HomePage())),
          ),
          ExpansionTile(
            leading: const Icon(Icons.sports_score_outlined),
            title: const Text('Súťaže'),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: ListTile(
                  title: const Text('Interliga'),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Interliga())),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: ExpansionTile(
                  title: const Text('Extraliga'),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: ListTile(
                        title: const Text('Extraliga muži'),
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const ExtraligaMuzi())),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: ListTile(
                        title: const Text('AGRO CS - RONA Extraliga ženy'),
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const ExtraligaZeny())),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: ExpansionTile(
                  title: const Text('1. liga'),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: ListTile(
                        title: const Text('1.KL Východ'),
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const Liga1Vychod())),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: ListTile(
                        title: const Text('1.KL Západ'),
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const Liga1Zapad())),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: ListTile(
                  title: const Text('2.KL Západ'),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Liga2Zapad())),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: ExpansionTile(
                  title: const Text('Dorast'),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: ListTile(
                        title: const Text('DL Západ'),
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const DLZapad())),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: ListTile(
                        title: const Text('DL Východ'),
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const DLVychod())),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: ExpansionTile(
                  title: const Text('3. liga'),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: ListTile(
                        title: const Text('3. liga TT + NR kraj'),
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const Liga3TTNR())),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: ListTile(
                        title: const Text('3. liga TN kraja'),
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const Liga3TN())),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: ListTile(
                  title: const Text('Slovenský pohár mužov'),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SlovenskyPoharMuzov())),
                ),
              ),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Ostatné'),
            onTap: () => {},
          ),
        ],
      ));
}
