// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_images.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookmarkImagesAdapter extends TypeAdapter<BookmarkImages> {
  @override
  final int typeId = 0;

  @override
  BookmarkImages read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookmarkImages(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BookmarkImages obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.imageUrl)
      ..writeByte(1)
      ..write(obj.author)
      ..writeByte(2)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookmarkImagesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
