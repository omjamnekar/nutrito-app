import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/data/model/media/post.dart';
import 'package:nutrito/util/theme/color.dart';
import 'package:shimmer/shimmer.dart';

class CommentSection extends StatefulWidget {
  PostModel postModel;
  CommentSection({required this.postModel}) : super();

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  @override
  Widget build(BuildContext context) {
    final postModelcon = widget.postModel;

    return Scaffold(
      body: Column(
        children: [
          Flexible(
            flex: 3,
            child: Container(
              width: double.infinity,
              child: postModelcon.postImageUrl != null
                  ? Image.network(
                      postModelcon.postImageUrl!,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: double.infinity,
                            height: double.maxFinite,
                            color: Colors.white,
                          ),
                        );
                      },
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ),
          Gap(20),
          Flexible(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Reply Section",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                  Divider(
                    color: Colors.black38,
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 7,
            child: postModelcon.reply != null && postModelcon.reply!.length != 0
                ? Container(
                    padding: EdgeInsets.all(10),
                    child: ListView.builder(
                      itemCount: postModelcon.reply?.length ?? 0,
                      itemBuilder: (context, index) {
                        return CommentGuy(
                          replyUser: postModelcon.reply![index],
                        );
                      },
                    ),
                  )
                : Center(
                    child: Text("No comments yet!"),
                  ),
          ),
        ],
      ),
      bottomSheet: Container(
        width: double.infinity,
        height: 70,
        color: ColorManager.bluePrimary.withOpacity(0.4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              flex: 1,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  postModelcon.imageUrl ?? "",
                ),
                radius: 30,
              ),
            ),
            Expanded(
              flex: 8,
              child: TextField(
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Add a comment...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: ColorManager.bluePrimary,
                ),
                child: Icon(Icons.send),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CommentGuy extends StatefulWidget {
  ReplyUser replyUser;
  CommentGuy({super.key, required this.replyUser});

  @override
  State<CommentGuy> createState() => _CommentGuyState();
}

class _CommentGuyState extends State<CommentGuy> {
  @override
  Widget build(BuildContext context) {
    final replyUser = widget.replyUser;
    return ListTile(
      leading: Icon(
        Icons.account_circle_sharp,
      ),
      title: Text(replyUser.name ?? ""),
      subtitle: Text(replyUser.message ?? ""),
      trailing: Icon(Icons.more_vert_outlined),
    );
  }
}
