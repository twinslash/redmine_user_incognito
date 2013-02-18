module RedmineAttachmentsHelperIncognitoPatch
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      alias_method_chain :link_to_attachments, :incognito
    end
  end

  module InstanceMethods
    def link_to_attachments_with_incognito(container, options = {})
      options.assert_valid_keys(:author, :thumbnails)

      project = params[:project_id] ? Project.find(params[:project_id]) : Issue.find(params[:id]).project if params[:controller] == 'issues'
      if container.attachments.any? && User.current.allowed_to?(:no_show_names, project) && !User.current.admin?
        options = {:deletable => container.attachments_deletable?, :author => false}.merge(options)
        render :partial => 'attachments/links',
          :locals => {:attachments => container.attachments, :options => options, :thumbnails => (options[:thumbnails] && Setting.thumbnails_enabled?)}
      else
        link_to_attachments_without_incognito(container, options)
      end
    end
  end
end
