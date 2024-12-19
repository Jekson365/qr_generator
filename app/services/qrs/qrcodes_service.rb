require 'digest'

module Qrs
  class QrcodesService
    def initialize(params, request)
      @params = params
      @request = request
      @user_name = ''
    end

    def create
      if more_than_three_qr
        random_number = rand(1..99999)
        new_code = Qrs::Qrcode.new(@params.merge(path: "/users/#{user_name}/qrs/#{random_number}").as_json)

        if user_exists? == false
          User.create(ip_address: @request.remote_ip, user: user_name)
        end

        result = Integration::QrApi.new(@params, { user_exists: user_exists?, user_name: user_name, path: random_number }).create_qr_code

        if result['status'] == 200
          user = User.find_by(user: user_name)
          new_code.user_id = user.id
          new_code.save
          new_code
        else
          new_code.errors.full_messages
        end
      end
    end

    def concat
      if current_user.user_finals.size > 1
        remove_final_image('/home/jeko/Desktop/qr_app/public' + current_user.user_finals.reload.last.path)
        current_user.user_finals.destroy_all
      end
      Integration::QrApi.new(@params, { user_name: user_name, final_image_name: }).concat
      save_user_final(final_image_name)
    end
    def remove_final_image(image_name)
      File.delete(image_name)
    end

    def more_than_three_qr
      current_user.qr_codes.size < 3
    end

    def more_than_three_images
      current_user.user_images.size < 3
    end

    def more_than_one_final
      current_user.user_finals.size == 1
    end

    def final_image_name
      "#{current_user.id}_#{current_user.user_finals.size + 1}" + "_image"
    end

    def save_user_final(image_name)
      UserFinal.create({ user_id: current_user.id, path: "/users/#{user_name}/final/#{image_name}.jpg" })
    end

    def index
      user = User.find_by(user: user_name)
      Qrs::Qrcode.where(user_id: user.id)
    end

    def upload_image
      if more_than_three_images
        upload_dir = Rails.root.join('public', 'users', user_name, 'images')
        file_name = "#{Time.now.to_i}_#{@params[:image].original_filename}"
        if @params[:image].present?
          FileUtils.mkdir_p(upload_dir) unless File.directory?(upload_dir)

          uploaded_file = @params[:image]

          file_path = File.join(upload_dir, file_name)

          File.open(file_path, 'wb') do |file|
            file.write(uploaded_file.read)
          end

          new_image = UserImages::UserImage.new(image_path: '/users/' + user_name + '/images/' + file_name, user_id: current_user.id)
          new_image.save
        end
      end
    end

    def user_images
      UserImages::UserImage.where(user_id: current_user.id)
    end

    def current_final
      UserFinal.where(user_id: current_user.id).last
    end

    private

    def current_user
      User.find_by(user: user_name)
    end

    def user_name
      @user_name = Digest::SHA256.hexdigest(@request.remote_ip)
    end

    def user_exists?
      find_user = User.find_by(user: user_name)
      find_user ? true : false
    end
  end
end
