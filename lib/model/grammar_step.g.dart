// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grammar_step.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GrammarStepAdapter extends TypeAdapter<GrammarStep> {
  @override
  final int typeId = 12;

  @override
  GrammarStep read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GrammarStep(
      level: fields[0] as String,
      step: fields[1] as int,
      grammars: (fields[2] as List).cast<Grammar>(),
    )
      ..unKnownGrammars = (fields[3] as List).cast<Grammar>()
      ..scores = fields[4] as int
      ..isFinished = fields[5] as bool?;
  }

  @override
  void write(BinaryWriter writer, GrammarStep obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.level)
      ..writeByte(1)
      ..write(obj.step)
      ..writeByte(2)
      ..write(obj.grammars)
      ..writeByte(3)
      ..write(obj.unKnownGrammars)
      ..writeByte(4)
      ..write(obj.scores)
      ..writeByte(5)
      ..write(obj.isFinished);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GrammarStepAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
