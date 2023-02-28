class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :project, null: false, foreign_key: true
      t.references :user, null: true, foreign_key: true
      t.string :value
      t.string :type

      t.timestamps
    end
  end
end
