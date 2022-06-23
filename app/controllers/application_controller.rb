class ApplicationController < ActionController::API
  include Pundit::Authorization

  rescue_from ActiveRecord::RecordInvalid, with: :bad_request
  rescue_from ActiveRecord::InvalidForeignKey, with: :bad_request
  rescue_from ActiveRecord::Rollback, with: :record_rollback_error
end
