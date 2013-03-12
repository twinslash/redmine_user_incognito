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
        if record.is_a?(User)
          link_to_user(record)
        elsif record.is_a?(Group)
          'Group'
        else
          find_name_by_reflection_without_incognito(field, id)
        end
      end
    end

  end
end
