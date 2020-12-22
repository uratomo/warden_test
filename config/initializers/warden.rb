
puts "読み込みできてる？？"
Warden::Strategies.add(:password) do
  # def valid?
  #   params['username'] || params['email']
  # end

  def authenticate!
    begin
      Rails.logger.info("認証をしている")
      u = User.find(session["user"])
      u.nil? ? fail!("Could not log in") : success!(u)
    rescue
      fail!("対象のuserは存在しなかった。")
    end
  end
end


Rails.configuration.middleware.use RailsWarden::Manager do |manager|
  manager.failure_app = TopController
  manager.default_strategies :password # needs to be defined
  # Optional Settings (see Warden wiki)
  manager.scope_defaults :user, strategies: [:password]
  # manager.default_scope = :admin # optional default scope
  # manager.intercept_401 = false # Warden will intercept 401 responses, which can cause conflicts
end

class Warden::SessionSerializer
  def serialize(record)
    Rails.logger.info("serialize")
    [record.class.name, record.id]
  end

  def deserialize(keys)
    Rails.logger.info("deserialize")
    Rails.logger.info(keys.inspect)
    klass, id = keys
    User.find_by(id: id)
  end
end
