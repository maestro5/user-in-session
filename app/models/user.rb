class User
  attr_accessor :first_name, :last_name
  attr_reader :id, :errors

  def initialize(id: nil, first_name: nil, last_name: nil)
    @id = id
    @first_name = first_name
    @last_name  = last_name
    @errors = []
  end

  def valid?
    @errors << 'First name can\'t be blank!' if first_name.to_s.empty?
    @errors << 'Last name can\'t be blank!'  if last_name.to_s.empty?
    @errors.empty?
  end

  def update(user_params)
    user_params.each { |k, v| send("#{k}=", v) }
    valid? ? self : false
  end

  def to_s
    "#{first_name} #{last_name}"
  end
end
