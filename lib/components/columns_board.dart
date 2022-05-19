import 'package:conecta4/contanst.dart';
import 'package:flutter/material.dart';

class ColumnsBoard extends StatelessWidget {
  final List<List<int>> board;
  final Function(int i, int j)? onPressCell;

  const ColumnsBoard({
    super.key, 
    required this.board,
    required void Function(int i, int j)? this.onPressCell
  });
  
  @override
  Widget build(BuildContext context) {
    final rows = board.asMap().entries.map((row){
      final cells = row.value.asMap().entries.map((cell){
        return TableCell(
          child: _buildCell(cell.value, row.key, cell.key),
        );
      }).toList();

      return TableRow( children: cells );
    }).toList();
    
    return Table( children: rows, border: TableBorder.all(), );
  }

  Widget _buildCell (value, i, j) {
    final isSelect = value > 2;
    final item = value > 2 ? value - 2 : value;

    return Container(
      foregroundDecoration: isSelect ? const BoxDecoration(color: Colors.grey, backgroundBlendMode: BlendMode.luminosity) : null,
      child: IconButton(
        onPressed: onPressCell != null ? () => onPressCell!(i, j) : null, 
        icon: item == 0 ? const Icon(null) : Icon(
          Icons.circle,
          color: item == 1 ? colorPlayerOne : colorPlayerTwo,
        )
      ),
    );
  }


}