import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:desktop_window/desktop_window.dart';

void main() {
  setupWindow();
  runApp(
    // Provide the model to all widgets within the app
    ChangeNotifierProvider(
      // Initialize the model in the builder
      create: (context) => AgeCounter(),
      child: const MyApp(),
    ),
  );
}

const double windowWidth = 360;
const double windowHeight = 640;
void setupWindow() async {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    WidgetsFlutterBinding.ensureInitialized();
    await DesktopWindow.setWindowSize(const Size(windowWidth, windowHeight));
    await DesktopWindow.setMinWindowSize(const Size(windowWidth, windowHeight));
    await DesktopWindow.setMaxWindowSize(const Size(windowWidth, windowHeight));
  }
}

/// Model for tracking age with increments and decrements.
///
/// [ChangeNotifier] is a class in `flutter:foundation`. [AgeCounter] does
/// _not_ depend on Provider.
class AgeCounter with ChangeNotifier {
  int age = 0;
  int decrements = 0;

  void increment() {
    age++;
    notifyListeners();
  }

  void decrement() {
    if (age > 0) {
      age--;
      decrements++;
      notifyListeners();
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Age Counter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Age Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Your current age:',
              style: TextStyle(fontSize: 20),
            ),
            Consumer<AgeCounter>(
              builder: (context, counter, child) => Text(
                '${counter.age}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () => context.read<AgeCounter>().decrement(),
                  tooltip: 'Decrease Age',
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 20),
                FloatingActionButton(
                  onPressed: () => context.read<AgeCounter>().increment(),
                  tooltip: 'Increase Age',
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Decrements:',
              style: TextStyle(fontSize: 16),
            ),
            Consumer<AgeCounter>(
              builder: (context, counter, child) => Text(
                '${counter.decrements}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
