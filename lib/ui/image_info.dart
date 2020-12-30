import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageInfoScreen extends StatelessWidget {
  final String author;
  final String url;
  ImageInfoScreen(this.author, this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("By: $author"),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark_border),
            onPressed: (){},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.fill,
          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Icon(Icons.error),
          placeholderFadeInDuration: Duration(seconds: 0),
        ),
      ),
    );
  }
}
