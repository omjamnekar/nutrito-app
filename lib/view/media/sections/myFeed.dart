import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutrito/view/media/sections/controller/postCont.dart';
import 'package:nutrito/view/media/sections/post.dart';

class MyFeedSection extends StatefulWidget {
  const MyFeedSection({super.key});

  @override
  State<MyFeedSection> createState() => _MyFeedSectionState();
}

class _MyFeedSectionState extends State<MyFeedSection> {
  PostController postController = PostController();

  @override
  void initState() {
    super.initState();
    loadAllPost();
  }

  Future<void> loadAllPost() async {
    if (postController.myFeed.isEmpty) {
      await postController.myFeedFetch();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (postController.myFeed.isEmpty) {
        return Text("no data");
      } else {
        return PostCard(post: postController.myFeed);
      }
    });
  }
}
