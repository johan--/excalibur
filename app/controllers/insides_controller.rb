class InsidesController < ApplicationController
  

  def home
    @documents = current_user.documents
    @tenders = Tender.all

    respond_to do |format| 
      format.html
      format.js
    end
  end

  def choose
  end

end