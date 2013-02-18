module RedmineQueriesHelperIncognitoPatch
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      alias_method_chain :retrieve_query, :incognito
    end
  end

  module InstanceMethods

    def retrieve_query_with_incognito
      retrieve_query_without_incognito
      if params[:controller] == 'issues'
        project = params[:project_id] ? Project.find(params[:project_id]) : Issue.find(params[:id]).project
      elsif params[:controller] == 'projects'
        project = Project.find(params[:id])
      end

      if User.current.allowed_to?(:no_show_names, project) && !User.current.admin?
        af = @query.available_filters
        %w(author_id assigned_to_id assigned_to_role watcher_id member_of_group).each do |filter|
          af.delete(filter)
          @query.available_filters = af
        end
      else
        retrieve_query_without_incognito
      end
    end

  end
end
