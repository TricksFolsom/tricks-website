class ExportsController < ApplicationController
  before_action :authorize_export!

  def index
  end

  def kid_quotes
    render_json_dump("kid_quotes", KidQuote.all)
  end

  def comments
    render_json_dump("comments", Comment.all)
  end

  def making_a_differences
    render_json_dump("making_a_differences", MakingADifference.all)
  end

  def tricks_u
    payload = {
      categories: TricksUCategory.all,
      videos: TricksUVideo.all
    }
    render_json_dump("tricks_u", payload)
  end

  private

  def authorize_export!
    authorize! :manage, :all
  end

  def render_json_dump(name, payload)
    json = JSON.pretty_generate(payload.as_json)
    send_data(
      json,
      filename: "#{name}-#{Time.zone.now.to_date}.json",
      type: "application/json",
      disposition: "attachment"
    )
  end
end
