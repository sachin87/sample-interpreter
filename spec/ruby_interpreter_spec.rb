require File.expand_path('../../ruby_interpreter', __FILE__)

describe Interpreter, "behaviour" do

  before do
    @obj = Interpreter.new
  end

  # public methods  
  [:hash,:input,:run].each do |method|
    it {respond_to(method) }
  end
  
  
  # private methods
  [:read_input, :evaluate_input,
   :brackets_equal?, :remove_outer_brackets,
   :add_new_scope, :remove_upper_scope,
   :display_output, :process_variables,
   :starting_with_square_bracket,
   :show_error_message].each do |method|
    it {respond_to(method) }
  end
  
end
