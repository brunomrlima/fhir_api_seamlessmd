class Fetch::Patient
  API_URL = "http://hapi.fhir.org/baseR4/Patient?birthdate=gt1950-01-01&_count=80"

  attr_accessor :patients, :next_url, :data

  def initialize(api_url = API_URL)
    api_request(api_url)
  end

  private

    def api_request(api_url = API_URL)
      response = Net::HTTP.get(URI(api_url))
      response = JSON.parse(response)
      @patients = response["entry"]
      @next_url = response.data["link"][1]["url"]
    rescue
      []
    end
end
