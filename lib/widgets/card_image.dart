import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:unsplash_sample/model/bookmark_images.dart';
import 'package:unsplash_sample/model/photo_model.dart';
import 'package:unsplash_sample/ui/image_info.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:unsplash_sample/widgets/bookmark_icon.dart';

class CardImage extends StatelessWidget {
  final Photo photo;
  CardImage(this.photo);


  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    double finalHeight =
        displayWidth / (photo.width / photo.height);


    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ImageInfoScreen(photo)
        ));
      },
      child: Hero(
        tag: "photo${photo.id}",
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: photo.urls.regular,
                  fit: BoxFit.fill,
                  width: displayWidth,
                  height: finalHeight,
                  placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  placeholderFadeInDuration: Duration(seconds: 0),
                ),
                BookMarkIcon(photo)
              ]
            ),
          ),
        ),
      ),
    );
  }
}
