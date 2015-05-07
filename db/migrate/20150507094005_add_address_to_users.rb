class AddAddressToUsers < ActiveRecord::Migration
  def up
    User.all.find_each do |u|
      u.create.address if u.address.nil?
    end
  end

  def down
  end
end
