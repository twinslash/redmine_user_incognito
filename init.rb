require 'redmine_user_incognito'

Redmine::Plugin.register :redmine_user_incognito do
  name 'Redmine User Incognito plugin'
  author 'Twinslash'
  description 'Permission, which replace employes names with roles'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'twinslash.com'

  permission :no_show_names, :show_names => :disable
end
