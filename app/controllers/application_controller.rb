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
    @user = User.find_by_username(params[:username])
      if @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect "/account"
      end
        erb :error
  end

  get '/account' do
    @current_user = User.find_by_id(session[:user_id])
      if @current_user
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

