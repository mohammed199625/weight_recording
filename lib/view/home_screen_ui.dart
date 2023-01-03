import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_recording/bloc/weight_state.dart';
import 'package:weight_recording/model/weight_model.dart';
import 'package:weight_recording/view/welcome_screen.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import '../bloc/weight_bloc.dart';
import '../bloc/weight_event.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
// text fields' controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  Future<void> _delete() async {
    BlocProvider.of<WeightBloc>(context).add(DeleteData());
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<WeightBloc>(context).add(GetData());
  }

  Future<void> _create() async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _weightController,
                  decoration: const InputDecoration(
                    labelText: 'weight',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Create'),
                  onPressed: () async {
                    final String name = _nameController.text;
                    final double? weight =
                        double.tryParse(_weightController.text);
                    if (widget != null) {
                      _postData(context);

                      _nameController.text = '';
                      _nameController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  void _postData(context) {
    BlocProvider.of<WeightBloc>(context).add(
      Create(_nameController.text, _weightController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Weight Track')),
          actions: [
            IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()));
                },
                icon: Icon(Icons.logout))
          ],
        ),
        body: PaginateFirestore(
          itemsPerPage: 5,
          isLive: true,
          itemBuilder: (context,dynamic ds,int index) {
            return  Card(
              child: ListTile(
                title: Text(ds[index]['name']),
                subtitle: Text(ds[index]['weight']),

              ),
            );
          },
          query: FirebaseFirestore.instance.collection("weights"),
          itemBuilderType: PaginateBuilderType.listView,
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton(
              onPressed: () => _create(),
              child: const Icon(Icons.add),
            ),
            FloatingActionButton(
              onPressed: () => _delete(),
              child: const Icon(Icons.delete),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
