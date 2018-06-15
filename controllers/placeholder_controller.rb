class PlaceHController < Sinatra::Base

  # sets root as the parent-directory of the current file
  set :root, File.join(File.dirname(__FILE__), '..')

  # sets the view directory correctly
  set :views, Proc.new { File.join(root, "views") }

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do

    @title = "Animals & Plants"

    @placeholders = Placeholder.all

    erb :'placeholders/index'

  end


  get '/new'  do

    @placeholder = Placeholder.new

    erb :'placeholders/new'

  end

  get '/:id' do

    # get the ID and turn it in to an integer
    id = params[:id].to_i

    # make a single post object available in the template
    @placeholder = Placeholder.find id

    erb :'placeholders/show'

  end

  post '/' do

    placeholder = Placeholder.new

    placeholder.scientificAnimalName = params[:scientificAnimalName]
    placeholder.commonAnimalName = params[:commonAnimalName]

    placeholder.save

    redirect '/'

  end



  put '/:id'  do

    id = params[:id].to_i

    # Find the right post from our DB using .find
    placeholder = Placeholder.find id

    placeholder.scientificAnimalName = params[:scientificAnimalName]
    placeholder.commonAnimalName = params[:commonAnimalName]

    placeholder.save

    redirect '/'


  end

  delete '/:id'  do

    id = params[:id].to_i

    Placeholder.destroy id

    redirect '/'

  end

  get '/:id/edit'  do

    id = params[:id].to_i

    @placeholder = Placeholder.find id

    erb :'placeholders/edit'

  end

end
