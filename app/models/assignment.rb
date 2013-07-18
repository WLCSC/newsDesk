class Assignment < ActiveRecord::Base
    belongs_to :organization
    belongs_to :group
    belongs_to :user

    def users
        if self.user_id
            User.where(:id => self.user_id)
        elsif self.group_id
            self.group.users
        else
            User.none 
        end
    end

    attr_accessor :user_name, :group_name
    before_create :find_principal

    def find_principal
        if self.user_name != ""
            self.user = User.where(:name => self.user_name).first
            return true
        end
        if self.group_name != ""
            self.group = Group.where(:name => self.group_name).first
            return true
        end
        nil
    end

    def target
        if self.user_id
            self.user
        elsif self.group_id
            self.group
        else
            nil
        end
    end
end
