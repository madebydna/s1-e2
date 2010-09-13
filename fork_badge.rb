class ForkBadge < Accolade
  
  def initialize(name)
    @name = name
  end
  
  # example of a "cumulative infinite" sort of award, i.e. there is an award for every nth achievement, so 
  # the user accumulates a collection of badges. The quantity of this sort of badge is important.
  # in this case every badge is worth 10 forks
  
  badge_name "super forker", {:requirement => Proc.new {|user| user.forks_count >= (number_of_badges(user) * 10 + 10)} } 
  
  def self.number_of_badges(user)
    x = user.badges.select { |b| b.is_a?(self) }.length
  end 
  
  def self.merit(user)
    only_badge = badge_names.first
    user.award(self.new(only_badge[:name])) if only_badge[:requirement].call(user)
  end
  
  
end
  
  
  