class Mobil {
  int? id;
  String? tipeMobil;
  String? merkMobil;
  String? noPlat;
  int? hargaSewa;

  Mobil({this.id, this.tipeMobil, this.merkMobil, this.noPlat, this.hargaSewa});

  factory Mobil.fromJson(Map<String, dynamic> obj) {
    return Mobil(
        id: int.tryParse('${obj['id_mobil']}'),
        tipeMobil: obj['tipe_mobil'],
        merkMobil: obj['merk_mobil'],
        noPlat: obj['no_plat'],
        hargaSewa: int.tryParse('${obj['harga_sewa']}'));
  }
}