import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gemini_flutter/gemini_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    String prompt = "";

    return Scaffold(
      appBar: AppBar(
        elevation: 0.9,
        centerTitle: true,
        title: Text("Gemini Vision",
            style: GoogleFonts.openSans(
                color: Colors.white,
                textStyle: Theme.of(context).textTheme.headlineSmall)),
        backgroundColor: const Color.fromARGB(255, 115, 0, 63),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                  onPressed: () async {
                    final response = await GeminiHandler().geminiPro(
                      text: "Who are you",

                      // countTokens: true,
                      // path: "assets/images/sample_image.png"
                    );
                    prompt = response
                            ?.candidates?.first.content?.parts?.first.text ??
                        "Failed to fetch Data";
                    debugPrint("GEMINI PRO $prompt");
                    setState(() {});
                  },
                  child: const Text("Generate Pro")),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () async {
                    final response = await GeminiHandler().geminiProVision(
                        text: "Who are you",
                        // countTokens: true,
                        base64Format: "",
                        path: "assets/images/gemini_logo.jpeg",
                        imageFile: File("assets/images/gemini_logo.jpeg"));
                    prompt = response
                            ?.candidates?.first.content?.parts?.first.text ??
                        "Failed to fetch Data";
                    debugPrint("GEMINI VISION $prompt");
                    setState(() {});
                  },
                  child: const Text("Generate Vision")),
            ),
          ],
        ),
      ),
    );
  }
}
