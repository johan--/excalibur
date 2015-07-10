class Biz::RostersController < Biz::BaseController

  def index
  	@tenders = Tender.all
  end

end