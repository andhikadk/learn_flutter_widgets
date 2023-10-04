import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TalentListCard extends StatelessWidget {
  final String name;
  final String position;
  final int salary;
  final Function() edit;
  final Function() delete;

  const TalentListCard({
    super.key,
    required this.name,
    required this.position,
    required this.salary,
    required this.edit,
    required this.delete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: ListTile(
        onTap: () {
          talentDetail(context);
        },
        title: Text(
          name,
          style: const TextStyle(fontSize: 18),
        ),
        iconColor: Theme.of(context).colorScheme.primary,
        subtitle: Text(position, style: const TextStyle(fontSize: 12)),
        leading: const Icon(Icons.person),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                edit();
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                delete();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> talentDetail(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(name),
          backgroundColor: Colors.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(position),
              Text(
                NumberFormat.currency(
                  locale: 'id',
                  symbol: 'Rp',
                  decimalDigits: 0,
                ).format(salary),
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
