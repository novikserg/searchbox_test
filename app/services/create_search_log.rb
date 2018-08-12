class CreateSearchLog
  attr_accessor :query, :parent_logs

  def self.call(*args)
    new(*args).call
  end

  def initialize(query)
    @query = query
  end

  def call
    self.parent_logs = SearchLog.parent_logs(query)
    if no_parents?
      SearchLog.child_logs(query).destroy_all
      SearchLog.create(query: query)
    elsif one_parent?
      parent_log = parent_logs.first
      parent_log.increment! if parent_log.exact_match?(query)
    end
  end

  private

  def no_parents?
    parent_logs.empty?
  end

  def one_parent?
    parent_logs.count == 1
  end
end

