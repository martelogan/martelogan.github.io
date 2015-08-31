$(document).ready ->
	$(document).on "go", ->
		$('.footer ul').fadeIn 260, ->
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


	$('a#kitimat').on 'mouseenter', ->
		$('iframe#kitimat').show()
		$('.shell .text').hide()
	$('a#kitimat').on 'mouseleave', ->
		$('iframe#kitimat').hide()
		$('.shell .text').show()
	$('a#montreal').on 'mouseenter', ->
		$('iframe#montreal').show()
		$('.shell .text').hide()
	$('a#montreal').on 'mouseleave', ->
		$('iframe#montreal').hide()
		$('.shell .text').show()


	about = $('#about')
	projects = $('#projects')
	skills = $('#skills')
	resume = $('#resume')

	$(document).on 'about', ->
		$('.alternate').hide()
		return if about.hasClass('active')
		if skills.hasClass('active')
			skills.fadeOut('fast').removeClass('active')
			setTimeout (-> about.fadeIn().addClass('active')), 200
		else 
			about.fadeIn().addClass('active')
	$(document).on 'skills', ->
		$('.alternate').hide()
		return if skills.hasClass('active')
		if about.hasClass('active')
			about.fadeOut('fast').removeClass('active')
			setTimeout (-> skills.fadeIn().addClass('active')), 200
		else 
			skills.fadeIn().addClass('active')

	$(document).on 'projects', ->
		$('.alternate').hide()
		return if projects.hasClass('active')
		if resume.hasClass('active')
			resume.fadeOut('fast').removeClass('active')
			setTimeout (-> projects.fadeIn().addClass('active')), 200
		else 
			projects.fadeIn().addClass('active')

	$(document).on 'resume', ->
		$('.alternate').hide()
		return if resume.hasClass('active')
		if projects.hasClass('active')
			projects.fadeOut('fast').removeClass('active')
			setTimeout (-> resume.fadeIn().addClass('active')), 200
		else 
			resume.fadeIn().addClass('active')