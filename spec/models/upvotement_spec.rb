require 'spec_helper'

describe Upvotement do
  it { should respond_to(:upvoter) }
  it { should respond_to(:song) }
end
