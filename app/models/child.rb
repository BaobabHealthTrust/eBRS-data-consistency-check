require 'couchrest_model'

class Child < CouchRest::Model::Base
  after_initialize EncryptionWrapper.new("first_name"), EncryptionWrapper.new("middle_name"),
                   EncryptionWrapper.new("last_name"), EncryptionWrapper.new("first_name", "mother"),
                   EncryptionWrapper.new("middle_name", "mother"), EncryptionWrapper.new("last_name", "mother"),
                   EncryptionWrapper.new("id_number", "mother"), EncryptionWrapper.new("first_name", "father"),
                   EncryptionWrapper.new("middle_name", "father"), EncryptionWrapper.new("last_name", "father"),
                   EncryptionWrapper.new("id_number", "father"), EncryptionWrapper.new("first_name", "informant"),
                   EncryptionWrapper.new("middle_name", "informant"), EncryptionWrapper.new("last_name", "informant"),
                   EncryptionWrapper.new("id_number", "informant"), EncryptionWrapper.new("record_status"),
                   EncryptionWrapper.new("request_status"), # EncryptionWrapper.new("national_serial_number"),
                   EncryptionWrapper.new("npid"), if: proc{|c| self.new_record?; !self.new_record? }



  def person_id=(value)
    self['_id']=value.to_s
  end

  def person_id
    self['_id']
  end

  after_create :create_audit
  
  #Person properties
  property :first_name, String
  property :middle_name, String
  property :last_name, String
  property :first_name_code, String
  property :last_name_code, String
  property :middle_name_code, String
  property :gender, String
  property :birthdate, String
  property :birthdate_estimated, String
  property :place_of_birth, String
  property :hospital_of_birth, String
  property :birth_address, String
  property :birth_village, String
  property :birth_ta, String
  property :birth_district, String
  property :other_birth_place_details, String
  property :birth_weight, String
  property :created_by, String
  property :date_created, String
  property :certificate_issued, String
  property :date_certificate_issued, String
  property :type_of_birth, String
  property :other_type_of_birth, String
  property :multiple_birth_id, String
  property :parents_married_to_each_other, String
  property :date_of_marriage, String
  property :gestation_at_birth, String
  property :number_of_prenatal_visits, String
  property :month_prenatal_care_started, String
  property :mode_of_delivery, String
  property :number_of_children_born_alive_inclusive, String
  property :number_of_children_born_still_alive, String
  property :level_of_education, String
  property :completed_level_of_education, String
  property :record_status, String # PRINTED | HQ OPEN | DUPLICATE | FACILITY OPEN | DC OPEN | VOIDED
  property :record_status_code, String
  property :request_status, String # ACTIVE | DC_ASK | GRANTED | REJECTED | CLOSED | APPROVED | RE-PRINT |
                                  # CAN PRINT | POTENTIAL DUPLICATE | INCOMPLETE | CAN REJECT | DISPATCHED
  property :request_status_code, String
  property :district_id_number, String
  property :date_registered, String
  property :facility_code, String
  property :district_code, String
  property :national_serial_number, String
  property :court_order_attached, String
  property :npid, String
  property :parents_signed, String
  property :updated_by, String
  property :form_signed, String
  property :approved, String, :default => 'No'
  property :approved_by, String
  property :approved_at, Time
  property :acknowledgement_of_receipt_date, Time
  property :facility_serial_number, String
  property :potentialduplicate, String
  property :dispatched_to, String
  property :dispatched_date, String
  property :dispatched_by, String
  property :locked, TrueClass, :default => false 
  property :voided_by, String
  property :date_voided, Time
  property :relationship, String, :default => "Normal" # Normal | Adopted | Orphaned | Abandoned
  property :adoption_court_order, String, :default => "No"


  #Child's mother properties
  property :mother do
    property :id_number, String
    property :first_name, String
    property :middle_name, String
    property :last_name, String
    property :first_name_code, String
    property :last_name_code, String
    property :middle_name_code, String
    property :gender, String
    property :birthdate, String
    property :birthdate_estimated, String
    property :current_village, String
    property :current_ta, String
    property :current_district, String
    property :home_village, String
    property :home_ta, String
    property :home_district, String
    property :home_country, String
    property :citizenship, String

    #Address details for foreigner

    property :residential_country, String #Country

    property :foreigner_current_district, String #District/State
    property :foreigner_current_village, String #Village/Town
    property :foreigner_current_ta, String #Address

    property :foreigner_home_district, String #District/State
    property :foreigner_home_village, String #Village/Town
    property :foreigner_home_ta, String #Address

  end

  #Child's father properties
  property :father do
    property :id_number, String
    property :first_name, String
    property :middle_name, String
    property :last_name, String
    property :first_name_code, String
    property :last_name_code, String
    property :middle_name_code, String
    property :gender, String
    property :birthdate, String
    property :birthdate_estimated, String
    property :current_village, String
    property :current_ta, String
    property :current_district, String
    property :home_village, String
    property :home_ta, String
    property :home_district, String
    property :home_country, String
    property :citizenship, String

    #Address details for foreigner

    property :residential_country, String #Country

    property :foreigner_current_district, String #District/State
    property :foreigner_current_village, String #Village/Town
    property :foreigner_current_ta, String #Address

    property :foreigner_home_district, String #District/State
    property :foreigner_home_village, String #Village/Town
    property :foreigner_home_ta, String #Address

  end

  #Birth informant properties
  property :informant do
    property :id_number, String
    property :first_name, String
    property :middle_name, String
    property :last_name, String
    property :first_name_code, String
    property :last_name_code, String
    property :middle_name_code, String
    property :relationship_to_child, String
    property :current_village, String
    property :current_ta, String
    property :current_district, String
    property :addressline1, String
    property :addressline2, String
    property :city, String
    property :phone_number, String
  end
  
  
   
  #Foster parents_details
  
  #Foster father
  
  property :foster_father do
    property :id_number, String
    property :first_name, String
    property :middle_name, String
    property :last_name, String
    property :first_name_code, String
    property :last_name_code, String
    property :gender, String
    property :birthdate, String
    property :birthdate_estimated, String
    property :current_village, String
    property :current_ta, String
    property :current_district, String
    property :home_village, String
    property :home_ta, String
    property :home_district, String
    property :home_country, String
    property :citizenship, String

    #Address details for foreigner

    property :residential_country, String #Country

    property :foreigner_current_district, String #District/State
    property :foreigner_current_village, String #Village/Town
    property :foreigner_current_ta, String #Address

    property :foreigner_home_district, String #District/State
    property :foreigner_home_village, String #Village/Town
    property :foreigner_home_ta, String #Address

  end
  
  
  #Foster father
  
  property :foster_mother do
    property :id_number, String
    property :first_name, String
    property :middle_name, String
    property :last_name, String
    property :first_name_code, String
    property :last_name_code, String
    property :gender, String
    property :birthdate, String
    property :birthdate_estimated, String
    property :current_village, String
    property :current_ta, String
    property :current_district, String
    property :home_village, String
    property :home_ta, String
    property :home_district, String
    property :home_country, String
    property :citizenship, String

    #Address details for foreigner

    property :residential_country, String #Country

    property :foreigner_current_district, String #District/State
    property :foreigner_current_village, String #Village/Town
    property :foreigner_current_ta, String #Address

    property :foreigner_home_district, String #District/State
    property :foreigner_home_village, String #Village/Town
    property :foreigner_home_ta, String #Address

  end

  property :merged, String, :default => nil
  property :_deleted, TrueClass, :default => false
  property :_rev, String

  property :previous_duplicate_checks, [], :default => []

  timestamps!

  
  
  design do

    view  :by__id
    view  :by_record_status_code    
    view  :by_request_status_code    
    view  :by_record_status_code_and_request_status_code 
    view  :by_national_serial_number
    view  :by_district_id_number
  end
  
  
end
