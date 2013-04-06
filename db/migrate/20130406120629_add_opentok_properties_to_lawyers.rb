class AddOpentokPropertiesToLawyers < ActiveRecord::Migration
  def change
    add_column :users, :opentok_session_id, :text
    add_column :users, :opentok_token_id, :text
  end
end
