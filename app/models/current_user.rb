# Simple Wrapper Class for User Auth
class CurrentUser
  DELEGATES = %i|id first_name last_name email username|

  attr_reader :user
  def initialize(user=nil)
    @user = user
  end

  def logged_in?
    !!user
  end

  def admin?
    !!(user && user.admin)
  end

  def ==(other)
    if other.is_a?(self.class)
      user == other.user
    elsif other.is_a?(User)
      user == other
    else
      false
    end
  end

  DELEGATES.each do |m|
    define_method(m) { user.try(m) }
  end

  class << self
    def with_id(id)
      new User.find_by_id(id)
    end
  end
end
