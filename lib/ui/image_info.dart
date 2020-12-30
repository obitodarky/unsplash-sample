import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:unsplash_sample/model/bookmark_images.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:unsplash_sample/model/photo_model.dart';

class ImageInfoScreen extends StatelessWidget {
  final Photo photo;
  ImageInfoScreen(this.photo);
  final bookmarkBox = Hive.box('images');

  @override
  Widget build(BuildContext context) {
    String author = "${photo.user.firstName} ${photo.user.lastName}";
    String imageUrl = photo.urls.regular;
    String id = photo.id;

    return Scaffold(
      appBar: AppBar(
        title: Text("By: $author"),
        actions: [
          ValueListenableBuilder(
            valueListenable: bookmarkBox.listenable(),
            builder: (context, Box box, child){
              final newBookmark = BookmarkImages(imageUrl, author, id);
              bool isBookmarked = box.values.contains(newBookmark);

              return IconButton(
                icon: isBookmarked ? Icon(Icons.bookmark) : Icon(Icons.bookmark_border),
                onPressed: (){

                  if(box.values.contains(newBookmark)){
                    print(box.keys);
                    bookmarkBox.deleteAt(bookmarkBox.values.toList().indexWhere((element) => element == newBookmark));
                    return;
                  }
                  addBookmark(newBookmark);
                },
              );
            }
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.fill,
          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Icon(Icons.error),
          placeholderFadeInDuration: Duration(seconds: 0),
        ),
      ),
    );
  }

  void addBookmark(BookmarkImages image){
    if(!bookmarkBox.values.contains(image)){
      bookmarkBox.add(image);
    }
  }
}
