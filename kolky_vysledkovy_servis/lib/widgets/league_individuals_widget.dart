import 'package:flutter/material.dart';
import 'package:kolky_vysledkovy_servis/all_assets.dart';
import 'package:kolky_vysledkovy_servis/all_models.dart';

class LeagueIndividualsWidget extends StatefulWidget {
  final IndividualResults individualResults;
  const LeagueIndividualsWidget({super.key, required this.individualResults});

  @override
  State<StatefulWidget> createState() => _LeagueIndividualsWidgetState();
}

class _LeagueIndividualsWidgetState extends State<LeagueIndividualsWidget> {
  int? sortColumnIndex = 0;
  bool isAscending = false;

  final boldColumns = [1, 4];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.individualResults.averages!.length; i++) {
      widget.individualResults.averages![i].order = i + 1;
    }
  }

  List<DataColumn> getColumns() {
    return [
      DataColumn(
        label: const Text('#'),
        tooltip: "Poradie",
        onSort: (int columnIndex, bool ascending) {
          setState(() {
            isAscending = ascending;
            sortColumnIndex = columnIndex;
            widget.individualResults.averages!.sort((a, b) => ascending
                ? a.total!.compareTo(b.total!)
                : b.total!.compareTo(a.total!));
            widget.individualResults.outOfOrder!.sort((a, b) => ascending
                ? a.total!.compareTo(b.total!)
                : b.total!.compareTo(a.total!));
          });
        },
      ),
      DataColumn(
        label: const Text('Hráč'),
        onSort: (int columnIndex, bool ascending) {
          setState(() {
            isAscending = ascending;
            sortColumnIndex = columnIndex;
            widget.individualResults.averages!.sort((a, b) => !ascending
                ? a.lastName!.compareTo(b.lastName!)
                : b.lastName!.compareTo(a.lastName!));
            widget.individualResults.outOfOrder!.sort((a, b) => !ascending
                ? a.lastName!.compareTo(b.lastName!)
                : b.lastName!.compareTo(a.lastName!));
          });
        },
      ),
      DataColumn(
        label: const Text('Z'),
        numeric: true,
        tooltip: "Zápasy",
        onSort: (int columnIndex, bool ascending) {
          setState(() {
            isAscending = ascending;
            sortColumnIndex = columnIndex;
            widget.individualResults.averages!.sort((a, b) => !ascending
                ? a.count!.compareTo(b.count!)
                : b.count!.compareTo(a.count!));
            widget.individualResults.outOfOrder!.sort((a, b) => !ascending
                ? a.count!.compareTo(b.count!)
                : b.count!.compareTo(a.count!));
          });
        },
      ),
      DataColumn(
        label: const Text('B'),
        numeric: true,
        tooltip: "Body",
        onSort: (int columnIndex, bool ascending) {
          setState(() {
            isAscending = ascending;
            sortColumnIndex = columnIndex;
            widget.individualResults.averages!.sort((a, b) => !ascending
                ? a.points!.compareTo(b.points!)
                : b.points!.compareTo(a.points!));
            widget.individualResults.outOfOrder!.sort((a, b) => !ascending
                ? a.points!.compareTo(b.points!)
                : b.points!.compareTo(a.points!));
          });
        },
      ),
      DataColumn(
        label: const Text('Spolu'),
        numeric: true,
        onSort: (int columnIndex, bool ascending) {
          setState(() {
            isAscending = ascending;
            sortColumnIndex = columnIndex;
            widget.individualResults.averages!.sort((a, b) => !ascending
                ? a.total!.compareTo(b.total!)
                : b.total!.compareTo(a.total!));
            widget.individualResults.outOfOrder!.sort((a, b) => !ascending
                ? a.total!.compareTo(b.total!)
                : b.total!.compareTo(a.total!));
          });
        },
      ),
      DataColumn(
        label: const Text('Max'),
        numeric: true,
        onSort: (int columnIndex, bool ascending) {
          setState(() {
            isAscending = ascending;
            sortColumnIndex = columnIndex;
            widget.individualResults.averages!.sort((a, b) => !ascending
                ? a.maxTotal!.compareTo(b.maxTotal!)
                : b.maxTotal!.compareTo(a.maxTotal!));
            widget.individualResults.outOfOrder!.sort((a, b) => !ascending
                ? a.maxTotal!.compareTo(b.maxTotal!)
                : b.maxTotal!.compareTo(a.maxTotal!));
          });
        },
      ),
    ];
  }

  List<DataRow> getRows(List<IndividualResult> rows) =>
      rows.map((IndividualResult row) {
        final cells = [
          row.order != null ? "${row.order}." : "",
          "${row.lastName} ${row.firstName}",
          row.count,
          row.points,
          row.total,
          row.maxTotal,
        ];
        return DataRow(cells: getCells(cells));
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) {
    List<DataCell> list = [];
    for (int i = 0; i < cells.length; i++) {
      list.add(DataCell(Text(cells[i].toString(),
          style: boldColumns.contains(i)
              ? const TextStyle(fontWeight: FontWeight.bold)
              : const TextStyle())));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    List<IndividualResult> list = [];
    list.addAll(widget.individualResults.averages!);
    list.addAll(widget.individualResults.outOfOrder!);
    return DataTable(
      headingRowColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        return primaryColor.withOpacity(0.2);
      }),
      headingRowHeight: 50,
      horizontalMargin: 12,
      columnSpacing: 5,
      sortAscending: isAscending,
      sortColumnIndex: sortColumnIndex,
      columns: getColumns(),
      rows: getRows(list),
    );
  }
}
