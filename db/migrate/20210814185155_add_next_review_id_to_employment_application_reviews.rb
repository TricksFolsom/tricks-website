class AddNextReviewIdToEmploymentApplicationReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :employment_application_reviews, :next_review_id, :integer
    add_column :employment_application_reviews, :active, :boolean, default: true
  end
end
