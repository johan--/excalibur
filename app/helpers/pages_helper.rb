module PagesHelper

  def welcome_popover_text
  	"Buat profil dan unggah berbagai berkas untuk meningkatkan kredibilitas 
  	bisnis kamu sebelum mengajukan pembiayaan. 
  	Ini juga akan memperbesar kemungkinan mendapatkan pembiayaan."
  end
  
  def credibility_popover_text
  	"Indicates whether or not this product get other prep before shipment"
  end

  def subscriber_slot(current_count)
    50 - current_count - 5
  end

  
end