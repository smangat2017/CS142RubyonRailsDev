class AddPassword < ActiveRecord::Migration
  def change
	add_column :users, :password_digest, :string
	add_column :users, :salt, :float
	User.reset_column_information
	User.all.each do |user|
		salt = Random.rand
		password_digest = Digest::SHA1.hexdigest(user.login + salt.to_s)
  		user.update_attributes!(:password_digest => password_digest)
  		user.update_attributes!(:salt => salt)
  	end
  end
end
