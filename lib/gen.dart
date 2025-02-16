import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GenPage extends StatefulWidget {
  const GenPage({super.key});

  @override
  State<GenPage> createState() => _GenPageState();
}

class _GenPageState extends State<GenPage> {
  File file = File("");
  bool isImageThere = false;
  @override
  void initState() {
    super.initState();
  }

  Future<String> ondataRanderer(
    File filename,
  ) async {
    Dio _dio = Dio();
    try {
      _dio.options.baseUrl = "https://nutrito-prompt-server.vercel.app";
      final url = '/v1/gen/nutrilization/conclusionPrompt';
      final options = Options(
        method: 'POST',
        headers: {
          HttpHeaders.contentTypeHeader: 'application/octet-stream',
        },
      );

      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(filename.path,
            filename: filename.path.split('/').last),
      });
      return await _dio
          .request(
            url,
            data: formData,
            options: options,
          )
          .then((response) => response.data.toString());
    } on DioException catch (e) {
      return e.message.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Flexible(flex: 1, child: Text("Fetch Data")),
            Flexible(
              flex: 3,
              child: Container(
                child: IconButton(
                  onPressed: () async {
                    final imagPicker = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);

                    if (imagPicker?.path == null) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("no image")));
                      return;
                    } else {
                      setState(() {
                        file = File(imagPicker!.path);
                        isImageThere = true;
                      });
                    }
                  },
                  icon: Icon(
                    Icons.abc,
                    size: 20,
                  ),
                ),
              ),
            ),
            Expanded(
              child: isImageThere
                  ? FutureBuilder(
                      future: ondataRanderer(file),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.data != null) {
                          return Container(
                            child: Text(snapshot.data ?? ""),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text("no data");
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    )
                  : Container(),
            )
          ],
        ),
      ),
    );
  }
}
