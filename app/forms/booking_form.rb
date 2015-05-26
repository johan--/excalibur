class BookingForm
  include Virtus.model
  include ActiveModel::Model
  #
  # attribute are the named scopes and their value are :
  # - either the value you pass a scope which takes arguments
  # - either a Siphon::Nil value to apply (or not) a scope which has no argument
  #
  attribute :duration, Decimal
  attribute :unpaid, Siphon::Nil
end