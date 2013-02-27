require 'patches/redmine_issues_helper_incognito_patch'
require 'patches/redmine_query_incognito_patch'
require 'patches/redmine_queries_helper_incognito_patch'
require 'patches/redmine_attachments_helper_incognito_patch'
require 'patches/redmine_reports_controller_incognito_patch'
require 'patches/redmine_versions_helper_incognito_patch'
require 'patches/redmine_helper_patch'

Rails.configuration.to_prepare do
  ApplicationHelper.send(:include, RedmineHelperPatch)
  IssuesHelper.send(:include, RedmineIssuesHelperIncognitoPatch)
  Query.send(:include, RedmineQueryIncognitoPatch)
  QueriesHelper.send(:include, RedmineQueriesHelperIncognitoPatch)
  AttachmentsHelper.send(:include, RedmineAttachmentsHelperIncognitoPatch)
  ReportsController.send(:include, RedmineReportsControllerIncognitoPatch)
  VersionsHelper.send(:include, RedmineVersionsHelperIncognitoPatch)
end
