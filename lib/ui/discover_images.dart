import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:unsplash_sample/bloc/api_bloc.dart';
import 'package:unsplash_sample/bloc/image_list_state.dart';
import 'package:unsplash_sample/model/photo_model.dart';
import 'package:unsplash_sample/provider/image_list.dart';
import 'package:unsplash_sample/widgets/card_image.dart';

class DiscoverImages extends StatefulWidget {
  final ImageListProvider imageListProvider;

  const DiscoverImages({Key key, this.imageListProvider}) : super(key: key);

  @override
  _DiscoverImagesState createState() => _DiscoverImagesState();
}

class _DiscoverImagesState extends State<DiscoverImages> {
  final _bloc = ApiBloc();
  final _scrollController =
      ScrollController();
  final _scrollThreshold = 200;
  Key centerKey = ValueKey('bottom-list');
  ImageListProvider _imageListProvider;

  @override
  void initState() {
    super.initState();
    _imageListProvider = Provider.of<ImageListProvider>(context, listen: false);
    getImage();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (t) {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentScroll = _scrollController.position.pixels;
        if(t is ScrollStartNotification){
          print("scroll start");
          if(_scrollController.position.pixels <= 100 &&
              _scrollController.position.userScrollDirection ==
                  ScrollDirection.forward && !_imageListProvider.isFetching){
            getImageTop();
          }
        }
        else if (t is UserScrollNotification) {
          print("user scroll");
          if (_scrollController.position.pixels <= 100 &&
              _scrollController.position.userScrollDirection ==
                  ScrollDirection.forward && !_imageListProvider.isFetching) {
            getImageTop();
          }
          return true;
        } else if (t is ScrollUpdateNotification) {
          print("scroll update");
          if (maxScroll - currentScroll <= _scrollThreshold &&
              _scrollController.position.userScrollDirection ==
                  ScrollDirection.reverse && !_imageListProvider.isFetching) {
            getImageBottom();
          }
        }
        return false;
      },
      child: CustomScrollView(
        center: centerKey,
        controller: _scrollController,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                Photo item = _imageListProvider.topList[index];
                return CardImage(item);
              },
              childCount: _imageListProvider.topList.length,
            ),
          ),
          SliverList(
            key: centerKey,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                Photo item = _imageListProvider.bottomList[index];
                return CardImage(item);
              },
              childCount: _imageListProvider.bottomList.length,
            ),
          ),
        ],
      ),
    );
  }

  getImage() async {
    ImageListState state = await _bloc.getImages(5);
    if (state is ImageLoaded) {
      _imageListProvider.addToBottomList(state.photos);
      _imageListProvider.updateBottomPage(state.page);
      _imageListProvider.updateTopPage(state.page);
    }
  }

  Future<void> getImageTop() async {
    if (_imageListProvider.currentTopPage != 0) {
      _imageListProvider.updateIsFetching(true);
      ImageListState state =
          await _bloc.getImages(_imageListProvider.currentTopPage - 1);
      if (state is ImageLoaded) {
        _imageListProvider.addToTopList(state.photos);
        _imageListProvider.updateTopPage(state.page);
        _imageListProvider.updateIsFetching(false);
      }
    }
  }

  getImageBottom() async {
    _imageListProvider.updateIsFetching(true);
    ImageListState state =
        await _bloc.getImages(_imageListProvider.currentBottomPage + 1);
    if (state is ImageLoaded) {
      _imageListProvider.addToBottomList(state.photos);
      _imageListProvider.updateBottomPage(state.page);
      _imageListProvider.updateIsFetching(false);
    }
  }
}
