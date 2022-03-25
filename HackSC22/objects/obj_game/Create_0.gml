///Create
/*
Sounds
-move
-make a word / tiles disappear (pop)
-error
-select



*/

//Randomize
randomize();

//Scaling stuff
base_width = room_width;
base_height = room_height;
width = base_width;
height = base_height;

//Constants
tileSize = 128;
gameSize = 3;
xOffset = 0;
yOffset = 128;


//Variables
swipeState = 0;
holdLength = 0;

swipeOriginX = -1;
swipeOriginY = -1;

selectionXs = ds_list_create();
selectionYs = ds_list_create();
selColor = make_color_rgb(68,140,203);

points = 0;
strikes = 0;

lost = false;
lostFade = 0;

wordDisplayState = 0;
wordDisplayTimer = 0;
displayWord = "";

//Initialize the board to nulls
for(var xx = 0; xx < gameSize; xx++){
	for(var yy = 0; yy < gameSize; yy++){
		board[xx][yy] = pointer_null;
		selectionDots[xx][yy] = 0;
	}
}

//Function that tells whether there is space on the board
boardHasSpace = function(){
	for(var xx = 0; xx < gameSize; xx++){
		for(var yy = 0; yy < gameSize; yy++){
			if(board[xx][yy] == pointer_null){
				return true;
			}
		}
	}
}

//Function that tells whether there is a vowel on the board
boardHasVowel = function(){
	for(var xx = 0; xx < gameSize; xx++){
		for(var yy = 0; yy < gameSize; yy++){
			if(board[xx][yy] != pointer_null && (board[xx][yy].letter == "a" ||
												board[xx][yy].letter == "e" ||
												board[xx][yy].letter == "i" ||
												board[xx][yy].letter == "o" ||
												board[xx][yy].letter == "u")){
				return true;
			}
		}
	}
	return false;
}

//Function that creates a random tile on the board
createRandomTile = function(){
	if(boardHasSpace()){
		while(true){
			var nX = irandom_range(0, gameSize-1);
			var nY = irandom_range(0, gameSize-1);
			if(board[nX][nY] == pointer_null){
				board[nX][nY] = instance_create_layer(gameToScreenX(nX), gameToScreenY(nY), "Tiles", obj_tile);
				
				board[nX][nY].moveTo(nX, nY);
				break;
			}
		}
	}
}

//Function that creates a random tile on the board
createSpecificTile = function(n){
	while(true){
		var nX = irandom_range(0, gameSize-1);
		var nY = irandom_range(0, gameSize-1);
		if(board[nX][nY] == pointer_null){
			board[nX][nY] = instance_create_layer(gameToScreenX(nX), gameToScreenY(nY), "Tiles", obj_tile);
			board[nX][nY].letter = n;
			board[nX][nY].moveTo(nX, nY);
			break;
		}
	}
}

//Helper function to check whether an item is in an array
arrayContains = function(arr, n){
	var len = array_length(arr);
	for(var i = 0; i < len; i++){
		if(arr[i] == n){ return true; }
	}
	return false;
}

//Function that uses new rules to spawn a tile on the board
vowels = ["a", "e", "i", "o", "u"];
vowelFloor = 2;
vowelCeil = 3;
specials = ["j", "k", "q", "v", "w", "x", "z"];
specialFloor = 1;
specialCeil = 2;
normals = ["b", "c", "d", "f", "g", "h", "l", "m", "n", "p", "r", "s", "t", "y"];

createBalancedTile = function(){
	//Count how much of each there already is
	var cV = 0;
	var cS = 0;
	var cN = 0;
	for(var yy = 0; yy < gameSize; yy++){
		for(var xx = 0; xx <gameSize; xx++){
			if(board[xx][yy] != pointer_null){
				var l = board[xx][yy].letter;
				if(arrayContains(vowels, l)){ cV++; }
				else if(arrayContains(specials, l)){ cS++; }
				else{ cN++; }
			}
		}
	}
	
	//Is the board full?
	if(cV + cS + cN == gameSize*gameSize){
		return;
	}
	
	//Do we require a vowel?
	if(cV < vowelFloor){
		createSpecificTile(vowels[irandom_range(0, array_length(vowels)-1)]);
		return;
	}
	
	//Do we require a special?
	if(cS < specialFloor){
		createSpecificTile(specials[irandom_range(0, array_length(specials)-1)]);
		return;
	}
	
	//Make a normal tile
	candidates = [0];
	array_copy(candidates, 0, normals, 0, array_length(normals));
	if(cV < vowelCeil){
		array_copy(candidates, array_length(candidates)-1, vowels, 0, array_length(vowels));
	}
	if(cS < specialCeil){
		array_copy(candidates, array_length(candidates)-1, specials, 0, array_length(specials));
	}
	createSpecificTile(candidates[irandom_range(0, array_length(candidates)-1)]);
}

//Function that finds the word you have currently selected
getSelectedWord = function(){
	var ans = "";
	for(var i = 0; i < ds_list_size(selectionXs); i++){
		var selTile = board[selectionXs[| i]][selectionYs[| i]];
		ans += selTile.letter;
	}
	return ans;
}

//Function that creates a random letter, but properly distributed across the engilsh language
letters = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"];
letterProbs = [8.4966, 2.0720, 4.5388, 3.3844, 11.1607, 1.8121, 2.4705, 3.0034, 7.5448, 0.1965, 1.1016, 5.4893, 3.0129, 6.6544, 7.1635,
				3.1671, 0.1962, 7.5809, 5.7351, 6.9509, 3.6308, 1.0074, 1.2899, 0.2902, 1.7779, 0.2722];
letterProbSum = 0;
for(var i = 0; i < array_length(letterProbs); i++){ letterProbSum += letterProbs[i]; }
getRandomLetter = function(){
	if(!boardHasVowel()){
		switch(irandom_range(0, 4)){
		case(0): return "a";
		case(1): return "e";
		case(2): return "i";
		case(3): return "o";
		case(4): return "u";
		}
	}
	var rand = random(letterProbSum);
	var sum = 0;
	for(var i = 0; i < 26; i++){
		sum += letterProbs[i];
		if(rand <= sum){
			return letters[i];
		}
	}
	return "e"; //something broke but lets imagine it didn't
}

//Read in valid words
wordGrid = load_csv("dictionary.csv");
wordMap = ds_map_create();
for (var i=0;i<ds_grid_height(wordGrid);i++){
    ds_map_add(wordMap,wordGrid[# 0, i],true);
}

//Function that tells whether a word is valid
validWord = function(word_){
	return ds_map_find_value(wordMap, word_) != undefined;
}

//BFS
validWordAt = function(atX, atY, str){
	if(atX < 0 || atX >= gameSize || atY < 0 || atY >= gameSize || checked[atX][atY]){
		return false;
	}
	str += board[atX][atY].letter;
	if(string_length(str) > 2 && validWord(str)){
		show_debug_message(str);
		return true;
	}
	checked[atX][atY] = true;
	for(var d = 0; d < 4; d++){
		if(validWordAt(atX + dirX(d), atY +  dirY(d), str)){
			return true;
		}
	}
	checked[atX][atY] = false;
	return false;
}

//BFS to tell whether the board has moves
gameOver = function(){
	//check the board has no empty spaces
	for(var xx = 0; xx < gameSize; xx++){
		for(var yy = 0; yy < gameSize; yy++){
			if(board[xx][yy] == pointer_null){
				return false;
			}
		}
	}
	
	//for each potential starting position...
	for(var xx = 0; xx < gameSize; xx++){
		for(var yy = 0; yy < gameSize; yy++){
			//reset the shit
			for(var i = 0; i < gameSize; i++){
				for(var j = 0; j < gameSize; j++){
					checked[i][j] = false;
				}
			}
			if(validWordAt(xx, yy, "")){
				return false;
			}
		}
	}
	return true;
}

//Initialize the board with 3 random tiles
for(var i = 0; i < 3; i++){
	createBalancedTile();
}