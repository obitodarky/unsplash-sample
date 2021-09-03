import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:unsplash_sample/model/photo_model.dart';


class CardImage extends StatelessWidget {
  final Photo photo;
  CardImage(this.photo);


  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    double finalHeight =
        displayWidth / (photo.width / photo.height);

    return Padding(
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
            //BookMarkIcon(photo)
          ]
        ),
      ),
    );
  }
}
