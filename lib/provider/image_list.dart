import 'package:flutter/cupertino.dart';
import 'package:unsplash_sample/model/photo_model.dart';

class ImageListProvider with ChangeNotifier{
  List<Photo> _topList = [];
  List<Photo> _bottomList = [];
  int _currentTopPage = 0;
  int _currentBottomPage = 0;
  bool _isFetching = false;

  List<Photo> get topList => _topList;
  List<Photo> get bottomList => _bottomList;
  int get currentTopPage => _currentTopPage;
  int get currentBottomPage => _currentBottomPage;
  bool get isFetching => _isFetching;

  void addToTopList(List<Photo> photoList){
    for(Photo photo in photoList){
      _topList.add(photo);
    }
    notifyListeners();
  }

  void addToBottomList(List<Photo> photoList){
    for(Photo photo in photoList){
      _bottomList.add(photo);
    }
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

  void jumpToPage(List<Photo> photoList, int page){
    _topList = [];
    _bottomList = photoList;
    _currentTopPage = page;
    _currentBottomPage = page;
    notifyListeners();
  }

  void updateIsFetching(bool value){
    _isFetching = value;
    notifyListeners();
  }

}