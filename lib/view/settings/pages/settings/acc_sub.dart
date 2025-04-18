import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/data/model/auth.dart';
import 'package:nutrito/data/storage/user_Data.dart';
import 'package:nutrito/util/theme/color.dart';
import 'package:nutrito/view/settings/pages/settings/payment.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  int selectedPlanIndex = -1; // -1 means no plan selected

  final List<Map<String, dynamic>> subscriptionPlans = [
    {
      "title": "Basic",
      "price": "₹199/month",
      "features": ["Limited access", "Ad-supported", "No offline mode"],
      "icon": Icons.lock_outline,
      "amount": 199
    },
    {
      "title": "Premium",
      "price": "₹499/month",
      "features": ["Full access", "No ads", "Offline mode"],
      "icon": Icons.star_border,
      "amount": 499
    },
    {
      "title": "Pro",
      "price": "₹999/month",
      "features": ["Full access", "No ads", "Offline mode", "Priority support"],
      "icon": Icons.verified,
      "amount": 999
    },
  ];

  void _subscribe() async {
    if (selectedPlanIndex == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select a subscription plan!")),
      );

      return;
    }
    UserModel userModel = await UserStore().loadData();

    await RazorpayService().openCheckout(
        double.parse(subscriptionPlans[selectedPlanIndex]["amount"].toString()),
        subscriptionPlans[selectedPlanIndex]["title"] + " Subscription",
        (subscriptionPlans[selectedPlanIndex]["features"] as List).join(", "),
        userModel.email ?? "",
        userModel.phone ?? "9999999999");

    String selectedPlan = subscriptionPlans[selectedPlanIndex]["title"];
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Subscribed to $selectedPlan!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 242, 242),
      appBar: AppBar(
        title: Text("Choose a Plan"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Subscribe to unlock premium features",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 81, 81, 81),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: subscriptionPlans.length,
                itemBuilder: (context, index) {
                  final plan = subscriptionPlans[index];
                  bool isSelected = selectedPlanIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPlanIndex = index;
                      });
                    },
                    child: Card(
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        margin: EdgeInsets.symmetric(vertical: 8),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          // color: isSelected
                          //     ? ColorManager.bluePrimary.withOpacity(0.2)
                          //     : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          color: isSelected
                              ? const Color.fromARGB(255, 25, 253, 212)
                              : Colors.white,
                          border: Border.all(
                            color: isSelected
                                ? ColorManager.bluePrimary
                                : Colors.white,
                            width: 2,
                          ),
                          // boxShadow: isSelected
                          //     ? [
                          //         BoxShadow(
                          //           color: ColorManager.bluePrimary
                          //               .withOpacity(0.6),
                          //           blurRadius: 10,
                          //           spreadRadius: 3,
                          //         )
                          //       ]
                          //     : [],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(plan["icon"], size: 40, color: Colors.black26),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    plan["title"],
                                    style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black26,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    plan["price"],
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: plan["features"]
                                        .map<Widget>(
                                          (feature) => Row(
                                            children: [
                                              Icon(Icons.check_circle,
                                                  color: Colors.green,
                                                  size: 18),
                                              SizedBox(width: 5),
                                              Text(feature,
                                                  style:
                                                      TextStyle(fontSize: 14)),
                                            ],
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(color: Colors.black.withOpacity(0.8)),
        child: TextButton(
          onPressed: _subscribe,
          child: Text("Subscribe Now",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
