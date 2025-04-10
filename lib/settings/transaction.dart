import 'package:flutter/material.dart';

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
            const Text(
              'Transaction History',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Account Role and Account Type row
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Account Role',
                  style: TextStyle(color: Colors.grey),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 38),
                      child: Text(
                        'AccountType',
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
                    child: const Row(
                      children: [
                        Text(
                          'Real Account',
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
                  child: const Row(
                    children: [
                      Text(
                        'All account',
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
            const Text(
              'Date',
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Account role',
                    style: TextStyle(color: Colors.grey, fontSize: 10)),
                Text('Account type',
                    style: TextStyle(color: Colors.grey, fontSize: 10)),
                Text('Currency type',
                    style: TextStyle(color: Colors.grey, fontSize: 10)),
                Text('Charge fees',
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
                  return const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('demo', style: TextStyle(color: Colors.white)),
                      Text('trade', style: TextStyle(color: Colors.white)),
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
