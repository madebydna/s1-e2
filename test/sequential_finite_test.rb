require File.expand_path(File.join(File.dirname(__FILE__), 'test_helper')) unless defined?(Accolade)


class SequentialFiniteTest < Test::Unit::TestCase
  
  setup do
    @bronze_badge = CommitBadge.new("bronze", 1)
    @silver_badge = CommitBadge.new("silver", 2)
    @gold_badge = CommitBadge.new("gold", 3)
  end
  
  context "user with no badge" do
      test "should receive the lowest badge if she meets the requirements" do
        @user = User.new(:commits_count => 0)
        @user.add_commit
        latest_badge = @user.badges.pop
        assert latest_badge.name == CommitBadge.lowest_badge[:name]
      end
      
      # this also handles the case where we don't have info about the user's existing badges
      # which means that the system needs to check most efficiently which badges the user has earned based on raw stats 
      test "should receive all eligible awards if legacy user" do
        @user = User.new(:commits_count => 100)
        @user.add_commit
        assert @user.badges.length == 3
        assert_kind_of CommitBadge, @user.badges.first
      end
  end
  
  context "user who already has a badge" do
    
    test "should get the next highest badge available" do
      @user = User.new([@bronze_badge], :commits_count => 19)
      @user.add_commit  
      assert CommitBadge.badge_status(@user) == CommitBadge.next_badge(@bronze_badge.level)[:level]
    end
    
    test "should get no badge if user already has the highest achivable badge" do
       @user = User.new([@bronze_badge, @silver_badge, @gold_badge], :commits_count => 55)
       @user.add_commit
       assert @user.badges.length == 3
    end
    
    test "should not get the same award twice, even though conditions are - by definition - met" do
      @user = User.new([@bronze_badge, @silver_badge], :commits_count => 30)
      @user.add_commit
      assert @user.badges.length == 2
    end
    
    test "should not be asked for requirements for a lower badge if alredy has a badge" do
      # can't figure out how to test for this since logic for the requirement is in a Proc
    end
     
  end
  
end