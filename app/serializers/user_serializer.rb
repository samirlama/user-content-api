class UserSerializer < ActiveModel::Serializer
  def type
    object.class.name.downcase
  end

  def token
    @instance_options[:token]
  end

  def attributes(*args)
    {
      id: object.id,
      type: type,
      attributes: {
        token: token,
        first_name: object.first_name,
        last_name: object.last_name,
        email: object.email,
        country: object.country
      }
    }
  end
end
