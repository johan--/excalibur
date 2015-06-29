json.cache! ['v1', @installment], expires_in: 3.days do  
	json.id @installment.id
	json.name @installment.name
	json.pay_code @installment.pay_code
	json.pay_time @installment.pay_time
	json.user_id @installment.user_id
	json.reservation_id @installment.reservation_id
end  