class UserController < ApplicationController
  def login
    
    if request.post?
      user = User.find_by_username(params[:user]['username'])
      if user
        if user.password_matches?(params[:user]['password'])
          session[:user_id] = user.id
          redirect_to '/' and return
        end
      end
    else
      session = nil
      User.current = nil
    end

    #raise session.inspect
  end

end
