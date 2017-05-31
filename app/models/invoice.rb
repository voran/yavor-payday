class Invoice < ActiveRecord::Base
  include Payday::Invoiceable

  has_many :line_items
  accepts_nested_attributes_for :line_items, allow_destroy: true

  validates_presence_of :due_at, :bill_to

  def initialize(attrs = {})
    attrs[:bill_to] ||= Rails.application.config.bill_to
    attrs[:due_at] ||= Date.today + 7.days
    super
  end

  def bill_to
    read_attribute(:bill_to)
  end

  def invoice_number
    "#{self.created_at.strftime('%y%m%d')}#{self.id.to_s.rjust(5, '0')}"
  end

  def tax_rate
    0
  end

  def shipping_rate
    0
  end

  def paid!
    update_attributes(paid_at: Time.now)
  end

  def refunded!
    update_attributes(refunded_at: Time.now)
  end
end
