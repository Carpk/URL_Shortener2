get '/' do
  # let user create new short URL, display a list of shortened URLs
  erb :index
end

post '/urls' do
  # create a new Url

  params[:inputted_url]

  @generated_shortened_url = (0...8).map { (65 + rand(26)).chr }.join
  url = Url.new(original_url: params[:inputted_url],
                shortened_url: @generated_shortened_url,
                click_counter: 0)

  unless url.valid?
    @generated_shortened_url = "Your URL " + url.errors[:original_url][0] + "!!!"
  else
    url.save
    @generated_shortened_url = 'http://127.0.0.1:9393/' + @generated_shortened_url
  end

  erb :index
end

# e.g., /q6bda
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
