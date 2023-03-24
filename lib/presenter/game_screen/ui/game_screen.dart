// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/design_system/alert_dialog/alert_dialog.dart';
import 'package:tic_tac_toe/design_system/appBar/appbar_widget.dart';
import 'package:tic_tac_toe/design_system/color/ds_colors.dart';
import 'package:tic_tac_toe/presenter/game_screen/controller/game_screen_controller.dart';
import 'package:tic_tac_toe/presenter/game_screen/utils/enum/player_type.dart';
import 'package:tic_tac_toe/presenter/game_screen/utils/enum/winner_type.dart';
import 'package:tic_tac_toe/presenter/game_screen/utils/strings/game_strings.dart';

class GameScreenView extends StatefulWidget {
  const GameScreenView({Key? key}) : super(key: key);

  static const routeName = '/game_screen_view';

  @override
  _GameScreenViewState createState() => _GameScreenViewState();
}

class _GameScreenViewState extends State<GameScreenView> {
  final controller = GameScreenController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: GAME_TITLE,
        backgroundColor: DSColors.black100,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding:
              const EdgeInsets.only(right: 12, left: 12, top: 12, bottom: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SwitchListTile(
                activeColor: DSColors.black100,
                title: Text(
                  controller.isSinglePlayer
                      ? 'Jogar Sozinho'
                      : 'Dois Jogadores',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                secondary: Icon(
                    controller.isSinglePlayer ? Icons.person : Icons.group),
                value: controller.isSinglePlayer,
                onChanged: (value) {
                  setState(() {
                    controller.isSinglePlayer = value;
                  });
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: _buildSquare,
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(DSColors.black100),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: DSColors.black30),
                    ),
                  ),
                ),
                onPressed: _onResetGame,
                child: const Text('Reiniciar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSquare(context, index) {
    return GestureDetector(
      onTap: () => _onMarkSquare(index),
      child: Container(
        color: controller.square[index].color,
        child: Center(
          child: Text(
            controller.square[index].symbol,
            style: const TextStyle(
              fontSize: 72.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  _onResetGame() {
    setState(() {
      controller.reset();
    });
  }

  _onMarkSquare(index) {
    if (!controller.square[index].enable) return;

    setState(() {
      controller.markBoardTileByIndex(index);
    });

    _checkWinner();
  }

  _checkWinner() {
    var winner = controller.checkWinner();
    if (winner == WinnerType.values) {
      if (!controller.hasMoves) {
        _showTiedDialog();
      } else if (controller.isSinglePlayer &&
          controller.currentPlayer == PlayerType.player2) {
        final index = controller.automaticMove();
        _onMarkSquare(index);
      }
    } else {
      String symbol = winner == WinnerType.player1 ? 'X' : 'O';
      _showWinnerDialog(symbol);
    }
  }

  _showWinnerDialog(String symbol) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialogWidget(
          title: WIN_TITLE.replaceAll('[SYMBOL]', symbol),
          message: ALERT_DIALOG_MESSAGE,
          onTap: _onResetGame,
        );
      },
    );
  }

  _showTiedDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialogWidget(
          title: TIED_TITLE,
          message: ALERT_DIALOG_MESSAGE,
          onTap: _onResetGame,
        );
      },
    );
  }
}
