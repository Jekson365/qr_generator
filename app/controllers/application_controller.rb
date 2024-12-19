class ApplicationController < ActionController::API
  def static_file
    send_file "#{Rails.root}/public/users/#{params[:filename]}", disposition: 'inline'
  end
end
