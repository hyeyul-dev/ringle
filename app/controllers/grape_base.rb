module GrapeBase
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActiveRecord::RecordInvalid, with: :bad_request
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    rescue_from Faraday::ClientError, with: :client_error
    rescue_from Grape::Exceptions::ValidationErrors, with: :parameter_validate_error
  end

  def user_not_authorized(exception)
    errors = exception.record&.errors&.full_messages
    error!({ errors: errors }, 403)
  end

  def not_found(exception)
    error!({ errors: [exception.message] }, 404)
  end

  def bad_request(exception)
    error!({ errors: [exception.message] }, 400)
  end

  def internal_server_error(exception)
    error!({ errors: [exception.message] }, 500)
  end

  def client_error(exception)
    error!(
      status: exception.response[:status],
      message: exception.response[:body].force_encoding('UTF-8')
    )
  end

  def parameter_validate_error(exception)
    errors = exception.errors.transform_keys! { |key| key.join(',') }
    error!({ errors: errors.transform_values { |key, value| [key, value.first.message] } }, 400)
  end
end
