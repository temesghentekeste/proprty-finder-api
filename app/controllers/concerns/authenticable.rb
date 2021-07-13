module Authenticable
  def check_login
    head :forbidden unless current_user
  rescue StandardError
    render json: { error: 'Please log in before you proceed with that action!' },
           status: :forbidden
  end

  def current_user
    return @current_user if @current_user

    header = request.headers['Authorization']

    return nil if header.nil?

    decoded = JsonWebToken.decode(header.split.last)
    @current_user = begin
      User.find(decoded[:user_id])
    rescue StandardError
      ActiveRecord::RecordNotFound
    end
  end
end
