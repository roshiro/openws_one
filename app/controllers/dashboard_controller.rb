# Controller to handle Dashboard actions
class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
  end
end
