require 'net/http'
require 'uri'
require 'json'


def prendre_un_shift(user_id, shifts_id)
  uri = URI.parse("https://api.staffomaticapp.com/v3/srvinfo/shifts/#{shifts_id}/applications.json")
  request = Net::HTTP::Post.new(uri)
  request.basic_auth("eric2011+employee@aliceadsl.fr", "eric67")
  request.content_type = "application/json"
  request.body = JSON.dump({
    "user_id" => user_id,
    "do" => "assign"
  })

  req_options = {
    use_ssl: uri.scheme == "https",
  }

  response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
    http.request(request)
  end

  # response.code
  # response.body
end

def recherche_user_id
  uri = URI.parse("https://api.staffomaticapp.com/v3/srvinfo/user.json")
  request = Net::HTTP::Get.new(uri)
  request.basic_auth("eric2011+employee@aliceadsl.fr", "eric67")

  req_options = {
    use_ssl: uri.scheme == "https",
  }

  response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
    http.request(request)
  end

  # response.code
  return JSON.parse(response.body)["id"]
end

user_id = recherche_user_id
shifts_id = "20863113"

puts user_id

