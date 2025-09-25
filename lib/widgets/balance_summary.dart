import 'package:flutter/material.dart';

class BalanceSummary extends StatelessWidget {
  const BalanceSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0),
      padding: const EdgeInsets.all( 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Row(
        children: [
          _buildItem("CREDIT", "RM100.00", context),
          _divider(),
          _buildItem("POINTS", "10", context),
          _divider(),
          _buildItem("PACKAGE", "1", context),
        ],
      ),
    );
  }

  Widget _buildItem(String label, String value, BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      width: 1,
      height: 30,
      color: Colors.grey.shade300,
    );
  }
}
