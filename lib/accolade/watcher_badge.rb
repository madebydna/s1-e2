class WatcherBadge < Accolade::Base
  
  def initialize(name)
    @name = name
  end
  
  #example of a dynamic badge that can be revoked if a user's status changes. 
  badge_name "top 10% of the most watched", 
    {:requirement => Proc.new {|user| user.watcher_percentile <= 10 } }
    
  # this time past achivements do not need to be checked
  # but badge could be revoked at any time
  def self.merit(user)
    only_badge = badge_names.first
    if only_badge[:requirement].call(user)
      user.award(self.new(only_badge[:name])) unless has_badge?(user)
    else
      user.badges.delete_if {|b| b.is_a?(self)}
    end
  end
  
  def self.has_badge?(user)
    !user.badges.select {|b| b.is_a?(self)}.empty?
  end
  
end