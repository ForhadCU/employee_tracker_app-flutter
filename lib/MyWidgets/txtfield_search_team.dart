import 'package:flutter/material.dart';

class SearchTeam extends StatelessWidget {
  const SearchTeam({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        suffixIcon: null,
        border: const OutlineInputBorder(),
        label: Text("Team name")

      ),
    );
  }
}
