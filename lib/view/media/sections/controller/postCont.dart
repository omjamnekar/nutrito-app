import "dart:io";

import "package:firebase_database/firebase_database.dart";
import "package:get/get.dart";
import "package:nutrito/data/model/auth.dart";
import "package:nutrito/data/model/gen/nutri_com_state.dart";
import "package:nutrito/data/model/media/post.dart";
import "package:nutrito/data/storage/user_Data.dart";
import "package:supabase_flutter/supabase_flutter.dart";

class PostController extends GetxController {
  final postALL = FirebaseDatabase.instance.ref().child("post");
  final SupabaseClient supabase = Supabase.instance.client;
  RxList<PostModel> posts = <PostModel>[].obs;
  RxList<PostModel> myFeed = <PostModel>[].obs;

  Future<void> allPost() async {
    try {
      final snapshot = await postALL.child("/allPost").get();
      if (snapshot.exists) {
        // converting from object to List<Map<String,dynamic>>

        final List<Map<String, dynamic>> valuesMap =
            (snapshot.value as List<dynamic>)
                .where((e) => e != null)
                .map((e) => Map<String, dynamic>.from(e as Map))
                .toList();

        //convert from list to Post
        posts.value = valuesMap.map((e) => PostModel.fromJson(e)).toList();

        update();
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
    String userNetworkImage = userModel.image ??
        "https://thumbs.dreamstime.com/b/default-avatar-profile-icon-vector-social-media-user-image-182145777.jpg";

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
      imageUrl: userModel.image,
      like: 0,
      dislike: 0,
      reply: [],
      postImageUrl: "",
      timestamp: DateTime.now().toUtc().toIso8601String(),
    );

    if (!userModel.image!.startsWith("https://")) {
      print("comes here");
      userNetworkImage = await findUserNetWork(userModel.image ?? "").then(
        (value) {
          postModel.imageUrl = value;
          return value;
        },
      );
    }

    print(postModel.imageUrl);

    final fileName = 'allPost/${postModel.id}.jpg';
    String imageNetworkImage = "";

    if (!existingData.any((element) => element["id"] == postModel.id)) {
      try {
        await supabase.storage
            .from('social')
            .upload(fileName, nutriComStateData.fileImage ?? File(''));
        imageNetworkImage =
            supabase.storage.from('social').getPublicUrl(fileName);

        postModel.postImageUrl = imageNetworkImage;
      } catch (e) {
        print("Upload error: $e");
      }

      existingData.add(postModel.toJson());
      await allPostsRef.set(existingData);
      await userFeedData(postModel);
    } else {
      //if post is already posted online
      Get.snackbar("Info", "You have already posted this Post");
    }
  }

  Future<String> findUserNetWork(String path) async {
    UserModel userModel = await UserStore().loadData();
    final filePath = "users/${userModel.id}.jpg";
    String userNetworkImage = "";
    try {
      final storageRef = supabase.storage.from('social');

      // List all files in the "users" bucket
      final files = await storageRef.list(path: "users");

      // Check if the file exists
      bool fileExists =
          files.any((file) => file.name == filePath.split('/').last);

      userNetworkImage = fileExists ? storageRef.getPublicUrl(filePath) : "";

      if (!fileExists) {
        await storageRef.upload(filePath, File(path));
        userNetworkImage = storageRef.getPublicUrl(filePath);
        return userNetworkImage;
      }
    } catch (e) {
      print(e.toString());
    }
    return userNetworkImage;
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

  Future<void> myFeedFetch() async {
    UserModel userModel = await UserStore().loadData();
    try {
      final snapshot = await postALL
          .child("myFeed")
          .child(userModel.id ?? "")
          .get(); // Fix path

      final List<Map<String, dynamic>> valuesMap =
          (snapshot.value as List<dynamic>)
              .where((e) => e != null)
              .map((e) => Map<String, dynamic>.from(e as Map))
              .toList();

      myFeed.value = valuesMap.map((e) => PostModel.fromJson(e)).toList();

      update();
    } catch (e) {
      print("Error fetching posts: $e");
    }
    update();
  }
}
