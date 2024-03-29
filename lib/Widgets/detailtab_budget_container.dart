import 'package:flutter/material.dart';
import '../Components/styles.dart';

class BudgetContainer extends StatelessWidget {
  final text;
  final budgetORexpenses;
  const BudgetContainer({super.key, this.text, this.budgetORexpenses});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: accentColor),
          borderRadius: BorderRadius.circular(10)),
      height: screenSize.height * 0.1277,
      width: screenSize.width * 0.425,
      child: Padding(
        padding: EdgeInsets.all(screenSize.height * 0.014),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Divider(color: accentColor2,),
            Text(
              budgetORexpenses,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: screenSize.height * 0.01,
            ),
          ],
        ),
      ),
    );
  }
}
