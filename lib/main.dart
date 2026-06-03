import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/flavors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  F.appFlavor = Flavor.values.firstWhere(
        (element) => element.name == appFlavor,
  );
  runApp(
    ProviderScope(child: const App(),
      ),
    );
}
