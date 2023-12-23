class ApiUrl {
  static const String baseUrl = 'http://192.168.18.2/marketplace-api/public';
  // static const String baseUrl = 'https://project-ubsi-api.000webhostapp.com/public';
  static const String registrasi = baseUrl + '/registrasi';
  static const String login = baseUrl + '/login';

  static const String listMobil = baseUrl + '/mobil';

  static const String createMobil = baseUrl + '/mobil';

  static String updateMobil(int id) {
    // return baseUrl + '/mobil/' + id.toString() + '/update';
    return baseUrl + '/mobil/ubah/' + id.toString();
  }

  static String showMobil(int id) {
    return baseUrl + '/mobil/' + id.toString();
  }

  static String deleteMobil(int id) {
    return baseUrl + '/mobil/' + id.toString();
  }

// supir
  static const String listSupir = baseUrl + '/supir';

  static const String createSupir = baseUrl + '/supir';

  static String updateSupir(int id) {
    // return baseUrl + '/supir/' + id.toString() + '/update';
    return baseUrl + '/supir/ubah/' + id.toString();
  }

  static String showSupir(int id) {
    return baseUrl + '/supir/' + id.toString();
  }

  static String deleteSupir(int id) {
    return baseUrl + '/supir/' + id.toString();
  }
}
