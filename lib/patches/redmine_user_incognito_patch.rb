module RedmineUserIncognitoPatch
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      alias_method_chain :link_to_user , :incognito

    end
  end

  module InstanceMethods
    def link_to_user_with_incognito(user, options={})

      if user == User.current || User.current.admin?
        link_to_user_without_incognito(user, options)

      elsif user.is_a?(Group)
        'is a Group'
      elsif user.is_a?(User)

        if params[:controller] == 'issues'
          project = params[:project_id] ? Project.find(params[:project_id]) : Issue.find(params[:id]).project
        elsif params[:controller] == 'projects'
          project = Project.find(params[:id])
        end

        if User.current.allowed_to?(:no_show_names, project)
          case params[:controller]
            when 'projects'
              user.roles_for_project(project).collect{|role| "#{role.name}" }.join(' ')
            when 'issues'
              user.roles_for_project(project).collect{|role| "#{role.name}" }.join(' ')
            else
             'left controller'
            end

        else
          ""
        end
      else
        "no USER no GROUP"
      end
    end
  end
end