module RedmineQueryIncognitoPatch
  def self.included(base)
    base.class_eval do

      def available_filters=(value)
        @available_filters = value
      end

    end
  end
end
