import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unsplash_sample/bloc/api_bloc.dart';
import 'package:unsplash_sample/bloc/image_list_state.dart';
import 'package:unsplash_sample/provider/image_list.dart';
import 'package:unsplash_sample/ui/discover_images.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _page = 0;
  ApiBloc _bloc = ApiBloc();
  ImageListProvider imageListProvider;

  @override
  Widget build(BuildContext context) {
    imageListProvider = Provider.of<ImageListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Unsplash demo'),
        actions: [
          Container(
            width: MediaQuery.of(context).size.width / 6,
            padding: const EdgeInsets.all(8),
            color: Colors.white,
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "0",
              ),
              onChanged: (value){
                ////print("${int.tryParse(value)} tryparse");
                if(int.tryParse(value) != null){
                  _page = int.parse(value);
                }
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.forward),
            onPressed: () {
              if(_page != null){
                jumpToPage(_page);
              }
            },
          )
        ],
      ),
      body: DiscoverImages(imageListProvider: imageListProvider,),
    );
  }

  jumpToPage(int page) async {
    ImageListState state = await _bloc.getImages(page);
    if(state is ImageLoaded){
      imageListProvider.jumpToPage(state.photos, page);
    }
  }

}
