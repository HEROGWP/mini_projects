
$(document).on('turbolinks:load', function() {
		if ($('select#comment_status').val()=="scheduled"){
			console.log($(this).val())
			$('#publish_time').css({'display':'block'})
		}

		$('select#comment_status').change(function(){
			 if ($(this).val()=="scheduled"){
			 		console.log($(this).val())
			 		$('#publish_time').css({'display':'block'})
			 } else{
			 		console.log($(this).val())
			 		$('#publish_time').css({'display':'none'})
			 }
		})
			
	})