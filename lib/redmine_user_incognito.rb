require 'patches/redmine_user_incognito_patch'

Rails.configuration.to_prepare do
  ApplicationHelper.send(:include, RedmineUserIncognitoPatch)
end
