class PropertiesRepresenter
  def initialize(properties, current_user)
    @properties = properties
    @current_user = current_user
  end

  def attach_current_user
    @properties.each do |property|
      property.current_user = @current_user
    end
  end
end
