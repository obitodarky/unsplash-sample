import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unsplash_sample/bloc/image_list/image_list_bloc.dart';
import 'package:unsplash_sample/bloc/image_list/index.dart';
import 'package:unsplash_sample/model/photo_model.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _bloc = ImageListBloc();
  final _scrollController = ScrollController();

  final _scrollThreshold = 200.0;

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    _bloc.add(ImageFetched(1));
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
        ),
        body: TabBarView(
          children: [
            //infinite list view
            BlocBuilder<ImageListBloc, ImageListState>(
              cubit: _bloc,
              builder: (buildContext, state) {
                if (state is ImageError)
                  return Center(
                    child: Text("error"),
                  );
                if (state is InitialPhotoListState)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                if (state is ImageLoaded) {
                  print(state.photos.length);
                  return ListView.builder(
                      itemCount: state.photos.length + 1,
                      controller: _scrollController,
                      itemBuilder: (buildContext, index) {
                        if (index >= state.photos.length) return CircularProgressIndicator();
                        Photo item = state.photos[index];
                        double displayWidth = MediaQuery.of(context).size.width;
                        double finalHeight =
                            displayWidth / (item.width / item.height);

                        return InkWell(
                          onTap: () {
                          },
                          child: Hero(
                            tag: "photo${item.id}",
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                child: Image.network(
                                  item.urls.regular,
                                  fit: BoxFit.fill,
                                  width: displayWidth,
                                  height: finalHeight,
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                }

                return Center(child: Text(""));
              },
            ),
            //bookmarks
            Container(color: Colors.purple),
          ],
        ),
      ),
    );
  }
  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      if(_bloc.state is ImageLoaded){
        _bloc.add(ImageFetched((_bloc.state as ImageLoaded).page + 1));
      }
    }
  }
}
