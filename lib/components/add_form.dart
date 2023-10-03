import 'package:flutter/material.dart';

class AddForm extends StatefulWidget {
  final void Function({
    required String name,
    required String position,
    required int salary,
  }) onSubmit;

  const AddForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.onSubmit,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  final _nameController = TextEditingController();
  final _positionController = TextEditingController();
  final _salaryController = TextEditingController();

  void createTalent({
    required String name,
    required String position,
    required int salary,
  }) {
    if (widget._formKey.currentState!.validate()) {
      widget.onSubmit(
        name: name,
        position: position,
        salary: salary,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    createTalent(
                      name: _nameController.text,
                      position: _positionController.text,
                      salary: int.tryParse(_salaryController.text) ?? 0,
                    );
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
