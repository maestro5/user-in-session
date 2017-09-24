class User
  attr_accessor :id, :first_name, :last_name
  @@users = {}

  class << self
    def all
      @@users
    end

    def find(id)
      @@users[id.to_i]
    end

    def update(id, user_params)
      find(id).merge! user_params
    end

    def destroy(id)
      all.except! id.to_i
    end
  end

  def initialize(first_name:, last_name:)
    @first_name = first_name
    @last_name  = last_name
    @id = User.all.count + 1
    @@users.merge! @id => { first_name: @first_name, last_name: @last_name }
  end

  def to_s
    "#{first_name} #{last_name}"
  end
end
