import 'package:flutter/material.dart';
import 'package:kolky_vysledkovy_servis/DAO.dart';

import 'models/all_models.dart';

void main(List<String> args) {
  DAO _dao = DAO();

  String _selectedItemSeason
  Widget ft = FutureBuilder(
    future: _dao.getSeasons(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        Map<String, int> seasonMap = getMap(snapshot.requireData);
        List<String> seasonList = [];
        seasonList.add(_selectedItemSeason);
        seasonMap.keys.forEach((element) {
          seasonList.add(element);
        });
        return DropdownButton(
          items: seasonList.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          value: _selectedItemSeason,
          onChanged: (newValue) {
            setState(() {
              _selectedItemSeason = newValue!;
            });
          },
        );
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
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