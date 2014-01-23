class DicegameController < ApplicationController
	def play_dice_game
			
		#make array of numbers
		diceNum = [1,2,3,4,5,6]

		# 3 parameter variantes:
		# 4 parameters = state, diceOne, diceTwo, goal
		##1 first game = nil,		nil,	 nil, nil
		##2	new game   = new,   randNum, randNum, -1
		##3	curr game  = old,   randNum, randNum, 10
		@state = params["state"]
		@diceOne = params["diceOne"].to_i
		@diceTwo = params["diceTwo"].to_i
		@goal = params["goal"].to_i

		#Set the sum of dice
		diceSum = @diceOne + @diceTwo
		#if first or new game, assign goal to sum of dice
		if @goal == -1 
			@goal = diceSum
		end

		#three possible game states
			#1. First game = nil
			#2. New game = new
			#3. Old game = old
		#below checks handle according to what the current game state is
		#and adjust for the new game state.

		#FIRST GAME STATE
		if @state == nil
		 	@bStart = true
		 	@stateMessage = "Welcome"
			@goalMessage = ""
			@buttonMessage = "Roll to start the game"
		else 
			@bStart = false
			@bPicture = true
			@stateMessage = "Your goal is now " + @goal.to_s
			@goalMessage = "Now try to get " + @goal.to_s + " before you roll a 7"
			@buttonMessage = "Roll the dice"
			@diceOnePicture = @diceOne
			@diceTwoPicture = @diceTwo
		end

		#NEW GAME STATE
		if @state == "new"
			
			@state = "old" #change game state
			#check if wins game
			if diceSum == 7 || diceSum == 11
				@state = "new"
				@goal = -1
				@stateMessage = "YOU WIN!"
				@goalMessage = ""
				@buttonMessage = "Start Over"
			end
			#check if lose game
			if diceSum == 2 || diceSum == 3 || diceSum == 12
				@state = "new"
				@goal = -1
				@stateMessage = "YOU LOSE!"
				@goalMessage = ""
				@buttonMessage = "Start Over"
			end
		
		#OLD GAME STATE
		elsif @state == "old"
			#check if wins game
			if diceSum == @goal
				@state = "new"
				@goal = -1
				@stateMessage = "YOU WIN!"
				@goalMessage = ""
				@buttonMessage = "Start Over"
			end
			#check if lose game
			if diceSum == 7
				@state = "new"
				@goal = -1
				@stateMessage = "YOU LOSE!"
				@goalMessage = ""
				@buttonMessage = "Start Over"
			end
		end

		#get two new numbers for next run
		@diceOne = diceNum.sample()
		@diceTwo = diceNum.sample()	

		#sets up first run from instructions screen
		if @bStart
			@state = "new"
			@goal = @diceOne + @diceTwo
		end

		render "dice"	#this points to the dice.html.erb 
	end
end

