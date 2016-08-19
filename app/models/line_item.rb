class LineItem < ActiveRecord::Base
  include Payday::LineItemable
  include ActionView::Helpers::NumberHelper

  belongs_to :invoice

  validates_presence_of :quantity, :price

  def initialize(attrs = {})
    attrs[:quantity] = 1
    super
  end

  def display_price
    number_to_currency read_attribute(:price), unit: "#{Payday::Config.default.currency.upcase} "
  end

  def display_quantity
    nil
  end
end
