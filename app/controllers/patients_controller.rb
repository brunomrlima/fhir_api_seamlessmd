class PatientsController < ApplicationController
  include PatientsHelper

  def index
    @patients = Fetch::Patient.new.patients
    @number_of_patients = @patients.count
    filter_pediatric if params[:pediatric]
  end

  private

    def filter_pediatric
      @patients = @patients.reject{|patient| patient_age(patient) >= 18}
    end
end
