Newsdesk
=========


How To
------
* bundle install
* edit/create config/database.yml, config/app_config.yml, config/initializers/mail.rb
* rake db:setup

This can use LDAP and/or a local set of users for authentication.  Users have to exist before they can log in, which means you need to manually create at least 1 user in your database before you can get in.

    Newsdesk is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Newsdesk is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Newsdesk.  If not, see <http://www.gnu.org/licenses/>.

