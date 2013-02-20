module RedmineReportsControllerIncognitoPatch
  def self.included(base)
    base.class_eval do

      before_filter :redirect_for_incognito

      private

      def redirect_for_incognito
        if User.current.allowed_to?(:no_show_names, Project.find(params[:id])) && !User.current.admin?
          redirect_to @project
        end
      end
    end
  end
end
