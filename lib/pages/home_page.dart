import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learn_flutter_widgets/components/add_form.dart';
import 'package:learn_flutter_widgets/data/talent.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  late SharedPreferences prefs;

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

  Future<List<Talent>> getTalents() async {
    prefs = await SharedPreferences.getInstance();
    List<String>? talentsJson = prefs.getStringList('talents');
    if (talentsJson != null) {
      return talentsJson.map((t) => Talent.fromJson(jsonDecode(t))).toList();
    }
    return [];
  }

  Future initial() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    initial();
    super.initState();
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
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 2));
          setState(() {});
        },
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(12),
                color: Colors.white,
                child: const Center(
                  child: Text(
                    'Talent List',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              FutureBuilder<List<Talent>>(
                future: getTalents(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(snapshot.data![index].name),
                            subtitle: Text(snapshot.data![index].position),
                            trailing: Text(
                              snapshot.data![index].salary.toString(),
                            ),
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
      ),
      floatingActionButton:
          FloatingButton(formKey: _formKey, saveTalent: saveTalent),
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
          child: Container(
            height: MediaQuery.of(context).size.height * 0.4,
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: AddForm(
              formKey: _formKey,
              onSubmit: saveTalent,
            ),
          ),
        );
      },
    );
  }
}
