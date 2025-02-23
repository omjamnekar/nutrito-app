import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutrito/network/controller/alternative.dart';
import 'package:nutrito/view/functions/display/alternative/alternative_image.dart';
import 'package:nutrito/view/functions/display/loading.dart';
import 'package:nutrito/util/theme/color.dart';
import 'package:shimmer/shimmer.dart';

class AlternativePage extends ConsumerStatefulWidget {
  const AlternativePage({super.key});

  @override
  ConsumerState<AlternativePage> createState() => _AlternativePageState();
}

class _AlternativePageState extends ConsumerState<AlternativePage> {
  File fileImage = File("");

  Future<void> providerData(ImageSource imageSource) async {
    final imagePicker = await ImagePicker().pickImage(source: imageSource);

    if (imagePicker != null) {
      setState(() {
        fileImage = File(imagePicker.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder<AlternativeController>(
              init: AlternativeController(),
              builder: (ctrl) {
                return Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Aleternative\nProduct !!",
                        style: GoogleFonts.poppins(
                          fontSize: 35,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                          height: 1.1,
                        ),
                      ),
                      Gap(20),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              flex: 3,
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 20),
                                child: Column(
                                  children: [
                                    Text(
                                      "Let's see Some Healthy Alternatives with one Click",
                                      style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        height: 1.2,
                                        color: const Color.fromARGB(
                                            255, 2, 185, 151),
                                      ),
                                    ),
                                    Gap(10),
                                    Text(
                                      "Discover a variety of healthy alternatives to your favorite products.",
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        height: 1.2,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    Container(
                                      height: 100,
                                      decoration: BoxDecoration(),
                                      child: fileImage.path.isNotEmpty
                                          ? Image.file(
                                              fileImage,
                                              fit: BoxFit.cover,
                                            )
                                          : null,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Flexible(
                                flex: 2,
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () async =>
                                          providerData(ImageSource.camera),
                                      child: Container(
                                        width: 170,
                                        height: 170,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.black26,
                                        ),
                                        child: Icon(
                                          Icons.camera,
                                          size: 100,
                                        ),
                                      ),
                                    ),
                                    Gap(10),
                                    Container(
                                      width: double.maxFinite,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        color: Colors.black87,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: TextButton.icon(
                                        onPressed: () async =>
                                            providerData(ImageSource.gallery),
                                        label: Text(
                                          "Files",
                                          style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ))
                          ],
                        ),
                      ),
                      Gap(10),
                      Container(
                        width: double.maxFinite,
                        height: 90,
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextButton.icon(
                          onPressed: () async {
                            if (fileImage.path.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("image is not selected")));
                              return;
                            }

                            await ctrl
                                .generateImageAlternative(fileImage, context)
                                .then((value) {
                              if (value.isNotEmpty) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AlternativeImagePage(
                                        alternative: value,
                                      ),
                                    ));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("server error")));
                              }
                            });
                          },
                          iconAlignment: IconAlignment.end,
                          icon: Icon(Icons.arrow_right_alt_sharp,
                              size: 30, color: ColorManager.bluePrimary),
                          label: Text(
                            "Show Products",
                            style: GoogleFonts.poppins(
                                fontSize: 23, color: ColorManager.bluePrimary),
                          ),
                        ),
                      ),
                      Gap(20),
                      Container(
                        child: Divider(
                          color: Colors.black38,
                        ),
                      ),
                      Gap(20),
                      Text(
                        "Options:",
                        style: GoogleFonts.poppins(fontSize: 25),
                      ),
                      FutureBuilder(
                        future: ctrl.fullRandom(ref),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Container(
                              height: (snapshot.data!.length / 2) * 100,
                              child: GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  final item = snapshot.data![index];
                                  return Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color.fromARGB(
                                              137, 0, 221, 181),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          flex: 2,
                                          child: Container(
                                            width: double.maxFinite,
                                            decoration: BoxDecoration(
                                                // color: const Color.fromARGB(84, 0, 221, 181),
                                                ),
                                            child: Image.network(
                                              item.imageUrl ??
                                                  "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg",
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.network(
                                                  "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg",
                                                  fit: BoxFit.cover,
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 2,
                                          child: Container(
                                            width: double.maxFinite,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: const Color.fromARGB(
                                                  255, 176, 255, 240),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 6, right: 6),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Flexible(
                                                        flex: 8,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Gap(5),
                                                            Text(
                                                              item.name ?? "",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                fontSize: 18,
                                                              ),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                            Text(
                                                              item.companyName ??
                                                                  "",
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                      fontSize:
                                                                          10,
                                                                      color: const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          4,
                                                                          144,
                                                                          118)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Flexible(
                                                        flex: 2,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(top: 6),
                                                          child: Icon(
                                                            Icons
                                                                .shopping_cart_outlined,
                                                            size: 23,
                                                            color: const Color
                                                                .fromARGB(255,
                                                                203, 203, 203),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Gap(5),
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        Flexible(
                                                          flex: 7,
                                                          child: Text(
                                                            item.healthBenefits!
                                                                    .map(
                                                                      (e) => e
                                                                          .toString(),
                                                                    )
                                                                    .toList()
                                                                    .join(
                                                                        '. ') ??
                                                                "",
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize:
                                                                        10,
                                                                    color: Colors
                                                                        .black45),
                                                          ),
                                                        ),
                                                        Gap(5),
                                                        Flexible(
                                                          flex: 3,
                                                          child: Container(
                                                            height: 34,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            child: TextButton(
                                                                onPressed:
                                                                    () {},
                                                                child: Text(
                                                                    "See")),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          } else {
                            return Container(
                              height: (10 / 2) * 150,
                              child: GridView.builder(
                                itemCount: 20,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                                itemBuilder: (context, index) {
                                  return Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                        },
                      )
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
