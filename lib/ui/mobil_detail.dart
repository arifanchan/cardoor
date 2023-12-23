import 'package:flutter/material.dart';
import 'package:cardoor/bloc/mobil_bloc.dart';
import 'package:cardoor/model/mobil.dart';
import 'package:cardoor/ui/mobil_form.dart';
import 'package:cardoor/widget/warning_dialog.dart';

class MobilDetail extends StatefulWidget {
  Mobil? mobil;

  MobilDetail({Key? key, this.mobil}) : super(key: key);

  @override
  _MobilDetailState createState() => _MobilDetailState();
}

class _MobilDetailState extends State<MobilDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Mobil'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Tipe : ${widget.mobil!.tipeMobil}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Merk : ${widget.mobil!.merkMobil}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "No Plat : ${widget.mobil!.noPlat}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Harga Sewa : Rp. ${widget.mobil!.hargaSewa.toString()}",
              style: const TextStyle(fontSize: 18.0),
            ),
            _tombolHapusEdit()
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
//Tombol Edit
        OutlinedButton(
            child: const Text("EDIT"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MobilForm(
                            mobil: widget.mobil!,
                          )));
            }),
//Tombol Hapus
        OutlinedButton(
            child: const Text("DELETE"), style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ), onPressed: () => confirmHapus()),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        //tombol hapus
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () {
            MobilBloc.deleteMobil(id: widget.mobil?.id).then((value) {
              print('hasil delete = $value');
              Navigator.pop(context, value);
            });
          },
        ),
        //tombol batal
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context)
        .then((value) {
      if (value == true) {
        Navigator.pop(context, true);
      } else {
        showDialog(
            context: context,
            builder: (c) => const WarningDialog(
                  description: 'Data gagal dihapus',
                ));
      }
    });
  }
}
