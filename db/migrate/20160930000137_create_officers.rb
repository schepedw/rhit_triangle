class CreateOfficers < ActiveRecord::Migration
  def change
    create_table :active_officers do |t|
      t.string :title, unique: true, null: false
      t.integer :member_id, unique: true, null: false
    end

    create_table :alumni_officers do |t|
      t.string  :title, unique: true, null: false
      t.integer :member_id, unique: true, null: false
      t.text    :bio
      t.text    :job_description
    end

    execute("ALTER TABLE active_officers ADD CONSTRAINT memberfk FOREIGN KEY (member_id) REFERENCES members (member_id)")
    execute("ALTER TABLE alumni_officers ADD CONSTRAINT memberfk FOREIGN KEY (member_id) REFERENCES members (member_id)")
#    add_column :members, :phone_number, :string
    ActiveOfficer.create!(title: 'President', member_id:
                         Member.create!(first_name: 'Dean', last_name: 'Thomas', email: 'thomasda@rose-hulman.edu', initiation_year: 2014, phone_number: '7655710844', password: AppConfig.default_password).id)
    ActiveOfficer.create!(title: 'Vice President', member_id:
                         Member.create!(first_name: 'Alex', last_name: 'Jansen', email: 'jansenat@rose-hulman.edu', initiation_year: 2014, phone_number: '8154038998', password: AppConfig.default_password).id)
    ActiveOfficer.create!(title: 'Secretary', member_id:
                         Member.create!(first_name: 'Mitchell', last_name: 'Baker', email: 'bakerma@rose-hulman.edu', initiation_year: 2014, phone_number: '2178209147', password: AppConfig.default_password).id)
    ActiveOfficer.create!(title: 'Treasurer', member_id:
                         Member.create!(first_name: 'Garret', last_name: 'Manship', email: 'manshigd@rose-hulman.edu', initiation_year: 2014, phone_number: '5138463458', password: AppConfig.default_password).id)
    ActiveOfficer.create!(title: 'House Manager', member_id:
                         Member.create!(first_name: 'Austin', last_name: 'Webb', email: 'webbam@rose-hulman.edu', initiation_year: 2015, phone_number: '7654132736', password: AppConfig.default_password).id)
    ActiveOfficer.create!(title: 'Steward', member_id:
                         Member.create!(first_name: 'Jack', last_name: 'Blauert', email: 'blauert@rose-hulman.edu', initiation_year: 2015, phone_number: '7085526615', password: AppConfig.default_password).id)
    ActiveOfficer.create!(title: 'Activities Director', member_id:
                         Member.create!(first_name: 'Nick', last_name: 'Kowalkowski', email: 'kowalkne@rose-hulman.edu', initiation_year: 2014, phone_number: '8152780816', password: AppConfig.default_password).id)
    ActiveOfficer.create!(title: 'Advisor', member_id:
                         Member.create!(first_name: 'Cary', last_name: 'Laxer', email: 'laxer@rose-hulman.edu', initiation_year: 1989, password: AppConfig.default_password).id)
    AlumniOfficer.create!(title: 'President', bio: AppConfig.alumni_officers.president.bio, job_description: AppConfig.alumni_officers.president.job_description, member_id:
                         Member.create!(first_name: 'Andy', last_name: 'Cheung', email: 'awcheung4@gmail.com', initiation_year: 2007, phone_number: '8435972120', password: AppConfig.default_password).id)
    AlumniOfficer.create!(title: 'Vice President', bio: AppConfig.alumni_officers.vice_president.bio, job_description: AppConfig.alumni_officers.vice_president.job_description, member_id:
                         Member.create!(first_name: 'Evan', last_name: 'Land', email: 'evanland90@gmail.com', initiation_year: 2010, phone_number: '3177019917', password: AppConfig.default_password).id)
    AlumniOfficer.create!(title: 'Treasurer', bio: AppConfig.alumni_officers.treasurer.bio, job_description: AppConfig.alumni_officers.treasurer.job_description, member_id:
                         Member.create!(first_name: 'Spencer', last_name: 'Johnson', email: 'spencerdavisjohnson@gmail.com', initiation_year: 2011, phone_number: '6306398547', password: AppConfig.default_password).id)
    AlumniOfficer.create!(title: 'Alumni Representative', bio: AppConfig.alumni_officers.alumni_representative.bio, job_description: AppConfig.alumni_officers.alumni_representative.job_description, member_id:
                         Member.create!(first_name: 'Michael', last_name: 'Ehrstein', email: 'mdehrstein@gmail.com', initiation_year: 2010, phone_number: '2192638277', password: AppConfig.default_password).id)
    AlumniOfficer.create!(title: 'Secretary', bio: AppConfig.alumni_officers.secretary.bio, job_description: AppConfig.alumni_officers.secretary.job_description, member_id:
                         Member.create!(first_name: 'Jordan', last_name: 'Ridgley', email: 'ridgleyjs@gmail.com', initiation_year: 2012, phone_number: '5137391106', password: AppConfig.default_password).id)
    ActiveOfficer.all.map(&:member).each { |o| o.add_role :admin }
    AlumniOfficer.all.map(&:member).each { |o| o.add_role :admin }
  end
end
