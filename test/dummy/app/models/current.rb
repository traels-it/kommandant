class Current < ActiveSupport::CurrentAttributes
  attribute :user

  def admin?
    user.admin?
  end
end
