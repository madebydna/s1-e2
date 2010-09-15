class ForkBadge < Accolade::Base
  
  def initialize(name)
    @name = name
  end
  
  # example of a "sequential infinite" sort of award, i.e. there is an award for every nth achievement, so 
  # the user accumulates a collection of badges. The quantity of this sort of badge is important.
  # in this case every badge is worth 10 forks
  
  badge_name "super forker", {:requirement => Proc.new {|user| user.forks_count >= (number_of_badges(user) * 10 + 10)} } 
  
  def self.number_of_badges(user)
    x = user.badges.select { |b| b.is_a?(self) }.length
  end 
  
  def self.merit(user)
    the_badge = badge_names.first
    if number_of_badges(user) > 0
      user.award(self.new(the_badge[:name])) if the_badge[:requirement].call(user)
    else
      # this is a bit of a hack to enable the system to award correctly if there is no info about previous awards
      # a hack because the exact requirements should be encapsulated in the badge's proc
      (user.forks_count/10).times do 
        user.award(self.new(the_badge[:name]))
      end
    end
  end

end
  
  
  