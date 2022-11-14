import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text(
        text,
        style: TextStyle(color: Theme.of(context).indicatorColor),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    ));
}
