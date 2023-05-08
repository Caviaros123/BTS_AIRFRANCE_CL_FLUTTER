import 'dart:math';

import 'package:airfrance/controllers/airport_controller.dart';
import 'package:airfrance/models/Aeroport.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'components/data_table.dart';

class AeroportsView extends GetView<AirportController> {
  const AeroportsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AirportController());

    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.all(28.0),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Ajouter un Aéroport',
                        style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      TextFormField(
                        controller: controller.nomController.value,
                        decoration: const InputDecoration(
                          hintText: 'Nom',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Ce champ ne peut être vide';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: controller.paysController.value,
                        decoration: const InputDecoration(
                          hintText: 'Pays',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Rentrez le pays';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueAccent,
                          minimumSize: Size(double.infinity, 50),
                        ),
                        onPressed: () async {
                          if (controller.formKey.currentState!.validate()) {
                            if (!controller.isEditing.value) {
                              await controller.addAirport();
                              controller.nomController.value.clear();
                              controller.paysController.value.clear();
                            } else {
                              controller.editAirport();
                            }
                          }
                        },
                        child: controller.isLoadingAdd.value
                            ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                            : Text(!controller.isEditing.value ? 'Ajouter' : 'Modifier'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          Expanded(
            child: GetBuilder<AirportController>(
              assignId: true,
              builder: (logic) {
                return FutureBuilder(
                  future: logic.fetchAirport(),
                  builder: (context, snapshot) {
                    //state
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                    //error
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('Erreur de connexion'),
                      );
                    }
                    //data
                    if (snapshot.hasData) {
                      return MyAirportGridTable(airport: controller.airport);
                    }

                    return const Center(
                      child: Text('Aucun aéroport'),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MyData extends DataTableSource {
  late final List<Airport> data;

  MyData({Key? key, required this.data}) : super();

  @override
  DataRow? getRow(int index) {
    return DataRow(
        onLongPress: () {
          // add deletion modal for delete item by each id
          Get.defaultDialog(
            title: 'Action',
            content: Text('OK'),
            confirm: Container(
                padding: const EdgeInsets.all(8.0),
                child: Text('Supprimer')),
            confirmTextColor: Colors.red[300],
            cancel: Container(
                padding: const EdgeInsets.all(8.0),
                child: Text('Annuler')),
            cancelTextColor: Colors.grey[300],
          );
        },
        cells: [
          DataCell(Text(data[index].idaeroport.toString())),
          DataCell(Text(data[index].nom)),
          DataCell(Text(data[index].pays.toString())),
        ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => data.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
