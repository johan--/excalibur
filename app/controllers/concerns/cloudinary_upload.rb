module CloudinaryUpload

def valid_cloudinary_response?
  received_signature = request.query_parameters[:signature]
  calculated_signature = Cloudinary::Utils.api_sign_request \
    request.query_parameters.except(:signature),
    Cloudinary.config.api_secret
  received_signature == calculated_signature
end

end