import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unsplash_sample/bloc/search_image/index.dart';
import 'package:unsplash_sample/bloc/search_image/search_image_bloc.dart';
import 'package:unsplash_sample/model/photo_model.dart';
import 'package:unsplash_sample/widgets/card_image.dart';

class ImageSearch extends SearchDelegate<Photo> {
  final _bloc;

  final _scrollController = ScrollController();

  final _scrollThreshold = 200.0;
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
    _bloc.add(DiscoverImageSearchEvent(0, query));

    print(query);
    return BlocBuilder<SearchImageBloc, SearchImageListState>(
      cubit: _bloc,
      builder: (BuildContext context, SearchImageListState state) {
        if (state is SearchImageError) {
          return Container(
            child: Text('Error'),
          );
        }
        if(state is SearchImageLoaded){
          return ListView.builder(
            itemCount: state.photos.length + 1,
            controller: _scrollController,
            itemBuilder: (buildContext, index) {
              _scrollController.addListener((){
                final maxScroll = _scrollController.position.maxScrollExtent;
                final currentScroll = _scrollController.position.pixels;
                if (maxScroll - currentScroll <= _scrollThreshold && !_bloc.isFetching && index == state.photos.length) {
                  if(_bloc.state is SearchImageLoaded){
                    _bloc.add(SearchImagePaginationEvent(query));
                  }
                }
              });

              if (index >= state.photos.length) return CircularProgressIndicator();
              Photo item = state.photos[index];

              return CardImage(item);
            },
          );
        }
        return Text("0");
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context){
    return Center(
      child: Text("Search for $query"),
    );
  }
}