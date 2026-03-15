import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/expense_category_model.dart';

class ExpensePieChart extends StatelessWidget {
  const ExpensePieChart({
    super.key,
    required this.expenseCategories,
  });

  final List<ExpenseCategoryModel> expenseCategories;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Расходы за месяц',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 18),
        SizedBox(
          height: 220,
          child: PieChart(
            PieChartData(
              centerSpaceRadius: 52,
              sectionsSpace: 3,
              startDegreeOffset: -90,
              sections: expenseCategories
                  .map(
                    (category) => PieChartSectionData(
                      color: category.color,
                      value: category.amount,
                      title: '${category.amount.toInt()}%',
                      radius: 54,
                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: expenseCategories
              .map(
                (category) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: category.color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: category.color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(category.title),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
