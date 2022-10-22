import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Settings {
  Settings._();

  static late Box<int> _box;

  static Future<void> initialize() async {
    await Hive.initFlutter();
    _box = await Hive.openBox<int>('settings');
    await _initializeSettings();
  }

  static Future<void> _initializeSettings() async {
    if (_box.get('appColor') == null)
      await _box.put('appColor', Colors.blue.value);
  }

  static ValueListenable<Box<int>> get listenable => _box.listenable();

  static set appColor(Color color) => _box.put('appColor', color.value);
  static Color get appColor => Color(_box.get('appColor')!);
  static MaterialColor get appMaterialColor {
    final color = appColor;
    return MaterialColor(
      color.value,
      {
        50: color.withOpacity(0.1),
        100: color.withOpacity(0.2),
        200: color.withOpacity(0.3),
        300: color.withOpacity(0.4),
        400: color.withOpacity(0.5),
        500: color.withOpacity(0.6),
        600: color.withOpacity(0.7),
        700: color.withOpacity(0.8),
        800: color.withOpacity(0.9),
        900: color.withOpacity(1),
      },
    );
  }

  // Get bubble color stream
  static ValueNotifier<Color> get getBubbleColor {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final color = ValueNotifier<Color>(Colors.blue);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .snapshots()
        .listen((event) {
      color.value = Color(event.get('color') as int);
    });
    return color;
  }

  static Future<void> setBubbleColor(Color color) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'color': color.value});
  }
}
