require 'patches/redmine_user_incognito_patch'
require 'patches/redmine_issues_helper_incognito_patch'
require 'patches/redmine_query_incognito_patch'
require 'patches/redmine_queries_helper_incognito_patch'
require 'patches/redmine_attachments_helper_incognito_patch'

Rails.configuration.to_prepare do
  ApplicationHelper.send(:include, RedmineUserIncognitoPatch)
  IssuesHelper.send(:include, RedmineIssuesHelperIncognitoPatch)
  Query.send(:include, RedmineQueryIncognitoPatch)
  QueriesHelper.send(:include, RedmineQueriesHelperIncognitoPatch)
  AttachmentsHelper.send(:include, RedmineAttachmentsHelperIncognitoPatch)


end
