///Step

//Movement
if(swipeState == 0 && mouse_check_button_pressed(mb_left)){
	swipeOriginX = screenToGameX(window_mouse_get_x());
	swipeOriginY = screenToGameY(window_mouse_get_y());
	if(swipeOriginX >= 0 && swipeOriginX < gameSize && swipeOriginY >= 0 && swipeOriginY < gameSize){
		swipeState = 1;
	}
}

if(swipeState == 1){
	if(!mouse_check_button(mb_left)){
		swipeState = 0;
	}
	var swipeX = screenToGameX(window_mouse_get_x());
	var swipeY = screenToGameY(window_mouse_get_y());
	var swipeDir = -2;
	if(swipeX == swipeOriginX+1 && swipeY == swipeOriginY){
		swipeDir = 0;
	}else if(swipeX == swipeOriginX && swipeY == swipeOriginY-1){
		swipeDir = 1;
	}else if(swipeX == swipeOriginX-1 && swipeY == swipeOriginY){
		swipeDir = 2;
	}else if(swipeX == swipeOriginX && swipeY == swipeOriginY+1){
		swipeDir = 3;
	}else if(swipeX == swipeOriginX && swipeY == swipeOriginY){
		//just let it run
		swipeDir = -1;
	}
	
	if(swipeDir == -2){
		//we've left the region of reasonable input
		swipeState = 0;
	}else if(swipeDir == -1){
		//We're waiting...
	}else{
		//Check if there's a tile to move
		if(swipeOriginX >= 0 && swipeOriginX < gameSize && swipeOriginY >= 0 && swipeOriginY < gameSize && board[swipeOriginX][swipeOriginY] != pointer_null){
			//so can we move it lol?
			var tilesToMove = 1;
			var checkX = swipeOriginX;
			var checkY = swipeOriginY;
			var canMove = true;
			while(true){
				checkX += dirX(swipeDir);
				checkY += dirY(swipeDir);
				if(checkX >= 0 && checkX < gameSize && checkY >= 0 && checkY < gameSize){
					if(board[checkX][checkY] == pointer_null){
						//we found an empty spot, so we can move!
						canMove = true;
						break;
					}else{
						//it's another tile, so we need to repeat
						tilesToMove++;
					}
				}else{
					//we've hit a wall, so we can't move :(
					canMove = false;
					break;
				}
			}
			
			//move the tile(s) if we can
			if(canMove){
				for(var i = tilesToMove; i > 0; i--){
					var mX = swipeOriginX + i*dirX(swipeDir);
					var mY = swipeOriginY + i*dirY(swipeDir);
					board[mX][mY] = board[mX-dirX(swipeDir)][mY-dirY(swipeDir)];
					board[mX-dirX(swipeDir)][mY-dirY(swipeDir)] = pointer_null;
					board[mX][mY].moveTo(mX,mY);
				}
				
				//Create a new tile
				createRandomTile();
			}
		}
		
		//Reset state
		swipeState = 0;
	}
}

//Selection
if(swipeState == 0 && mouse_check_button_pressed(mb_right)){
	swipeOriginX = screenToGameX(window_mouse_get_x());
	swipeOriginY = screenToGameY(window_mouse_get_y());
	if(swipeOriginX >= 0 && swipeOriginX < gameSize && swipeOriginY >= 0 && swipeOriginY < gameSize && board[swipeOriginX][swipeOriginY] != pointer_null){
		ds_list_clear(selectionXs);
		ds_list_clear(selectionYs);
		ds_list_add(selectionXs, swipeOriginX);
		ds_list_add(selectionYs, swipeOriginY);
		swipeState = 2;
	}
}

if(swipeState == 2){
	if(mouse_check_button(mb_right)){
		//Get where we selected
		var selX = screenToGameX(window_mouse_get_x());
		var selY = screenToGameY(window_mouse_get_y());
		var lastSelX = selectionXs[| ds_list_size(selectionXs)-1];
		var lastSelY = selectionYs[| ds_list_size(selectionYs)-1];
		
		//Check whether the click was the same spot, an adjacent spot, or an illegal spot
		var changeSel = false;
		if(selX < 0 || selX >= gameSize || selY < 0 || selY >= gameSize || board[selX][selY] == pointer_null){
			//out of bounds or non-tile, so abort the selection
			swipeState = 0;
		}else if(selX == lastSelX && selY == lastSelY){
			//we good, do nothing
		}else if(selX == lastSelX+1 && selY == lastSelY){
			changeSel = true;
		}else if(selX == lastSelX && selY == lastSelY-1){
			changeSel = true;
		}else if(selX == lastSelX-1 && selY == lastSelY){
			changeSel = true;
		}else if(selX == lastSelX && selY == lastSelY+1){
			changeSel = true;
		}else{
			//abort
			swipeState = 0;
		}
		if(changeSel){
			//if we're trying to select something already selected, reduce your selection until it is at that point
			for(var i = 0; i < ds_list_size(selectionXs); i++){
				if(selX == selectionXs[| i] && selY == selectionYs[| i]){
					while(ds_list_size(selectionXs) > i+1){
						ds_list_delete(selectionXs, i+1);
						ds_list_delete(selectionYs, i+1);
					}
					changeSel = false;
					break;
				}
			}
			if(changeSel){
				ds_list_add(selectionXs, selX);
				ds_list_add(selectionYs, selY);
			}
		}
	}else{
		//Wrap up and check if it's a word
		if(ds_list_size(selectionXs) > 1 && validWord(getSelectedWord())){
			//valid word
			points += ds_list_size(selectionXs)*ds_list_size(selectionXs);
			for(var i = 0; i < ds_list_size(selectionXs); i++){
				board[selectionXs[| i]][selectionYs[| i]].die();
				board[selectionXs[| i]][selectionYs[| i]] = pointer_null;
			}
			createRandomTile();
		}else{
			//invalid word
		}
		swipeState = 0;
	}
}
