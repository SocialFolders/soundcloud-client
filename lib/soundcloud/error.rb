# 400 Bad Request  Check if your request is a valid HTTP request.
# 401 Unauthorized   Check if you've send a valid client_id or access_token.
# 403 Forbidden Access to the requested resource is forbidden.
# 404 Not Found The requested resource was not found or is not accessible to the user.
# 406 Not Acceptable  The resource is not available in the format you requested.
# 422 Unprocessable Entity   The request is syntaxtically correct, but of an incorrect structure for this resource. Typically you are missing required properties or use incorrect data structures (e.g. strings instead of arrays).
# 500 Internal Server Error  Occurs when an unexpected error on our side happend. Please contact us to resolve that issue.
# 503 Service Unavailable  Occurs when no services are available to process your request. If possible provide your app users a way to manually trigger a retry.
# 504 Gateway Timeout  Occurs when the request processing took to long. Be aware that your request could still be executed and manipulate data.


module Soundcloud
  module Error

    class Error < Faraday::Error::ClientError; end
    class ClientError < Error; end
    class ServerError < Error; end
    class UnexpectedError < Error; end

    class BadRequest < ClientError; end
    class Unauthorized < ClientError; end
    class PaymentRequired < ClientError; end
    class Forbidden < ClientError; end
    class NotFound < ClientError; end
    class NotAcceptable < ClientError; end
    class UnprocessableEntity < ClientError; end
    class InternalServerError < ServerError; end
    class ServiceUnavailable < ServerError; end
    class GatewayTimeout < ServerError; end

    STATUS_ERROR_MAP = Hash.new do |h, k|
      case k
      when 400...500 then :ClientError
      when 500...600 then :ServerError
      end
    end.merge(400 => :BadRequest,
              401 => :Unauthorized,
              402 => :PaymentRequired,
              403 => :Forbidden,
              404 => :NotFound,
              406 => :NotAcceptable,
              422 => :UnprocessableEntity,
              500 => :InternalServerError,
              503 => :ServiceUnavailable,
              504 => :GatewayTimeout)

    def self.[](status)
      self.const_get(STATUS_ERROR_MAP[status])
    end

  end
end
