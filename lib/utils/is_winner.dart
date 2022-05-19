import 'package:conecta4/contanst.dart';

bool paintWinner(List<List<int>> board, List<List<int>> boardTemp, col, row, turn){
  board[col][row] = turn + 2;
  for (var i = 0; i < board.length; i++) {
    for (var j = 0; j < board[i].length; j++){
      if (boardTemp[i][j] != 0) board[i][j] = boardTemp[i][j];
    }
  }
  return true;
}

bool isWinner(List<List<int>> board, int turn, int col, int row) {
  int i = 0;
  int j = 0;
  int counter = 0;

  const limitCols = colsBoard - 1;
  const limitRows = rowsBoard - 1;

  List<List<int>> boardTemp = List.generate(rowsBoard, (index) => List.generate(colsBoard, (index) => 0));
  /* validacion de fila */
  while (i < limitCols && counter < 3) {
    if (board[i][row] == board[i + 1][row] && board[i][row] == turn){
      counter++;
      boardTemp[i][row] = turn + 2;
      boardTemp[i + 1][row] = turn + 2;
    }
    i++;
  }
  if (counter == 3) return paintWinner(board, boardTemp, col, row, turn);

  /* validacion de columna */
  boardTemp = List.generate(rowsBoard, (index) => List.generate(colsBoard, (index) => 0));
  j = counter = 0;
  while (j < limitRows && counter < 3) {
    if (board[col][j] == board[col][j + 1] && board[col][j] == turn){
      counter++;
      boardTemp[col][j] = turn + 2;
      boardTemp[col][j + 1] = turn + 2;
    }
    j++;
  }
  if (counter == 3) return paintWinner(board, boardTemp, col, row, turn);

  /* validacion de diagonal principal */
  boardTemp = List.generate(rowsBoard, (index) => List.generate(colsBoard, (index) => 0));
  i = col;
  j = row;
  counter = 0;
  while (i > 0 && j > 0) { i--; j--; }
  while (i < limitCols && j < limitRows) {
    if  (board[i][j] == board[i + 1][j + 1] && board[i][j] == turn){ 
      counter++;
      boardTemp[i][j] = turn + 2;
      boardTemp[i + 1][j + 1] = turn + 2;  
    }
    i++; j++;
  }
  if (counter == 3) return paintWinner(board, boardTemp, col, row, turn);

  /* validacion de diagonal invertida */
  boardTemp = List.generate(rowsBoard, (index) => List.generate(colsBoard, (index) => 0));
  i = col;
  j = row;
  counter = 0;
  while (i > 0 && j < limitRows) { i--; j++; }
  while (i < limitCols && j > 0) {
    if  (board[i][j] == board[i + 1][j - 1] && board[i][j] == turn){ 
      counter++;
      boardTemp[i][j] = turn + 2;
      boardTemp[i + 1][j - 1] = turn + 2;
    }
    i++; j--;
  }
  if (counter == 3) return paintWinner(board, boardTemp, col, row, turn);

  return false;
}