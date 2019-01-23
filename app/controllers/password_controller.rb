class PasswordsController < Devise::PasswordsController
    def create
      self.resource = resource_class.send_reset_password_instructions(resource_params)
  
      if successfully_sent?(resource)
        render json: {status: 'ok'}, status: :ok, location: after_sending_reset_password_instructions_path_for(resource_name)
      else
        render json: {error: ['Error occurred']}, status: :internal_server_error
      end
    end
  end