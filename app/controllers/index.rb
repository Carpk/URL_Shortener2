get '/' do
  # let user create new short URL, display a list of shortened URLs
  # @array = Url.where('user_id: = ?', session[:object][:id])
  erb :index
end

get '/signup' do
  erb :signup
end

get '/signin' do
  erb :signin
end

get '/logout' do
  session.clear
  redirect '/'
end

post '/urls' do
  # create a new Url
  params[:inputted_url]

  # Use the helpers user.rb to set id
  id = set_id

  @generated_shortened_url = (0...8).map { (65 + rand(26)).chr }.join
  url = Url.new(original_url: params[:inputted_url],
                shortened_url: @generated_shortened_url,
                click_counter: 0,
                user_id: id)

  unless url.valid?
    @generated_shortened_url = "Your URL " + url.errors[:original_url][0] + "!!!"
  else
    url.save
    @generated_shortened_url = 'http://127.0.0.1:9393/' + @generated_shortened_url
  end

  # redirect '/'
  # @array = Url.where('user_id: = ?', session[:object][:id])
  erb :index
end

post '/create_account' do
  new_user = User.new(name: params[:user],
                      password: params[:password],
                      email: params[:email])
  session[:object] = new_user
  new_user.save
  redirect '/'
end

post '/signin' do
  attempted_acct = User.where('name = ?', params[:user])[0]
  unless attempted_acct == nil
    if attempted_acct.password == params[:password]
      session[:object] = attempted_acct
      redirect '/'
    end
  end
  erb :tryagainsignin
end

get '/:short_url' do
  redirect_url = nil
  Url.all.each do |x|
    if x.shortened_url == "#{params[:short_url]}"
      redirect_url = x
      x.click_counter += 1
      x.save
    end
  end
  redirect "#{redirect_url.original_url}"
end
