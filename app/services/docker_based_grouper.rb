class DockerBasedGrouper
  def initialize(group_assignment)
    @group_assignment = group_assignment
  end

  def run
    uuid = SecureRandom.uuid
    students_csv_path = Rails.root.join("tmp", "students_#{uuid}.csv")
    grouped_csv_path = Rails.root.join("tmp", "grouped_students_#{uuid}.csv")

    File.write(students_csv_path, GroupAssignmentCsvExporter.new(@group_assignment).export)
    Rails.logger.debug "🐳 Docker用CSV出力完了: #{students_csv_path}"

    result = system("docker run --rm -v #{Rails.root}/tmp:/app/tmp -e UUID=#{uuid} python-grouping")

    unless result
      Rails.logger.error "❌ Docker実行に失敗しました"
      return false
    end

    GroupOptimizerImporter.new(grouped_csv_path, @group_assignment).import!
    true
  ensure
    File.delete(students_csv_path) if File.exist?(students_csv_path)
    File.delete(grouped_csv_path)  if File.exist?(grouped_csv_path)
    Rails.logger.debug "🧹 一時ファイル削除完了 (UUID=#{uuid})"
  end
end
