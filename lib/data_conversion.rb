require 'csv'

def convert_date_to_datetime(date)
  r = date.split('/').map{ |e| e.to_i }
  DateTime.new(r[2], r[0], r[1])
end

def create_visit_objects_from_data
  patient_data = CSV.read('./lib/assets/data/new_patient_data_1.csv')
  patient_data.shift # to remove header row
  patient_data.each do |row|
     visit = Visit.new(raw_code: row[0])
     visit.date = convert_date_to_datetime(row[1])
     visit.dob = convert_date_to_datetime(row[2])
     visit.save
     puts visit.errors.full_messages if !visit.persisted?
  end
end

def create_diagnosis_objects_from_data
  diagnosis_data = CSV.read('./lib/assets/data/ICD9_code_description.csv')
  diagnosis_data.shift
  diagnosis_data.each do |row|
    diagnosis = Diagnosis.create(
      code: row[0],
      description_long: row[1],
      description_short: row[2]
    )
  end
end

# return Diagnosis object based on raw_code from Visit
def lookup_icd9_code(raw_code)

  raw_code.gsub('.','')
end
