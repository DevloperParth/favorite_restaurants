class Users::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)

    jwt_token = resource.generate_jwt_token

    render json: { message: 'User logged in successfully', user: resource, token: jwt_token }
  end
end
