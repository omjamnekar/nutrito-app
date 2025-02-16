import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/data/model/gen/nutri_com_state.dart';
import 'package:nutrito/data/storage/nutri.dart';
import 'package:nutrito/pages/functions/display/nutri_out%20history.dart';
import 'package:nutrito/util/theme/color.dart';

class NutriHistPage extends StatefulWidget {
  const NutriHistPage({super.key});

  @override
  State<NutriHistPage> createState() => _NutriHistPageState();
}

class _NutriHistPageState extends State<NutriHistPage> {
  List<NutriComState> nutriList = [];
  String index = "";
  bool isDelete = false;
  NutriPreference nutriPreference = NutriPreference();

  Future<void> loadData() async {
    final nutriListbeta = await nutriPreference.getNutriData();
    setState(() {
      nutriList = nutriListbeta;
    });
  }

  void activateDelete() {
    setState(() {
      isDelete = !isDelete;
    });
  }

  Future<void> removeData(String id) async {
    await nutriPreference.nutriRemove(id);
    await loadData();
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
        actions: [
          IconButton(
            onPressed: () => activateDelete(),
            icon: Icon(
              Icons.delete_outline,
              color: const Color.fromARGB(221, 40, 40, 40),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: Future.value(nutriList),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  // reverse: true,
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    final item = snapshot.data?[index];
                    return Card(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    NutriOutPageHistory(nutristate: item!),
                              ));
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Icon(Icons.menu),
                                      Gap(20),
                                      if (isDelete)
                                        GestureDetector(
                                          onTap: () async =>
                                              removeData(item?.id ?? ""),
                                          child: Icon(
                                            Icons.cancel_outlined,
                                            color: const Color.fromARGB(
                                                255, 255, 162, 155),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                Gap(10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: ColorManager.bluePrimary,
                                        ),
                                        child: Image.file(
                                          item?.fileImage ?? File(""),
                                          color: ColorManager.bluePrimary
                                              .withOpacity(0.5),
                                          colorBlendMode: BlendMode.color,
                                        ),
                                      ),
                                    ),
                                    Gap(5),
                                    Flexible(
                                      flex: 3,
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item
                                                      ?.genNutrilizationResponse
                                                      ?.initialPromptManager
                                                      ?.initialData
                                                      ?.name ??
                                                  "",
                                              style: GoogleFonts.ubuntu(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Gap(5),
                                            Text(
                                              item
                                                      ?.genNutrilizationResponse
                                                      ?.conclusionPromptManger
                                                      ?.conclusionData
                                                      ?.conclusion ??
                                                  "",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(),
                                            ),
                                            Gap(8),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color: const Color.fromARGB(
                                                        104, 0, 221, 181),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.star),
                                                      Text(
                                                        "${item?.genNutrilizationResponse?.conclusionPromptManger?.conclusionData?.overallHealthRating ?? ""}/10",
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: GoogleFonts
                                                            .poppins(),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  child: Text(
                                                    "Serving Size :${item?.genNutrilizationResponse?.conclusionPromptManger?.conclusionData?.servingSize ?? ""}",
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ),
                    );
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
