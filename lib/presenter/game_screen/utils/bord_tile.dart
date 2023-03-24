import 'package:flutter/material.dart';
import 'package:tic_tac_toe/design_system/color/ds_colors.dart';

class BoardTile {
  final int id;
  String symbol;
  Color color;
  bool enable;

  BoardTile(
    this.id, {
    this.symbol = '',
    this.color = DSColors.black10,
    this.enable = true,
  });
}
