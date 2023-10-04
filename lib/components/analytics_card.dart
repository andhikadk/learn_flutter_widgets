import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AnalyticsCard extends StatelessWidget {
  final String title;
  final int amount;
  final bool isCurrency;

  const AnalyticsCard({
    super.key,
    required this.title,
    required this.amount,
    this.isCurrency = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary
            ],
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: TotalSalary(
          title: title,
          amount: amount,
          isCurrency: isCurrency,
        ),
      ),
    );
  }
}

class TotalSalary extends StatefulWidget {
  final String title;
  final int amount;
  final bool isCurrency;

  const TotalSalary({
    super.key,
    required this.title,
    required this.amount,
    this.isCurrency = false,
  });

  @override
  State<TotalSalary> createState() => _TotalSalaryState();
}

class _TotalSalaryState extends State<TotalSalary> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.isCurrency
                            ? NumberFormat.currency(
                                locale: 'id',
                                symbol: 'Rp',
                                decimalDigits: 0,
                              ).format(widget.amount)
                            : widget.amount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
