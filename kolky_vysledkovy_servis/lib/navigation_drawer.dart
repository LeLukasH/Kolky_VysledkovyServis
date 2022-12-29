import 'package:flutter/material.dart';
import 'screens/screens.dart';
import 'colors.dart';

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
      color: secondaryColor,
      //padding: const EdgeInsets.only(top: 250.0),
      child: Image.asset('images/logo200x200.png'));

  Widget buildMenuItems(BuildContext context) => Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Domov'),
            onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const HomePage())),
          ),
          ExpansionTile(
            leading: const Icon(Icons.ballot_outlined),
            title: const Text('Súťaže'),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: ListTile(
                  title: const Text('Interliga'),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const InterligaPage())),
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
                        onTap: () => {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: ListTile(
                        title: const Text('AGRO CS - RONA Extraliga ženy'),
                        onTap: () => {},
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
                        onTap: () => {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: ListTile(
                        title: const Text('1.KL Západ'),
                        onTap: () => {},
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: ListTile(
                  title: const Text('2.KL Západ'),
                  onTap: () => {},
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
                        onTap: () => {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: ListTile(
                        title: const Text('DL Východ'),
                        onTap: () => {},
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
                        onTap: () => {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: ListTile(
                        title: const Text('3. liga TN kraja'),
                        onTap: () => {},
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: ListTile(
                  title: const Text('Slovenský pohár mužov'),
                  onTap: () => {},
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
