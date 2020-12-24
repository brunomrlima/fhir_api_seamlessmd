module PatientsHelper
  def patient_id(patient)
    patient['resource']['id']
  end

  def patient_name(patient)
    return unless patient['resource']['name'] && patient['resource']['name'][0] && patient['resource']['name'][0]['given']
    patient['resource']['name'][0]['family'].to_s + ', ' + patient['resource']['name'][0]['given'][0].to_s
  end

  def patient_birthday(patient)
    patient['resource']['birthDate'].to_date
  end

  def patient_age(patient)
    ((DateTime.now - patient_birthday(patient)).to_f/365).floor
  end

  def average_age(patients)
    return 0 if patients.count == 0
    sum_ages = 0
    patients.map{|patient| sum_ages += patient_age(patient)}
    sum_ages/patients.count
  end

  def pediatric_patients(patients)
    patients = patients.reject{|patient| patient_age(patient) >= 18}
    patients.count
  end

  def all_patients_age(patients)
    patients.map{|patient| patient_age(patient)}
  end

  def filter_pediatric
    if params[:pediatric]
      link_to 'All Patients', { }, { class: 'btn btn-primary' }
    else
      link_to 'Only Pediatric', { pediatric: true }, { class: 'btn btn-secondary' }
    end
  end
end