import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:kolky_vysledkovy_servis/models/league_detail.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'models/league.dart';
import 'models/match.dart';
import 'models/match_detail.dart';
import 'models/season.dart';

class KolkyDatabase {
  static final KolkyDatabase instance = KolkyDatabase._init();

  static Database? _database;

  KolkyDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('kolky.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    //deleteDatabase(path);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute(MatchFields.createTableQuery);
    await db.execute(MatchDetailFields.createTableQuery);
    await db.execute(SeasonFields.createTableQuery);
    await db.execute(LeagueFields.createTableQuery);
    await db.execute(LeagueDetailFields.createTableQuery);
  }

  Future<List<Season>> dbGetSeasons() async {
    final db = await instance.database;
    final result =
        await db.query(SeasonFields.tableSeason, columns: SeasonFields.values);
    return result.map((json) => Season.fromJson(json)).toList();
  }

  Future<void> dbInsertSeasons(List<Season> seasons) async {
    final db = await instance.database;
    for (Season season in seasons) {
      if (await db.query(SeasonFields.tableSeason,
          where: '${SeasonFields.id} = ?',
          whereArgs: [season.id]).then((rows) => rows.isEmpty)) {
        await db.insert(SeasonFields.tableSeason, season.toJson());
      } else {
        await db.update(SeasonFields.tableSeason, season.toJson(),
            where: '${SeasonFields.id} = ?', whereArgs: [season.id]);
      }
    }
  }

  Future<List<League>> dbGetLeagues(int seasonId) async {
    final db = await instance.database;
    final result = await db.query(LeagueFields.tableLeague,
        columns: LeagueFields.values,
        where: '${LeagueFields.seasonId} = ?',
        whereArgs: [seasonId]);
    return result.map((json) => League.fromJson(json)).toList();
  }

  Future<void> dbInsertLeagues(List<League> leagues) async {
    final db = await instance.database;
    for (League league in leagues) {
      if (await db.query(LeagueFields.tableLeague,
          where: '${LeagueFields.id} = ?',
          whereArgs: [league.id]).then((rows) => rows.isEmpty)) {
        await db.insert(LeagueFields.tableLeague, league.toJson());
      } else {
        await db.update(LeagueFields.tableLeague, league.toJson(),
            where: '${LeagueFields.id} = ?', whereArgs: [league.id]);
      }
    }
  }

  Future<LeagueDetail?> dbGetLeagueDetail(int id) async {
    final db = await instance.database;
    final result = await db.query(LeagueDetailFields.tableLeagueDetail,
        columns: LeagueDetailFields.values,
        where: '${LeagueDetailFields.id} = ?',
        whereArgs: [id]);
    if (result.isEmpty) return null;
    return result.map((json) => LeagueDetail.fromJson(json)).first;
  }

  Future<void> dbInsertLeagueDetail(LeagueDetail leagueDetail) async {
    final db = await instance.database;
    if (await db.query(LeagueDetailFields.tableLeagueDetail,
        where: '${LeagueDetailFields.id} = ?',
        whereArgs: [leagueDetail.id]).then((rows) => rows.isEmpty)) {
      await db.insert(
          LeagueDetailFields.tableLeagueDetail, leagueDetail.toJson());
    } else {
      await db.update(
          LeagueDetailFields.tableLeagueDetail, leagueDetail.toJson(),
          where: '${LeagueDetailFields.id} = ?', whereArgs: [leagueDetail.id]);
    }
  }

  Future<List<Match>> dbGetMatches(int leagueId, int round) async {
    final db = await instance.database;
    final result = await db.query(MatchFields.tableMatch,
        columns: MatchFields.values,
        where: '${MatchFields.leagueId} = ? AND ${MatchFields.round} = ?',
        whereArgs: [leagueId, round]);
    return result.map((json) => Match.fromJson(json)).toList();
  }

  Future<List<Match>> dbGetMatchesByDate(DateTime date) async {
    final db = await instance.database;
    final result = await db.query(MatchFields.tableMatch,
        columns: MatchFields.values,
        where: 'substr(${MatchFields.startDate}, 1, 10) = ?',
        whereArgs: [date.toString().substring(0, 10)]);
    return result.map((json) => Match.fromJson(json)).toList();
  }

  Future<void> dbInsertMatches(List<Match> matches) async {
    final db = await instance.database;
    for (Match match in matches) {
      if (await db.query(MatchFields.tableMatch,
          where: '${MatchFields.id} = ?',
          whereArgs: [match.id]).then((rows) => rows.isEmpty)) {
        await db.insert(MatchFields.tableMatch, match.toJson());
      } else {
        await db.update(MatchFields.tableMatch, match.toJson(),
            where: '${MatchFields.id} = ?', whereArgs: [match.id]);
      }
    }
  }

  Future<MatchDetail?> dbGetMatchDetail(int id) async {
    final db = await instance.database;
    final result = await db.query(MatchDetailFields.tableMatchDetail,
        columns: MatchDetailFields.values,
        where: '${MatchDetailFields.id} = ?',
        whereArgs: [id]);
    if (result.isEmpty) return null;
    return result.map((json) => MatchDetail.fromJson(json)).first;
  }

  Future<void> dbInsertMatchDetail(MatchDetail matchDetail) async {
    final db = await instance.database;
    if (await db.query(MatchDetailFields.tableMatchDetail,
        where: '${MatchDetailFields.id} = ?',
        whereArgs: [matchDetail.id]).then((rows) => rows.isEmpty)) {
      await db.insert(MatchDetailFields.tableMatchDetail, matchDetail.toJson());
    } else {
      await db.update(MatchDetailFields.tableMatchDetail, matchDetail.toJson(),
          where: '${MatchDetailFields.id} = ?', whereArgs: [matchDetail.id]);
    }
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
