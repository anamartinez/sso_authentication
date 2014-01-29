class ProtectedController < ApplicationController
  before_filter :authorize!
end
