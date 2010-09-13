class CommitBadge < Accolade
  
  def initialize(name, level)
    @name = name
    @level = level
  end
  
  # example of a "cumulative finite" sort of award, i.e. there are a set number of badges
  # and each marks a point of cumulative achievement
  
  badge_name "bronze", {:requirement => Proc.new {|user| user.commits_count >= 1 }, :level => 1}
  badge_name "silver", {:requirement => Proc.new {|user| user.commits_count >= 20 }, :level => 2}
  badge_name "gold", {:requirement => Proc.new { |user| user.commits_count >= 50 }, :level => 3}
  
  
  def self.merit(user)  
    current_highest = badge_status(user)
    if nb = next_badge(current_highest)
      user.award(self.new(nb[:name], nb[:level])) if nb[:requirement].call(user)
    end
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
    badge_names.select {|b| b[:level] == max}.first
  end
  
  def lowest_badge
    # select badge where the order "attribute" is the lowest
    min = badge_names.map {|b| b[:level]}.min
    badge_names.select {|b| b[:level] == min}.first
  end
  
  #returns the next highest badge given an order number
  def next_badge(number)
    return nil if number == highest_badge[:level]
    badge_names.select {|b| b[:level] == number + 1}.first
  end

end