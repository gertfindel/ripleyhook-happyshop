# encoding: UTF-8
set :root, File.dirname(__FILE__)

get '/' do
  contents = RipleyScrapper.get_contents params[:gender], params[:age]
  contents.to_json
end
