import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:unsplash_sample/ui/image_info.dart';

class DiscoverImages extends StatefulWidget {
  @override
  _DiscoverImagesState createState() => _DiscoverImagesState();
}

class _DiscoverImagesState extends State<DiscoverImages> {
  final _scrollThreshold = 200.0;

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
                double displayWidth = MediaQuery.of(context).size.width;
                double finalHeight =
                    displayWidth / (item.width / item.height);

                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ImageInfoScreen(item.user.firstName, item.urls.regular, item.id)
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
