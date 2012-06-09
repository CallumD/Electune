class SayController < ApplicationController
  # GET /hello
  def hello
    @time = Time.now
    @files = Dir.glob('*')
  end

  # GET /hello/1
  def helloPath
    @time = Time.now
    @files = Dir.glob(params[:path])
  end

  def goodbye
  end
end
