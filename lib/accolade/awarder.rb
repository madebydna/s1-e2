module Accolade
  class Awarder
  
    def handle(user, action)
      klass = pick_badge_type(action)
      klass.merit(user)
    end
  
    def pick_badge_type(action)
      Awarder.const_get("#{action.to_s.capitalize}Badge")
    end
  
  end
end