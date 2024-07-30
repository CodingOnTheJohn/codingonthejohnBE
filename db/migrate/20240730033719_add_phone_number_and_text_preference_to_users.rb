class AddPhoneNumberAndTextPreferenceToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :phone_number, :string
    add_column :users, :text_preference, :boolean, default: false
  end
end
