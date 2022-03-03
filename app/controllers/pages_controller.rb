require 'net/http'
require 'uri'
require 'json'


class PagesController < ApplicationController
	before_action :set_user_data, only: %i[signup login]
	before_action :authenticate_user, except: %i[signup login index]
	before_action :get_todos_service, only: %i[home create_todo]
  def index
  end

  def signup
  		uri = URI("https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=#{Rails.application.credentials.firebase_api_key}")
  		response =Net::HTTP.post_form(uri, "email":@email , "password": @password)
  		data = JSON.parse(response.body)
  		session[:user_id] = data['localId']
  		session[:data]	=	data

  		redirect_to home_path, notice: 'signed up sucessfully!' if response.is_a?(Net::HTTPSuccess)
   end

  def home
  	@todos = @todos_service.all
  end

  def login
	  uri = URI("https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=#{Rails.application.credentials.firebase_api_key}")
	  response =Net::HTTP.post_form(uri, "email":@email , "password": @password)
	  data = JSON.parse(response.body)
	 
	  if response.is_a?(Net::HTTPSuccess)
	  	session[:user_id] = data['localId']
	  	session[:data]	= data
	  	redirect_to home_path, notice: 'Logged in sucessfully'
	  end

  end

  def logout
  		session.clear
  		redirect_to root_path, notice: 'Logged out sucessfully'
  end
  private
  def get_todos_service 
  		@todos_service = Todos.new
  	end



  private
  def set_user_data
  		@email = params[:email]
  		@password = params[:password]
  end

  def authenticate_user
  		redirect_to root_path, notice: 'you must be Logged in to view this page' unless current_user
   end

end
