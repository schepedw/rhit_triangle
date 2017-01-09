class AddScreenNameToMembers < ActiveRecord::Migration
  def up
    add_column :members, :screen_name, :string

    #TODO: The trigger isn't working
    #TODO: not sure the index is either. Explain statements aren't using it.
    # ^ maybe because of unique? idk..
    execute(<<-SQL
            UPDATE members SET screen_name = lower(first_name) || '.' || lower(last_name);
            ALTER TABLE members ALTER COLUMN screen_name SET NOT NULL;

            CREATE FUNCTION create_screen_name() RETURNS trigger AS $create_screen_name$
                BEGIN
                  IF NEW.screen_name IS NULL THEN
                    NEW.screen_name := lower(NEW.first_name) || '.' || lower(NEW.last_name);
                  END IF;
                  RETURN NEW;
                END;
            $create_screen_name$ LANGUAGE plpgsql;

            CREATE TRIGGER create_screen_name BEFORE INSERT OR UPDATE OF first_name, last_name ON members
              FOR EACH ROW
              EXECUTE PROCEDURE create_screen_name();

            CREATE UNIQUE INDEX idx_member_screen_name ON members(lower(screen_name))
            SQL
      )
  end

  def down
    remove_column :members, :screen_name
  end
end
