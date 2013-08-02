require "bcrypt"
class User < ActiveRecord::Base
    include BootstrapHelper
	validates :username, :presence => true
	validates :password, :confirmation => true
	attr_accessor :password
	before_save :encrypt_password

    has_many :memberships
    has_many :groups, :through => :memberships
    has_many :posts

	def encrypt_password
		if password
			self.password_salt = BCrypt::Engine.generate_salt
			self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
		end
	end

	def admin?
		self.administrator
	end

	def belongs_to? group
		group.users.include? self
	end

	def display
        if admin?
            i('cog')
        elsif supervisor
            i('group')
        else
            ''
        end + " " +	self.name
	end

    def internal
        self.password_hash != nil
    end

    def organizations
        (Assignment.where(:user_id => self.id) + Assignment.where(:group_id => self.group_ids)).map{|a| a.organization}.uniq
    end
end
