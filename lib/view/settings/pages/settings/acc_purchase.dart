import 'package:flutter/material.dart';
import 'package:nutrito/util/theme/color.dart';

class PurchaseHistoryPage extends StatefulWidget {
  const PurchaseHistoryPage({super.key});

  @override
  State<PurchaseHistoryPage> createState() => _PurchaseHistoryPageState();
}

class _PurchaseHistoryPageState extends State<PurchaseHistoryPage> {
  // Dummy purchase history data
  final List<Map<String, dynamic>> purchaseHistory = [
    {'item': 'Protein Shake', 'price': 299, 'date': '2024-02-15'},
    {'item': 'Vitamin C Supplements', 'price': 499, 'date': '2024-02-12'},
    {'item': 'Organic Oats', 'price': 249, 'date': '2024-02-08'},
    {'item': 'Fitness Tracker', 'price': 1999, 'date': '2024-01-25'},
    {'item': 'Yoga Mat', 'price': 699, 'date': '2024-01-20'},
  ];

  double getTotalAmountSpent() {
    return purchaseHistory.fold(0, (sum, item) => sum + item['price']);
  }

  @override
  Widget build(BuildContext context) {
    double totalSpent = getTotalAmountSpent();

    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase History'),
        backgroundColor: ColorManager.bluePrimary.withOpacity(0.4),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Amount Spent: ₹$totalSpent',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: purchaseHistory.length,
                itemBuilder: (context, index) {
                  final purchase = purchaseHistory[index];
                  return Card(
                    child: ListTile(
                      title: Text(purchase['item']),
                      subtitle: Text('Date: ${purchase['date']}'),
                      trailing: Text('₹${purchase['price']}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
