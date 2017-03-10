module DataConsistencyCheck

  def self.get_inconsistent_data
    inconsistent_data = {}

=begin
    checks = [
      ['Duplicate BEN HQ', ["HQ OPEN", "ACTIVE"], 'BEN: Birth entry numbers' , 'Only one number is assign to one record','district_id_number'],
      ['Duplicate BEN DC', ["DC OPEN", "COMPLETE"], 'BEN: Birth entry numbers' , 'Only one number is assign to one record','district_id_number']
    ]

    
    (checks).each do |check|
      check_name =  check[0]
      states = check[1]
=end

    ben_count = 0

    (['district_id_number','national_serial_number']).each do |check|
      data = ['Init'] ; page = 1

      while data.present? do 
        data = Child.by_district_id_number.page(page).per(2000).each
        puts "................. #{page}    ::::: #{check}"
        break if data.blank?
        (data || []).each do |d|
          identifier = d.send(check)
          next if identifier.blank?
          if check.match(/district_id_number/i)
            c = Child.by_district_id_number.key(identifier).count 
          else
            c = Child.by_national_serial_number.key(identifier).count 
          end
          next unless c > 1
          inconsistent_data[check] = [] if inconsistent_data[check].blank?
          inconsistent_data[check] << identifier
          puts "########################### #{identifier}"
        end
        page += 1
      end

    
    end
  
    return inconsistent_data
  end

end
