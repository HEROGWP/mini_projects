
$(document).on('turbolinks:load', function() {
		if ($('select#topic_status').val()=="scheduled"){
			console.log($(this).val())
			$('#publish_time').css({'display':'block'})
		}

		$('select#topic_status').change(function(){
			 if ($(this).val()=="scheduled"){
			 		console.log($(this).val())
			 		$('#publish_time').css({'display':'block'})
			 } else{
			 		console.log($(this).val())
			 		$('#publish_time').css({'display':'none'})
			 }
		})
			
	})