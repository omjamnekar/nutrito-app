import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/pages/settings/components/goal.dart';
import 'package:nutrito/pages/settings/components/profile.dart';
import 'package:nutrito/pages/settings/components/scanner.dart';
import 'package:nutrito/pages/settings/components/settings.dart';
import 'package:nutrito/util/data/settings.dart';
import 'package:nutrito/util/extensions/extensions.dart';
import 'package:nutrito/util/theme/color.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with SingleTickerProviderStateMixin {
  bool isFilled = false;

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Settings");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: DefaultTabController(
            length: 4,
            child: Container(
              padding: const EdgeInsets.only(left: 14, right: 14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          "User Account",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize: 28,
                              color: Colors.black87),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: CircleAvatar(
                          backgroundColor: Color.fromARGB(129, 0, 221, 181),
                          child: Icon(
                            Icons.account_circle,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(20),
                  Row(
                    children: [
                      Flexible(
                        flex: 5,
                        child: TextFormField(
                          controller: _searchController,
                          onChanged: (value) {
                            if (value == null || value.isNotEmpty) {
                              setState(() {
                                isFilled = true;
                              });
                            } else {
                              setState(() {
                                isFilled = false;
                              });
                            }
                          },
                          onTap: () {
                            if (_searchController.text == null ||
                                _searchController.text.isEmpty) {
                              setState(() {
                                isFilled = false;
                              });
                            } else {
                              setState(() {
                                isFilled = true;
                              });
                            }
                          },
                          onTapOutside: (event) {
                            if (_searchController.text.isNotEmpty) {
                              setState(() {
                                isFilled = true;
                              });
                            } else {
                              setState(() {
                                isFilled = false;
                              });
                            }
                          },
                          onFieldSubmitted: (value) {
                            if (_searchController.text.isEmpty) {
                              setState(() {
                                isFilled = false;
                              });
                            } else {
                              setState(() {
                                isFilled = true;
                              });
                            }
                          },
                          onSaved: (newValue) {
                            print(newValue);
                            if (newValue == null || newValue.isEmpty) {
                              setState(() {
                                isFilled = false;
                              });
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "Search...",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusColor: ColorManager.bluePrimary,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  color: ColorManager.bluePrimary,
                                )),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.search,
                          ),
                        ),
                      )
                    ],
                  ),
                  const Gap(10),
                  isFilled
                      ? SearchedData(
                          searchData: _searchController.text ?? "",
                        )
                      : UserSpaceSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SearchedData extends StatefulWidget {
  String searchData;
  SearchedData({
    super.key,
    required this.searchData,
  });

  @override
  State<SearchedData> createState() => _SearchedDataState();
}

class _SearchedDataState extends State<SearchedData> {
  @override
  Widget build(BuildContext context) {
    if (widget.searchData == null) {
      return Container();
    } else {
      // print(widget.searchData);
      final filteredData = settingSearchData
          .where((element) => element['name']
              .toString()
              .toLowerCase()
              .contains(widget.searchData.toLowerCase()))
          .toList();
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 1000,
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(bottom: 30),
          itemCount: filteredData.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(filteredData[index]['name']).withStyle(),
              leading: filteredData[index]["icon"],
            );
          },
        ),
      );
    }
  }
}

class UserSpaceSection extends StatefulWidget {
  UserSpaceSection({super.key});
  @override
  State<UserSpaceSection> createState() => _UserSpaceSectionState();
}

class _UserSpaceSectionState extends State<UserSpaceSection>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  final List<String> list = ["Profile", "Scans", "Settings", "Goals"];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: ListView.builder(
            itemCount: list.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    tabController.animateTo(index);
                  });
                },
                child: Container(
                  width: 90,
                  margin: const EdgeInsets.only(left: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: tabController.index == index
                        ? ColorManager.bluePrimary
                        : Colors.white,
                    border: Border.all(
                      color: const Color.fromARGB(221, 120, 120, 120),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      list[index],
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        color: tabController.index == index
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        //Sections

        SizedBox(
          height: 1230,
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: tabController,
            children: const [
              ProfileSection(),
              ScancSection(),
              SettingSection(),
              GoalSection(),
            ],
          ),
        )
      ],
    );
  }
}
