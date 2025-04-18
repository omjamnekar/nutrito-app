import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/data/model/gen/alternative/alternative.dart';
import 'package:nutrito/network/controller/alternative.dart';
import 'package:shimmer/shimmer.dart';

class AlternativeImagePage extends ConsumerStatefulWidget {
  const AlternativeImagePage({super.key});

  @override
  ConsumerState<AlternativeImagePage> createState() =>
      _AlternativeImagePageState();
}

class _AlternativeImagePageState extends ConsumerState<AlternativeImagePage> {
  List<AlthernativeModel> _listAlternative = [];
  @override
  void initState() {
    super.initState();
    setup();
  }

  AlternativeController alternativeController = AlternativeController();

  void setup() async {
    final data = await alternativeController.fullRandom(ref);
    setState(() {
      _listAlternative = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder(
          future: Future.value(_listAlternative),
          builder: (context, snapshot) {
            if (snapshot.data != null &&
                snapshot.data!.isNotEmpty &&
                snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                snapshot.data!.shuffle();
              }
              return SizedBox(
                height: (snapshot.data!.length / 2) * 100,
                child: GridView.builder(
                  // physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                            color: const Color.fromARGB(137, 0, 221, 181),
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 2,
                            child: Container(
                              height: double.maxFinite,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  // color: const Color.fromARGB(84, 0, 221, 181),
                                  ),
                              child: Image.network(
                                item.imageUrl ?? "",
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: const Color.fromARGB(
                                        255, 240, 240, 240),
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
                                                  .join('. '),
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
              );
            } else {
              // print(snapshot.data?.first?.name ?? "");
              return Container(
                child: GridView.builder(
                  itemCount: 20,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
        ));
  }
}
