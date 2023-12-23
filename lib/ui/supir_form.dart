import 'package:flutter/material.dart';
import 'package:cardoor/bloc/supir_bloc.dart';
import 'package:cardoor/model/supir.dart';
import 'package:cardoor/ui/supir_page.dart';
import 'package:cardoor/widget/warning_dialog.dart';

class SupirForm extends StatefulWidget {
  Supir? supir;

  SupirForm({Key? key, this.supir}) : super(key: key);

  @override
  _SupirFormState createState() => _SupirFormState();
}

class _SupirFormState extends State<SupirForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH SUPIR";
  String tombolSubmit = "SIMPAN";

  final _namaTextboxController = TextEditingController();
  final _noKtpTextboxController = TextEditingController();
  final _alamatTextboxController = TextEditingController();
  final _pengalamanTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.supir != null) {
      setState(() {
        judul = "UBAH SUPIR";
        tombolSubmit = "UBAH";
        _namaTextboxController.text = widget.supir!.nama!;
        _noKtpTextboxController.text = widget.supir!.noKtp!;
        _alamatTextboxController.text = widget.supir!.alamat!;
        _pengalamanTextboxController.text = widget.supir!.pengalaman!;
      });
    } else {
      judul = "TAMBAH SUPIR";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _namaTextField(),
                _noKtpTextField(),
                _alamatTextField(),
                _pengalamanTextField(),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Membuat Textbox Nama
  Widget _namaTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama"),
      keyboardType: TextInputType.text,
      controller: _namaTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama Supir harus diisi";
        }
        return null;
      },
    );
  }

  //Membuat Textbox Nomor KTP
  Widget _noKtpTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "No KTP"),
      keyboardType: TextInputType.number,
      controller: _noKtpTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "No KTP harus diisi";
        }
        return null;
      },
    );
  }
  //Membuat Textbox Alamat
  Widget _alamatTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Alamat"),
      keyboardType: TextInputType.text,
      controller: _alamatTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Alamat harus diisi";
        }
        return null;
      },
    );
  }

  //Membuat Textbox Pengalaman
  Widget _pengalamanTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Pengalaman"),
      keyboardType: TextInputType.number,
      controller: _pengalamanTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Pengalaman harus diisi";
        }
        return null;
      },
    );
  }

  //Membuat Tombol Simpan/Ubah
  Widget _buttonSubmit() {
    return OutlinedButton(
        child: Text(tombolSubmit), style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) {
              if (widget.supir != null) {
                //kondisi update supir
                ubah();
              } else {
                //kondisi tambah supir
                simpan();
              }
            }
          }
        });
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    Supir createSupir = Supir(id: null);
    createSupir.nama = _namaTextboxController.text;
    createSupir.noKtp = _noKtpTextboxController.text;
    createSupir.alamat = _alamatTextboxController.text;
    createSupir.pengalaman = _pengalamanTextboxController.text;
    SupirBloc.addSupir(supir: createSupir).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const SupirPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Simpan gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    Supir updateSupir = Supir(id: null);
    updateSupir.id = widget.supir!.id;
    updateSupir.nama = _namaTextboxController.text;
    updateSupir.noKtp = _noKtpTextboxController.text;
    updateSupir.alamat = _alamatTextboxController.text;
    updateSupir.pengalaman = _pengalamanTextboxController.text;
    SupirBloc.updateSupir(supir: updateSupir).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const SupirPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Permintaan ubah data gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}
