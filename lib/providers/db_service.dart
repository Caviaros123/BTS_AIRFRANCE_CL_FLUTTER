


import 'package:dio/dio.dart';
import 'package:get/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

const String API_URL = 'http://localhost:8888/BTS_SIO2_SLAM_DM_AIRFRANCE/';

class ApiProvider {

  final box = GetStorage();
  Dio dio = Dio();
  late Response response;
  String connErr = 'check_internet_connection';

  _setHeaders() => {
    'Content-type': 'application/x-www-form-urlencoded',
    'Accept': 'application/json',
    'Charset': 'utf-8',
  };

  final apiToken = CancelToken();

  Future<http.Response> postData(apiUrl, data) async {
    final fullUrl = Uri.parse(API_URL + apiUrl);
    print('URL==$fullUrl');
    printInfo(info: 'DATA====>>  $data');
    return await http.post(fullUrl, body: data, headers: _setHeaders());
  }


  Future<Response> dioConnect(url, data) async {
    final finalUrl = "$API_URL$url";
    print('url : $finalUrl');
    print('postData Hello : ${data.toString()}');

    try {
      dio.options.headers['accept'] = "application/json";
      dio.options.headers['content-type'] = 'application/x-www-form-urlencoded';
      dio.options.connectTimeout = 30000; // 30s
      dio.options.receiveTimeout = 25000; // 25s

      return await dio.post(finalUrl, data: data, cancelToken: apiToken);

    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        int? statusCode = e.response!.statusCode;
        if (statusCode == 404) {
          throw "Api non trouvé";
        } else if (statusCode == 500) {
          throw "Erreur serveur interne";
        } else {
          throw e.response!.data.toString() ;
        }
      } else if (e.type == DioErrorType.connectTimeout) {
        throw e.message.toString();
      } else if (e.type == DioErrorType.cancel) {
        throw 'annuler';
      }
      throw Exception(connErr);
    } finally {
      dio.close();
    }
  }

  Future dbQuery(query, data) async {

    final finalUrl = "$query";

    printInfo(info: 'DB CONN PROVIDER========>: $finalUrl');

    try {
      final res = await http.post(
        Uri.parse(finalUrl),
        body: data,
      );
      printInfo(info: 'DB CONN PROVIDER========>: $res')  ;

      return res;
    } catch (e) {
      printError(info: 'DBService login error: $e');
    } finally {
      // await conn.close();
    }
  }
}