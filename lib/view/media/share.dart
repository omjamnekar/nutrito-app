import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/data/model/auth.dart';
import 'package:nutrito/data/model/gen/nutri_com_state.dart';
import 'package:nutrito/data/storage/user_Data.dart';
import 'package:nutrito/util/theme/color.dart';
import 'package:nutrito/view/media/sections/controller/postCont.dart';

class SharePost extends StatefulWidget {
  NutriComState nutriComState;
  SharePost({super.key, required this.nutriComState});

  @override
  State<SharePost> createState() => _SharePostState();
}

class _SharePostState extends State<SharePost> {
  bool isName = true;

  TextEditingController usernameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isSave = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    UserModel userModel = await UserStore().loadData();
    if (userModel.name != null && userModel.name!.isNotEmpty) {
      print(userModel.name);
      setState(() {
        isName = false;
        usernameController.text = userModel.name ?? "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final postModeldata = widget.nutriComState;
    return Scaffold(
      appBar: AppBar(
        title: Text("Share Post"),
        actions: [
          IconButton(
            onPressed: () async {
              if (isSave) {
                await PostController()
                    .sendPostAll(postModeldata, descriptionController.text);
                Get.snackbar("Post", "Post shared successfully!");
                Navigator.pop(context);
              }
            },
            icon: Icon(
              Icons.send,
              color: ColorManager.bluePrimary,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image Container
            Container(
              width: double.infinity,
              height: 250, // Set a fixed height to prevent overflow
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5),
                    BlendMode.darken,
                  ),
                  image: postModeldata.fileImage != null
                      ? FileImage(postModeldata.fileImage!)
                      : AssetImage("assets/placeholder.jpg") as ImageProvider,
                ),
              ),
            ),
            Gap(20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      postModeldata.genNutrilizationResponse
                              ?.initialPromptManager?.initialData?.name ??
                          "",
                      style:
                          GoogleFonts.poppins(color: ColorManager.bluePrimary),
                    ),
                    subtitle: Text(
                      postModeldata
                              .genNutrilizationResponse
                              ?.conclusionPromptManger
                              ?.conclusionData
                              ?.conclusion ??
                          "",
                      style: GoogleFonts.poppins(),
                    ),
                  ),
                  Divider(color: Colors.black26),
                  Gap(20),
                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      enabled: isName,
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.account_circle_outlined),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Gap(10),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Write comment',
                      prefixIcon: Icon(Icons.description_outlined),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Gap(20),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black87,
                    ),
                    child: TextButton(
                      onPressed: () async {
                        if (usernameController.text.isNotEmpty &&
                            descriptionController.text.isNotEmpty) {
                          UserModel userModel = await UserStore().loadData();
                          userModel.name = usernameController.text;
                          await UserStore().updateData(userModel);

                          setState(() {
                            isSave = true;
                          });
                          if (isSave) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("content is saved")));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please fill both fields")),
                          );
                        }
                      },
                      child: Text(
                        "Save",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Gap(30),
                  Center(
                    child: Text(
                      "Share and engage with similar\ninterest users",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(color: Colors.black45),
                    ),
                  ),
                  Gap(10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
