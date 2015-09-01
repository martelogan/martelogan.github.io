# © 2015 Logan Martel
# Extensible class for terminal emulator in web application
class Terminal
	constructor:\
	(	@target=".shell .text" 
	,	@PS1="$ " 
	,	@welcome="./hello_friend"
	,	@guide="Run 'help' for basic commands"
	,	@commands= ["about", "projects", "skills", "resume", "interests", "clear","ls", "help"]
	,	@broadcasts= ["about", "projects", "skills", "resume"]
	,	@secrets = ["gandalf"]
	) ->
		instance = @
		history = []
		index = history.length

		# build basic broadcasting commands
		(instance[command] = -> instance["broadcast"](command)) for command in @broadcasts
		
		# enable ctrl + l to clear terminalinte
		$(document).keydown (e) ->
			if e.which == 76 && e.ctrlKey
				e.preventDefault()
				instance.clear()
				instance.newline()

		# up and down to traverse history
		$(document).keydown (e) ->
			code = e.which
			if code == 38 || code == 40
				e.preventDefault()
				input = $('input#command').last()
				index-- if code == 38 and index - 1 >= 0
				index++ if code == 40 and index + 1 <= history.length
				if 0 <= index < history.length
					input.val(history[index])
				else
					input.val('')

		# tab completion
		$(document).keydown (e) ->
			if e.which == 9
				e.preventDefault()
				input = $('input#command').last()
				str = input.val()
				options = instance.commands.concat(instance.secrets)
				results = []
				for command in options
					if command.substr(0, str.length) is str
						results.push(command)
				
				return if results.length is 0
				
				else if results.length is 1
					return input.val(results[0])

				instance.print("<br>")
				for option in results
					instance.print ("#{option}<br>")
					instance.newline


		# process command on enter
		$(document.body).on 'keyup', 'input#command', (e) ->
			if e.which == 13
				$(@).blur()
				$(@).prop 'readonly', true
				command = $(@).val()
				command = command.toLowerCase()
				instance.print("<br>")
				# try calling command
				try
					if command in ["init","newline"]
						throw "no h4x0rs allowed!"
					if command.substr(0,2) == "cd"
						console.log instance["cd"]() 
					else instance["#{command}"]()
					history.push(command)
					index = history.length
				catch e
					console.log(e)
					instance.print("command unavailable")
				finally
					setTimeout (-> instance.newline()), 200

	command_line = '<input type="text" id="command" value="" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false">'

	init: ->
		@greet(@welcome, 0, 100)

	print: (element) ->
		$target = $(@target)
		$target.append(element)
	
	newline: ->
		@print("<br> #{@PS1}")
		@print(command_line)
		$("input#command").last().focus()

	greet: (message, index, interval) ->
		if index < message.length
			@print(message[index++])
			setTimeout (=> @greet(message, index, interval)), interval
		else
			@broadcast("go")
			$(document).on "done", =>
				@print("<br> #{@guide}")
				@newline()
	
	help: ->
		@print ("#{command}<br>") for command in @commands when command isnt "help"

	broadcast: (event) ->
		$(document).trigger(event)

	clear: ->
		$(@target).empty()

	interests: ->
		@print("Hey, I'm looking for projects in:<br>")
		@print("data science (esp. data mining)<br>")
		@print("back-end (mobile or web)<br>")
		@print("biotech (esp. bioinformatics)<br>")
		@print("Shoot me an email if you want to work together!")

	ls: ->
		@print("Hey, secret commands will be updated here as they are added:<br>")
		@print ("1. #{command}<br>") for command in @secrets

	cd: ->
		@print("I'm sorry Dave but I can't let you do that...")

	gandalf: ->
		window.open("https://youtu.be/Sagg08DrO5U")

terminal = new Terminal()
terminal.init()