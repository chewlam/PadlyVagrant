require 'erb'

class PadlyServer < Sinatra::Base
  set :root, ROOT
  set :public_folder, Proc.new { File.join(ROOT, "asset") }

  set :sessions, true

  get '/' do
    erb :index
  end


  get '/favorites' do

  end


  put '/favorites' do
  end


  put '/search' do

  end


  get '/collections' do

  end


  # /monsters => all monsters
  # /monsters?name=valkyrie => monsters with name like *valkyrie*
  get '/monsters/?' do
    "1 #{params}"
    (Monster.new).find(params).to_json
  end

  # /monster/123 => monster with id 123
  get '/monsters/:id' do
    puts "Find by id #{params[:id]}"
    (Monster.new).find_by_id(params[:id]).to_json
  end

end
