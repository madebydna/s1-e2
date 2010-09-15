module Accolade
  class Base
  
    attr_reader :name, :level
    class << self
    
      def badge_names
        @badge_names ||= []
      end
    
      def badge_name(name, options)
        badge_names << {:name => name, :requirement => options[:requirement], :level => options[:level]}
      end
  
    end 
  end
end