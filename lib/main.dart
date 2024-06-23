import 'package:asalam/data/location.dart';
import 'package:asalam/data/prayer_times.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Location.loadPosition();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final prayerToday = PrayerToday();
    final prayerTimeFormatter = DateFormat('h:mm', );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        useMaterial3: true,
      ),
      title: 'Asalam',
      home: Scaffold(
        body: ListView(
          children: [
            ListTile(
              title: const Text('Position'),
              subtitle: Text(Location.position?.toString() ?? 'Unset'),
              trailing: const IconButton(
                  onPressed: Location.resetPosition,
                  icon: Icon(Icons.location_searching_rounded)),
            ),
            ListTile(
              title: const Text('Fajr'),
              subtitle: Text(prayerTimeFormatter.format(prayerToday.fajr)),
            ),
            ListTile(
              title: const Text('Sunrise'),
              subtitle: Text(prayerTimeFormatter.format(prayerToday.sunrise)),
            ),
            ListTile(
              title: const Text('Dhuhr'),
              subtitle: Text(prayerTimeFormatter.format(prayerToday.dhuhr)),
            ),
            ListTile(
              title: const Text('Asr'),
              subtitle: Text(prayerTimeFormatter.format(prayerToday.asr)),
            ),
            ListTile(
              title: const Text('Maghrib'),
              subtitle: Text(prayerTimeFormatter.format(prayerToday.maghrib)),
            ),
            ListTile(
              title: const Text('Isha'),
              subtitle: Text(prayerTimeFormatter.format(prayerToday.isha)),
            ),
          ],
        ),
      ),
    );
  }
}
