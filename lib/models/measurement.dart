import 'package:hive/hive.dart';
part 'measurement.g.dart';

@HiveType(typeId: 1)
class Measurement extends HiveObject {
  Measurement({
    required this.id,
    required this.customerId,
    required this.title,
    required this.createdAt,
    this.fullLength,
    this.blouseLength,
    this.kurtiLength,
    this.shoulder,
    this.upperBust,
    this.bustRound,
    this.underBust,
    this.bustToApex,
    this.apex,
    this.waistRound,
    this.hipRound,
    this.neckToWaist,
    this.neckToHip,
    this.sleeveLength,
    this.sleeveHole,
    this.biceps,
    this.armHole,
    this.pantLength,
    this.waistToKnee,
    this.thighRound,
    this.kneeRound,
    this.ankleRound,
    this.crotch,
    this.skirtLength,
    this.lowWaist,
    this.customFields,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  String customerId;

  @HiveField(2)
  String title;

  @HiveField(3)
  DateTime createdAt;

  // Upper Body
  @HiveField(4)
  double? fullLength;

  @HiveField(5)
  double? blouseLength;

  @HiveField(6)
  double? kurtiLength;

  @HiveField(7)
  double? shoulder;

  @HiveField(8)
  double? upperBust;

  @HiveField(9)
  double? bustRound;

  @HiveField(10)
  double? underBust;

  @HiveField(11)
  double? bustToApex;

  @HiveField(12)
  double? apex;

  @HiveField(13)
  double? waistRound;

  @HiveField(14)
  double? hipRound;

  @HiveField(15)
  double? neckToWaist;

  @HiveField(16)
  double? neckToHip;

  @HiveField(17)
  double? sleeveLength;

  @HiveField(18)
  double? sleeveHole;

  @HiveField(19)
  double? biceps;

  @HiveField(20)
  double? armHole;

  // Lower Body
  @HiveField(21)
  double? pantLength;

  @HiveField(22)
  double? waistToKnee;

  @HiveField(23)
  double? thighRound;

  @HiveField(24)
  double? kneeRound;

  @HiveField(25)
  double? ankleRound;

  @HiveField(26)
  double? crotch;

  @HiveField(27)
  double? skirtLength;

  @HiveField(28)
  double? lowWaist;

  @HiveField(29)
  Map<String, String>? customFields;
}
