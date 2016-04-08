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
    slot_left = 50 - current_count - 5 
    if slot_left == 0
      return "Slot Waiting List tersisa"
    else 
      return "#{slot_left} slot tersisa"
    end
  end
end