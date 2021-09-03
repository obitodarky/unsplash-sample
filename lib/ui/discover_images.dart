import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  final _scrollController = ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
  int count = 1;
  List<int> top = [];
  List<int> bottom = List<int>.generate(10, (i) => i + 1);


  @override
  void initState() {
    super.initState();
    getImage();
  }

  @override
  Widget build(BuildContext context) {
    const Key centerKey = ValueKey('second-sliver-list');
    return NotificationListener<ScrollNotification>(
        onNotification: (t){
          if(t is UserScrollNotification){
            if(_scrollController.position.pixels <= 100 && _scrollController.position.userScrollDirection == ScrollDirection.forward){
              print('Getting top image');
              getImageTop();
            } else if(_scrollController.position.userScrollDirection == ScrollDirection.reverse){
              final maxScroll = _scrollController.position.maxScrollExtent;
              final currentScroll = _scrollController.position.pixels;
              if(maxScroll - currentScroll <= 300){
                getImageBottom();
              }
            }
            return true;
          }
          return false;
        },
        child: CustomScrollView(
          controller: _scrollController,
          center: centerKey,
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      Photo item = widget.imageListProvider.topList[index];
                      return CardImage(item);
                },
                childCount: widget.imageListProvider.topList.length,
              ),
            ),
            SliverList(
              key: centerKey,
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      Photo item = widget.imageListProvider.bottomList[index];
                      return CardImage(item);
                },
                childCount: widget.imageListProvider.bottomList.length,
              ),
            ),
          ],
        ),
      );
  }

  getImage() async {
    ImageListState state = await _bloc.getImages(5);
    if(state is ImageLoaded){
      widget.imageListProvider.addToBottomList(state.photos);
      widget.imageListProvider.updateBottomPage(state.page);
      widget.imageListProvider.updateTopPage(state.page);
    }
  }

  Future<void> getImageTop() async {
    if(widget.imageListProvider.currentTopPage != 0 ){
      ImageListState state = await _bloc.getImages(widget.imageListProvider.currentTopPage - 1);
      if(state is ImageLoaded){
        widget.imageListProvider.addToTopList(state.photos);
        widget.imageListProvider.updateTopPage(state.page);
      }
    }
  }

  getImageBottom() async {
    ImageListState state = await _bloc.getImages(widget.imageListProvider.currentBottomPage + 1);
    if(state is ImageLoaded){
      widget.imageListProvider.addToBottomList(state.photos);
      widget.imageListProvider.updateBottomPage(state.page);
    }
  }

}
