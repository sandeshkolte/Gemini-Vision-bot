import 'package:flutter/material.dart';
import 'package:gemini_vision/provider/state.dart';
import 'package:gemini_vision/screen/gemini.dart';
// import 'package:gemini_flutter/gemini_flutter.dart';
// import 'package:gemini_vision/screen/homescreen.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:provider/provider.dart';

void main() {
  // GeminiHandler().initialize(apiKey: "AIzaSyAG-lc64EjUwpynyWpO_6cjW3Gdrp_w8bE");
  Gemini.init(
      apiKey: "AIzaSyAG-lc64EjUwpynyWpO_6cjW3Gdrp_w8bE", enableDebugging: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => StateProvider(),
        child: MaterialApp(
          home: GeminiScreen(),
          theme: ThemeData.dark(),
          themeMode: ThemeMode.dark,
          darkTheme: ThemeData.dark(),
        ));
  }
}
