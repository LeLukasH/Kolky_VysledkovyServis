import 'package:flutter/material.dart';
import 'package:kolky_vysledkovy_servis/DAO.dart';
import 'package:kolky_vysledkovy_servis/models/all_models.dart';
import '../screens/screens.dart';

class NavigationDrawer extends StatelessWidget {
  NavigationDrawer({Key? key}) : super(key: key);

  final _dao = DAO();

  final double _leftPadding = 16.0;

  Future<int> getLastSeasonId() async {
    var seasons = await _dao.getSeasons();
    return seasons.first.id;
  }

  Future<List<League>> getListOfLeagues() async {
    var leagues = await _dao.getLeagues(await getLastSeasonId());
    return leagues;
  }

  List<Widget> getTiles(BuildContext context, List<League> leagues) {
    leagues.sort(((a, b) {
      int cmp = a.category.rank.compareTo(b.category.rank);
      if (cmp != 0) return cmp;
      return a.id.compareTo(b.id);
    }));

    Map<int, int> categoryCount = {};
    for (League league in leagues) {
      categoryCount.putIfAbsent(league.categoryId, () => 0);
      categoryCount.update(league.categoryId, (value) => value + 1);
    }

    List<Widget> tiles = [];
    for (int i = 0; i < leagues.length; i++) {
      if (categoryCount[leagues[i].categoryId] == 1) {
        tiles.add(addListTile(leagues[i].name, leagues[i].id, context));
      } else {
        var j = i;
        List<Widget> tilesToAdd = [];
        while (categoryCount[leagues[j].categoryId]! > 0) {
          tilesToAdd.add(addListTile(leagues[i].name, leagues[i].id, context));
          categoryCount.update(leagues[j].categoryId, (value) => value - 1);
          i++;
        }
        i--;
        tiles.add(
          Padding(
            padding: EdgeInsets.only(left: _leftPadding),
            child: ExpansionTile(
              title: Text(leagues[j].category.name),
              children: tilesToAdd,
            ),
          ),
        );
      }
    }
    return tiles;
  }

  Widget addListTile(String leagueName, int leagueId, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: _leftPadding),
      child: ListTile(
        title: Text(leagueName),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => LeaguePage(
                  id: leagueId,
                  name: leagueName,
                ))),
      ),
    );
  }

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

  Widget buildMenuItems(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Domov'),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const HomePage())),
            ),
            FutureBuilder(
              future: getListOfLeagues(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ExpansionTile(
                      leading: const Icon(Icons.sports_score_outlined),
                      title: const Text('Súťaže'),
                      children: getTiles(context, snapshot.requireData));
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return const ExpansionTile(
                    leading: Icon(Icons.sports_score_outlined),
                    title: Text('Súťaže'),
                    children: [CircularProgressIndicator()]);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Ostatné'),
              onTap: () => {},
            ),
          ],
        ));
  }
}
