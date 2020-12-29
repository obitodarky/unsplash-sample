import 'package:flutter/material.dart';
import 'package:unsplash_sample/ui/home.dart';

class EntryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
