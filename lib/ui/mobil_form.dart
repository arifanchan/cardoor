import 'package:flutter/material.dart';
import 'package:cardoor/bloc/mobil_bloc.dart';
import 'package:cardoor/model/mobil.dart';
import 'package:cardoor/ui/mobil_page.dart';
import 'package:cardoor/widget/warning_dialog.dart';

class MobilForm extends StatefulWidget {
  Mobil? mobil;

  MobilForm({Key? key, this.mobil}) : super(key: key);

  @override
  _MobilFormState createState() => _MobilFormState();
}

class _MobilFormState extends State<MobilForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH MOBIL";
  String tombolSubmit = "SIMPAN";

  final _tipeMobilTextboxController = TextEditingController();
  final _merkMobilTextboxController = TextEditingController();
  final _noPlatTextboxController = TextEditingController();
  final _hargaSewaTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.mobil != null) {
      setState(() {
        judul = "UBAH MOBIL";
        tombolSubmit = "UBAH";
        _tipeMobilTextboxController.text = widget.mobil!.tipeMobil!;
        _merkMobilTextboxController.text = widget.mobil!.merkMobil!;
        _noPlatTextboxController.text = widget.mobil!.noPlat!;
        _hargaSewaTextboxController.text =
            widget.mobil!.hargaSewa.toString();
      });
    } else {
      judul = "TAMBAH MOBIL";
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
                _tipeMobilTextField(),
                _merkMobilTextField(),
                _noPlatTextField(),
                _hargaSewaTextField(),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Membuat Textbox Tipe Mobil
  Widget _tipeMobilTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Tipe Mobil"),
      keyboardType: TextInputType.text,
      controller: _tipeMobilTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Tipe Mobil harus diisi";
        }
        return null;
      },
    );
  }

  //Membuat Textbox Merk Mobil
  Widget _merkMobilTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Merk Mobil"),
      keyboardType: TextInputType.text,
      controller: _merkMobilTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Merk Mobil harus diisi";
        }
        return null;
      },
    );
  }
  //Membuat Textbox Nomor Plat
  Widget _noPlatTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "No Plat"),
      keyboardType: TextInputType.text,
      controller: _noPlatTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "No Plat harus diisi";
        }
        return null;
      },
    );
  }

  //Membuat Textbox Harga Sewa
  Widget _hargaSewaTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Harga Sewa"),
      keyboardType: TextInputType.number,
      controller: _hargaSewaTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Harga Sewa harus diisi";
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
              if (widget.mobil != null) {
                //kondisi update mobil
                ubah();
              } else {
                //kondisi tambah mobil
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
    Mobil createMobil = Mobil(id: null);
    createMobil.tipeMobil = _tipeMobilTextboxController.text;
    createMobil.merkMobil = _merkMobilTextboxController.text;
    createMobil.noPlat = _noPlatTextboxController.text;
    createMobil.hargaSewa = int.parse(_hargaSewaTextboxController.text);
    MobilBloc.addMobil(mobil: createMobil).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const MobilPage()));
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
    Mobil updateMobil = Mobil(id: null);
    updateMobil.id = widget.mobil!.id;
    updateMobil.tipeMobil = _tipeMobilTextboxController.text;
    updateMobil.merkMobil = _merkMobilTextboxController.text;
    updateMobil.noPlat = _noPlatTextboxController.text;
    updateMobil.hargaSewa = int.parse(_hargaSewaTextboxController.text);
    MobilBloc.updateMobil(mobil: updateMobil).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const MobilPage()));
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
