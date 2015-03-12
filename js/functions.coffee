
randomFrame = 24 #How fast to move the bar in frames. Initialized

tempScore = 0 # Init score

addScore = (number)->
	if number > 0
		tempScore = tempScore + number

updateScore = ->
	if tempScore > 0
		tempScore = tempScore -1
		score = score + 1
		$score.html "<i class='fa fa-money'></i> #{score}"

setInterval updateScore, 30 #add score to current score

playing = false # Is the game playing? Stop everything if not

# Actually run the game!
playGame = ->
	playing = true
	randomFrame = pickRandomFrame frameRange[1]

	$ "message2"
	.text "The answer is: #{randomFrame}"

	moveBar() #animate the bar

# Stop the game
pauseGame = ->
	playing = false
	stopBar()

# Direction for the bar to travel. Flip - flops
barLeftDirection = false

moveBar = ->
	if playing
		soundclick.play()
		if barLeftDirection #move bar right
			barLeftDirection = false
			$ "#bar"
			.animate {width: "100%"}, calculateFrames(randomFrame, fps), "linear", moveBar
		else
			barLeftDirection = true
			$ "#bar"
			.animate {width: "0%"  }, calculateFrames(randomFrame, fps), "linear", moveBar

stopBar = ->
	$ "#bar"
	.stop true, true

addMessage = (classtitle, message)->
	maxUp = 5 #max messages shown
	$ "#messageHolder"
	.prepend "<li class='span6 message #{classtitle}'><p>#{message}</p></li>"
	messageBox = $ "#messageHolder li"
	messageBox.first().hide().fadeIn "slow"
	listNum = messageBox.length
	if listNum > maxUp #too many messages, trim it back
		messageBox.last().fadeOut "slow", ()-> `$(this).remove();`

calculateFrames = (frame, framesPerSecond)->
	singleFrame = 1000 / framesPerSecond
	frame * singleFrame

pickRandomFrame = (range)->
	Math.floor( Math.random() * (range[1] - range[0] + 1)) + range[0]

checkAnswer = (answer, number)-> #check the answer
	numInt = parseInt answer # convert text to number
	if numInt is not numInt
		false
	else
		numInt = number - numInt

gup = (name)-> # method fo getting $_GET params through javascript. Thanks to http://www.netlobo.com/url_query_string_javascript.html
	name = name.replace /[\[]/, "\\\["
		.replace /[\]]/, "\\\]"

	regexS = "[\\?&]#{name}=([^&#]*)"
	regex = new RegExp regexS
	results = regex.exec window.location.href

	if results
		return results[1]
		