import 'dart:convert';
import 'package:cardoor/helpers/api.dart';
import 'package:cardoor/helpers/api_url.dart';
import 'package:cardoor/model/supir.dart';

class SupirBloc {
  static Future<List<Supir>> getSupirs() async {
    String apiUrl = ApiUrl.listSupir;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listSupir = (jsonObj as Map<String, dynamic>)['data'];
    List<Supir> supirs = [];
    for (int i = 0; i < listSupir.length; i++) {
      supirs.add(Supir.fromJson(listSupir[i]));
    }
    return supirs;
  }

  static Future addSupir({Supir? supir}) async {
    String apiUrl = ApiUrl.createSupir;

    var body = {
      "nama": supir!.nama,
      "no_ktp": supir.noKtp,
      "alamat": supir.alamat,
      "pengalaman": supir.pengalaman,
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> updateSupir({required Supir supir}) async {
    String apiUrl = ApiUrl.updateSupir(supir.id!);

    var body = {
      "nama": supir.nama,
      "no_ktp": supir.noKtp,
      "alamat": supir.alamat,
      "pengalaman": supir.pengalaman,
    };
    print("Body : $body");
    var response = await Api().put(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['code'] == 200;
  }

  static Future<bool> deleteSupir({int? id}) async {
    String apiUrl = ApiUrl.deleteSupir(id!);

    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return jsonObj['code'] == 200;
  }
}
