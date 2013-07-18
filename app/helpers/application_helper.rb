module ApplicationHelper
	def current_user  
		if session[:user_id]
			current_user ||= User.find(session[:user_id])
		else
			current_user = nil
			nil
		end
	end

	def time_delta time
		if time < Time.now
			distance_of_time_in_words_to_now(time) + " ago"
		else
			distance_of_time_in_words_to_now(time) + " from now"
		end
	end

	def markdown(text)
		sanitize(BlueCloth::new(text).to_html)
	end

	def nice_date d
		d.strftime("%A, %B %d, %Y")
  end

  def nice_datetime d
		d.strftime("%I:%M %p, %B %d, %Y")
  end

end
