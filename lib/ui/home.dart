import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unsplash_sample/provider/image_list.dart';
import 'package:unsplash_sample/ui/discover_images.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _page = 0;
  ImageListProvider imageListProvider;

  @override
  Widget build(BuildContext context) {
    imageListProvider = Provider.of<ImageListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Unsplash demo'),
        actions: [
          Text("Jump to Page:"),
          Container(
            width: MediaQuery.of(context).size.width / 6,
            padding: EdgeInsets.all(8),
            color: Colors.white,
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "0",
              ),
              onChanged: (value){
                ////print("${int.tryParse(value)} tryparse");
                if(int.tryParse(value) != null){
                  setState(() {
                    ////print(value);
                    _page = int.parse(value);

                  });
                }
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.forward),
            onPressed: () {
              //_bloc.add(ImageFetched(_page, jumpToPage: true));
            },
          )
        ],
      ),
      body: DiscoverImages(imageListProvider: imageListProvider,),
    );
  }
}
