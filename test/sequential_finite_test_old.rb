require File.expand_path(File.join(File.dirname(__FILE__), 'test_helper')) unless defined?(Accolade)


class SequentialFiniteTest < Test::Unit::TestCase 
  
  setup do
    @bronze_badge = CommitBadge.new("bronze", 1)
    @silver_badge = CommitBadge.new("silver", 2)
    @gold_badge = CommitBadge.new("gold", 3)
  end
  

  test "should receive the lowest badge if she meets the requirements" do
    @user = User.new(:commits_count => 0)
    @user.add_commit
    latest_badge = @user.badges.pop
    assert latest_badge.name == CommitBadge.lowest_badge[:name]
  end

  
end
