module Nop
  def nop(&block)
    yield
  end

  module_function :nop
end
