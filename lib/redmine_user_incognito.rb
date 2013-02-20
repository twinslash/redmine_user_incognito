require 'patches/redmine_application_helper_incognito_patch'
require 'patches/redmine_issues_helper_incognito_patch'
require 'patches/redmine_query_incognito_patch'
require 'patches/redmine_queries_helper_incognito_patch'
require 'patches/redmine_attachments_helper_incognito_patch'
require 'patches/redmine_user_incognito_patch'
require 'patches/redmine_reports_controller_incognito_patch'
require 'patches/redmine_versions_helper_incognito_patch'

Rails.configuration.to_prepare do
  ApplicationHelper.send(:include, RedmineApplicationHelperIncognitoPatch)
  IssuesHelper.send(:include, RedmineIssuesHelperIncognitoPatch)
  Query.send(:include, RedmineQueryIncognitoPatch)
  QueriesHelper.send(:include, RedmineQueriesHelperIncognitoPatch)
  AttachmentsHelper.send(:include, RedmineAttachmentsHelperIncognitoPatch)
  User.send(:include, RedmineUserIncognitoPatch)
  ReportsController.send(:include, RedmineReportsControllerIncognitoPatch)
  VersionsHelper.send(:include, RedmineVersionsHelperIncognitoPatch)
end
