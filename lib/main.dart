import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';

import 'app.dart';
import 'core/flavors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Jiffy.setLocale('es');

  F.appFlavor = Flavor.values.firstWhere(
        (element) => element.name == appFlavor,
  );
  runApp(
    ProviderScope(child: const App(),
      ),
    );
}
