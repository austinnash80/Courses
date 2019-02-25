class AddPolicyToLiveChatAnswer < ActiveRecord::Migration[5.1]
  def change
    add_column :live_chat_answers, :policy, :text
  end
end
