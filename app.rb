require "sinatra"
require_relative "isbn.rb"
require 'aws-sdk'
load "./local_env.rb" 

:access_key_id => ENV['S3_KEY']
:secret_access_key => ENV['S3_SECRET'] 
bucket => ENV['S3_BUCKET']
file => ENV['S3File']



get '/' do
erb :enter_isbn
end 

get '/enter_isbn' do
erb :enter_isbn
end

post '/enter_isbn' do
isbn_data = params[:isbn_data].to_s
isbn_done = params[:isbn_done].to_s
isbn_done = isbn_check(isbn_data)
p isbn_done
isbn_done = isbn_text(isbn_done).to_s
p isbn_done
redirect '/isbn_out?isbn_done=' + isbn_done.to_s + '&isbn_data=' + isbn_data.to_s
end 

get '/isbn_out' do 
isbn_data = params[:isbn_data]
isbn_done = params[:isbn_done]

erb :isbn_out, :locals => {:isbn_data=>isbn_data, :isbn_done=>isbn_done}
end

post '/isbn_out' do 

isbn_data = params[:isbn_data]
isbn_done = params[:isbn_done]
end


# <input type ="number" min = 1 max = 100 value = isbn_data[] autofocus = "autofocus" id ="nameList" oninput = "nameFunction()" >
#     <p id = "demo"></p>
#     <br>

