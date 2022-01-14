class AddDescriptionToBachelorettes < ActiveRecord::Migration[5.2]
  def change
    add_column :bachelorettes, :desc, :text
  end
end
