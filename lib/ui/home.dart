import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unsplash_sample/bloc/image_list/image_list_bloc.dart';
import 'package:unsplash_sample/bloc/image_list/index.dart';
import 'package:unsplash_sample/bloc/search_image/index.dart';
import 'package:unsplash_sample/model/photo_model.dart';
import 'package:unsplash_sample/ui/bookmarks.dart';
import 'package:unsplash_sample/ui/search_image.dart';
import 'package:unsplash_sample/ui/image_info.dart';
import 'package:hive/hive.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _bloc = ImageListBloc();
  final _scrollController = ScrollController();
  final _searchBloc = SearchImageBloc();



  @override
  void initState() {
    Hive.openBox('images');
    _bloc.add(ImageFetched(0));
    super.initState();
  }

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

            //bookmarks
            Bookmarks(),
          ],
        ),
      ),
    );
  }
}
