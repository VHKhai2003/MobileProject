import 'package:flutter/material.dart';

class TokenUsageWidget extends StatelessWidget {
  final int totalTokens;
  final int usedTokens;

  const TokenUsageWidget({
    super.key,
    required this.totalTokens,
    required this.usedTokens,
  });

  @override
  Widget build(BuildContext context) {
    // Tính toán tỷ lệ token đã sử dụng
    double usagePercentage = totalTokens > 0 ? usedTokens / totalTokens : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: usagePercentage,
          backgroundColor: Colors.grey[300],
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
        const SizedBox(height: 8)
      ],
    );
  }
}