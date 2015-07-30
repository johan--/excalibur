class ConsumerFinancing < Tender

  typed_store :details, coder: DumbCoder do |s|
    s.string  :work_experience#, array: true, default: []
    s.string  :industry_experience#, array: true, default: []
  end	
  
end