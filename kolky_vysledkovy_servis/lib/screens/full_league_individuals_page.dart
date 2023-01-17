import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kolky_vysledkovy_servis/all_assets.dart';
import 'package:kolky_vysledkovy_servis/all_models.dart';

class FullLeagueIndividualsPage extends StatefulWidget {
  const FullLeagueIndividualsPage(
      {super.key, required this.leagueId, required this.round});

  final int leagueId;
  final int round;

  @override
  State<StatefulWidget> createState() => _FullLeagueIndividualsPageState();
}

class _FullLeagueIndividualsPageState extends State<FullLeagueIndividualsPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Poradie jednotlivcov'),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(assetsPadding),
          child: CustomContainerWithOutPadding(
            child: FutureBuilder(
              future: dao.getInidividualResults(widget.leagueId, widget.round),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return FullLeagueIndividualsWidget(
                      individualResults: snapshot.requireData);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        )));
  }
}

class FullLeagueIndividualsWidget extends StatefulWidget {
  final IndividualResults individualResults;
  const FullLeagueIndividualsWidget(
      {super.key, required this.individualResults});

  @override
  State<StatefulWidget> createState() => _FullLeagueIndividualsWidgetState();
}

class _FullLeagueIndividualsWidgetState
    extends State<FullLeagueIndividualsWidget> {
  int? sortColumnIndex = 0;
  bool isAscending = false;

  final boldColumns = [1, 10];

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
        label: const Text('Tím'),
        onSort: (int columnIndex, bool ascending) {
          setState(() {
            isAscending = ascending;
            sortColumnIndex = columnIndex;
            widget.individualResults.averages!.sort((a, b) => !ascending
                ? a.teamName!.compareTo(b.teamName!)
                : b.teamName!.compareTo(a.teamName!));
            widget.individualResults.outOfOrder!.sort((a, b) => !ascending
                ? a.teamName!.compareTo(b.teamName!)
                : b.teamName!.compareTo(a.teamName!));
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
        label: const Text('K'),
        numeric: true,
        tooltip: "Kolkárne",
        onSort: (int columnIndex, bool ascending) {
          setState(() {
            isAscending = ascending;
            sortColumnIndex = columnIndex;
            widget.individualResults.averages!.sort((a, b) => !ascending
                ? a.hallCount!.compareTo(b.hallCount!)
                : b.hallCount!.compareTo(a.hallCount!));
            widget.individualResults.outOfOrder!.sort((a, b) => !ascending
                ? a.hallCount!.compareTo(b.hallCount!)
                : b.hallCount!.compareTo(a.hallCount!));
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
        label: const Text('Plné'),
        numeric: true,
        onSort: (int columnIndex, bool ascending) {
          setState(() {
            isAscending = ascending;
            sortColumnIndex = columnIndex;
            widget.individualResults.averages!.sort((a, b) => !ascending
                ? a.full!.compareTo(b.full!)
                : b.full!.compareTo(a.full!));
            widget.individualResults.outOfOrder!.sort((a, b) => !ascending
                ? a.full!.compareTo(b.full!)
                : b.full!.compareTo(a.full!));
          });
        },
      ),
      DataColumn(
        label: const Text('Dor.'),
        numeric: true,
        onSort: (int columnIndex, bool ascending) {
          setState(() {
            isAscending = ascending;
            sortColumnIndex = columnIndex;
            widget.individualResults.averages!.sort((a, b) => !ascending
                ? a.clean!.compareTo(b.clean!)
                : b.clean!.compareTo(a.clean!));
            widget.individualResults.outOfOrder!.sort((a, b) => !ascending
                ? a.clean!.compareTo(b.clean!)
                : b.clean!.compareTo(a.clean!));
          });
        },
      ),
      DataColumn(
        label: const Text('Ch'),
        numeric: true,
        onSort: (int columnIndex, bool ascending) {
          setState(() {
            isAscending = ascending;
            sortColumnIndex = columnIndex;
            widget.individualResults.averages!.sort((a, b) => !ascending
                ? a.faults!.compareTo(b.faults!)
                : b.faults!.compareTo(a.faults!));
            widget.individualResults.outOfOrder!.sort((a, b) => !ascending
                ? a.faults!.compareTo(b.faults!)
                : b.faults!.compareTo(a.faults!));
          });
        },
      ),
      DataColumn(
        label: const Text('Ch(Ø)'),
        numeric: true,
        onSort: (int columnIndex, bool ascending) {
          setState(() {
            isAscending = ascending;
            sortColumnIndex = columnIndex;
            widget.individualResults.averages!.sort((a, b) => !ascending
                ? a.faultsAverage!.compareTo(b.faultsAverage!)
                : b.faultsAverage!.compareTo(a.faultsAverage!));
            widget.individualResults.outOfOrder!.sort((a, b) => !ascending
                ? a.faultsAverage!.compareTo(b.faultsAverage!)
                : b.faultsAverage!.compareTo(a.faultsAverage!));
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
          row.teamName,
          row.count,
          row.hallCount,
          row.points,
          row.full,
          row.clean,
          row.faults,
          row.faultsAverage,
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
    return SizedBox(
      width: double.infinity,
      child: DataTable(
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
      ),
    );
  }
}
