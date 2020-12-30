import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:unsplash_sample/model/bookmark_images.dart';
import 'package:hive_flutter/hive_flutter.dart';


class Bookmarks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("goes here");
    return _imageListView();
  }

  Widget _imageListView(){
    final bookmarkImagesBox = Hive.box('images');
    print(bookmarkImagesBox.values.length);
    return ValueListenableBuilder(
      valueListenable: bookmarkImagesBox.listenable(),
      builder: (context, Box box, widget){
        return Container(
          height: 300,
          child: ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index){
              print(index);
              print(bookmarkImagesBox.values);
              final bookmark = box.getAt(index);

              return CachedNetworkImage(
                imageUrl: bookmark.imageUrl,
              );
            },
          ),
        );
      }
    );
  }

}
