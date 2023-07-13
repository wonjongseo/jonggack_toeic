// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jlpt_step.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JlptStepAdapter extends TypeAdapter<JlptStep> {
  @override
  final int typeId = 10;

  @override
  JlptStep read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return JlptStep(
      headTitle: fields[0] as String,
      step: fields[1] as int,
      words: (fields[2] as List).cast<Word>(),
      scores: fields[4] as int,
    )
      ..unKnownWord = (fields[3] as List).cast<Word>()
      ..isFinished = fields[5] as bool?
      ..wrongQestion = (fields[6] as List?)?.cast<Question>();
  }

  @override
  void write(BinaryWriter writer, JlptStep obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.headTitle)
      ..writeByte(1)
      ..write(obj.step)
      ..writeByte(2)
      ..write(obj.words)
      ..writeByte(3)
      ..write(obj.unKnownWord)
      ..writeByte(4)
      ..write(obj.scores)
      ..writeByte(5)
      ..write(obj.isFinished)
      ..writeByte(6)
      ..write(obj.wrongQestion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JlptStepAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
