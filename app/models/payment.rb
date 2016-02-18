class Payment < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :sender, polymorphic: true

  protokoll :ticker, :pattern => "PAY%y####"
  monetize :amount_sens

  before_create :set_to_pending
  after_save :touch_invoice, if: ->(obj){ obj.state_changed? }
  validate :amount_checking

  scope :verified, -> { where(state: '2') }
  scope :rejected, -> { where(state: '0') }


  def confirm_payment!
  	update(state: '2') unless self.state == '2'
  end
  def flag_payment!
  	update(state: '0') unless self.state == '0'
  end

private
  def set_to_pending
  	self.state = '1' unless self.state.present?
  end

  def touch_invoice
  	self.invoice.touch
  end
  def amount_checking
    if amount > self.invoice.amount
      errors.add(:amount, "error soal jumlah")
    end
  end
end