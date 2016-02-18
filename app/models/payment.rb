class Payment < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :sender, polymorphic: true

  protokoll :ticker, :pattern => "PAY%y####"
  monetize :amount_sens

  after_save :touch_invoice
  validate :amount_checking

private

  def touch_invoice
  	self.invoice.touch
  end
  def amount_checking
    if amount > self.invoice.amount
      errors.add(:amount, "error soal jumlah")
    end
  end
end