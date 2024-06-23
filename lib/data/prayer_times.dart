import 'package:adhan/adhan.dart';
import 'package:asalam/data/location.dart';

class PrayerToday {
  final _coordinates = Coordinates(Location.position!.latitude, Location.position!.longitude);
  CalculationMethod calculationMethod;
  Madhab madhab;

  PrayerToday({this.calculationMethod=CalculationMethod.moon_sighting_committee, this.madhab=Madhab.hanafi});

  PrayerTimes get today {
    var params = calculationMethod.getParameters();
    params.madhab = madhab;
    return PrayerTimes.today(_coordinates, params);
  }

  DateTime get fajr => today.fajr;
  DateTime get sunrise => today.sunrise;
  DateTime get dhuhr => today.dhuhr;
  DateTime get asr => today.asr;
  DateTime get maghrib => today.maghrib;
  DateTime get isha => today.isha;
}