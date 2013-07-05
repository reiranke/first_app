module ApplicationHelper


	def title
	base_title ="RUBY SAMPLE APPLICATION"
		if @title.nil?
			base_title
		else
			"#{base_title} | #{@title}"
		end
	end
end
