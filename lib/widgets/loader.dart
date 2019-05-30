import 'package:flutter/material.dart';


class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
