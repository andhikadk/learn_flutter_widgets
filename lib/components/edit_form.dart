import 'package:flutter/material.dart';

class EditForm extends StatefulWidget {
  final void Function({
    required String name,
    required String position,
    required int salary,
    required int index,
  }) onSubmit;

  final String name;
  final String position;
  final int salary;
  final int index;

  const EditForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.onSubmit,
    required this.name,
    required this.position,
    required this.salary,
    required this.index,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;

  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  final _nameController = TextEditingController();
  final _positionController = TextEditingController();
  final _salaryController = TextEditingController();

  void updateTalent({
    required String name,
    required String position,
    required int salary,
    required int index,
  }) {
    if (widget._formKey.currentState!.validate()) {
      widget.onSubmit(
        name: name,
        position: position,
        salary: salary,
        index: index,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
    _positionController.text = widget.position;
    _salaryController.text = widget.salary.toString();
  }

  @override
  Widget build(BuildContext context) {
    int index = widget.index;

    return Form(
      key: widget._formKey,
      child: Column(
        children: [
          TextFormField(
            autofocus: true,
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Name',
              hintText: 'Enter name',
              icon: const Icon(Icons.person),
              iconColor: Theme.of(context).colorScheme.primary,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _positionController,
            decoration: InputDecoration(
              labelText: 'Position',
              hintText: 'Enter position',
              icon: const Icon(Icons.work),
              iconColor: Theme.of(context).colorScheme.primary,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _salaryController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Salary',
              hintText: 'Enter salary',
              icon: const Icon(Icons.payments),
              iconColor: Theme.of(context).colorScheme.primary,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              final age = int.tryParse(value);
              if (age == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                const SizedBox(
                  width: 12,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    updateTalent(
                      name: _nameController.text,
                      position: _positionController.text,
                      salary: int.tryParse(_salaryController.text) ?? 0,
                      index: index,
                    );
                  },
                  child: const Text('Update'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
