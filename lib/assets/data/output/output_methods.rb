require 'csv'

def write_diagnoses(filename)
  CSV.open("./lib/assets/data/output/#{filename}.csv", 'w') do |row|
    Diagnosis.all.each do |diagnosis|
      row << diagnosis_serializer(diagnosis)
    end
  end
end

def diagnosis_serializer(diagnosis)
  [diagnosis.code, diagnosis.description_short, diagnosis.description_long]
end
