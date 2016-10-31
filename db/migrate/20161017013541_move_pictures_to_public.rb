class MovePicturesToPublic < ActiveRecord::Migration
  def change
    AlumniOfficer.all.each do |officer|
      FileUtils.mv(
        File.join(Rails.root,
                  'app',
                  'assets',
                  'images',
                  'alumni_officers',
                  "#{officer.member.first_name.downcase}_#{officer.member.last_name.downcase}.png"),
        officer.member.picture_dir,
        force: true
      )
    end

    ActiveOfficer.all.each do |officer|
      FileUtils.mv(
        File.join(Rails.root,
                  'app',
                  'assets',
                  'images',
                  'active_officers',
                  "#{officer.member.first_name.downcase}_#{officer.member.last_name.downcase}.jpg"),
        officer.member.picture_dir,
        force: true
      )
    end
  end
end
