class User
  attr_accessor :first_name, :last_name, :persist
  attr_reader :id

  class << self
    def all
      ObjectSpace.each_object(self).to_a.reject { |user| user.persist == false }
    end

    def find(id)
      all.select { |user| user.id == id.to_i }&.first
    end

    def delete_all
      all.map(&:destroy)
    end
  end

  def initialize(first_name:, last_name:)
    @first_name = first_name
    @last_name  = last_name
    @id = User.all.count + 1
    @persist = true
  end

  def update(user_params)
    user_params.each { |k, v| send("#{k}=", v) unless v.empty? }
  end

  def destroy
    self.persist = false
  end

  def to_s
    "#{first_name} #{last_name}"
  end
end
