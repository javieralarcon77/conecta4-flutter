import 'package:flutter/material.dart';

import 'package:conecta4/contanst.dart';
import 'package:conecta4/components/columns_board.dart';
import 'package:conecta4/utils/is_winner.dart';



class Board extends StatefulWidget {
  const Board({Key? key}) : super(key: key);
  
  @override
  BoardState createState() => BoardState();
}

class BoardState extends State<Board> {
  List<List<int>> board = List.generate(rowsBoard, (index) => List.generate(colsBoard, (index) => 0));
  int turn = 1;
  bool haveWinner = false;
  Map<String, int> winner = {
    "player1": 0,
    "player2": 0
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: const Text('Time of play'),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Turn of ', style: TextStyle(fontSize: 18.0),),
              Text(
                turn == 1 ? 'Player 1' : 'Player 2',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: turn == 1 ? colorPlayerOne : colorPlayerTwo
                ),
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ColumnsBoard(
            board: board,
            onPressCell: !haveWinner ? _handlePressCell : null,
          ),
        ),
        Container(
          margin: const EdgeInsets.all(20.0),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Player 1: ${winner["player1"]}'),
              const Spacer(flex: 1),
              Text('Player 2: ${winner["player2"]}')
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50,),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _restartGame(),
              const Spacer(flex: 2),
              _restart()
            ],
          ),
        ),
        haveWinner ? 
          Text("El ganador es ${turn == 1 ? "Player 2": "Player 1"}", style: const TextStyle(fontSize: 20.0),) : 
          const Spacer(flex: 1)
      ],
    );
  }

  void animationCaida (encountered, row) {
    
  }

  void _handlePressCell (col, row) {
    setState((){
      int encountered = -1;
      int i = 0;
      while (i < colsBoard && encountered == -1) {
        if (board[i][row] != 0) encountered = i;
        i++;
      }
      if (encountered != 0) {
        encountered = encountered == -1 ? colsBoard - 1 : encountered - 1;
        board[encountered][row] = turn;
        final win = isWinner(board, turn, encountered, row);
        //print(win);
        if (win){
          final playerWin = turn == 1 ? 'player1' : 'player2';
          final countWin = winner[playerWin] ?? 0;
          winner[playerWin] = countWin + 1;
          //_showMyDialog(playerWin);
          haveWinner = true;
        } 
        turn = turn == 1 ? 2 : 1;
      }
    });
  }

  void _cleanState () {
    setState(() {
      haveWinner = false;
      board = List.generate(rowsBoard, (index) => List.generate(colsBoard, (index) => 0));
    });
  }

  Widget _restartGame () {
    return TextButton(
      onPressed: _cleanState, 
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
      ),
      child: Text(
        !haveWinner ? "Restart Game" : "Play Again", 
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _restart () {
    return TextButton(
      onPressed: () {
        _cleanState();
        winner = {
          "player1": 0,
          "player2": 0,
        };
      }, 
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
      ),
      child: const Text("Restart all", style: TextStyle(color: Colors.white),),
    );
  }

  Future<void> _showMyDialog(String win) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('We have a winner'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('The winner is: $win'),
                const Text('Play again?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Play'),
              onPressed: () {
                _cleanState();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
