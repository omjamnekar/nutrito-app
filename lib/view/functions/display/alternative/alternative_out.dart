import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/data/model/gen/alternative/alternative.dart';
import 'package:nutrito/data/model/gen/initial_pr.dart';
import 'package:nutrito/util/theme/color.dart';

class AlternativeOutPage extends StatefulWidget {
  List<AlthernativeModel> alterdata;
  InitialData initialData;
  AlternativeOutPage(
      {super.key, required this.alterdata, required this.initialData});

  @override
  State<AlternativeOutPage> createState() => _AlternativePageState();
}

class _AlternativePageState extends State<AlternativeOutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alternative products"),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorManager.bluePrimary,
                  ),
                  child: Text(
                    widget.initialData.name ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Gap(20),
              Flexible(
                flex: 9,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: widget.alterdata.length,
                  itemBuilder: (context, index) {
                    final item = widget.alterdata[index];
                    return Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(137, 0, 221, 181),
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 2,
                            child: Container(
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  // color: const Color.fromARGB(84, 0, 221, 181),
                                  ),
                              child: Image.network(
                                item.imageUrl ?? "",
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: Container(
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color.fromARGB(255, 176, 255, 240),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 6, right: 6),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          flex: 8,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Gap(5),
                                              Text(
                                                item.name ?? "",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 18,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                item.companyName ?? "",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 10,
                                                    color: const Color.fromARGB(
                                                        255, 4, 144, 118)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Flexible(
                                          flex: 2,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 6),
                                            child: Icon(
                                              Icons.shopping_cart_outlined,
                                              size: 23,
                                              color: const Color.fromARGB(
                                                  255, 203, 203, 203),
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
                                                        (e) => e.toString(),
                                                      )
                                                      .toList()
                                                      .join('. ') ??
                                                  "",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 10,
                                                  color: Colors.black45),
                                            ),
                                          ),
                                          Gap(5),
                                          Flexible(
                                            flex: 3,
                                            child: Container(
                                              height: 34,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: Colors.white,
                                              ),
                                              child: TextButton(
                                                  onPressed: () {},
                                                  child: Text("See")),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
