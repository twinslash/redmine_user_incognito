module RedmineIssuesHelperIncognitoPatch
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      alias_method_chain :find_name_by_reflection, :incognito
    end
  end

  module InstanceMethods
    def find_name_by_reflection_with_incognito(field, id)
      association = Issue.reflect_on_association(field.to_sym)
      if association
        record = association.class_name.constantize.find_by_id(id)

        if record
          if field == 'assigned_to'
            if params[:controller] == 'issues'
              project = params[:project_id] ? Project.find(params[:project_id]) : Issue.find(params[:id]).project
            elsif params[:controller] == 'projects'
              project = Project.find(params[:id])
            end

            if User.current.allowed_to?(:no_show_names, project) && !User.current.admin? && params[:controller] ==  'issues'||params[:controller] == 'projects'
              return record.roles_for_project(project).collect{|role| "#{role.name}" }.join(' ')
            end
          end
          find_name_by_reflection_without_incognito(field, id)
        end

      end
    end

  end
end
