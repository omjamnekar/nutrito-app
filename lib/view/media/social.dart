import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nutrito/data/model/ImagePost.dart';
import 'package:nutrito/view/media/sections/feed.dart';
import 'package:nutrito/view/media/sections/popular.dart';
import 'package:nutrito/util/extensions/extensions.dart';
import 'package:nutrito/util/theme/color.dart';

class SocialMediaPage extends StatefulWidget {
  const SocialMediaPage({super.key});

  @override
  State<SocialMediaPage> createState() => _SocialMediaPageState();
}

class _SocialMediaPageState extends State<SocialMediaPage>
    with TickerProviderStateMixin {
  late TabController tabcontroller;
  late TabController sectionController;
  @override
  void initState() {
    super.initState();
    tabcontroller = TabController(length: 2, initialIndex: 0, vsync: this);
    sectionController = TabController(length: 4, initialIndex: 0, vsync: this);

    print("social");
  }

  final List<String> _navigate = [
    "MY FEED",
    "POPULAR",
    "ALL",
    "CUSTOM",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // TabBar
            Flexible(
              flex: 1,
              child: Row(
                children: [
                  SizedBox(
                    width: 250,
                    child: TabBar(
                      controller: tabcontroller,
                      dividerColor: Colors.transparent,
                      indicatorColor: ColorManager.bluePrimary,
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: [
                        Tab(
                          child: const Text(
                            'Posts',
                            style: TextStyle(color: Colors.grey),
                          ).withStyle(),
                        ),
                        Tab(
                          child: const Text(
                            'Community',
                          ).withStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.search,
                  ).withIconStyle(),
                  const Gap(10),
                  const Icon(
                    Icons.notifications_active_outlined,
                    color: Color.fromARGB(255, 109, 109, 109),
                  ).withIconStyle(),
                  const Gap(10),
                ],
              ),
            ),
            // Navigation List
            const Gap(10),
            Flexible(
              flex: 1,
              child: TabBar(
                controller: sectionController,
                dividerColor: Colors.transparent,
                indicatorColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: ColorManager.bluePrimary,
                tabs: _navigate
                    .map((e) => Container(
                        height: 30,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(e)))
                    .toList(),
              ),
            ),
            // TabBarView
            Flexible(
              flex: 12,
              child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 240, 240, 240)),
                child: TabBarView(
                  controller: tabcontroller,
                  children: [
                    TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: sectionController,
                      children: [
                        PostCard(post: [
                          Post(
                              likes: "30k",
                              messages: {
                                "messages": {
                                  "user1": {"om": "this is good food"},
                                  "user2": {"omkar": "this is good food"},
                                  "user3": {"om": "this is good food"},
                                }
                              },
                              userName: "username",
                              userRole: "datascience",
                              profileImageUrl:
                                  "https://static.vecteezy.com/system/resources/previews/009/292/244/non_2x/default-avatar-icon-of-social-media-user-vector.jpg",
                              postImageUrl: [
                                "https://images.immediate.co.uk/production/volatile/sites/30/2013/05/spaghetti-carbonara-382837d.jpg?quality=90&resize=556,505"
                              ],
                              timestamp: DateTime.now().toUtc().toString(),
                              content:
                                  "Get this image on: Vecteezy | License details Want to know where this information comes from? Learn more"),
                          Post(
                              likes: "30k",
                              messages: {
                                "messages": {
                                  "user1": {"om": "this is good food"},
                                  "user2": {"omkar": "this is good food"},
                                  "user3": {"om": "this is good food"},
                                }
                              },
                              userName: "username",
                              userRole: "datascience",
                              profileImageUrl:
                                  "https://static.vecteezy.com/system/resources/previews/009/292/244/non_2x/default-avatar-icon-of-social-media-user-vector.jpg",
                              postImageUrl: [
                                "https://images.immediate.co.uk/production/volatile/sites/30/2013/05/spaghetti-carbonara-382837d.jpg?quality=90&resize=556,505"
                              ],
                              timestamp: DateTime.now().toUtc().toString(),
                              content:
                                  "Get this image on: Vecteezy | License details Want to know where this information comes from? Learn more"),
                        ]),
                        const UserPostCard(),
                        const UserPostCard(),
                        const UserPostCard(),
                      ],
                    ),
                    Container(
                      color: Colors.blue[100],
                      child: const Center(child: Text('Community Section')),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    tabcontroller.dispose();
    super.dispose();
  }
}
