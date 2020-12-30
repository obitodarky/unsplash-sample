import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


class Bookmarks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _imageListView();
  }

  Widget _imageListView(){
    final bookmarkImagesBox = Hive.box('images');

    return ValueListenableBuilder(
      valueListenable: bookmarkImagesBox.listenable(),
      builder: (context, Box box, widget){
        return ListView.builder(
          itemCount: box.values.length,
          itemBuilder: (context, index){
            final bookmark = box.getAt(index);

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: CachedNetworkImage(
                  imageUrl: bookmark.imageUrl,
                ),
              ),
            );
          },
        );
      }
    );
  }

}
