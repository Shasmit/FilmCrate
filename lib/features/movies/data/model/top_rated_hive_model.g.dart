// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_rated_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TopRatedHiveModelAdapter extends TypeAdapter<TopRatedHiveModel> {
  @override
  final int typeId = 1;

  @override
  TopRatedHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TopRatedHiveModel(
      id: fields[0] as int,
      original_language: fields[1] as String,
      original_title: fields[2] as String,
      overview: fields[3] as String,
      poster_path: fields[4] as String,
      backdrop_path: fields[5] as String,
      title: fields[6] as String,
      vote_average: fields[7] as num,
      release_date: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TopRatedHiveModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.original_language)
      ..writeByte(2)
      ..write(obj.original_title)
      ..writeByte(3)
      ..write(obj.overview)
      ..writeByte(4)
      ..write(obj.poster_path)
      ..writeByte(5)
      ..write(obj.backdrop_path)
      ..writeByte(6)
      ..write(obj.title)
      ..writeByte(7)
      ..write(obj.vote_average)
      ..writeByte(8)
      ..write(obj.release_date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TopRatedHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
