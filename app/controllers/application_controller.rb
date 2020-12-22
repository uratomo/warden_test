class ApplicationController < ActionController::Base
    before_action :create_session

    private

    def create_session
      Rails.logger.info("テスト")
      session["user"] = 1
      puts "最初のuser"
      puts request.env['warden'].user.inspect
      puts "authenticateを挟む"
      puts request.env['warden'].authenticate.inspect
      puts "authenticate後のuser"
      puts request.env['warden'].user.inspect
    end
end



# (startegy　にて認証が終わった => serialize_into_session ) <= cacheされる。２回目以降は呼び出されない
