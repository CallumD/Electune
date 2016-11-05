module HashInitializer
  def initialize(params = {})
    params.each { |k, v| send("#{k}=", v) }
  end
end
