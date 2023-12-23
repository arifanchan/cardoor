import 'package:flutter/material.dart';
import 'package:cardoor/bloc/supir_bloc.dart';
import 'package:cardoor/model/supir.dart';
import 'package:cardoor/ui/supir_detail.dart';
import 'package:cardoor/ui/supir_form.dart';
import 'package:cardoor/widget/sidebar.dart';


class SupirPage extends StatefulWidget {
  const SupirPage({Key? key}) : super(key: key);

  @override
  _SupirPageState createState() => _SupirPageState();
}

class _SupirPageState extends State<SupirPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(),
      appBar: AppBar(
        title: const Text("Data Supir"),
        actions: [
          GestureDetector(
            child: const Icon(Icons.add),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SupirForm()));
            },
          )
        ],
      ),
      body: FutureBuilder<List>(
        future: SupirBloc.getSupirs(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListSupir(
                  list: snapshot.data,
                  onChange: () {
                    setState(() {});
                  },
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ListSupir extends StatelessWidget {
  final List? list;
  VoidCallback? onChange;

  ListSupir({Key? key, this.onChange, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list!.length,
        itemBuilder: (context, i) {
          return ItemSupir(
            supir: list![i],
            onChange: onChange,
          );
        });
  }
}

class ItemSupir extends StatelessWidget {
  final Supir supir;
  final VoidCallback? onChange;

  const ItemSupir({Key? key, this.onChange, required this.supir})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SupirDetail(
                      supir: supir,
                    ))).then((value) {
          if (value == true) {
            if (onChange != null) {
              onChange!();
            }
          }
        });
      },
      child: Card(
        child: ListTile(
          title: Text(supir.nama!),
          subtitle: Text(supir.pengalaman.toString() + " tahun"),
        ),
      ),
    );
  }
}
