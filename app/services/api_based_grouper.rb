require "net/http"
require "uri"
require "json"

class ApiBasedGrouper
  def initialize(group_assignment)
    @group_assignment = group_assignment
  end

  def run
    payload = JSON.generate({
      students: @group_assignment.students.map { |s|
        {
          id: s.id,
          athletic_ability: s.athletic_ability,
          leadership: s.leadership,
          cooperation: s.cooperation,
          science: s.science,
          humanities: s.humanities
        }
      },
      group_count: @group_assignment.group_count
    })

    uri = URI.parse("https://your-python-api.example.com/group")
    response = Net::HTTP.post(uri, payload, "Content-Type" => "application/json")

    unless response.code.to_i == 200
      Rails.logger.error("[ApiBasedGrouper] API Error: #{response.body}")
      return false
    end

    json = JSON.parse(response.body)
    GroupOptimizerImporter.new_from_json(json, @group_assignment).import!
    true
  rescue => e
    Rails.logger.error("[ApiBasedGrouper] Error: #{e.message}")
    false
  end
end
