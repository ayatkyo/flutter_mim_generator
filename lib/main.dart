import 'package:mim_generator/app.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set local ke indonesia
  Intl.defaultLocale = "id_ID";

  // Run
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}