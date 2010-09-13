class Awarder
  
  def self.handle(user, action)
    klass = pick_badge_type(action)
    klass.merit(user)
  end
  
  def self.pick_badge_type(action)
    const_get("#{action.to_s.capitalize}Badge")
  end
  
end