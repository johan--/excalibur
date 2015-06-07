module BizHelper


	def current_dp(firm)
		firm.settings(:down_payment).percentage
	end

	def current_dp_deadline(firm)
		firm.settings(:down_payment).deadline
	end

	def current_dp_pref(firm)
		if firm.settings(:down_payment).state == "off"
			auto_options[0]
		else
			auto_options[1]
		end
	end

	def current_auto_confirmation_pref(firm)
		firm.settings(:auto_confirmation).state
	end

	def dp_percentages
		[ 0.25, 0.50, 0.75 ]
	end

	def dp_deadlines
		[ "off", 1, 2, 3, 4, 5 ]
	end

	def auto_confirm_options
		# [ "off", 1, 2, 3, 4, 5 ]
		[ ["off", 0], ["1 Jam Sebelum Main", 1], ["2 Jam Sebelum Main", 2],
		  ["3 Jam Sebelum Main", 3], ["4 Jam Sebelum Main", 4], 
		  ["5 Jam Sebelum Main", 5] ]
	end


	def current_auto_promo_pref(firm)
		if firm.settings(:auto_promo).state == "off"
			auto_options[0]
		else
			auto_options[1]
		end
	end

	def auto_options
		['off', 'on']
	end

end
