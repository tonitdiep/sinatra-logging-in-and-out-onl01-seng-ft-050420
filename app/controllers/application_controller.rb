require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(password: params[:password]) ==@user.password
      # if @user != nil && @user.password == params[:password]
        session[:user_id] = @user.id
        redirect to '/account'
      else
        erb :error
      end
  end

  get '/account' do
    if Helpers.is_logged_in?(session)
      erb :account
    else
      erb :error
    end
  end

# class Helpers
  
#   	def self.current_user(session)
# 			@user = User.find(session[:user_id])
# 		end
# 		def self.is_logged_in?(session)
# 			!!session[:user_id]
# 		end
# end



  get '/logout' do
    session.clear
    redirect '/'
  end


end

