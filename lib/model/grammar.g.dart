// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grammar.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GrammarAdapter extends TypeAdapter<Grammar> {
  @override
  final int typeId = 11;

  @override
  Grammar read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Grammar(
      id: fields[0] as int,
      step: fields[1] as int,
      description: fields[7] as String,
      level: fields[2] as String,
      grammar: fields[3] as String,
      connectionWays: fields[4] as String,
      means: fields[5] as String,
      examples: (fields[6] as List).cast<Example>(),
    );
  }

  @override
  void write(BinaryWriter writer, Grammar obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.step)
      ..writeByte(2)
      ..write(obj.level)
      ..writeByte(3)
      ..write(obj.grammar)
      ..writeByte(4)
      ..write(obj.connectionWays)
      ..writeByte(5)
      ..write(obj.means)
      ..writeByte(6)
      ..write(obj.examples)
      ..writeByte(7)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GrammarAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
