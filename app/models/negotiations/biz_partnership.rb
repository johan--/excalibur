class BizPartnership < Tender

  typed_store :details, coder: DumbCoder do |s|
    s.string  :intent_type
    s.string  :intent_assets, array: true, default: []
  end

end