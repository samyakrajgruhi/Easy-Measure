// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurement.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MeasurementAdapter extends TypeAdapter<Measurement> {
  @override
  final int typeId = 1;

  @override
  Measurement read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Measurement(
      id: fields[0] as String,
      customerId: fields[1] as String,
      title: fields[2] as String,
      createdAt: fields[3] as DateTime,
      fullLength: fields[4] as double?,
      blouseLength: fields[5] as double?,
      kurtiLength: fields[6] as double?,
      shoulder: fields[7] as double?,
      upperBust: fields[8] as double?,
      bustRound: fields[9] as double?,
      underBust: fields[10] as double?,
      bustToApex: fields[11] as double?,
      apex: fields[12] as double?,
      waistRound: fields[13] as double?,
      hipRound: fields[14] as double?,
      neckToWaist: fields[15] as double?,
      neckToHip: fields[16] as double?,
      sleeveLength: fields[17] as double?,
      sleeveHole: fields[18] as double?,
      biceps: fields[19] as double?,
      armHole: fields[20] as double?,
      pantLength: fields[21] as double?,
      waistToKnee: fields[22] as double?,
      thighRound: fields[23] as double?,
      kneeRound: fields[24] as double?,
      ankleRound: fields[25] as double?,
      crotch: fields[26] as double?,
      skirtLength: fields[27] as double?,
      lowWaist: fields[28] as double?,
      customFields: (fields[29] as Map?)?.cast<String, String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Measurement obj) {
    writer
      ..writeByte(30)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.customerId)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.fullLength)
      ..writeByte(5)
      ..write(obj.blouseLength)
      ..writeByte(6)
      ..write(obj.kurtiLength)
      ..writeByte(7)
      ..write(obj.shoulder)
      ..writeByte(8)
      ..write(obj.upperBust)
      ..writeByte(9)
      ..write(obj.bustRound)
      ..writeByte(10)
      ..write(obj.underBust)
      ..writeByte(11)
      ..write(obj.bustToApex)
      ..writeByte(12)
      ..write(obj.apex)
      ..writeByte(13)
      ..write(obj.waistRound)
      ..writeByte(14)
      ..write(obj.hipRound)
      ..writeByte(15)
      ..write(obj.neckToWaist)
      ..writeByte(16)
      ..write(obj.neckToHip)
      ..writeByte(17)
      ..write(obj.sleeveLength)
      ..writeByte(18)
      ..write(obj.sleeveHole)
      ..writeByte(19)
      ..write(obj.biceps)
      ..writeByte(20)
      ..write(obj.armHole)
      ..writeByte(21)
      ..write(obj.pantLength)
      ..writeByte(22)
      ..write(obj.waistToKnee)
      ..writeByte(23)
      ..write(obj.thighRound)
      ..writeByte(24)
      ..write(obj.kneeRound)
      ..writeByte(25)
      ..write(obj.ankleRound)
      ..writeByte(26)
      ..write(obj.crotch)
      ..writeByte(27)
      ..write(obj.skirtLength)
      ..writeByte(28)
      ..write(obj.lowWaist)
      ..writeByte(29)
      ..write(obj.customFields);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MeasurementAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
