class DashboardController < ApplicationController
  def index
    @search_logs = SearchLog.all
  end

  def search
    CreateSearchLog.call(params[:query])
    redirect_to root_path, notice: "Search completed"
  end

  def purge
    SearchLog.destroy_all
    redirect_to root_path, notice: "Analytics are purged"
  end
end
