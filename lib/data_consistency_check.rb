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
        data = Child.by_district_id_number.page(page).per(100).each
        puts "................. #{page}    ::::: #{check}"

        begin
          break if data.first.blank?
        rescue
          break
        end

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

  def self.render_inconsistent_data
    file_path = "#{Rails.root}/app/assets/data/inconsistent_data.json"
    return {} unless File.exists?(file_path)
    records = eval(File.read(file_path))
    
    inconsistents = {}

    (records || {}).map do |r, data|
      inconsistents[r] = [] if inconsistents[r].blank?
      (data || []).each do |d|
        inconsistents[r] << d
        inconsistents[r] = inconsistents[r].uniq
      end
    end

    rendered_text = {}
    (inconsistents || {}).each do |r, data|
      if r == 'district_id_number'
        (data || []).each do |d|
          
          rendered_text['BEN'] = {} if rendered_text['BEN'].blank?
          ben_year = d[-4..-1].to_i

          rendered_text['BEN'][ben_year] = {errors: 0, identifier: 'BEN: Birth registration number',
            description: "BENs assigned in #{ben_year}", records: []
          } if rendered_text['BEN'][ben_year].blank?



          rendered_text['BEN'][ben_year][:errors] += 1
          rendered_text['BEN'][ben_year][:records] << d
        end
      end
    end


    return rendered_text
  end

end
