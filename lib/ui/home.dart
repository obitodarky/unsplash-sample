import 'package:flutter/material.dart';
import 'package:unsplash_sample/bloc/search_image/index.dart';
import 'package:unsplash_sample/model/photo_model.dart';
import 'package:unsplash_sample/ui/bookmarks.dart';
import 'package:unsplash_sample/ui/discover_images.dart';
import 'package:unsplash_sample/ui/search_image.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final _searchBloc = SearchImageBloc();


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Text("Discover")),
              Tab(icon: Text("Bookmarks")),
            ],
          ),
          title: Text('Unsplash demo'),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                Photo selected = await showSearch<Photo>(
                  context: context,
                  delegate: ImageSearch(_searchBloc),
                );
              },
            )
          ],
        ),
        body: TabBarView(
          children: [
            //infinite list view
            DiscoverImages(),
            //bookmarks
            Bookmarks(),
          ],
        ),
      ),
    );
  }
}
