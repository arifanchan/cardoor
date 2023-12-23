import 'package:flutter/material.dart';
import '../ui/beranda.dart';
import '../ui/login_page.dart';
import '../ui/mobil_page.dart';
import '../ui/supir_page.dart';
import '../bloc/logout_bloc.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              accountName: Text("Admin"),
              accountEmail: Text("admin@cardoor.com")),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Beranda"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Beranda()));
            },
          ),
          ListTile(
            leading: Icon(Icons.car_rental),
            title: Text("Mobil"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MobilPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text("Supir"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SupirPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout_rounded),
            title: Text("Keluar"),
            onTap: () {
              LogoutBloc.logout();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (Route<dynamic> route) => false);
            },
          )
        ],
      ),
    );
  }
}
