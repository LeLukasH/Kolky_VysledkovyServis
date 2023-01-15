import 'package:flutter/material.dart';
import 'package:kolky_vysledkovy_servis/widgets/table_widget.dart';

import '../all_assets.dart';

class TableChooser extends StatefulWidget {
  const TableChooser({super.key, required this.leagueId, required this.round});

  final int leagueId;
  final int round;

  @override
  State<StatefulWidget> createState() => TableChooserState();
}

class TableChooserState extends State<TableChooser> {
  String type = "total";
  final List<DropdownMenuItem> items = const [
    DropdownMenuItem(value: "total", child: Text("Celkom")),
    DropdownMenuItem(value: "home", child: Text("Doma")),
    DropdownMenuItem(value: "away", child: Text("Vonku"))
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: assetsPadding / 2),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const NameWidget(
                  icon: Icons.table_rows_outlined, name: 'Tabuľka'),
              DropdownButton(
                  items: items,
                  value: type,
                  onChanged: ((value) {
                    setState(() {
                      type = value;
                    });
                  }))
            ],
          ),
          CustomContainerWithOutPadding(
              child: FutureBuilder(
            future: dao.getTable([], widget.leagueId, widget.round, type),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return TableWidget(
                    tableRows: snapshot.requireData.tableOfRoundRows);
              } else if (snapshot.hasError) {
                return const Text("Error");
              }
              return const Center(child: CircularProgressIndicator());
            },
          ))
        ]));
  }
}
