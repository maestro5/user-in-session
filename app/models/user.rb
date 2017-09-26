class User
  attr_accessor :first_name, :last_name, :id

  def initialize(first_name:, last_name:, id: nil)
    @first_name, @last_name, @id = first_name, last_name, id
  end

  def update(user_params)
    user_params.each { |k, v| send("#{k}=", v) unless v.empty? }
    self
  end

  def to_s
    "#{first_name} #{last_name}"
  end
end
