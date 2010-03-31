module TinyPaper
  module AssetExtensions
    def self.included(base)
      base.class_eval do
        named_scope :by_title, lambda{ |search_term| {:conditions => ["LOWER(title) LIKE ?", "%#{search_term.to_s.downcase}%"]}}
      end
    end
  end  
end