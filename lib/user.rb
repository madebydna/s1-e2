class User
  
  attr_reader :badges
  
  # Avoiding db setup, so setting user state through initialize method
  
  def initialize(badges = [], actions={})
    if badges.is_a?(Hash)
      actions = badges
      badges = []
    end
    @badges = badges
    @actions = actions
    @awarder = Accolade::Awarder.new
  end
  
  def commits_count
    @actions[:commits_count]
  end
  
  def forks_count
    @actions[:forks_count]
  end
  
  def watcher_percentile
    @actions[:watcher_percentile]
  end
  
  
  # TRIGGER EVENTS 
  
  def change_watcher_percentile(by, better = true)
    # method to mimic user's watch status moving up or down
    if better
      @actions[:watcher_percentile] =  watcher_percentile - by
    else
      @actions[:watcher_percentile] =  watcher_percentile + by
    end
    @awarder.handle(self, :watcher)
  end
  
  def add_commit
    @actions[:commits_count] = commits_count + 1
    @awarder.handle(self, :commit)
  end
  
  def add_fork
    @actions[:forks_count] = forks_count + 1
    @awarder.handle(self, :fork)
  end
  
  # AWARD STUFF
  
  def award(badge)
    @badges << badge
  end
  
end