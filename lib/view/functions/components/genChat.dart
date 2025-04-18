import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/data/model/gen/smart/com_smart.dart';
import 'package:nutrito/data/model/gen/smart/shopping.dart';
import 'package:nutrito/util/data/fruit_image.dart';
import 'package:nutrito/util/data/veggie_image.dart';
import 'package:nutrito/util/theme/color.dart';
import 'package:nutrito/view/functions/components/product_card.dart';
import 'package:shimmer/shimmer.dart';

class SmartListService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> getSmartList(String userMessage) async {
    final url = '${dotenv.get("BASEURL")}/api/smartlist';

    try {
      final response = await _dio.post(
        url,
        data: {'message': userMessage},
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        final outerJson = response.data;
        final resultJson = jsonDecode(outerJson['result']);

        final List<String> messageProducts =
            (resultJson["productname"] as List<dynamic>?)
                    ?.map((item) => item.toString())
                    .toList() ??
                [];

        final mergedList = [...veggies, ...fruits];

        final Map<String, Map<String, dynamic>> dataMap = {
          for (var item in mergedList) item['name']: item,
        };

        final List<Map<String, dynamic>> sortedData = [
          for (var name in messageProducts)
            if (dataMap.containsKey(name)) dataMap[name]!
        ];

        return {
          "message": resultJson["message"],
          "data": sortedData
              .map<ShoppingItemManager>((e) => ShoppingItemManager.fromJson(e))
              .toList()
        };
      } else {
        throw Exception('Failed to get smart list');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}

class ChatSection extends StatefulWidget {
  Function(List<ShoppingItemManager> list) dataOnClick;
  ChatSection({super.key, required this.dataOnClick});

  @override
  State<ChatSection> createState() => _ChatSectionState();
}

class _ChatSectionState extends State<ChatSection> {
  final TextEditingController dataController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<ChatItem> chatItems = [];

  bool isResponding = false;

  Future<void> _sendMessage(String userInput) async {
    setState(() {
      chatItems.add(ChatItem(
        userMessage: userInput,
        botMessage: "",
        items: [],
        isLoading: true,
      ));
    });

    _scrollToBottom();

    try {
      final smartListService = SmartListService();
      final response = await smartListService.getSmartList(userInput);

      final index =
          chatItems.lastIndexWhere((item) => item.userMessage == userInput);
      if (index != -1) {
        setState(() {
          chatItems[index] = ChatItem(
            userMessage: userInput,
            botMessage: response["message"] ?? "",
            items: response["data"] ?? [],
            isLoading: false,
          );
        });
      }
      _scrollToBottom();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Something went wrong. Please try again later.")),
      );
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 300,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 650,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(13, 0, 255, 132),
        border: Border.all(color: ColorManager.bluePrimary),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 9,
            child: chatItems.isEmpty
                ? _buildPlaceholder()
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: chatItems.length,
                    itemBuilder: (context, index) {
                      final chatItem = chatItems[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: ColorManager.bluePrimary,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                chatItem.userMessage,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          chatItem.isLoading
                              ? _buildShimmerResponse()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Text(
                                          chatItem.botMessage,
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                    ),
                                    GridView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        childAspectRatio: 1,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                      ),
                                      itemCount: chatItem.items.length,
                                      itemBuilder: (context, itemIndex) {
                                        final item = chatItem.items[itemIndex];

                                        return GestureDetector(
                                          onLongPress: () {
                                            setState(() {
                                              chatItems[index].isSelected =
                                                  !chatItems[index].isSelected;
                                            });
                                          },
                                          child: Stack(
                                            children: [
                                              ShoppingItemCard(
                                                asset: item.imageUrl ?? "",
                                                name: item.name ?? "",
                                                quantity: "1kg",
                                              ),
                                              if (chatItem.isSelected)
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.lightBlue
                                                        .withOpacity(0.4),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                          const SizedBox(height: 10),
                        ],
                      );
                    },
                  ),
          ),
          if (chatItems.any((item) => item.isSelected))
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0, bottom: 8),
                child: ElevatedButton(
                  onPressed: () {
                    final selectedItem =
                        chatItems.firstWhere((item) => item.isSelected);

                    widget.dataOnClick(selectedItem.items);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                  ),
                  child: Text(
                    'Add List',
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                ),
              ),
            ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: dataController,
                  decoration: InputDecoration(
                    hintText: "Start listing",
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  final input = dataController.text.trim();
                  if (input.isNotEmpty) {
                    _sendMessage(input);
                    dataController.clear();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please enter something")),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(14),
                  backgroundColor: ColorManager.bluePrimary,
                ),
                child: const Icon(Icons.arrow_forward_ios_rounded,
                    color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Let's Make Grocery with Gen",
              style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45)),
          const SizedBox(height: 5),
          Text("Begin by sharing your grocery list ideas below",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.black38)),
        ],
      ),
    );
  }

  Widget _buildShimmerResponse() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 60,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 6,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class ChatItem {
  final String userMessage;
  final String botMessage;
  final List<ShoppingItemManager> items;
  final bool isLoading;
  bool isSelected;

  ChatItem({
    required this.userMessage,
    required this.botMessage,
    required this.items,
    this.isLoading = false,
    this.isSelected = false,
  });
}
