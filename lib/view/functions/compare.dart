import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutrito/network/controller/gen.dart';
import 'package:nutrito/util/theme/color.dart';

class ComaparePage extends ConsumerStatefulWidget {
  const ComaparePage({super.key});

  @override
  ConsumerState<ComaparePage> createState() => _ComaparePageState();
}

class _ComaparePageState extends ConsumerState<ComaparePage> {
  File _fileIamge1 = File("");

  File _fileIamge2 = File("");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<GenController>(
          init: GenController(),
          builder: (ctrl) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Compare Section",
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromARGB(221, 72, 72, 72),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        label: Text("History"),
                        icon: Icon(
                          Icons.history,
                        ),
                      ),
                    ],
                  ),
                  Gap(10),
                  CompareSection(
                    onFileSelection: (file) {
                      setState(() {
                        _fileIamge1 = file;
                      });
                    },
                  ),
                  Gap(10),
                  Divider(),
                  Gap(10),
                  CompareSection(
                    onFileSelection: (file) {
                      setState(() {
                        _fileIamge2 = file;
                      });
                    },
                  ),
                  Gap(20),
                  SizedBox(
                    width: double.infinity,
                    height: 70,
                    child: TextButton(
                      onPressed: () async {
                        await ctrl.compareCompact(
                            _fileIamge1, _fileIamge2, ref, context);
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.black87),
                      ),
                      child: Text(
                        "Compare",
                        style: GoogleFonts.poppins(
                            fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ),
                  Gap(20),
                  OptionsSection(),
                ],
              ),
            );
          }),
    );
  }
}

class OptionsSection extends StatelessWidget {
  const OptionsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      decoration: BoxDecoration(
        color: const Color.fromARGB(192, 0, 0, 0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.compare_rounded,
                size: 30,
                color: ColorManager.bluePrimary,
              ),
              Text(
                "Compare\nProduct",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(color: Colors.white),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.downloading_outlined,
                size: 30,
                color: ColorManager.bluePrimary,
              ),
              Text(
                " download\nReport",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(color: Colors.white),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.summarize_outlined,
                size: 30,
                color: ColorManager.bluePrimary,
              ),
              Text(
                "Instant\nSummary",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(color: Colors.white),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.pin_invoke_outlined,
                size: 30,
                color: ColorManager.bluePrimary,
              ),
              Text(
                "Pin\nResults",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CompareSection extends StatefulWidget {
  Function(File) onFileSelection;

  CompareSection({super.key, required this.onFileSelection});

  @override
  State<CompareSection> createState() => _CompareSectionState();
}

class _CompareSectionState extends State<CompareSection> {
  bool isFileSelected = false;
  File imageFile = File("");
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: ColorManager.bluePrimary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 6,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.save,
                            color: Colors.white,
                            size: 30,
                          ),
                          TextButton.icon(
                              onPressed: () {},
                              icon: Icon(
                                Icons.new_label_outlined,
                                color: Colors.white,
                                size: 30,
                              ),
                              label: Text(
                                "New",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ))
                        ],
                      ),
                      Gap(10),
                      Text(
                        "Upload an image to analyze product. The model will scan it, provide insights on health impact.",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: GestureDetector(
                  onTap: () => _pickImage(ImageSource.camera),
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: const Color.fromARGB(255, 139, 248, 230),
                    ),
                    child: isFileSelected
                        ? ClipRRect(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            child: Image.file(
                              imageFile,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          )
                        : Icon(
                            Icons.camera,
                            color: const Color.fromARGB(221, 255, 255, 255),
                            size: 100,
                          ),
                  ),
                ),
              ),
            ],
          ),
          Gap(10),
          GestureDetector(
            onTap: () => _pickImage(ImageSource.gallery),
            child: Container(
              width: double.infinity,
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: const Color.fromARGB(221, 128, 127, 127), width: 1),
              ),
              child: Text("Upload File"),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage(ImageSource imageSource) async {
    print("pressed");
    final imagefile = await ImagePicker().pickImage(source: imageSource);

    if (imagefile != null && imagefile.path.isNotEmpty) {
      print("image is selecteed");
      setState(() {
        imageFile = File(imagefile.path);
        isFileSelected = true;
      });
      widget.onFileSelection(imageFile);
    }
  }
}
