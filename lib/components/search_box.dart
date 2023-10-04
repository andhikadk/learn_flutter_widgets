import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  final void Function(String value) updateTalentList;

  const SearchBox({
    super.key,
    required this.updateTalentList,
  });

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _showClearIcon = false;

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      setState(() {
        _showClearIcon = _textEditingController.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      color: Colors.white,
      child: TextField(
        controller: _textEditingController,
        onChanged: (value) => widget.updateTalentList(value),
        autofocus: false,
        decoration: InputDecoration(
          hintText: 'Search Talent',
          filled: true,
          fillColor: const Color.fromARGB(255, 239, 239, 239),
          prefixIcon: const Icon(Icons.search),
          suffixIcon: Visibility(
            visible: _showClearIcon,
            child: Opacity(
              opacity: 0.5,
              child: IconButton(
                icon: const Icon(Icons.cancel),
                onPressed: () {
                  _textEditingController.clear();
                  widget.updateTalentList('');
                },
              ),
            ),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
