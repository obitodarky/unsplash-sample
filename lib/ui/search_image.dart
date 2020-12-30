import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unsplash_sample/bloc/search_image/index.dart';
import 'package:unsplash_sample/bloc/search_image/search_image_bloc.dart';
import 'package:unsplash_sample/model/photo_model.dart';
import 'package:unsplash_sample/ui/image_info.dart';

/*
class BookmarkedImages extends StatefulWidget {
  final String query;
  BookmarkedImages(this.query);

  @override
  _BookmarkedImagesState createState() => _BookmarkedImagesState();
}

class _BookmarkedImagesState extends State<BookmarkedImages> {
  final _bloc = SearchImageListBloc();
  final _scrollController = ScrollController();

  final _scrollThreshold = 200.0;

  @override
  void initState() {
    _bloc.add(SearchedImage(0, widget.query));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchImageListBloc, SearchImageListState>(
      cubit: _bloc,
      builder: (buildContext, state) {
        if (state is SearchImageError)
          return Center(
            child: Text("error"),
          );
        if (state is SearchInitialPhotoListState)
          return Center(
            child: CircularProgressIndicator(),
          );
        if (state is SearchImageLoaded) {
          print(state.photos.length);
          return ListView.builder(
              itemCount: state.photos.length + 1,
              controller: _scrollController,
              itemBuilder: (buildContext, index) {
                _scrollController.addListener((){
                  final maxScroll = _scrollController.position.maxScrollExtent;
                  final currentScroll = _scrollController.position.pixels;
                  if (maxScroll - currentScroll <= _scrollThreshold && !_bloc.isFetching && index == state.photos.length) {
                    if(_bloc.state is SearchImageLoaded){
                      _bloc.add(SearchedImage((_bloc.state as SearchImageLoaded).page + 1, widget.query), );
                    }
                  }
                });

                if (index >= state.photos.length) return CircularProgressIndicator();
                Photo item = state.photos[index];
                double displayWidth = MediaQuery.of(context).size.width;
                double finalHeight =
                    displayWidth / (item.width / item.height);

                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ImageInfoScreen(item.user.firstName, item.urls.regular)
                    ));
                  },
                  child: Hero(
                    tag: "photo${item.id}",
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: CachedNetworkImage(
                          imageUrl: item.urls.regular,
                          fit: BoxFit.fill,
                          width: displayWidth,
                          height: finalHeight,
                          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                          placeholderFadeInDuration: Duration(seconds: 0),
                        ),
                      ),
                    ),
                  ),
                );
              });
        }

        return Center(child: Text(""));
      },
    );
  }
}
*/


class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _bloc = ImageBloc();
  @override
  void initState() {
    _bloc.add(ImageSearchEvent(0, 'Jimmy'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Delegate'),
      ),
      body: Container(
        child: Center(
          child: RaisedButton(
            child: Text('Show search'),
            onPressed: () async {
              Photo selected = await showSearch<Photo>(
                context: context,
                delegate: ImageSearch(_bloc),
              );
              print(selected);
            },
          ),
        ),
      ),
    );
  }
}

class ImageSearch extends SearchDelegate<Photo> {
  final _bloc;

  ImageSearch(this._bloc);

  @override
  List<Widget> buildActions(BuildContext context) => null;

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: BackButtonIcon(),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    _bloc.add(ImageSearchEvent(0, query));

    return BlocBuilder<ImageBloc, SearchImageListState>(
      cubit: _bloc,
      builder: (BuildContext context, SearchImageListState state) {
        if (state is SearchImageError) {
          return Container(
            child: Text('Error'),
          );
        }
        if(state is SearchImageLoaded){
          return ListView.builder(
            itemBuilder: (context, index) {
              Photo item = state.photos[index];
              return ListTile(
                leading: Icon(Icons.add),
                title: Text(state.photos[index].user.firstName),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ImageInfoScreen(item.user.firstName, item.urls.regular)
                  ));
                },
              );
            },
            itemCount: state.photos.length,
          );
        }
        return Text("0");
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) => Container();
}