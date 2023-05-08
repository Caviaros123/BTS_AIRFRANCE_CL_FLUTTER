


import 'package:airfrance/models/Aeroport.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../providers/db_service.dart';
import '../views/aeroports/components/data_table.dart';

class AirportController extends GetxController {

  late final Future futureFetchAirport;

  // inputs
  Rx<TextEditingController> nomController = TextEditingController().obs;
  Rx<TextEditingController> paysController = TextEditingController().obs;
  Rx<String> idToEditing = ''.obs;

  final box = GetStorage();

  final isEditing = false.obs;
  final isLoading = false.obs;
  final isLoadingAdd = false.obs;
  final List<Airport> airport = <Airport>[].obs;

  final formKey = GlobalKey<FormState>();
  final formKeyEdit = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    futureFetchAirport = fetchAirport();
  }

  @override
  void onClose() {
    airport.clear();
    isEditing(false);
    idToEditing.value = '';
    nomController.value.clear();
    paysController.value.clear();
    super.onClose();
  }

  Future fetchAirport() async {
    isLoading(true);
    try {
      final data = {
        'getAeroports': 'getAeroports',
        'from': 'api'
      };
      final res = await ApiProvider().dioConnect('aeroports.php', data);
      final body = res.data;

      // printInfo(info: "DATA IS==========>${body}");
      if (body['status'] == 200) {
        airport.assignAll(body['data'].map<Airport>((e) => Airport.fromJson(e)).toList());
        return airport;
      }
      printInfo(info: 'error no data found');
      return body['data'];
    } catch (e) {
      printError(info: e.toString());
      rethrow;
    } finally {
      isLoading(false);
    }
  }


  Future<void> addAirport() async {
    isLoadingAdd(true);
    try{
      final data = {
        'from': 'api',
        'Valider': 'Valider',
        'getAeroports': 'getAeroports',
        'nom': nomController.value.text,
        'pays': paysController.value.text
      };

      final req = await ApiProvider().dioConnect('aeroports.php', data);
      final body = req.data;

      if (body['status'] == 200) {
        await Get.delete<AirportController>();
        Get.put(AirportController());
        update();
        return ;

      }

      return;
    } catch (e) {
      rethrow;
    }finally{
      isLoadingAdd(false);
    }
  }


  Future<void> deleteAirport(int id) async {
    isLoading(true);
    try{
      final data = {
        'from': 'api',
        'action': 'sup',
        'getAeroports': 'getAeroports',
        'idaeroport': id.toString()
      };

      final req = await ApiProvider().dioConnect('aeroports.php', data);
      final body = req.data;

      if (body['status'] == 200) {
        // printInfo(info: 'DELETE====>  ${body['data']}' );
        await Get.delete<AirportController>();
        Get.put(AirportController());
        update();
        return ;
      }

      return;
    } catch (e) {
      rethrow;
    }finally{
      isLoading(false);
    }
  }

  Future<void> editAirport() async {
    isLoading(true);
    try{
      if(idToEditing.value == '') return;
      final data = {
        'from': 'api',
        'action': 'edit',
        'getAeroports': 'getAeroports',
        'idaeroport': idToEditing.value.toString(),
        'modifier': 'modifier',
        'nom': nomController.value.text,
        'pays': paysController.value.text
      };

      final req = await ApiProvider().dioConnect('aeroports.php', data);
      final body = req.data;

      if (body['status'] == 200) {
        // printInfo(info: 'EDIT====>  ${body['data']}' );
        Get.delete<AirportController>();
        Get.put(AirportController());

        update();
        return ;
      }

      return;
    } catch (e) {
      rethrow;
    }finally{
      isLoading(false);
    }
  }
}