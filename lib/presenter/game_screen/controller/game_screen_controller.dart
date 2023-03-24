import 'dart:math';

import 'package:tic_tac_toe/design_system/color/ds_colors.dart';
import 'package:tic_tac_toe/presenter/game_screen/utils/bord_tile.dart';
import 'package:tic_tac_toe/presenter/game_screen/utils/enum/player_type.dart';
import 'package:tic_tac_toe/presenter/game_screen/utils/enum/winner_type.dart';
import 'package:tic_tac_toe/presenter/game_screen/utils/winning_rules.dart';

class GameScreenController {
  List<BoardTile> square = [];
  List<int> movesPlayer1 = [];
  List<int> movesPlayer2 = [];
  late PlayerType currentPlayer;
  late bool isSinglePlayer;

  bool get hasMoves => (movesPlayer1.length + movesPlayer2.length) != 9;

  GameScreenController() {
    _initialize();
  }

  void _initialize() {
    movesPlayer1.clear();
    movesPlayer2.clear();
    currentPlayer = PlayerType.player1;
    isSinglePlayer = false;
    square = List<BoardTile>.generate(9, (index) => BoardTile(index + 1));
  }

  void reset() {
    _initialize();
  }

  void markBoardTileByIndex(index) {
    final tile = square[index];
    if (currentPlayer == PlayerType.player1) {
      _markBoardTileWithPlayer1(tile);
    } else {
      _markBoardTileWithPlayer2(tile);
    }

    tile.enable = false;
  }

  void _markBoardTileWithPlayer1(BoardTile tile) {
    tile.symbol = 'X';
    tile.color = DSColors.red100;
    movesPlayer1.add(tile.id);
    currentPlayer = PlayerType.player2;
  }

  void _markBoardTileWithPlayer2(BoardTile tile) {
    tile.symbol = 'O';
    tile.color = DSColors.yellow100;
    movesPlayer2.add(tile.id);
    currentPlayer = PlayerType.player1;
  }

  bool _checkPlayerWinner(List<int> moves) {
    return winningRules.any((rule) =>
        moves.contains(rule[0]) &&
        moves.contains(rule[1]) &&
        moves.contains(rule[2]));
  }

  Object checkWinner() {
    if (_checkPlayerWinner(movesPlayer1)) return WinnerType.player1;
    if (_checkPlayerWinner(movesPlayer2)) return WinnerType.player2;
    return WinnerType.values;
  }

  int automaticMove() {
    var list = List.generate(9, (i) => i + 1);
    list.removeWhere((element) => movesPlayer1.contains(element));
    list.removeWhere((element) => movesPlayer2.contains(element));

    var random = Random();
    var index = random.nextInt(list.length - 1);
    return square.indexWhere((tile) => tile.id == list[index]);
  }
}