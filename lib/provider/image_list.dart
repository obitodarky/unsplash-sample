import 'package:flutter/cupertino.dart';
import 'package:unsplash_sample/model/photo_model.dart';

class ImageListProvider with ChangeNotifier{
  List<Photo> _topList = [];
  List<Photo> _bottomList = [];
  int _currentTopPage = 0;
  int _currentBottomPage = 0;

  List<Photo> get topList => _topList;
  List<Photo> get bottomList => _bottomList;
  int get currentTopPage => _currentTopPage;
  int get currentBottomPage => _currentBottomPage;

  void addToTopList(List<Photo> photoList){
    for(Photo photo in photoList){
      _topList.add(photo);
    }
    print("${_topList.length} top list");
    notifyListeners();
  }

  void addToBottomList(List<Photo> photoList){
    _bottomList.addAll(photoList);
    print(_bottomList.length);
    notifyListeners();
  }

  void updateTopPage(int page){
    _currentTopPage = page;
    notifyListeners();
  }

  void updateBottomPage(int page){
    _currentBottomPage = page;
    notifyListeners();
  }

}