import 'package:flutter/material.dart';
import 'package:signalwavex/features/authentication/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:signalwavex/features/authentication/presentation/blocs/auth_bloc/auth_state.dart';
import 'package:signalwavex/languages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              'Transaction History'.toCurrentLanguage(),
              style: const TextStyle(
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
                  'Account Role'.toCurrentLanguage(),
                  style: TextStyle(color: Colors.grey),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 38),
                      child: Text(
                        'Account Type'.toCurrentLanguage(),
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
                          'Real Account'.toCurrentLanguage(),
                          style: const TextStyle(color: Colors.white),
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
                        'All account'.toCurrentLanguage(),
                        style: TextStyle(color: Colors.white),
                      ),
                      const Icon(Icons.arrow_drop_down, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Date label
            Text(
              'Date'.toCurrentLanguage(),
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
                Text('Account role'.toCurrentLanguage(),
                    style: const TextStyle(color: Colors.grey, fontSize: 10)),
                Text('Account type'.toCurrentLanguage(),
                    style: const TextStyle(color: Colors.grey, fontSize: 10)),
                Text('Currency type'.toCurrentLanguage(),
                    style: const TextStyle(color: Colors.grey, fontSize: 10)),
                Text('Charge fees'.toCurrentLanguage(),
                    style: const TextStyle(color: Colors.grey, fontSize: 10)),
              ],
            ),

            const SizedBox(height: 16),

            // Fetch transaction history from Bloc
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is FetchTransactionLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is FetchTransactionErrorState) {
                  return Center(
                    child: Text(
                      state.errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else if (state is FetchTransactionLoadedState) {
                  final transactions = state.transactions;

                  if (transactions.isEmpty) {
                    return Center(
                      child: Text(
                        'No transactions yet'.toCurrentLanguage(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: ListView.separated(
                        itemCount: transactions.length,
                        separatorBuilder: (context, index) =>
                            const Divider(color: Colors.grey, height: 24),
                        itemBuilder: (context, index) {
                          final transaction = transactions[index];

                          // Parse pnl value to a double for comparison
                          final pnl = double.tryParse(transaction.pnl) ?? 0.0;

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(transaction.title!.toCurrentLanguage(),
                                  style: const TextStyle(color: Colors.white)),
                              Text(transaction.side.toCurrentLanguage(),
                                  style: const TextStyle(color: Colors.white)),
                              Text(transaction.symbol,
                                  style: const TextStyle(color: Colors.white)),
                              Text(
                                pnl.toString(),
                                style: TextStyle(
                                  color: pnl < 0 ? Colors.red : Colors.green,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  }
                } else {
                  // Handle unexpected states by displaying the current state
                  return const Center(
                    child: Text(
                      'No Transaction yet ', // Log the unexpected state
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
