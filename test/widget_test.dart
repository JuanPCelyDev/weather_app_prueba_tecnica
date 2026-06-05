import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app_prueba_tecnica/app.dart';
import 'package:weather_app_prueba_tecnica/core/flavors.dart';

void main() {
  testWidgets('Verificar que la app renderiza correctamente', (WidgetTester tester) async {

    // se Inicializa el flavor antes de cargar la app
    F.appFlavor = Flavor.dev;


    await tester.pumpWidget(
      const ProviderScope(
        child: App(),
      ),
    );

    await tester.pump(const Duration(seconds: 1));

    expect(find.byType(App), findsOneWidget);
  });
}
