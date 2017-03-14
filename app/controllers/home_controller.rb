class HomeController < ApplicationController
  def index
    @fetched_data = DataConsistencyCheck.render_inconsistent_data
  end

  def dashboard
    @fetched_data = DataConsistencyCheck.render_inconsistent_data
    render :layout => false
  end

end
