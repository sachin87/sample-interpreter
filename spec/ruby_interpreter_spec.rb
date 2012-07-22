require File.expand_path('../../ruby_interpreter', __FILE__)

describe Interpreter, "behaviour" do

  before do
    @obj = Interpreter.new
  end
  
  it {respond_to(:hash) }
  it {respond_to(:input) }
  it {respond_to(:read_input) }
  it {respond_to(:evaluate_input) }
  it {respond_to(:run) }
  
end
