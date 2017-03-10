class HomeController < ApplicationController
  def index
    @fetched_data = DataConsistencyCheck.render_inconsistent_data
  end
end
