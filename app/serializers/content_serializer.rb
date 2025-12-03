class ContentSerializer < ActiveModel::Serializer
  def type
    object.class.name.downcase
  end

  def attributes(*args)
    {
      id: object.id,
      type: type,
      attributes: {
        title: object.title,
        body: object.body,
        updated_at: object.updated_at,
        created_at: object.created_at
      }
    }.deep_transform_keys { |key| key.to_s.camelize(:lower) }
  end
end
