import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:unsplash_sample/model/bookmark_images.dart';
import 'package:unsplash_sample/model/photo_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BookMarkIcon extends StatelessWidget {
  final Photo photo;
  BookMarkIcon(this.photo);
  final bookmarkBox = Hive.box('images');
  final iconSize = 24.0;
  final iconColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    String author = "${photo.user.firstName} ${photo.user.lastName}";
    String imageUrl = photo.urls.regular;
    String id = photo.id;

    return ValueListenableBuilder(
        valueListenable: bookmarkBox.listenable(),
        builder: (context, Box box, child){
          final newBookmark = BookmarkImages(imageUrl, author, id);
          bool isBookmarked = box.values.contains(newBookmark);

          return IconButton(
            icon: isBookmarked ? Icon(Icons.bookmark, size: iconSize, color: iconColor,) : Icon(Icons.bookmark_border, size: iconSize, color: iconColor,),
            onPressed: () => _changeBookmarkValue(box, newBookmark),
          );
        }
    );
  }

  void _addBookmark(BookmarkImages image){
    if(!bookmarkBox.values.contains(image)){
      bookmarkBox.add(image);
    }
  }

  void _changeBookmarkValue(Box box, BookmarkImages newBookmark){
    if(box.values.contains(newBookmark)){
      bookmarkBox.deleteAt(bookmarkBox.values.toList().indexWhere((element) => element == newBookmark));
      return;
    }
    _addBookmark(newBookmark);
  }

}
