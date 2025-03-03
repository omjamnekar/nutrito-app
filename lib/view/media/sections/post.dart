import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nutrito/data/model/media/post.dart';
import 'package:nutrito/util/theme/color.dart';
import 'package:nutrito/view/media/sections/comment.dart';
import 'package:shimmer/shimmer.dart';

class PostCard extends StatelessWidget {
  final List<PostModel> post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: post.length,
      itemBuilder: (context, postIndex) {
        final postItem = post[postIndex];

        String formattedDate = postItem.timestamp != null
            ? DateFormat('dd MMM yyyy')
                .format(DateTime.parse(postItem.timestamp!))
            : "Unknown Date";

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _UserInfo(postItem, formattedDate),
              _AISuggestions(postItem),
              if (postItem.postImageUrl != null)
                _PostImage(postItem.postImageUrl!),
              _ActionButtons(postItem),
              const Gap(30),
            ],
          ),
        );
      },
    );
  }
}

class _UserInfo extends StatelessWidget {
  final PostModel post;
  final String formattedDate;

  const _UserInfo(this.post, this.formattedDate);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: CachedNetworkImageProvider(
          post.imageUrl ??
              "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg",
        ),
      ),
      title: Text(
        post.name ?? "Unknown",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        '$formattedDate\n${post.description ?? ""}',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Transform.rotate(
        angle: 1.6,
        child: const Icon(Icons.more_vert_outlined),
      ),
    );
  }
}

class _AISuggestions extends StatelessWidget {
  final PostModel post;

  const _AISuggestions(this.post);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("AI Suggestions:", style: GoogleFonts.poppins()),
          ListTile(
            title: Text(
              post.nutriComState?.genNutrilizationResponse?.initialPromptManager
                      ?.initialData?.name ??
                  "",
            ),
            subtitle: Text(
              post.nutriComState?.genNutrilizationResponse
                      ?.conclusionPromptManger?.conclusionData?.conclusion ??
                  "",
            ),
          ),
        ],
      ),
    );
  }
}

class _PostImage extends StatelessWidget {
  final String imageUrl;

  const _PostImage(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: MediaQuery.of(context).size.width,
        height: 200,
        fit: BoxFit.cover,
        placeholder: (context, url) => SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Shimmer(
              gradient: LinearGradient(
                colors: [Colors.black, Colors.black12],
              ),
              child: Text("loading..."),
            )),
        errorWidget: (context, url, error) => Image.network(
          "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final PostModel post;

  const _ActionButtons(this.post);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(CupertinoIcons.heart,
              color: ColorManager.bluePrimary, size: 30),
          Text(post.like.toString()),
          const Gap(20),
          const Icon(Icons.message_outlined,
              color: ColorManager.bluePrimary, size: 30),
          const Gap(5),
          Text(post.reply?.length.toString() ?? "0"),
          const Spacer(),
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CommentSection(postModel: post),
                    ));
              },
              child:
                  Transform.rotate(angle: -1, child: const Icon(Icons.send))),
          const Gap(10),
          const Icon(Icons.bookmark_border),
        ],
      ),
    );
  }
}
