class Firm::BidsController < Firm::BaseController

  def index
  	@tenders = Tender.all
  end

end