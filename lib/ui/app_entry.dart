import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unsplash_sample/provider/image_list.dart';
import 'package:unsplash_sample/ui/home.dart';

class EntryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<ImageListProvider>(
            create: (_) => ImageListProvider(),
          ),
        ],
        child: Home()
      ),
    );
  }
}
