require_dependency 'application_helper'
module RedmineHelperPatch
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      alias_method_chain :link_to_user, :incognito
      alias_method_chain :other_formats_links, :incognito

      def define_project
        if params[:controller] == 'issues'
          params[:project_id] ? Project.find(params[:project_id]) : Issue.find(params[:id]).project
        elsif params[:controller] == 'projects'|| params[:controller] == 'activities' || params[:controller] == 'reports'
          Project.find(params[:id])||@project
        elsif params[:controller] == 'journals'
          Journal.find(params[:id]).issue.project
        end
      end

    end
  end

  module InstanceMethods

    def link_to_user_with_incognito(user, options={})
      if user == User.current || User.current.admin?
        link_to_user_without_incognito(user, options)
      elsif user.is_a?(Group)
        'Group'
      elsif user.is_a?(User)
        if User.current.allowed_to?(:no_show_names, define_project) && !User.current.admin?
          user.roles_for_project(define_project).collect{|role| "#{role.name}" }.join(' ')
        else
          link_to_user_without_incognito(user, options)
        end
      else
        ""
      end
    end

    def other_formats_links_with_incognito(&block)
      other_formats_links_without_incognito(&block) unless User.current.allowed_to?(:no_show_names, define_project) && !User.current.admin?
    end

  end
end
