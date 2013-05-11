class AddNameTranslationToCategory < ActiveRecord::Migration
  class Category < ActiveRecord::Base
    attr_accessor :old_name
    translates :name
  end
  def up
    ActiveRecord::Base.connection.execute("CREATE EXTENSION IF NOT EXISTS hstore;")
    add_column :categories, :name_translations, :hstore
    ActiveRecord::Base.connection.execute("UPDATE categories SET name_translations = hstore('es', name);")
    remove_column :categories, :name
  end
end
