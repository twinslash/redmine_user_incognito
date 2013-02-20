module RedmineVersionsHelperIncognitoPatch
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      alias_method_chain :status_by_options_for_select, :incognito
    end
  end

  module InstanceMethods
    def status_by_options_for_select_with_incognito(value)
      if User.current.allowed_to?(:no_show_names, Version.find(params[:id]).project) && !User.current.admin?
        options_for_select(VersionsHelper::STATUS_BY_CRITERIAS.reject{|s| s == 'author' || s == 'assigned_to'}.collect {|criteria| [l("field_#{criteria}".to_sym), criteria]}, value)
      else
        status_by_options_for_select_without_incognito(value)
      end
    end
  end
end
