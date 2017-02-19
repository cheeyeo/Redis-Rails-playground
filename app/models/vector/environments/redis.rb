module Vector
  module Environments
    class Redis < Vector::Environment
      def initialize
        puts "INSIDE HERE!!!"
      end

      def has_redis
        true
      end
    end
  end
end
