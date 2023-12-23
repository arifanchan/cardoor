import 'dart:convert';
import 'package:cardoor/helpers/api.dart';
import 'package:cardoor/helpers/api_url.dart';
import 'package:cardoor/model/mobil.dart';

class MobilBloc {
  static Future<List<Mobil>> getMobils() async {
    String apiUrl = ApiUrl.listMobil;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listMobil = (jsonObj as Map<String, dynamic>)['data'];
    List<Mobil> mobils = [];
    for (int i = 0; i < listMobil.length; i++) {
      mobils.add(Mobil.fromJson(listMobil[i]));
    }
    return mobils;
  }

  static Future addMobil({Mobil? mobil}) async {
    String apiUrl = ApiUrl.createMobil;

    var body = {
      "tipe_mobil": mobil!.tipeMobil,
      "merk_mobil": mobil.merkMobil,
      "no_plat": mobil.noPlat,
      "harga_sewa": mobil.hargaSewa.toString()
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> updateMobil({required Mobil mobil}) async {
    String apiUrl = ApiUrl.updateMobil(mobil.id!);

    var body = {
      "tipe_mobil": mobil.tipeMobil,
      "merk_mobil": mobil.merkMobil,
      "no_plat": mobil.noPlat,
      "harga_sewa": mobil.hargaSewa.toString()
    };
    print("Body : $body");
    var response = await Api().put(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['code'] == 200;
  }

  static Future<bool> deleteMobil({int? id}) async {
    String apiUrl = ApiUrl.deleteMobil(id!);

    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return jsonObj['code'] == 200;
  }
}
