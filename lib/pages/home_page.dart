import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learn_flutter_widgets/components/add_form.dart';
import 'package:learn_flutter_widgets/components/edit_form.dart';
import 'package:learn_flutter_widgets/components/talent_list_card.dart';
import 'package:learn_flutter_widgets/components/search_box.dart';
import 'package:learn_flutter_widgets/models/talent.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  late SharedPreferences prefs;
  String? searchQuery;

  List<Talent> talents = [];

  void saveTalent({
    required String name,
    required String position,
    required int salary,
  }) {
    if (_formKey.currentState!.validate()) {
      List<String>? oldTalentsJson = prefs.getStringList('talents');
      if (oldTalentsJson != null) {
        talents =
            oldTalentsJson.map((t) => Talent.fromJson(jsonDecode(t))).toList();
      }
      talents.add(Talent(name: name, position: position, salary: salary));
      List<String> talentsJson =
          talents.map((t) => jsonEncode(t.toJson())).toList();
      prefs.setStringList('talents', talentsJson);
      setState(() {});
      Navigator.pop(context);
    }
  }

  void updateTalent({
    required String name,
    required String position,
    required int salary,
    required int index,
  }) {
    if (_formKey.currentState!.validate()) {
      List<String>? oldTalentsJson = prefs.getStringList('talents');
      if (oldTalentsJson != null) {
        talents =
            oldTalentsJson.map((t) => Talent.fromJson(jsonDecode(t))).toList();
      }
      talents[index] = Talent(name: name, position: position, salary: salary);
      List<String> talentsJson =
          talents.map((t) => jsonEncode(t.toJson())).toList();
      prefs.setStringList('talents', talentsJson);
      setState(() {});
      Navigator.pop(context);
    }
  }

  void deleteTalent(int index) {
    List<String>? oldTalentsJson = prefs.getStringList('talents');
    if (oldTalentsJson != null) {
      talents =
          oldTalentsJson.map((t) => Talent.fromJson(jsonDecode(t))).toList();
    }
    talents.removeAt(index);
    List<String> talentsJson =
        talents.map((t) => jsonEncode(t.toJson())).toList();
    prefs.setStringList('talents', talentsJson);
    setState(() {});
  }

  Future<List<Talent>> getTalents(String? query) async {
    prefs = await SharedPreferences.getInstance();
    List<String>? talentsJson = prefs.getStringList('talents');
    if (talentsJson != null) {
      List<Talent> talents =
          talentsJson.map((t) => Talent.fromJson(jsonDecode(t))).toList();
      if (query != null && query.isNotEmpty) {
        talents = talents
            .where((t) =>
                t.name.toLowerCase().contains(query.toLowerCase()) ||
                t.position.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
      return talents;
    }
    return [];
  }

  void updateTalentList(String value) {
    setState(() {
      searchQuery = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            SearchBox(
              updateTalentList: updateTalentList,
            ),
            FutureBuilder<List<Talent>>(
              future: getTalents(searchQuery ?? ''),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return TalentListCard(
                          name: snapshot.data![index].name,
                          position: snapshot.data![index].position,
                          salary: snapshot.data![index].salary,
                          edit: () {
                            showModalBottomEdit(context, snapshot, index);
                          },
                          delete: () {
                            showDialogAlertDelete(context, index);
                          },
                        );
                      },
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton:
          FloatingButton(formKey: _formKey, saveTalent: saveTalent),
    );
  }

  Future<dynamic> showDialogAlertDelete(BuildContext context, int index) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Talent'),
          backgroundColor: Colors.white,
          content: const Text('Are you sure want to delete this talent?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                deleteTalent(index);
                Navigator.pop(context);
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> showModalBottomEdit(
      BuildContext context, AsyncSnapshot<List<Talent>> snapshot, int index) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height < 600
                  ? MediaQuery.of(context).size.height
                  : MediaQuery.of(context).size.height * 0.4,
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: EditForm(
                formKey: _formKey,
                name: snapshot.data![index].name,
                position: snapshot.data![index].position,
                salary: snapshot.data![index].salary,
                index: index,
                onSubmit: updateTalent,
              ),
            ),
          ),
        );
      },
    );
  }
}

class FloatingButton extends StatelessWidget {
  final void Function({
    required String name,
    required String position,
    required int salary,
  }) saveTalent;

  const FloatingButton({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.saveTalent,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: const Text('Add'),
      icon: const Icon(Icons.add),
      backgroundColor: Theme.of(context).colorScheme.primary,
      onPressed: () {
        showModalBottom(context);
      },
    );
  }

  Future<dynamic> showModalBottom(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height < 600
                  ? MediaQuery.of(context).size.height
                  : MediaQuery.of(context).size.height * 0.4,
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: AddForm(
                formKey: _formKey,
                onSubmit: saveTalent,
              ),
            ),
          ),
        );
      },
    );
  }
}
