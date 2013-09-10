class AddAvatarToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :avatar, :string
  end
end
