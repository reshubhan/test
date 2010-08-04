class UpdateEmailAliasOfUsers < ActiveRecord::Migration
  def self.up
    execute "update users set email_alias=CONCAT(login,'@trustedinsightinc.com')"
  end

  def self.down
    execute "update users set email_alias=NULL"
  end
end
