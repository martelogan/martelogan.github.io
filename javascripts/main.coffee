$(document).ready ->
	$(document).on "go", ->
		$('.footer ul').fadeIn "slow", ->
			$('.logo').fadeIn "slow", ->
				$('.nav').fadeIn "slow", ->
					$(document).trigger('done')

	$(".cmd").on  'click', ->
		input = $('input#command').last()
		e = $.Event('keyup')
		e.which = 13
		input.val($(this).text()).focus().trigger(e)

	$(document.body).click ->
		input = $('input#command').last()
		input.focus()

	about = $('#about')
	projects = $('#projects')
	skills = $('#skills')
	contact = $('#contact')

	$(document).on 'about', ->
		return if about.hasClass('active')
		if skills.hasClass('active')
			skills.fadeOut('fast').removeClass('active')
			setTimeout (-> about.fadeIn().addClass('active')), 200
		else 
			about.fadeIn().addClass('active')
	$(document).on 'skills', ->
		return if skills.hasClass('active')
		if about.hasClass('active')
			about.fadeOut('fast').removeClass('active')
			setTimeout (-> skills.fadeIn().addClass('active')), 200
		else 
			skills.fadeIn().addClass('active')

	$(document).on 'projects', ->
		return if projects.hasClass('active')
		if contact.hasClass('active')
			contact.fadeOut('fast').removeClass('active')
			setTimeout (-> projects.fadeIn().addClass('active')), 200
		else 
			projects.fadeIn().addClass('active')

	$(document).on 'contact', ->
		return if contact.hasClass('active')
		if projects.hasClass('active')
			projects.fadeOut('fast').removeClass('active')
			setTimeout (-> contact.fadeIn().addClass('active')), 200
		else 
			contact.fadeIn().addClass('active')