class AddCommentAndParticipantsNumberToPublicCompetitions < ActiveRecord::Migration
  def change
    add_column :employments_public_competitions, :participants_number, :integer
    add_column :employments_public_competitions, :closing_comment, :text
  end
end
