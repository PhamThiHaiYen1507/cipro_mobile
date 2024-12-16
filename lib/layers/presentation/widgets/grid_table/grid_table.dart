import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

class GridTableColumnConfig<T> {
  final TableSpan columnWidth;

  final Widget Function(BuildContext context, T data, int index) cellBuilder;

  final Widget Function(BuildContext context) headerBuilder;

  GridTableColumnConfig({
    required this.columnWidth,
    required this.cellBuilder,
    required this.headerBuilder,
  });
}

class GridTable<T> extends StatelessWidget {
  final List<T> items;

  final List<GridTableColumnConfig<T>> configs;

  final double headerHeight;

  final double rowHeight;

  final int pinnedRowCount;

  final Function(int index)? onTapRow;

  const GridTable({
    super.key,
    required this.items,
    required this.configs,
    this.headerHeight = 44,
    this.rowHeight = 44,
    this.pinnedRowCount = 1,
    this.onTapRow,
  });

  @override
  Widget build(BuildContext context) {
    return TableView.builder(
      pinnedRowCount: pinnedRowCount,
      columnBuilder: _columnBuilder,
      rowBuilder: _rowBuilder,
      columnCount: configs.length,
      rowCount: items.length + 1,
      cellBuilder: (context, vicinity) => TableViewCell(
        child: _itemBuilder(context, vicinity),
      ),
    );
  }

  Widget _itemBuilder(
    BuildContext context,
    TableVicinity vicinity,
  ) {
    final config = configs[vicinity.column];

    final index = vicinity.row - 1;

    switch (vicinity.row) {
      case 0:
        return config.headerBuilder(context);
      default:
        return config.cellBuilder(context, items[index], index);
    }
  }

  TableSpan _columnBuilder(int index) {
    final config = configs[index];

    return config.columnWidth;
  }

  TableSpan _rowBuilder(int index) {
    switch (index) {
      case 0:
        return TableSpan(
          extent: FixedSpanExtent(headerHeight),
        );
      default:
        return TableSpan(
          extent: FixedSpanExtent(rowHeight),
          recognizerFactories: <Type, GestureRecognizerFactory>{
            if (onTapRow != null)
              TapGestureRecognizer:
                  GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
                () => TapGestureRecognizer(),
                (TapGestureRecognizer t) =>
                    t.onTap = () => onTapRow!(index - 1),
              ),
          },
        );
    }
  }
}
