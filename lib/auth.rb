require 'simple_ldap_authenticator.rb'

SimpleLdapAuthenticator.servers = [APP_CONFIG[:ldap_domain_controller]]
SimpleLdapAuthenticator.logger = Rails.logger
SimpleLdapAuthenticator.use_ssl = true

def ldap_login user,pass
	if l = SimpleLdapAuthenticator.valid?(user,pass)
		l
	else
		false
	end
end

def ldap_populate user, pass, obj=nil
	if l = SimpleLdapAuthenticator.valid?(user,pass)[0]
		u = obj || User.new
		u.username = user
		u.name = l['givenname'][0].to_s + " " + l['sn'][0].to_s
		u.administrator = true if(l[:memberof].include? APP_CONFIG[:ldap_domain_administrator_ou])
		u.supervisor = true if(l[:memberof].include? APP_CONFIG[:ldap_domain_supervisor_ou])
		u.email_address ||= l['mail'][0]

		Group.all.each do |group|
			unless group.auth_attribute == "*"
				raise group.inspect unless group.auth_attribute
				if (l[group.auth_attribute.to_sym].include?(group.auth_value))
					unless group.users.include? u
						group.users << u 
					end
				else
						if group.users.include? u && (group.memberships.where(:user_id => u.id).count > 0 && !group.memberships.where(:user_id => u.id).first.internal)
							group.users.delete u
					end
				end
			end
		end


		u.save
		u
	else
		false
	end
end

def ldap_search user
	if l = SimpleLdapAuthenticator.search(user)
		l
	else
		nil
	end
end
