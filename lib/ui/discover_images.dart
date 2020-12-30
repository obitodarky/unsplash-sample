import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:unsplash_sample/bloc/image_list/index.dart';
import 'package:unsplash_sample/model/photo_model.dart';
import 'package:unsplash_sample/ui/image_info.dart';
import 'package:unsplash_sample/widgets/card_image.dart';

class DiscoverImages extends StatefulWidget {
  @override
  _DiscoverImagesState createState() => _DiscoverImagesState();
}

class _DiscoverImagesState extends State<DiscoverImages> {
  final _bloc = ImageListBloc();

  final _scrollThreshold = 200.0;
  final _scrollController = ScrollController();


  @override
  void initState() {
    Hive.openBox('images');
    _bloc.add(ImageFetched(0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageListBloc, ImageListState>(
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
                _scrollController.addListener((){
                  final maxScroll = _scrollController.position.maxScrollExtent;
                  final currentScroll = _scrollController.position.pixels;
                  if (maxScroll - currentScroll <= _scrollThreshold && !_bloc.isFetching && index == state.photos.length) {
                    if(_bloc.state is ImageLoaded){
                      _bloc.add(ImageFetched((_bloc.state as ImageLoaded).page + 1));
                    }
                  }
                });

                if (index >= state.photos.length) return CircularProgressIndicator();
                Photo item = state.photos[index];

                return CardImage(item);
              });
        }
        return Center(child: Text(""));
      },
    );
  }
}
