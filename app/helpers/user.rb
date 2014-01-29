helpers do

  def set_id
    if session[:object] == nil
      0
    else
      session[:object][:id]
    end
  end

end
