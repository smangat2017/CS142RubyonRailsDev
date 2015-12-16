class User < ActiveRecord::Base
	has_many :photos
	has_many :comments
	has_many :tags

	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :login, presence: true

	def fullname
		first_name + ' ' + last_name
	end

	def password=(password)
		self.salt = Random.rand
		self.password_digest = Digest::SHA1.hexdigest(password + self.salt.to_s)
	end

	def password_valid?(candidate)
		digest = Digest::SHA1.hexdigest(candidate + self.salt.to_s)
		if digest == self.password_digest
			return true
		else
			return false
		end
	end
end
