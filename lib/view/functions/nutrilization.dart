import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutrito/network/bloc/nutri_bloc.dart';
import 'package:nutrito/network/bloc/nutri_state.dart';
import 'package:nutrito/network/controller/gen.dart';
import 'package:nutrito/view/functions/display/loading.dart';
import 'package:nutrito/view/functions/display/nutri_hist.dart';
import 'package:nutrito/view/functions/display/nutri_out.dart';
import 'package:nutrito/util/extensions/extensions.dart';
import 'package:nutrito/util/theme/color.dart';

class NutriStateNavigate extends StatefulWidget {
  const NutriStateNavigate({super.key});

  @override
  State<NutriStateNavigate> createState() => _NutriStateNavigateState();
}

class _NutriStateNavigateState extends State<NutriStateNavigate> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NutriBloc, NutriState>(
      builder: (context, state) {
        if (state is NutriStart) {
          return NutrilizationPage();
        } else if (state is GenLoadingState) {
          return GenLoading();
        } else if (state is GenOutput) {
          return NutriOutPage(
            options: {},
          );
        } else {
          return GenLoading();
        }
      },
    );
  }
}

class NutrilizationPage extends ConsumerStatefulWidget {
  const NutrilizationPage({super.key});

  @override
  ConsumerState<NutrilizationPage> createState() => _NutrilizationPageState();
}

class _NutrilizationPageState extends ConsumerState<NutrilizationPage> {
  bool isDownLoad = false;
  bool isInstanct = false;
  bool isPinned = false;
  File fileImage = File("");
  bool isFileUploaded = false;

  List<DropdownMenuItem<String>> genItems = [
    DropdownMenuItem(
      value: "Gemini",
      child: Text("Gemini"),
    ),
    DropdownMenuItem(
      value: "Olama",
      child: Text("Olama"),
    ),
    DropdownMenuItem(
      value: "ChatGPT-4.0",
      child: Text("ChatGPT-4.0"),
    ),
    DropdownMenuItem(
      value: "ChatGPT-flash",
      child: Text("ChatGPT-flash"),
    ),
  ];

  String selectedItem = "Gemini";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.amber,
      ),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: () async {
          setState(() {
            isFileUploaded = false;
            fileImage = File("");
          });
        },
        child: GetBuilder<GenController>(
            init: GenController(),
            builder: (ctrl) {
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Text(
                              "Nutrilization",
                              style: GoogleFonts.poppins(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600,
                                  color: const Color.fromARGB(221, 36, 36, 36)),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NutriHistPage(),
                                  )),
                              child: Row(
                                children: [
                                  Text(
                                    "History",
                                    style: GoogleFonts.poppins(
                                      color: const Color.fromARGB(
                                          221, 122, 122, 122),
                                    ),
                                  ),
                                  Gap(5),
                                  Icon(
                                    Icons.history,
                                    color: const Color.fromARGB(
                                        221, 122, 122, 122),
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                            Gap(5),
                          ],
                        ),
                      ),
                      Gap(20),
                      SizedBox(
                        height: 400,
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              left: 0,
                              child: Container(
                                width: 250,
                                height: 200,
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(top: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  "Let's Nutrilize Food",
                                  style: GoogleFonts.poppins(
                                    fontSize: 26,
                                    color: ColorManager.bluePrimary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                width: 150,
                                height: 180,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(142, 0, 221, 181),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Transform.translate(
                                  offset: Offset(0, -25),
                                  child: IconButton(
                                    onPressed: () =>
                                        _pickImage(ImageSource.camera),
                                    icon: Icon(
                                      Icons.camera_outlined,
                                      color: Colors.white,
                                      size: 80,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              left: 0,
                              child: Container(
                                height: 280,
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: ColorManager.bluePrimary,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            Icons.save,
                                            color: Colors.white,
                                            size: 35,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "New",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Gap(10),
                                              Icon(
                                                Icons.new_label_outlined,
                                                color: Colors.white,
                                                size: 35,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Gap(5),
                                    Row(
                                      children: [
                                        Flexible(
                                          flex: 2,
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Upload an image to analyze product. The model will scan it, provide insights on health impact.",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                DropdownButton<String>(
                                                  items: genItems,
                                                  value: selectedItem,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      selectedItem = value!;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: GestureDetector(
                                            onTap: () =>
                                                _pickImage(ImageSource.gallery),
                                            child: !isFileUploaded
                                                ? Container(
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                        color: const Color
                                                            .fromARGB(
                                                            221, 54, 54, 54),
                                                        width: 1,
                                                        style:
                                                            BorderStyle.solid,
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Upload\nFile",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 15,
                                                          color: const Color
                                                              .fromARGB(
                                                              221, 74, 74, 74),
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  )
                                                : Container(
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      image: DecorationImage(
                                                        image: FileImage(
                                                          fileImage,
                                                        ),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Gap(15),
                                    SizedBox(
                                      height: 70,
                                      width: double.infinity,
                                      child: TextButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStatePropertyAll(
                                                  Colors.black87),
                                        ),
                                        onPressed: () async {
                                          await ctrl.nutrilizationCompact(
                                              fileImage, context, ref, {
                                            "isDownload": isDownLoad,
                                            "isFileUploaded": isFileUploaded,
                                            "isInstant": isInstanct,
                                            "isPinned": isPinned
                                          });
                                        },
                                        child: Text(
                                          "Start !!",
                                          style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(10),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(192, 0, 0, 0),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            //compare current image
                            // download Report
                            // Instant Summary:
                            // Instant Suggestions (ask boat)
                            // pin important Results
                            // Retry Option
                            // Share Insights

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
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isDownLoad = !isDownLoad;
                                });
                                snackBar(
                                    "Download Report is ${isDownLoad == true ? "Active" : "Disable"}");
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.downloading_outlined,
                                    size: 30,
                                    color: ColorManager.bluePrimary,
                                  ),
                                  Text(
                                    " Download\nReport",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isInstanct = !isInstanct;
                                });
                                snackBar(
                                    "Instant summary is ${isInstanct == true ? "Active" : "Disable"}");
                              },
                              child: Column(
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
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isPinned = !isPinned;
                                });
                                snackBar(
                                    "Pinmed Result is ${isPinned == true ? "Active" : "Disable"}");
                              },
                              child: Column(
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
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Gap(20),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Options",
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                color: const Color.fromARGB(221, 41, 41, 41),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      isFileUploaded = false;
                                      fileImage = File("");
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Text("Retry"),
                                      Gap(10),
                                      Icon(Icons.refresh).withIconStyle(),
                                    ],
                                  ),
                                ),
                                Gap(10),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _processingModes
                                          .updateAll((key, value) => false);
                                      _instructionStyles
                                          .updateAll((key, value) => false);
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Text("Reset"),
                                      Gap(10),
                                      Icon(Icons.restore_page_sharp)
                                          .withIconStyle(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 600,
                        child: ListView(
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            // 1. Processing Modes
                            ListTile(
                              leading:
                                  Icon(Icons.speed, color: Colors.blueAccent),
                              title: Text(
                                "Processing Mode",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text(
                                "Choose how the model processes your image.",
                                style: GoogleFonts.poppins(
                                    fontSize: 12, color: Colors.grey),
                              ),
                              trailing: Icon(Icons.arrow_drop_down),
                            ),
                            CheckboxListTile(
                              title: Text("🧠 Standard"),
                              value: _processingModes["Standard"],
                              onChanged: (bool? value) {
                                setState(() {
                                  _processingModes["Standard"] = value!;
                                });
                              },
                            ),
                            CheckboxListTile(
                              title: Text("⚡ Fast"),
                              value: _processingModes["Fast"],
                              onChanged: (bool? value) {
                                setState(() {
                                  _processingModes["Fast"] = value!;
                                });
                              },
                            ),
                            CheckboxListTile(
                              title: Text("🎯 Accurate"),
                              value: _processingModes["Accurate"],
                              onChanged: (bool? value) {
                                setState(() {
                                  _processingModes["Accurate"] = value!;
                                });
                              },
                            ),
                            CheckboxListTile(
                              title: Text("🔍 Inspect"),
                              value: _processingModes["Inspect"],
                              onChanged: (bool? value) {
                                setState(() {
                                  _processingModes["Inspect"] = value!;
                                });
                              },
                            ),
                            Divider(),

                            // 2. Instruction Styles
                            ListTile(
                              leading: Icon(Icons.tips_and_updates,
                                  color: Colors.green),
                              title: Text(
                                "Instruction Style",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text(
                                "Choose how instructions are provided.",
                                style: GoogleFonts.poppins(
                                    fontSize: 12, color: Colors.grey),
                              ),
                              trailing: Icon(Icons.arrow_drop_down),
                            ),
                            CheckboxListTile(
                              title: Text("💡 Guided"),
                              value: _instructionStyles["Guided"],
                              onChanged: (bool? value) {
                                setState(() {
                                  _instructionStyles["Guided"] = value!;
                                });
                              },
                            ),
                            CheckboxListTile(
                              title: Text("📘 Expert"),
                              value: _instructionStyles["Expert"],
                              onChanged: (bool? value) {
                                setState(() {
                                  _instructionStyles["Expert"] = value!;
                                });
                              },
                            ),
                            CheckboxListTile(
                              title: Text("🔄 Retry"),
                              value: _instructionStyles["Retry"],
                              onChanged: (bool? value) {
                                setState(() {
                                  _instructionStyles["Retry"] = value!;
                                });
                              },
                            ),
                            Divider(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  void _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();

    final response = await picker.pickImage(source: source) ?? XFile("");
    if (response == XFile("")) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please take image first")));
      return;
    }
    if (response.path.isNotEmpty) {
      setState(() {
        fileImage = File(response.path);
        isFileUploaded = true;
      });
      print("image selection is done");
    }
  }

  final Map<String, bool> _processingModes = {
    "Standard": false,
    "Fast": false,
    "Accurate": false,
    "Inspect": false,
  };

  final Map<String, bool> _instructionStyles = {
    "Guided": false,
    "Expert": false,
    "Retry": false,
  };

  void snackBar(String data) {
    print("asdsd");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(data),
      ),
    );
  }
}
