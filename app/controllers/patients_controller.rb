class PatientsController < ApplicationController
  include PatientsHelper

  def index
    api_url = api_params[:api_url]
    api_url.present? ? request = @patients = Fetch::Patient.new(api_url) : request = @patients = Fetch::Patient.new
    @patients = request.patients
    @current_url = request.current_url
    @next_url = request.next_url
    @number_of_patients = @patients&.count
    filter_pediatric if params[:pediatric]
  end

  private

    def api_params
      params.permit(:api_url)
    end

    def filter_pediatric
      @patients = @patients.reject{|patient| patient_age(patient) >= 18}
    end
end
