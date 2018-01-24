class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details, dependent: :destroy
  accepts_nested_attributes_for :order_details
  before_save :default_values
  after_update :send_receipt_email

  WAIT = 0
  ACCEPTED = 1
  SHIPPING = 2
  RECEIVED = 4

  def default_values
    self.status ||= WAIT
  end

  def wait?
  	self.status == WAIT
  end

  def accepted?
  	self.status == ACCEPTED
  end

  def shipping?
  	self.status == SHIPPING
  end

  def received?
  	self.status == RECEIVED
  end

  def isstatus
    if self.status == WAIT
      return (I18n.t "users.show.comfirm")
    elsif self.status == ACCEPTED
      return (I18n.t "users.show.accepted")
    elsif self.status == SHIPPING
      return (I18n.t "users.show.shipping")
    elsif self.status == RECEIVED
      return (I18n.t "users.show.received")
    end
  end

  def send_receipt_email
    @user = User.find_by_email(self.user.email)
    @order = self

    time = Time.now.to_i
    joinMd5 = "#{@user.email}-#{time.to_s}-#{ENV['SECRET_CODE_CREATE_ORDER_FROM_EMAIL']}"
    token_key = Digest::MD5.hexdigest joinMd5
    token_key = token_key.upcase

    if @order.status == 'Complete' && @user.present?
      SendEmailOrderJob.perform_now(@user, @order, token_key, time)
    end
  end
end
