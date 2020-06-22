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

def write_visits(filename)
  CSV.open("./lib/assets/data/output/#{filename}.csv", 'w') do |row|
    Visit.all.each do |visit|
      row << visit_serializer(visit)
    end
  end
end

def visit_serializer(visit)
  [visit.raw_code, visit.date, visit.diagnosis.description_short, visit.diagnosis.description_long]
end
