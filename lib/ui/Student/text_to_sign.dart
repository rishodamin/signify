import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';

class Texttosign extends StatefulWidget {
  const Texttosign({super.key});

  @override
  State<Texttosign> createState() => _TexttosignState();
}

class _TexttosignState extends State<Texttosign> {
  String data = "";
  bool isFocus = false;
  bool isConverting = false;
  final _controller = TextEditingController();
  final _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(checkFocus);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  void checkFocus() async {
    if (!_focus.hasFocus) {
      await Future.delayed(const Duration(milliseconds: 450));
      isFocus = _focus.hasFocus;
    } else {
      isFocus = _focus.hasFocus;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Text/voice to Sign"),
          backgroundColor: const Color.fromARGB(255, 233, 223, 190),
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.black,
                child: Cube(
                  onSceneCreated: (Scene scene) {
                    scene.world.add(Object(fileName: 'assets/img/MaleLow.obj'));
                    scene.camera.zoom = 20;
                  },
                ),
              ),
            ),
            // SizedBox(
            //     height: 300,
            //     width: MediaQuery.of(context).size.width,
            //     child: data.isEmpty
            //         ? Image.asset(
            //             "assets/ISL_Gifs/stll.png",
            //             fit: BoxFit.cover,
            //             errorBuilder: (context, error, stackTrace) {
            //               return const Center(
            //                 child: Text(
            //                   "Sry No Image Found....",
            //                   style: TextStyle(
            //                     fontSize: 24,
            //                   ),
            //                 ),
            //               );
            //             },
            //           )
            //         : Image.asset(
            //             "assets/ISL_Gifs/excited.gif",
            //             fit: BoxFit.cover,
            //             errorBuilder: (context, error, stackTrace) {
            //               return const Center(
            //                 child: Text(
            //                   "Sry No Image Found....",
            //                   style: TextStyle(
            //                     fontSize: 24,
            //                   ),
            //                 ),
            //               );
            //             },
            //           )),
            // const Spacer(),
            if (!isFocus)
              Image.asset(
                "assets/img/voice.png",
                errorBuilder: (context, error, stackTrace) =>
                    const SizedBox.shrink(),
              ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  focusNode: _focus,
                  controller: _controller,
                  decoration: InputDecoration(
                      hintText: "Enter the text",
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 233, 223, 190),
                              width: 3)),
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.black)),
                      prefixIcon: const Icon(Icons.text_fields_outlined),
                      suffixIcon: IconButton(
                          onPressed: () async {
                            _focus.unfocus();
                            if (isConverting) {
                              return;
                            }
                            isConverting = true;
                            await Future.delayed(
                                const Duration(milliseconds: 1500));
                            data = 'excited';
                            setState(() {});
                            await Future.delayed(const Duration(seconds: 8));
                            data = '';
                            isConverting = false;
                            setState(() {});
                          },
                          icon: const Icon(Icons.send)))),
            ),
          ],
        ));
  }
}
