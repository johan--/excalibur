class SoftRequest
  include ActiveModel::Model
  
  attr_accessor :occupation, :income, :price, :capital, :tangible,
  				:target_address, :email, :full_name

  validates :email, presence: true
  validates :full_name, presence: true
  validates :tangible, presence: true
  validates :target_address, presence: true
  validates :occupation, presence: true
  # validates :income, presence: true, numericality: { only_integer: true }
  validates :price, presence: true, numericality: { only_integer: true }
  validates :capital, presence: true, numericality: { only_integer: true }


  def initialize(attributes={})
    super
  	@income = income.to_i
  	@price = price.to_i 
  	@maturity = maturity.to_i
  	@contribution = capital.to_i
  end

  def self.build_from(name, email, occupation, tangible, address, price, capital)
    new \
      full_name: name, email: email, 
      occupation: occupation, tangible: tangible, 
      target_address: address, price: price, 
      capital: capital
  end

  def message
  	"Saya bekerja sebagai #{occupation} dengan penghasilan 
  	bulanan sebesar #{income}. Ingin membeli #{tangible} yang terletak di
  	#{target_address} seharga #{price}. Saya memiliki modal sebesar 
  	#{capital}. Mohon bantuannya, terima kasih."
  end

end