import "dart:io";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_database/firebase_database.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:image_picker/image_picker.dart";
import "package:nutrito/data/model/auth.dart";
import "package:nutrito/data/model/gen/com.dart";
import "package:nutrito/data/model/gen/conclusion_pr.dart";
import "package:nutrito/data/model/gen/health_pr.dart";
import "package:nutrito/data/model/gen/initial_pr.dart";
import "package:nutrito/data/model/gen/nutri_com_state.dart";
import "package:nutrito/data/model/gen/ratio_pr.dart";
import "package:nutrito/data/model/media/post.dart";
import "package:nutrito/data/storage/user_Data.dart";
import "package:nutrito/view/media/sections/feed.dart";
import "package:supabase_flutter/supabase_flutter.dart";

// load all post
class AllPostSection extends StatefulWidget {
  const AllPostSection({super.key});

  @override
  State<AllPostSection> createState() => _AllPostSectionState();
}

class _AllPostSectionState extends State<AllPostSection> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostController>(
        init: PostController(),
        initState: (state) async {
          if (!state.controller!.posts.isNotEmpty) {
            await state.controller!.allPost();
          }
        },
        builder: (ctrl) {
          return PostCard(post: [
            PostModel(
              like: 30,
              reply: [
                Reply(
                  name: "om",
                  message: "this is good",
                  reply: [],
                ),
              ],
              name: "username",
              description: "datascience",
              imageUrl:
                  "https://static.vecteezy.com/system/resources/previews/009/292/244/non_2x/default-avatar-icon-of-social-media-user-vector.jpg",
              postImageUrl:
                  "https://images.immediate.co.uk/production/volatile/sites/30/2013/05/spaghetti-carbonara-382837d.jpg?quality=90&resize=556,505",
              timestamp: DateTime.now().toUtc().toString(),
              nutriComState: NutriComState(
                  genNutrilizationResponse: GenNutrilizationResponse(
                    initialPromptManager: InitialPromptManager(
                      initialData: InitialData(name: "meggie"),
                    ),
                    healthPromptManager: HealthPromptManager(),
                    ratioPromptManager: RatioPromptManager(),
                    conclusionPromptManger: ConclusionPromptManger(
                      conclusionData: ConclusionData(
                        conclusion: "it is good product",
                      ),
                    ),
                  ),
                  fileImage: File("path"),
                  timestamp: Timestamp.fromDate(DateTime.now())),
            ),
          ]);
        });
  }
}

class PostController extends GetxController {
  final postALL = FirebaseDatabase.instance.ref().child("post");
  final SupabaseClient supabase = Supabase.instance.client;
  RxList<PostModel> posts = <PostModel>[].obs;

  Future<void> allPost() async {
    try {
      final snapshot = await postALL.get();
      if (snapshot.exists) {
        final values = snapshot.value as Map<dynamic, dynamic>;
        print(values.entries.first);
        // posts = values.entries.map((entry) {
        //   return PostModel.fromJson(Map<String, dynamic>.from(entry.value));
        // }).toList();
      }
    } catch (e) {
      print("Error fetching posts: $e");
    }
    update(); // Notify UI to rebuild
  }

  Future<void> sendPostAll(
      NutriComState nutriComStateData, String userComment) async {
    UserModel userModel = await UserStore().loadData();

    // network image
    if (nutriComStateData.fileImage == null) return;

    DatabaseReference allPostsRef = postALL.child("/allPost");

    DataSnapshot snapshot = await allPostsRef.get();
    List<dynamic> existingData = [];

    if (snapshot.exists && snapshot.value != null) {
      if (snapshot.value is List) {
        existingData = List.from(snapshot.value as List);
      } else if (snapshot.value is Map) {
        existingData = (snapshot.value as Map).values.toList();
      }
    }

    PostModel postModel = PostModel(
      uid: userModel.id,
      name: userModel.name,
      description: userComment,
      nutriComState: nutriComStateData,
      imageUrl: userModel.image ??
          "https://thumbs.dreamstime.com/b/default-avatar-profile-icon-vector-social-media-user-image-182145777.jpg",
      like: 0,
      dislike: 0,
      reply: [],
      postImageUrl: "",
      timestamp: DateTime.now().toUtc().toIso8601String(),
    );
    final fileName = 'allPost/${postModel.id}.jpg';
    String imageNetworkImage = "";

    if (!existingData.any((element) => element["id"] == postModel.id)) {
      try {
        await supabase.storage
            .from('social')
            .upload(fileName, nutriComStateData.fileImage ?? File(''));
        imageNetworkImage =
            supabase.storage.from('social').getPublicUrl(fileName);

        print("Uploaded: $imageNetworkImage");
        postModel.postImageUrl = imageNetworkImage;
      } catch (e) {
        print("Upload error: $e");
      }

      existingData.add(postModel.toJson());
      await allPostsRef.set(existingData);
    } else {
      //if post is already posted online
      Get.snackbar("Info", "You have already posted this Post");
    }
  }

  void addLike(PostModel post) async {
    if (post.like != null) {
      int likes = post.like ?? 0;
      likes += 1;
      post.like = likes;
      if (post.like! > 10) {
        DatabaseReference allPostsRef = postALL.child("/popular");

        DataSnapshot snapshot = await allPostsRef.get();
        List<dynamic> existingData = [];

        if (snapshot.exists && snapshot.value != null) {
          if (snapshot.value is List) {
            existingData = List.from(snapshot.value as List);
          } else if (snapshot.value is Map) {
            existingData = (snapshot.value as Map).values.toList();
          }
        }
        if (!existingData.any((element) => element["id"] == post.id)) {
          existingData.add(post.toJson());
          await allPostsRef.set(existingData);
          await userFeedData(post);
        }
      }
    }
  }

  Future<void> userFeedData(PostModel post) async {
    DatabaseReference allPostsRef = postALL.child("/myFeed");
    UserModel userModel = await UserStore().loadData();
    DataSnapshot snapshot =
        await allPostsRef.child(userModel.id.toString()).get();
    List<dynamic> existingData = [];

    if (snapshot.exists && snapshot.value != null) {
      if (snapshot.value is List) {
        existingData = List.from(snapshot.value as List);
      } else if (snapshot.value is Map) {
        existingData = (snapshot.value as Map).values.toList();
      }
    }

    if (!existingData.any((element) => element["id"] == post.id)) {
      existingData.add(post.toJson());
      await allPostsRef.child("/${userModel.id.toString()}").set(existingData);
    }
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  File fileImage = File("");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<PostController>(
          init: PostController(),
          builder: (ctrl) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () async {
                    final imagePicker = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (imagePicker != null) {
                      setState(() {
                        fileImage = File(imagePicker.path);
                      });
                    }
                  },
                  child: Text("Image import"),
                ),
                TextButton(
                  onPressed: () async {
                    await ctrl.sendPostAll(
                        NutriComState(
                          genNutrilizationResponse: GenNutrilizationResponse(
                            initialPromptManager: InitialPromptManager(
                              initialData: InitialData(name: "meggie"),
                            ),
                            healthPromptManager: HealthPromptManager(),
                            ratioPromptManager: RatioPromptManager(),
                            conclusionPromptManger: ConclusionPromptManger(
                              conclusionData: ConclusionData(
                                conclusion: "it is good product",
                              ),
                            ),
                          ),
                          fileImage: fileImage,
                          timestamp: Timestamp.fromDate(
                            DateTime.now(),
                          ),
                        ),
                        "data is good");
                  },
                  child: Text("data"),
                ),
              ],
            );
          }),
    );
  }
}
