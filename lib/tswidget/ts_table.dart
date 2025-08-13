import 'package:flutter/material.dart';
import 'ts_theme.dart';

class TSTable extends StatelessWidget {
  final List<String> columns;
  final List<List<Widget>> rows;

  const TSTable({super.key, required this.columns, required this.rows});

  @override
  Widget build(BuildContext context) {
    final config = TSTheme.of(context);
    final Color headerTextColor = config.useGradient
        ? Theme.of(context).colorScheme.onSurface
        : Theme.of(context).colorScheme.onPrimary;
    final headerStyle = tsTextStyleForConfig(
      config,
      size: config.fontSize * 0.95,
      weight: FontWeight.w700,
      color: headerTextColor,
    );

    return LayoutBuilder(builder: (context, constraints) {
      final bool isTight = constraints.maxWidth < 380;
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: constraints.maxWidth),
          child: DataTable(
            headingRowColor: WidgetStateProperty.all(config.useGradient ? Colors.transparent : config.primaryColor),
            horizontalMargin: isTight ? 6 : 12,
            columnSpacing: isTight ? 8 : 16,
            columns: [
              for (final c in columns)
                DataColumn(
                  label: Padding(
                    padding: EdgeInsets.symmetric(horizontal: isTight ? 4 : 8, vertical: 6),
                    child: FittedBox(alignment: Alignment.centerLeft, fit: BoxFit.scaleDown, child: Text(c, style: headerStyle)),
                  ),
                ),
            ],
            rows: [
              for (final r in rows) DataRow(cells: [for (final cell in r) DataCell(cell)]),
            ],
          ),
        ),
      );
    });
  }
}


