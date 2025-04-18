import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/util/theme/color.dart';
import 'package:hexcolor/hexcolor.dart';

class GoalHomeSections extends StatefulWidget {
  const GoalHomeSections({super.key});

  @override
  State<GoalHomeSections> createState() => _GoalHomeSectionsState();
}

class _GoalHomeSectionsState extends State<GoalHomeSections>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> list = [
      {
        "title": "10-minute Meditation",
        "subtitle": "Time remaining: 1 Week",
        "button": "10 points",
        "status": "3/5",
        "substatus": "this week",
      },
      {
        "title": "Sleep Better",
        "subtitle": "Goal: 7+ Hours/Night",
        "button": "20 points",
        "status": "6hr15min",
        "substatus": "Avg. Duration Asleep",
      },
      {
        "title": "Move More",
        "subtitle": "Goal: 10k Steps a-Day(4.9mv)",
        "button": "20 points",
        "status": "6,990 steps",
        "substatus": "on average (3.1m)",
      },
      {
        "title": "Nutrition Tracking",
        "subtitle": "Stay within 2000 calories/day",
        "button": "15 points",
        "status": "1,800 kcal",
        "substatus": "Today's intake",
      },
      {
        "title": "Hydration Goals",
        "subtitle": "Drink 8 glasses daily",
        "button": "10 points",
        "status": "6/8 glasses",
        "substatus": "Today's progress",
      },
      {
        "title": "Mental Wellness Check-Ins",
        "subtitle": "Reflect on your mood daily",
        "button": "10 points",
        "status": "Good",
        "substatus": "Today's mood",
      },
      {
        "title": "Sleep Pattern Insights",
        "subtitle": "Maintain consistent sleep hours",
        "button": "15 points",
        "status": "85% consistency",
        "substatus": "This week",
      },
      {
        "title": "Activity Challenges",
        "subtitle": "Complete a 5K run this week",
        "button": "25 points",
        "status": "2/5 km",
        "substatus": "Progress this week",
      },
      {
        "title": "Healthy Eating Habits",
        "subtitle": "Eat 5 servings of fruits/vegetables",
        "button": "15 points",
        "status": "3/5 servings",
        "substatus": "Today's intake",
      },
      {
        "title": "Screen Time Reduction",
        "subtitle": "Limit phone use to 2 hours daily",
        "button": "10 points",
        "status": "2.5 hours",
        "substatus": "Today's usage",
      },
      {
        "title": "Workout Routines",
        "subtitle": "Complete 3 workout sessions this week",
        "button": "20 points",
        "status": "1/3 sessions",
        "substatus": "This week",
      },
      {
        "title": "Mindfulness Reminders",
        "subtitle": "Take 3 mindful breaks daily",
        "button": "10 points",
        "status": "2/3 breaks",
        "substatus": "Today's progress",
      },
      {
        "title": "Reward System",
        "subtitle": "Earn 100 points this month",
        "button": "Reward Badge",
        "status": "75 points",
        "substatus": "This month",
      },
    ];

    List<Map<String, dynamic>> itemList = [
      {
        "title": "10-minute Meditation",
        "subtitle": "Time remaining: 1 Week",
        "button": "10 points",
        "status": "3/5",
        "substatus": "this week",
        "primaryColor": "#C1F2E0",
        "buttonColor": "#00796B",
        "textColor": "#004D40"
      },
      {
        "title": "Sleep Better",
        "subtitle": "Goal: 7+ Hours/Night",
        "button": "20 points",
        "status": "6hr15min",
        "substatus": "Avg. Duration Asleep",
        "primaryColor": "#F8D7FF",
        "buttonColor": "#6A1B9A",
        "textColor": "#4A148C"
      },
      {
        "title": "Move More",
        "subtitle": "Goal: 10k Steps a-Day(4.9mv)",
        "button": "20 points",
        "status": "6,990 steps",
        "substatus": "on average (3.1m)",
        "primaryColor": "#FFE0B2",
        "buttonColor": "#EF6C00",
        "textColor": "#E65100"
      },
      {
        "title": "Nutrition Tracking",
        "subtitle": "Track your daily nutrient intake",
        "button": "15 points",
        "status": "Balanced",
        "substatus": "Nutritional Score",
        "primaryColor": "#FFF3CD",
        "buttonColor": "#FFC107",
        "textColor": "#FF8F00"
      },
      {
        "title": "Hydration Goals",
        "subtitle": "Goal: 8 Glasses/Day",
        "button": "10 points",
        "status": "6/8",
        "substatus": "Today",
        "primaryColor": "#B3E5FC",
        "buttonColor": "#0288D1",
        "textColor": "#01579B"
      },
      {
        "title": "Mental Wellness Check-Ins",
        "subtitle": "Daily mindfulness check",
        "button": "15 points",
        "status": "4/7",
        "substatus": "This Week",
        "primaryColor": "#E1BEE7",
        "buttonColor": "#8E24AA",
        "textColor": "#6A1B9A"
      },
      {
        "title": "Sleep Pattern Insights",
        "subtitle": "Monitor your sleep trends",
        "button": "20 points",
        "status": "Consistent",
        "substatus": "Last 7 Days",
        "primaryColor": "#D1C4E9",
        "buttonColor": "#5E35B1",
        "textColor": "#4527A0"
      },
    ];
    return DefaultTabController(
      length: 2,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 1800,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Your Goals',
                style: GoogleFonts.poppins(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Gap(20),
            Container(
              height: 50,
              decoration: BoxDecoration(
                // color: const Color.fromARGB(221, 215, 215, 215),

                borderRadius: BorderRadius.circular(30),
              ),
              child: TabBar(
                  controller: _tabController,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: ColorManager.bluePrimary,
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    Tab(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          // border: Border.all(
                          //     color: const Color.fromARGB(255, 98, 98, 98)),
                        ),
                        child: Text(
                          "Active",
                          style: GoogleFonts.poppins(fontSize: 20),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          // border: Border.all(
                          //     color: const Color.fromARGB(255, 98, 98, 98)),
                        ),
                        child: Text(
                          "Completed",
                          style: GoogleFonts.poppins(fontSize: 20),
                        ),
                      ),
                    ),
                  ]),
            ),
            Gap(20),
            SizedBox(
              height: 1650,
              width: MediaQuery.of(context).size.width,
              child: TabBarView(
                  controller: _tabController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    ActiveContainer(itemList: itemList),
                    ActiveContainer(itemList: [
                      {
                        "title": "Activity Challenges",
                        "subtitle": "Complete weekly challenges",
                        "button": "25 points",
                        "status": "2/5",
                        "substatus": "Challenges Done",
                        "primaryColor": "#FFCCBC",
                        "buttonColor": "#D84315",
                        "textColor": "#BF360C"
                      },
                      {
                        "title": "Healthy Eating Habits",
                        "subtitle": "Track your eating habits",
                        "button": "20 points",
                        "status": "Improving",
                        "substatus": "Last Week",
                        "primaryColor": "#DCEDC8",
                        "buttonColor": "#7CB342",
                        "textColor": "#558B2F"
                      },
                      {
                        "title": "Screen Time Reduction",
                        "subtitle": "Reduce daily screen time",
                        "button": "15 points",
                        "status": "3hrs avg",
                        "substatus": "Yesterday",
                        "primaryColor": "#FFECB3",
                        "buttonColor": "#FFA000",
                        "textColor": "#FF6F00"
                      }
                    ])
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}

class ActiveContainer extends StatelessWidget {
  const ActiveContainer({
    super.key,
    required List<Map<String, dynamic>> itemList,
  }) : _itemList = itemList;

  final List<Map<String, dynamic>> _itemList;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
          children: _itemList
              .map(
                (e) => Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: HexColor(e["primaryColor"]),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          e["title"],
                          style: GoogleFonts.changa(
                              fontSize: 24, fontWeight: FontWeight.w400),
                        ),
                        subtitle: Text(
                          e["subtitle"],
                          style: GoogleFonts.poppins(
                              fontSize: 17, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Gap(40),
                      Row(
                        children: [
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                HexColor(
                                  e["buttonColor"],
                                ),
                              ),
                              padding:
                                  WidgetStatePropertyAll(EdgeInsets.all(20)),
                            ),
                            onPressed: () {},
                            child: Text(
                              e["button"],
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Spacer(),
                          Column(
                            children: [
                              Text(
                                e["status"],
                                style: GoogleFonts.changa(fontSize: 40),
                              ),
                              Text(
                                e["substatus"],
                                style: GoogleFonts.poppins(fontSize: 20),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
              .toList()),
    );
  }
}
