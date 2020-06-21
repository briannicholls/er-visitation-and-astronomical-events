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
  diagnosis_data = CSV.read('./lib/assets/data/icd10_codes_2.csv')
  # diagnosis_data.shift
  diagnosis_data.each do |row|
    Diagnosis.create(
      code: row[0],
      description_long: row[1]
      # description_short: row[2]
    )
  end
end

def standardize_raw_code(raw_code)
  # if format is 3 digits + 1 decimal + 0, remove trailing zero
  /\A\d\d\d\.\d0\z/ =~ raw_code ? "#{raw_code[0..raw_code.length-2]}" : nil
end

def fix_raw_codes(visits)
  visits.each do |visit|
     fixed = standardize_raw_code(visit.raw_code)
     visit.raw_code = fixed if fixed
     visit.save
  end
end

# return Diagnosis object based on raw_code from Visit
def lookup_icd9_code(visit)
  Diagnosis.find_by(code: visit.raw_code.gsub('.',''))
end

# assign diagnosis to visit
def add_diagnosis_to_visit(visit)
  visit.diagnosis = lookup_icd9_code(visit)
  visit.diagnosis ? visit.save : nil
end

def match_first_4_characters_and_assign
  Visit.unassigned.each do |visit|
    trimmed_raw_code = visit.raw_code[0..2]
    puts trimmed_raw_code
    diagnosis = Diagnosis.where("code LIKE ?", "#{trimmed_raw_code}__")
    visit.diagnosis = diagnosis[0] if diagnosis.exists?
    visit.save
  end
end

# assign all unassigned visits a diagnosis
def assign_diagnosis_to_visits
  problematic_codes = {}
  Visit.unassigned.each do |unassigned_visit|
      if add_diagnosis_to_visit(unassigned_visit)
        nil
      else
        (problematic_codes[unassigned_visit.raw_code] = problematic_codes[unassigned_visit.raw_code].to_i+1)
      end
    end

  puts problematic_codes
end

def soft_assign_diagnosis_to_visits

end
