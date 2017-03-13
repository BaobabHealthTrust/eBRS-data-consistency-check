class PersonController < ApplicationController
  def duplicates
    identifiers = params[:identifiers].split(',')
    @person = []

    (identifiers || []).each do |identifier|
      (Child.by_district_id_number.key(identifier).each || []).each do |person|
        @person << person
      end
    end

  end


end
