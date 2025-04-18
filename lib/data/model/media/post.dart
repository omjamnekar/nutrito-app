import 'package:nutrito/data/model/gen/nutri_com_state.dart';
import 'package:uuid/uuid.dart';

class PostModel {
  String? id;
  String? imageUrl;
  String? name;
  String? uid;
  String? timestamp;
  String? description;
  String? postImageUrl;
  NutriComState? nutriComState;
  int? like;
  int? dislike;
  List<ReplyUser>? reply;

  PostModel({
    this.imageUrl,
    this.name,
    this.uid,
    this.timestamp,
    this.description,
    this.postImageUrl,
    this.like,
    this.dislike,
    this.nutriComState,
    this.reply,
  }) : id = Uuid().v4();

  PostModel.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    name = json['name'];
    uid = json['uid'];
    id = json['id'];
    timestamp = json['timestamp'];
    description = json['description'];
    postImageUrl = json['postImageUrl'];
    like = json['like'];
    dislike = json['dislike'];

    nutriComState = json['genNutrilizationResponse'] != null
        ? NutriComState.fromJson(json['nutriComState'])
        : null;

    if (json['reply'] != null) {
      reply =
          List<ReplyUser>.from(json['reply'].map((v) => ReplyUser.fromJson(v)));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['imageUrl'] = imageUrl;
    data['name'] = name;
    data['uid'] = uid;
    data['id'] = id;
    data['timestamp'] = timestamp;
    data['description'] = description;
    data['postImageUrl'] = postImageUrl;
    data['like'] = like;
    data['dislike'] = dislike;
    data['nutriComState'] = nutriComState?.toJson();

    if (reply != null) {
      data['reply'] = reply!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class ReplyUser {
  String? uid;
  String? name;
  String? message;
  List<ReplyUser>? reply;

  ReplyUser({this.uid, this.name, this.message, this.reply});

  ReplyUser.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    message = json['message'];

    if (json['reply'] != null) {
      reply =
          List<ReplyUser>.from(json['reply'].map((v) => ReplyUser.fromJson(v)));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['uid'] = uid;
    data['name'] = name;
    data['message'] = message;

    if (reply != null) {
      data['reply'] = reply!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}
