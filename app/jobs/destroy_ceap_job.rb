class DestroyCeapJob < ApplicationJob
  queue_as :default

  def perform(ceap)
    ceap.destroy
  end
end
