import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildLoadingIndicator() {
  return Container(
    color: Colors.black.withOpacity(0.5), // You can adjust the opacity
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}
