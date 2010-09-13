require File.expand_path(File.join(File.dirname(__FILE__), 'test_helper')) unless defined?(Accolade)
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'fork_badge'))


class CumulativeIniniteTest < Test::Unit::TestCase 
  # Badge is being given for every 10th fork. A user can theoretically earn an infinite number of badges.
  
  setup do
    @f1 = ForkBadge.new("super forker")
    @f2 = ForkBadge.new("great forker")
  end
  
  context "user without a badge" do
  
    test "should get no badge without meeting requirements for the first" do
      @user = User.new(:forks_count => 2)
      @user.add_fork
      assert ForkBadge.number_of_badges(@user) == 0
    end
    
    test "should get first badge once the threshold has been crossed for the first time" do
      @user = User.new(:forks_count => 9)
      @user.add_fork
      assert ForkBadge.number_of_badges(@user) == 1
    end
    
  end
  
  context "user with existing badges" do
    test "should get no badge until the requirement for the next badge is met" do 
      @user = User.new([@f1], :forks_count => 12)
      @user.add_fork
      assert ForkBadge.number_of_badges(@user) == 1
    end
    
    test "should get subsequent badge if he crosses threshold again" do
      @user = User.new([@f1], :forks_count => 19)
      @user.add_fork
      assert ForkBadge.number_of_badges(@user) == 2
    end
    
  end
  
  
end
