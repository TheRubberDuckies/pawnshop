class AddPawnMovedTwiceToPieces < ActiveRecord::Migration[5.0]
  def change
  	add_column :pieces, :pawn_moved_twice, :integer
  end
end
