class Note < ApplicationRecord
  validates :title, presence: true

  def self.search_by_title_or_content(query)
    sanitized_query = ActiveRecord::Base.sanitize_sql_like(query) # to avoid SQL injection
    where("title LIKE ? OR content LIKE ?", "%#{sanitized_query}%", "%#{sanitized_query}%")
  end
end
