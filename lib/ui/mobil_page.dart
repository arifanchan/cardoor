import 'package:flutter/material.dart';
import 'package:cardoor/bloc/mobil_bloc.dart';
import 'package:cardoor/model/mobil.dart';
import 'package:cardoor/ui/mobil_detail.dart';
import 'package:cardoor/ui/mobil_form.dart';
import 'package:cardoor/widget/sidebar.dart';


class MobilPage extends StatefulWidget {
  const MobilPage({Key? key}) : super(key: key);

  @override
  _MobilPageState createState() => _MobilPageState();
}

class _MobilPageState extends State<MobilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(),
      appBar: AppBar(
        title: const Text("Data Mobil"),
        actions: [
          GestureDetector(
            child: const Icon(Icons.add),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MobilForm()));
            },
          )
        ],
      ),
      body: FutureBuilder<List>(
        future: MobilBloc.getMobils(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListMobil(
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

class ListMobil extends StatelessWidget {
  final List? list;
  VoidCallback? onChange;

  ListMobil({Key? key, this.onChange, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list!.length,
        itemBuilder: (context, i) {
          return ItemMobil(
            mobil: list![i],
            onChange: onChange,
          );
        });
  }
}

class ItemMobil extends StatelessWidget {
  final Mobil mobil;
  final VoidCallback? onChange;

  const ItemMobil({Key? key, this.onChange, required this.mobil})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MobilDetail(
                      mobil: mobil,
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
          title: Text(mobil.merkMobil!),
          subtitle: Text(mobil.hargaSewa.toString()),
        ),
      ),
    );
  }
}
