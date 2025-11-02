// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class MovieHiveModelAdapter extends TypeAdapter<MovieHiveModel> {
  @override
  final typeId = 0;

  @override
  MovieHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieHiveModel(
      backdropPath: fields[0] as String?,
      genreIds: (fields[1] as List).cast<int>(),
      id: (fields[2] as num).toInt(),
      overview: fields[3] as String,
      posterPath: fields[4] as String?,
      releaseDate: fields[5] as String?,
      title: fields[6] as String,
      voteAverage: (fields[7] as num).toDouble(),
      voteCount: (fields[8] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, MovieHiveModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.backdropPath)
      ..writeByte(1)
      ..write(obj.genreIds)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.overview)
      ..writeByte(4)
      ..write(obj.posterPath)
      ..writeByte(5)
      ..write(obj.releaseDate)
      ..writeByte(6)
      ..write(obj.title)
      ..writeByte(7)
      ..write(obj.voteAverage)
      ..writeByte(8)
      ..write(obj.voteCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
