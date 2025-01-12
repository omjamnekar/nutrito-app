import 'package:flutter/material.dart';

class ShoppingItemCard extends StatelessWidget {
  final String name;
  final String asset;
  final String quantity;

  ShoppingItemCard(
      {required this.name, required this.asset, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 192, 255, 197),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            asset,
            width: 50,
            height: 50,
          ),
          SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          if (quantity.isNotEmpty)
            Text(
              quantity,
              style: TextStyle(color: Colors.grey),
            ),
        ],
      ),
    );
  }
}
