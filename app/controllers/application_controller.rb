class ApplicationController < ActionController::Base
  protect_from_forgery

  include SessionsHelper

  def seconds_to_mins seconds
    mm, ss = seconds.to_f.divmod(60)
    "#{mm.round}:#{'%02d' % ss.round}"
  end

  helper_method :seconds_to_mins
end
