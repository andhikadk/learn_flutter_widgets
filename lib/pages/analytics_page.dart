import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learn_flutter_widgets/components/analytics_card.dart';
import 'package:learn_flutter_widgets/models/talent.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  late SharedPreferences prefs;
  int totalSalary = 0;
  int averageSalary = 0;
  int totalTalent = 0;
  int totalRoles = 0;

  Future<int> getTotalSalary() async {
    prefs = await SharedPreferences.getInstance();
    List<String>? oldTalentsJson = prefs.getStringList('talents');
    if (oldTalentsJson != null) {
      List<Talent> talents =
          oldTalentsJson.map((t) => Talent.fromJson(jsonDecode(t))).toList();
      int totalSalary = 0;
      for (var talent in talents) {
        totalSalary += talent.salary;
      }
      return totalSalary;
    }
    return 0;
  }

  Future<int> getAverageSalary() async {
    prefs = await SharedPreferences.getInstance();
    List<String>? oldTalentsJson = prefs.getStringList('talents');
    if (oldTalentsJson != null) {
      List<Talent> talents =
          oldTalentsJson.map((t) => Talent.fromJson(jsonDecode(t))).toList();
      int totalSalary = 0;
      for (var talent in talents) {
        totalSalary += talent.salary;
      }
      return totalSalary ~/ talents.length;
    }
    return 0;
  }

  Future<int> getTotalTalent() async {
    prefs = await SharedPreferences.getInstance();
    List<String>? oldTalentsJson = prefs.getStringList('talents');
    if (oldTalentsJson != null) {
      List<Talent> talents =
          oldTalentsJson.map((t) => Talent.fromJson(jsonDecode(t))).toList();
      return talents.length;
    }
    return 0;
  }

  Future<int> getTotalRoles() async {
    prefs = await SharedPreferences.getInstance();
    List<String>? oldTalentsJson = prefs.getStringList('talents');
    if (oldTalentsJson != null) {
      List<Talent> talents =
          oldTalentsJson.map((t) => Talent.fromJson(jsonDecode(t))).toList();
      List<String> roles = [];
      for (var talent in talents) {
        if (!roles.contains(talent.position)) {
          roles.add(talent.position);
        }
      }
      return roles.length;
    }
    return 0;
  }

  void setAmount() async {
    int totalSalary = await getTotalSalary();
    int averageSalary = await getAverageSalary();
    int totalTalent = await getTotalTalent();
    int totalRoles = await getTotalRoles();
    setState(() {
      this.totalSalary = totalSalary;
      this.averageSalary = averageSalary;
      this.totalTalent = totalTalent;
      this.totalRoles = totalRoles;
    });
  }

  @override
  void initState() {
    super.initState();
    setAmount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Analytics',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Column(
              children: [
                AnalyticsCard(
                  title: 'Total Cost',
                  amount: totalSalary,
                  isCurrency: true,
                ),
                AnalyticsCard(
                  title: 'Average Salary',
                  amount: averageSalary,
                  isCurrency: true,
                ),
                AnalyticsCard(
                  title: 'Total Talents',
                  amount: totalTalent,
                ),
                AnalyticsCard(
                  title: 'Total Roles',
                  amount: totalRoles,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
