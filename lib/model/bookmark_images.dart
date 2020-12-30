import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'bookmark_images.g.dart';

@HiveType(typeId: 0)
class BookmarkImages extends Equatable{
  @HiveField(0)
  final String imageUrl;
  @HiveField(1)
  final String author;
  @HiveField(2)
  final String id;

  BookmarkImages(this.imageUrl, this.author, this.id);

  @override
  // TODO: implement props
  List<Object> get props => [imageUrl, author, id];
}