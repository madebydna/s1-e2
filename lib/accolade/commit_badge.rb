class CommitBadge < Accolade::Base
  
  def initialize(name, level)
    @name = name
    @level = level
  end
  
  # example of a "sequential finite" sort of award, i.e. there are a set number of badges
  # and each marks a point of sequential achievement
  
  badge_name "bronze", {:requirement => Proc.new {|user| user.commits_count >= 1 }, :level => 1}
  badge_name "silver", {:requirement => Proc.new {|user| user.commits_count >= 20 }, :level => 2}
  badge_name "gold", {:requirement => Proc.new { |user| user.commits_count >= 50 }, :level => 3}
  
  
  class << self
    def merit(user)  
      current_highest = badge_status(user)
      if current_highest > 0 
        if nb = next_badge(current_highest)
          user.award(self.new(nb[:name], nb[:level])) if nb[:requirement].call(user)
        end
      else 
        # handle legacy user or case when the user's previous badges are unknown
        # seems best to start with the check for the highest achievable level and if the requirement is met,
        # then just award all dependent levels without having to check each in turn
        badges_reversed_by_level.each do |b|
          if b[:requirement].call(user)
            award_badge_and_dependents(b, user)
            break
          end
        end
      end
    end
    
    def award_badge_and_dependents(badge, user)
      user.award(self.new(badge[:name], badge[:level]))
      level = badge[:level]
      while !previous_badge(level).nil?
        award = previous_badge(level)
        user.award(self.new(award[:name], award[:level]))
        level -= 1
      end
    end
    
    def badges_reversed_by_level
      badge_names.sort_by {|b| b[:level]}.reverse
    end
  
    # returns the currently highest held level of this type of badge for the user
    def badge_status(user)
      if user.badges.select {|b| b.is_a?(self)}.empty?
        0
      else
        current = user.badges.select {|b| b.is_a?(self)}
        current.map {|b| b.level }.max
      end
    end
      
    def highest_badge
      # select badge where the order "attribute" is the highest
      max = badge_names.map {|b| b[:level]}.max
      select_by_level(max)
    end
  
    def lowest_badge
      # select badge where the order "attribute" is the lowest
      min = badge_names.map {|b| b[:level]}.min
      select_by_level(min)
    end
    
    #returns the next lowest badge given an order number
    def previous_badge(number)
      return nil if number == lowest_badge[:level]
      select_by_level(number - 1)
    end
  
    #returns the next highest badge given an order number
    def next_badge(number)
      return nil if number == highest_badge[:level]
      select_by_level(number + 1)
    end
    
    def select_by_level(level)
      badge_names.select {|b| b[:level] == level}.first
    end
    
end

end