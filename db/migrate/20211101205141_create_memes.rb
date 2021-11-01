class CreateMemes < ActiveRecord::Migration[6.1]
  def change
    create_table :memes do |t|
      t.string :name
      t.string :url
      t.string :description

      t.timestamps
    end
  end
end
