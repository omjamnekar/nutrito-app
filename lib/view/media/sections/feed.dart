// lib/controllers/post_controller.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:nutrito/data/model/ImagePost.dart';
import 'package:nutrito/util/theme/color.dart';

class PostController extends GetxController {
  var posts = <Post>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  void fetchPosts() {
    posts.assignAll([
      Post(
        userName: 'Eckart Walther',
        userRole: 'CMO at Modern Media',
        profileImageUrl: 'https://via.placeholder.com/50',
        timestamp: 'Nov 20',
        content: 'Do you have any experience with deploying @Hubspot?',
        postImageUrl: ['https://via.placeholder.com/400x200'],
        likes: "200k",
        messages: {
          "messages": [
            {
              "user1": {"om": "this is good food"},
              "user2": {"omkar": "this is good food"},
              "user3": {"raj": "this is good food"},
            }
          ]
        },
      ),
      Post(
        userName: 'Hillary Jones',
        userRole: 'Performance Marketing',
        profileImageUrl: 'https://via.placeholder.com/50',
        timestamp: 'Nov 23',
        content:
            'We have used @Hubspot extensively for our business, and are generally very happy with them...',
        likes: "20k",
        messages: {
          "messages": [
            {
              "user1": {"om": "this is good food"},
              "user2": {"omkar": "this is good food"},
              "user3": {"raj": "this is good food"},
            }
          ]
        },
      ),
    ]);
  }
}

class PostCard extends StatelessWidget {
  final List<Post> post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: post.length,
        itemBuilder: (context, postindex) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(post[postindex].profileImageUrl),
                  ),
                  title: Text(
                    post[postindex].userName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                      '${post[postindex].userRole} • ${post[postindex].timestamp}'),
                  trailing: Transform.rotate(
                      angle: 1.6, child: const Icon(Icons.more_vert_outlined)),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: SizedBox(
                    height: 60,
                    child: Text(
                      post[postindex].content,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                if (post[postindex].postImageUrl != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.orange,
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: post[postindex].postImageUrl!.length,
                        itemBuilder: (context, index) {
                          return Image.network(
                            post[postindex].postImageUrl![index],
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                const Gap(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        CupertinoIcons.heart,
                        color: ColorManager.bluePrimary,
                        size: 30,
                      ),
                      Text(post[postindex].likes),
                      const Gap(20),
                      const Icon(
                        Icons.message_outlined,
                        color: ColorManager.bluePrimary,
                        size: 30,
                      ),
                      const Gap(5),
                      Text(
                        post[postindex].messages['messages'].length.toString(),
                      ),
                      const Spacer(),
                      Transform.rotate(
                        angle: -1,
                        child: const Icon(Icons.send),
                      ),
                      const Gap(10),
                      const Icon(Icons.bookmark_border),
                    ],
                  ),
                ),
                const Gap(30),
                // Container(
                //     padding: EdgeInsets.symmetric(horizontal: 5),
                //     child: const Divider()),
              ],
            ),
          );
        });
  }
}
