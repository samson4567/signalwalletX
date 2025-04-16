import 'package:flutter/material.dart';
import 'package:signalwavex/languages.dart';

class TransactionHistorySection extends StatelessWidget {
  const TransactionHistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              toCurrentLanguageFunction('Transaction History'),
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Account Role and Account Type row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  toCurrentLanguageFunction('Account Role'),
                  style: TextStyle(color: Colors.grey),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 38),
                      child: Text(
                        toCurrentLanguageFunction('Account Type'),
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                )
              ],
            ),

            // Real Account and All Account containers
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Text(
                          toCurrentLanguageFunction('Real Account'),
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    )),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      Text(
                        toCurrentLanguageFunction('All account'),
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(Icons.arrow_drop_down, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Date label
            Text(
              toCurrentLanguageFunction('Date'),
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 8),

            // Date container
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                '20/12/2024 - 30/12/2029',
                style: TextStyle(color: Colors.white),
              ),
            ),

            const SizedBox(height: 24),

            // Table headers
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(toCurrentLanguageFunction('Account role'),
                    style: TextStyle(color: Colors.grey, fontSize: 10)),
                Text(toCurrentLanguageFunction('Account type'),
                    style: TextStyle(color: Colors.grey, fontSize: 10)),
                Text(toCurrentLanguageFunction('Currency type'),
                    style: TextStyle(color: Colors.grey, fontSize: 10)),
                Text(toCurrentLanguageFunction('Charge fees'),
                    style: TextStyle(color: Colors.grey, fontSize: 10)),
              ],
            ),

            const SizedBox(height: 16),

            // Transaction list
            Expanded(
              child: ListView.separated(
                itemCount: 5,
                separatorBuilder: (context, index) =>
                    const Divider(color: Colors.grey, height: 24),
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(toCurrentLanguageFunction('demo'),
                          style: TextStyle(color: Colors.white)),
                      Text(toCurrentLanguageFunction('trade'),
                          style: TextStyle(color: Colors.white)),
                      Text('usdt', style: TextStyle(color: Colors.white)),
                      Text('-30.00', style: TextStyle(color: Colors.red)),
                    ],
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
