import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/view/settings/components/graphs/linear.dart';
import 'package:nutrito/util/extensions/extensions.dart';
import 'package:nutrito/util/theme/color.dart';

class UserPostCard extends StatefulWidget {
  const UserPostCard({super.key});

  @override
  State<UserPostCard> createState() => _UserPostCardState();
}

class _UserPostCardState extends State<UserPostCard> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 6, left: 2, right: 2),
      itemBuilder: (context, index) {
        return const UserPost();
      },
    );
  }
}

class UserPost extends StatelessWidget {
  const UserPost({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      height: 270,
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: ColorManager.bluePrimary,
                  foregroundColor: ColorManager.bluePrimary,
                ),
                const Gap(10),
                const Text("username").withStyle(),
                const Spacer(),
                const Icon(Icons.grid_view_outlined),
                // Icon(Icons.messenger_outline_sharp),
                const Icon(Icons.more_vert_outlined),
              ],
            ),
          ),
          const Gap(5),
          Flexible(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Absolutely love it! the....")
                            .withHeadStyle(),
                        Text(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,",
                          style: GoogleFonts.poppins(),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      width: 100,
                      height: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          "https://www.foodiesfeed.com/wp-content/uploads/2023/06/burger-with-melted-cheese.jpg",
                          fit: BoxFit.cover,
                          color: const Color.fromARGB(255, 27, 163, 138)
                              .withOpacity(0.5), // Blue color with transparency
                          colorBlendMode: BlendMode
                              .overlay, // Blend mode for the color effect
                          //ssgh quality rendering
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                            child: const RoundedProgressBar(percentage: 20)),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(),
                      )
                    ],
                  ),
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Image.asset("assets/image/media/arrow-up.png",
                                  fit: BoxFit.cover,
                                  width: 30,
                                  height: 30,
                                  color: ColorManager.bluePrimary),
                              const Text("20k"),
                              Image.asset("assets/image/media/arrow-down.png",
                                  fit: BoxFit.cover,
                                  width: 30,
                                  height: 30,
                                  color: const Color.fromARGB(146, 0, 17, 14)),
                            ],
                          ),
                        ),
                        const Gap(20),
                        const Row(
                          children: [
                            Icon(Icons.messenger_outline),
                            Text("30"),
                          ],
                        ),
                        const Gap(10),
                        const Row(
                          children: [Icon(Icons.share_outlined)],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
