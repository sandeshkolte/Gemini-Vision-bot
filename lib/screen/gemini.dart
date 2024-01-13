import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:gemini_vision/provider/state.dart';
// import 'package:gemini_flutter/gemini_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class GeminiScreen extends StatefulWidget {
  const GeminiScreen({super.key});

  @override
  State<GeminiScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<GeminiScreen> {
  File? selectedImage;

  final chatController = TextEditingController();
  String? output;

  ValueNotifier<bool> isTyping = ValueNotifier(false);

  Future picImageFromGallery() async {
    var pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;
    setState(() {
      selectedImage = File(pickedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    // String prompt = "";
    final textProvider = Provider.of<StateProvider>(context);

    void resultAns() {
      try {
        final gemini = Gemini.instance;
        // final file = File('assets/images/sample_image.png');
        gemini.textAndImage(
            text: chatController.text.toString(),

            /// text
            images: [selectedImage!.readAsBytesSync()]

            /// list of images
            ).then((value) {
          debugPrint(value?.content?.parts?.last.text ?? '');
          output = value?.content?.parts?.last.text ?? 'nothing';
          textProvider.showOutput(output);
          chatController.text = "";
        });
      } catch (e) {
        debugPrint(e.toString());
      } finally {
        isTyping.value = false;
      }
    }

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 150,
            width: 400,
            decoration: BoxDecoration(border: Border.all(color: Colors.white)),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Text(
                output.toString(),
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: isTyping,
            builder: (context, value, child) {
              if (value) {
                return const CircularProgressIndicator(
                  color: Colors.white,
                );
              } else {
                return const SizedBox(); // Or any other widget you want when not typing
              }
            },
          ),
          SizedBox(
              height: 300,
              width: 200,
              // color: Colors.amber,
              child: selectedImage != null
                  ? Image.file(selectedImage!)
                  : const Center(child: Text("Add Image"))),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  picImageFromGallery();
                  // resultAns();
                },
                child: const Text("Pick")),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  isTyping.value = true;
                  // picImageFromGallery();
                  chatController.text.isNotEmpty
                      ? resultAns()
                      : const Text("Ask me something");
                },
                child: const Text("Generate Vision")),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: chatController,
              decoration: const InputDecoration(hintText: "Ask me Anything"),
            ),
          )
        ],
      ),
    );
  }
}
