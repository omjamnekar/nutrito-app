import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutrito/data/model/auth.dart';
import 'package:nutrito/data/storage/user_Data.dart';
import 'package:nutrito/util/theme/color.dart';
import 'package:nutrito/view/settings/pages/profile/setup.dart';

class AvatarPage extends StatefulWidget {
  WidgetRef ref;
  AvatarPage({super.key, required this.ref});

  @override
  State<AvatarPage> createState() => _AvatarPageState();
}

class _AvatarPageState extends State<AvatarPage> {
  bool isThereChange = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController =
      TextEditingController(text: "8888888888");

  File currentImage = File("");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadModel();
  }

  UserModel userModel = UserModel();

  loadModel() async {
    print("data");
    final userModelw = await UserStore().loadData();
    setState(() {
      userModel = userModelw;
    });
    loadData();
  }

  loadData() async {
    setState(() {
      emailController.text = userModel.email ?? "";
      usernameController.text = userModel.name ?? "";
    });
  }

  Future onAvatarChange(File image) async {
    final data = await widget.ref.watch(profileProvider.notifier).loadState();
    if (data.section_1 != null) {
      data.section_1!.avatar = image.path ?? "";
    }

    // updating usermodel
    await UserStore().updateData(await UserStore().loadData().then(
      (value) {
        value.image = image.path;
        return value;
      },
    ));

    //updating profile data
    widget.ref.watch(profileProvider.notifier).updateState(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.bluePrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorManager.bluePrimary,
              ),
              child: GestureDetector(
                onTap: () async {
                  updateAvatar();
                  // final data = await widget.ref
                  //     .watch(profileProvider.notifier)
                  //     .loadState();
                  // data.section_1.avatar = "" ?? "";
                  // widget.ref.watch(profileProvider.notifier).updateState(data);
                },
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: AvatarImage(userModel),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(40),
                  Text(
                    "Email",
                  ).withStyleOf(),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.edit),
                    ),
                  ),
                  Gap(20),
                  Text(
                    "Username",
                    style: GoogleFonts.poppins(),
                  ).withStyleOf(),
                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.edit),
                    ),
                  ),
                  Gap(20),
                  Text("Phone No.").withStyleOf(),
                  TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.edit),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: isThereChange
          ? Container(
              height: 70,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.amber,
              ),
            )
          : null,
    );
  }

  void updateAvatar() {
    File image = File("");
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, satState) {
          return AlertDialog(
            title: Text(
              "Upload Image",
              style: GoogleFonts.poppins(),
            ),
            content: SizedBox(
              height: MediaQuery.of(context).size.height / 2.8,
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.file_present_outlined,
                    ),
                    title: Text("File"),
                    onTap: () async {
                      final imageFile = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (imageFile != null && imageFile.path.isNotEmpty) {
                        satState(() {
                          image = File(imageFile.path);
                        });
                        setState(() {
                          image = File(imageFile.path);
                        });
                      }
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.camera,
                    ),
                    title: Text("Camera"),
                    onTap: () async {
                      final imageFile = await ImagePicker()
                          .pickImage(source: ImageSource.camera);
                      if (imageFile != null && imageFile.path.isNotEmpty) {
                        satState(() {
                          image = File(imageFile.path);
                        });
                        setState(() {
                          image = File(imageFile.path);
                        });
                      }
                    },
                  ),
                  image.path.isNotEmpty
                      ? CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 100,
                          backgroundImage: FileImage(image),
                        )
                      : CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 100,
                          child: Center(
                            child: Text(
                              "No Image",
                              style: GoogleFonts.poppins(),
                            ),
                          ),
                        ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "cancel",
                  style: GoogleFonts.poppins(),
                ),
              ),
              TextButton(
                onPressed: () async {
                  if (image.path.isNotEmpty) {
                    await onAvatarChange(image);
                  }
                  Navigator.pop(context);
                },
                child: Text(
                  "update",
                  style: GoogleFonts.poppins(),
                ),
              ),
            ],
          );
        });
      },
    );
  }
}

extension TextStyleExtension on Text {
  Text withStyleOf() {
    return Text(
      data ?? '',
      style: GoogleFonts.poppins(fontSize: 20),
    );
  }
}

ImageProvider AvatarImage(UserModel userModel) {
  return userModel.image?.isNotEmpty ?? false
      ? userModel.image!.trim().startsWith("https://")
          ? NetworkImage(
              userModel.image ??
                  "https://thumbs.dreamstime.com/b/default-avatar-profile-icon-vector-social-media-user-image-182145777.jpg",
            )
          : FileImage(
              File(
                userModel.image!,
              ),
            )
      : NetworkImage(
          "https://thumbs.dreamstime.com/b/default-avatar-profile-icon-vector-social-media-user-image-182145777.jpg",
        );
}
