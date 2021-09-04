import 'package:flutter/material.dart';
import 'package:unsplash_sample/model/photo_model.dart';

abstract class ImageListState {}


class ImageError extends ImageListState {}

class ImageLoaded extends ImageListState {
  final List<Photo> photos;
  final int page;

  ImageLoaded(this.photos, this.page);
}
