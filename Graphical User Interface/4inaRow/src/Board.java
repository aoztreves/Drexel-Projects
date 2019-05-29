import java.util.ArrayList;

public class Board {
	
	public static final int X = 1;
	public static final int O = -1;
	public static final int EMPTY = 0;
	
    private Move lastMove;
    
    private int lastSymbolPlayed;
    
    private int winner;
	private int [][] gameBoard;
	
	private boolean overflowOccured = false;
		
	private boolean isGameOver;
	
	public Board() {
		lastMove = new Move();
		lastSymbolPlayed = O;
		winner = 0;
		gameBoard = new int[6][7];
		for(int i=0; i<6; i++) {
			for(int j=0; j<7; j++) {
				gameBoard[i][j] = EMPTY;
			}
		}
	}

	public Board(Board board) {
		lastMove = board.lastMove;
		lastSymbolPlayed = board.lastSymbolPlayed;
		winner = board.winner;
		gameBoard = new int[6][7];
		for(int i=0; i<6; i++) {
			for(int j=0; j<7; j++) {
				gameBoard[i][j] = board.gameBoard[i][j];
			}
		}
	}
	
	
	public Move getLastMove() {
		return lastMove;
	}
	
	public void setLastMove(Move lastMove) {
		this.lastMove.setRow(lastMove.getRow());
		this.lastMove.setCol(lastMove.getCol());
		this.lastMove.setValue(lastMove.getValue());
	}
	
	
	public int getLastSymbolPlayed() {
		return lastSymbolPlayed;
	}
	
	
	public void setLastSymbolPlayed(int lastLetterPlayed) {
		this.lastSymbolPlayed = lastLetterPlayed;
	}
	
	
	public int[][] getGameBoard() {
		return gameBoard;
	}
	
	
	public void setGameBoard(int[][] gameBoard) {
		for(int i=0; i<6; i++) {
			for(int j=0; j<7; j++) {
				this.gameBoard[i][j] = gameBoard[i][j];
			}
		}
	}
	
	
	public int getWinner() {
		return winner;
	}
	
	
	public void setWinner(int winner) {
		this.winner = winner;
	}
	
	
	public boolean isGameOver() {
		return isGameOver;
	}


	public void setGameOver(boolean isGameOver) {
		this.isGameOver = isGameOver;
	}
	
	
	public boolean isOverflowOccured() {
		return overflowOccured;
	}

	
	public void setOverflowOccured(boolean overflowOccured) {
		this.overflowOccured = overflowOccured;
	}
	

	
	public void makeMove(int col, int letter) {
		try {
		
			this.lastMove = new Move(getRowPosition(col), col);
			this.lastSymbolPlayed = letter;
			this.gameBoard[getRowPosition(col)][col] = letter;
		} catch (ArrayIndexOutOfBoundsException e) {
			System.err.println("Column " + (col+1) + " is full!");
			setOverflowOccured(true);
		}
	}

	public boolean canMove(int row, int col) {
		if ((row <= -1) || (col <= -1) || (row > 5) || (col > 6)) {
			return false;
		}
		return true;
	}
	
	
	public boolean checkFullColumn(int col) {
		if (gameBoard[0][col] == EMPTY)
			return false;
		return true;
	}
	

	public int getRowPosition(int col) {
		int rowPosition = -1;
		for (int row=0; row<6; row++) {
			if (gameBoard[row][col] == EMPTY) {
				rowPosition = row;
			}
		}
		return rowPosition;
	}
	
	public ArrayList<Board> getChildren(int letter) {
		ArrayList<Board> children = new ArrayList<Board>();
		for(int col=0; col<7; col++) {
			if(!checkFullColumn(col)) {
				Board child = new Board(this);
				child.makeMove(col, letter);
				children.add(child);
			}
		}
		return children;
	}
	
	
	public int evaluate() {
		int Xlines = 0;
		int Olines = 0;

        if (checkWinState()) {
			if(getWinner() == X) {
				Xlines = Xlines + 100;
			} else if (getWinner() == O) {
				Olines = Olines + 100;
			}
		}
		
        Xlines  = Xlines + check3InARow(X)*10 + check2InARow(X);
        Olines  = Olines + check3InARow(O)*10 + check2InARow(O);
		
        // if the result is 0, then it'a a draw 
		return Xlines - Olines;
	}
	//All the loops are in the same order, horizontal, vertical, diagonal dec, diagonal asc
	public boolean checkWinState() {
		
		for (int i=5; i>=0; i--) {
			for (int j=0; j<4; j++) {
				if (gameBoard[i][j] == gameBoard[i][j+1]
						&& gameBoard[i][j] == gameBoard[i][j+2]
						&& gameBoard[i][j] == gameBoard[i][j+3]
						&& gameBoard[i][j] != EMPTY) {
					setWinner(gameBoard[i][j]);
					return true;
				}
			}
		}
		
		for (int i=5; i>=3; i--) {
			for (int j=0; j<7; j++) {
				if (gameBoard[i][j] == gameBoard[i-1][j]
						&& gameBoard[i][j] == gameBoard[i-2][j]
						&& gameBoard[i][j] == gameBoard[i-3][j]
						&& gameBoard[i][j] != EMPTY) {
					setWinner(gameBoard[i][j]);
					return true;
				}
			}
		}
		
		for (int i=0; i<3; i++) {
			for (int j=0; j<4; j++) {
				if (gameBoard[i][j] == gameBoard[i+1][j+1]
						&& gameBoard[i][j] == gameBoard[i+2][j+2]
						&& gameBoard[i][j] == gameBoard[i+3][j+3] 
						&& gameBoard[i][j] != EMPTY) {
					setWinner(gameBoard[i][j]);
					return true;
				}
			}
		}
		
		for (int i=0; i<6; i++) {
			for (int j=0; j<7; j++) {
				if (canMove(i-3,j+3)) {
					if (gameBoard[i][j] == gameBoard[i-1][j+1]
							&& gameBoard[i][j] == gameBoard[i-2][j+2]
							&& gameBoard[i][j] == gameBoard[i-3][j+3] 
							&& gameBoard[i][j] != EMPTY) {
						setWinner(gameBoard[i][j]);
						return true;
					}
				}
			}
		}
		
		setWinner(0); // set as winner nobody
		return false;

	}
	
    public boolean checkGameOver() {

    	if (checkWinState()) {
    		return true;
    	}
    	
    	for(int row=0; row<6; row++) {
			for(int col=0; col<7; col++) {
				if(gameBoard[row][col] == EMPTY) {
                    return false;
                }
            }
        }
    	
    	return true;
    }

	public int check3InARow(int playerSymbol) {
		
		int times = 0;
		
		for (int i = 5; i >= 0; i--) {
			for (int j = 0; j < 7; j++) {
				if (canMove(i, j + 2)) {
					if (gameBoard[i][j] == gameBoard[i][j + 1]
							&& gameBoard[i][j] == gameBoard[i][j + 2]
							&& gameBoard[i][j] == playerSymbol) {
						times++;
					}
				}
			}
		}

		for (int i = 5; i >= 0; i--) {
			for (int j = 0; j < 7; j++) {
				if (canMove(i - 2, j)) {
					if (gameBoard[i][j] == gameBoard[i - 1][j]
							&& gameBoard[i][j] == gameBoard[i - 2][j]
							&& gameBoard[i][j] == playerSymbol) {
						times++;
					}
				}
			}
		}

		for (int i = 0; i < 6; i++) {
			for (int j = 0; j < 7; j++) {
				if (canMove(i + 2, j + 2)) {
					if (gameBoard[i][j] == gameBoard[i + 1][j + 1]
							&& gameBoard[i][j] == gameBoard[i + 2][j + 2]
							&& gameBoard[i][j] == playerSymbol) {
						times++;
					}
				}
			}
		}

		for (int i = 0; i < 6; i++) {
			for (int j = 0; j < 7; j++) {
				if (canMove(i - 2, j + 2)) {
					if (gameBoard[i][j] == gameBoard[i - 1][j + 1]
							&& gameBoard[i][j] == gameBoard[i - 2][j + 2]
							&& gameBoard[i][j] == playerSymbol) {
						times++;
					}
				}
			}
		}

		return times;
				
	}
	
	public int check2InARow(int player) {
		
		int times = 0;
		
		for (int i = 5; i >= 0; i--) {
			for (int j = 0; j < 7; j++) {
				if (canMove(i, j + 1)) {
					if (gameBoard[i][j] == gameBoard[i][j + 1]
							&& gameBoard[i][j] == player) {
						times++;
					}
				}
			}
		}

		for (int i = 5; i >= 0; i--) {
			for (int j = 0; j < 7; j++) {
				if (canMove(i - 1, j)) {
					if (gameBoard[i][j] == gameBoard[i - 1][j]
							&& gameBoard[i][j] == player) {
						times++;
					}
				}
			}
		}

		for (int i = 0; i < 6; i++) {
			for (int j = 0; j < 7; j++) {
				if (canMove(i + 1, j + 1)) {
					if (gameBoard[i][j] == gameBoard[i + 1][j + 1]
							&& gameBoard[i][j] == player) {
						times++;
					}
				}
			}
		}

		for (int i = 0; i < 6; i++) {
			for (int j = 0; j < 7; j++) {
				if (canMove(i - 1, j + 1)) {
					if (gameBoard[i][j] == gameBoard[i - 1][j + 1]
							&& gameBoard[i][j] == player) {
						times++;
					}
				}
			}
		}

		return times;
				
	}
	
	//Used for checking the AI before Gui
  	public void print() {
  		
  		System.out.println("| 1 | 2 | 3 | 4 | 5 | 6 | 7 |");
  		System.out.println();
  		for (int i=0; i<6; i++) {
  			for (int j=0; j<7; j++) {
  				if (j!=6) {
  					if (gameBoard[i][j] == 1) {
  						System.out.print("| " + "X" + " ");
  					} else if (gameBoard[i][j] == -1) {
  						System.out.print("| " + "O" + " ");
  					} else {
  						System.out.print("| " + "-" + " ");
  					}
  				} else {
  					if (gameBoard[i][j] == 1) {
  						System.out.println("| " + "X" + " |");
  					} else if (gameBoard[i][j] == -1) {
  						System.out.println("| " + "O" + " |");
  					} else {
  						System.out.println("| " + "-" + " |");
  					}
  				}
  			}
  		}
  		
  	}


}
