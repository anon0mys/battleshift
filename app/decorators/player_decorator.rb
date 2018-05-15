class PlayerDecorator < SimpleDelegator
  attr_reader :user, :board

  def initialize(user, board)
    @user = user
    @board = board
    super(@user)
  end
end
