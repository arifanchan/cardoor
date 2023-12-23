class Supir {
  int? id;
  String? nama;
  String? noKtp;
  String? alamat;
  String? pengalaman;

  Supir({this.id, this.nama, this.noKtp, this.alamat, this.pengalaman});

  factory Supir.fromJson(Map<String, dynamic> obj) {
    return Supir(
        id: int.tryParse('${obj['id_supir']}'),
        nama: obj['nama'],
        noKtp: obj['no_ktp'],
        alamat: obj['alamat'],
        pengalaman: obj['pengalaman']);
  }
}