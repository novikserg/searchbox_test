class SearchLog < ApplicationRecord
  before_save :set_defaults

  scope :parent_logs, ->(query) { where("query ilike ?", "#{query}%") }
  scope :child_logs,  ->(query) { where("? like query || '%'", query) }

  def increment!
    update!(hits: hits + 1)
  end

  def exact_match?(query)
    self.query == query
  end

  private

  def set_defaults
    self.hits ||= 1
  end
end
