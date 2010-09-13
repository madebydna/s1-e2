require File.expand_path(File.join(File.dirname(__FILE__), 'test_helper')) unless defined?(Accolade)
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'watcher_badge'))


class DynamicBadgeTest < Test::Unit::TestCase
  
  test "user with repo among the top 10% of most watched should get badge" do
    @user = User.new(:watcher_percentile => 11)
    @user.change_watcher_percentile(2)
    new_badge = @user.badges.pop
    assert new_badge.class == WatcherBadge
  end
  
  test "user who already has a badge can lose it" do
    @badge = WatcherBadge.new("top 10% of most watched repos")
    @user = User.new([@badge], :watcher_percentile => 8)
    @user.change_watcher_percentile(3, false)
    assert @user.badges.empty?
  end
  
  test "user can't get the badge twice" do
    @badge = WatcherBadge.new("top 10% of most watched repos")
    @user = User.new([@badge], :watcher_percentile => 8)
    @user.change_watcher_percentile(1)
    assert @user.badges.length == 1
  end
  
end