class AdjustNullConditionsOnTender < ActiveRecord::Migration
  def self.up
  	change_column_null(:tenders, :category, true)
  	change_column_null(:tenders, :aqad, true)
  	change_column_null(:tenders, :annum, true)
  	change_column_null(:tenders, :volume, true)
  	change_column_null(:tenders, :details, true)
  end

  def self.down
  	change_column_null(:tenders, :category, false)
  	change_column_null(:tenders, :aqad, false)
  	change_column_null(:tenders, :annum, false)
  	change_column_null(:tenders, :volume, false)
  	change_column_null(:tenders, :details, false)  	
  end  
end
