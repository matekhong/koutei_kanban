import 'package:http/http.dart' as http;
import 'package:koutei_kanban/model/machine_status.dart';

class DataApi {
  static var client = http.Client();

  // GET Method from REST API
  static Future<List<MachineStatus>> loadMachineStatus(String machcode) async {
    var response = await client.get(Uri.parse(
        "http://192.168.1.104:8080/ords/denso/kanban/machine/$machcode"));
    if (response.statusCode == 200) {
      // ignore: avoid_print
      print(response.body);
      return decodeMachineStatus(response.body);
    } else {
      // ignore: avoid_print
      print('Cannot download');
      return [];
    }
  }

  // POST Method to REST API
  static void updateMachineStatus(int? barcode, int? status) async {
    var response = await client.post(
      Uri.parse(
          'http://192.168.1.104:8080/ords/denso/kanban/machineresult/$barcode/$status'),
    );
    if (response.statusCode == 200) {
      // ignore: avoid_print
      print('Updated');
    } else {
      // ignore: avoid_print
      print('Failed to update');
    }
  }
}
