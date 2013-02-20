module RedmineUserIncognitoPatch
  def self.included(base)
    base.class_eval do

    def name=(value)
      @name = value
    end

    end
  end
end
