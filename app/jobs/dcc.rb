class Dcc
  include SuckerPunch::Job
  workers 1

  def perform()
    #SuckerPunch.logger.info "In----"
     
		DataConsistencyCheck.get_inconsistent_data rescue (Dcc.perform_in(5))
    Dcc.perform_in(5)
  end

end
