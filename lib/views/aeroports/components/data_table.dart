import 'package:airfrance/controllers/airport_controller.dart';
import 'package:airfrance/models/Aeroport.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

final controller = Get.find<AirportController>();
late AirportDataSource _airportDataSource;

class MyAirportGridTable extends StatefulWidget {
  final List<Airport> airport;
  MyAirportGridTable({Key? key, required this.airport}) : super(key: key);

  @override
  State<MyAirportGridTable> createState() => _MyAirportGridTableState();
}

class _MyAirportGridTableState extends State<MyAirportGridTable> {




  @override
  void initState() {
    super.initState();
    _airportDataSource = AirportDataSource();
    // printInfo(info: "DATA AIRPORT DEUX ZZO=====> ${widget.airport.map((e) => e.toJson()).toList()}");
  }

  updateDataTable(aeroport) {
    setState(() {
      _airportDataSource = AirportDataSource();
    });
  }

  @override
  void dispose() {
    _airportDataSource.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: SfDataGrid(
        source: _airportDataSource,
        allowPullToRefresh: true,
        allowEditing: false,
        allowSorting: true,
        selectionMode: SelectionMode.single,
          onCellDoubleTap: (DataGridCellDoubleTapDetails details) {
            controller.isEditing.value = true;
            controller.idToEditing.value = controller.airport[details.rowColumnIndex.rowIndex-1].idaeroport.toString();
            // init
            controller.nomController.value.text = controller.airport[details.rowColumnIndex.rowIndex-1].nom.toString();
            controller.paysController.value.text = controller.airport[details.rowColumnIndex.rowIndex-1].pays.toString();

          },
        onCellLongPress: (DataGridCellLongPressDetails details) {
          printInfo(info: "DATA IS=====> ${controller.airport[details.rowColumnIndex.rowIndex-1].toJson()}");

          // voulez vous supprimer l'aeroport
          Get.defaultDialog(
            title: "Supprimer l'aéroport",
            titlePadding: EdgeInsets.all(16.0),
            contentPadding: EdgeInsets.all(26.0),
            content: Column(
              children: [
                const Text("Voulez vous supprimer l'aéroport "),
                const SizedBox(height: 10.0,),
                Text("${controller.airport[details.rowColumnIndex.rowIndex-1].nom} ?", style: const TextStyle(fontWeight: FontWeight.bold),),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  controller.deleteAirport(
                    controller.airport[details.rowColumnIndex.rowIndex-1].idaeroport
                  );
                  updateDataTable(controller.airport);
                  Get.back();
                },
                child: Text("Oui"),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("Non"),
              ),
            ],
          );
        },
        columns: [
          GridColumn(
              columnName: 'idaeroport',
              width: 100,
              columnWidthMode: ColumnWidthMode.auto,
              label: Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'ID',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black,),
                  ))),
          GridColumn(
              columnName: 'nom',
              width: 200,
              columnWidthMode: ColumnWidthMode.auto,
              label: Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'Nom',
                    overflow: TextOverflow.ellipsis,
                  ))),
          GridColumn(
              columnName: 'pays',
              width: 180,
              columnWidthMode: ColumnWidthMode.auto,
              label: Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'Pays',
                    overflow: TextOverflow.ellipsis,
                  ))),
        ],
      )
    ));
  }

  Widget buildDeleteButton(Airport airport) {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () {
        // Code pour supprimer l'employé de votre source de données
        // (une liste dans cet exemple).
        setState(() {
          controller.deleteAirport(airport.idaeroport);
          _airportDataSource.buildDataGridRows();
          _airportDataSource.updateDataGridSource();
        });
      },
    );
  }

  /*List<Airport> getAirportData() {
    return controller.airport;
  }*/
}

class AirportDataSource extends DataGridSource {
  AirportDataSource() {
    _dataGridRows = controller.airport.map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
      DataGridCell<int>(columnName: 'idaeroport', value: dataGridRow.idaeroport),
      DataGridCell<String>(columnName: 'nom', value: dataGridRow.nom),
      DataGridCell<String>(columnName: 'pays', value: dataGridRow.pays),
    ])).toList();
    notifyDataSourceListeners();
  }

  late List<DataGridRow> _dataGridRows;
  late List<Airport> _airportData;

  @override
  List<DataGridRow> get rows => _dataGridRows;

  void buildDataGridRows() {
    _dataGridRows = controller.airport
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
      DataGridCell<int>(columnName: 'id', value: dataGridRow.idaeroport),
      DataGridCell<String>(columnName: 'name', value: dataGridRow.nom),
      DataGridCell<String>(
          columnName: 'designation', value: dataGridRow.pays),
    ]))
        .toList();
  }


  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(dataGridCell.value.toString(),
        overflow: TextOverflow.ellipsis
        ));
    }).toList());
  }

  void updateDataGridSource() {
    notifyListeners();
  }
}


