import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:nutrito/data/model/gen/nutri_com_state.dart';
import 'package:nutrito/data/storage/nutri.dart';
import 'package:nutrito/util/extensions/extensions.dart';
import 'package:nutrito/view/functions/display/nutri_out%20history.dart';

class ScanHistory extends StatefulWidget {
  final Function() oncencel;

  const ScanHistory({
    super.key,
    required this.oncencel,
  });

  @override
  State<ScanHistory> createState() => _ScanHistoryState();
}

class _ScanHistoryState extends State<ScanHistory> {
  NutriPreference nutriPreference = NutriPreference();

  List<NutriComState> data = [];

  Future<void> setup() async {
    final dataitem = await nutriPreference.getNutriData();

    setState(() {
      data = dataitem;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setup();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: 500,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(42, 0, 0, 0),
            spreadRadius: 5,
            blurRadius: 10,
            offset: Offset(0, -2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: widget.oncencel,
              icon: const Icon(
                Icons.cancel_outlined,
                color: Colors.black87,
              ).withIconStyle(iconSize: 30),
            ),
          ),
          const Center(
            child: Text(
              'Scan History',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              color: const Color.fromARGB(68, 128, 128, 128),
            ),
          ),
          // Add a ListView to display the history
          Expanded(
            child: FutureBuilder(
                future: Future.value(data),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data != null && snapshot.data!.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Opacity(
                              opacity: 0.5,
                              child: Lottie.asset(
                                "assets/image/auth/cat.json",
                                width: 200,
                                height: 200,
                                filterQuality: FilterQuality.low,
                              ),
                            ),
                            Gap(20),
                            Text(
                              "No Nutritized Data",
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                snapshot.data?[index].fileImage ?? File(""),
                                fit: BoxFit.cover,
                                width: 80,
                                height: 100,
                              ),
                            ),
                            subtitle: Text(snapshot
                                    .data?[index]
                                    .genNutrilizationResponse
                                    ?.conclusionPromptManger
                                    ?.conclusionData
                                    ?.recommendations ??
                                ""), // Display each scanned product

                            title: Text(
                              snapshot
                                      .data?[index]
                                      .genNutrilizationResponse
                                      ?.initialPromptManager
                                      ?.initialData
                                      ?.name ??
                                  "",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.label_important_sharp),
                              onPressed: () {
                                // Handle delete action if needed
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NutriOutPageHistory(
                                          nutristate: snapshot.data![index]),
                                    ));
                              },
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          ),
        ],
      ),
    );
  }
}
