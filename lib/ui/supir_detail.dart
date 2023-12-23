import 'package:flutter/material.dart';
import 'package:cardoor/bloc/supir_bloc.dart';
import 'package:cardoor/model/supir.dart';
import 'package:cardoor/ui/supir_form.dart';
import 'package:cardoor/widget/warning_dialog.dart';

class SupirDetail extends StatefulWidget {
  Supir? supir;

  SupirDetail({Key? key, this.supir}) : super(key: key);

  @override
  _SupirDetailState createState() => _SupirDetailState();
}

class _SupirDetailState extends State<SupirDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Supir'),
      ),
    
      body: Center(
        child: Column(
          children: [
            Text(
              "Nama : ${widget.supir!.nama}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "No KTP : ${widget.supir!.noKtp}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Alamat : ${widget.supir!.alamat}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Pengalaman : ${widget.supir!.pengalaman} tahun",
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
                      builder: (context) => SupirForm(
                            supir: widget.supir!,
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
            SupirBloc.deleteSupir(id: widget.supir?.id).then((value) {
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
