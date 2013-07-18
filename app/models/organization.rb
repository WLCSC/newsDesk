class Organization < ActiveRecord::Base
    has_many :assignments
    has_many :posts

    def users
        collection = [] 
        self.assignments.each do |a|
            collection += a.users
        end
        collection
    end
end
