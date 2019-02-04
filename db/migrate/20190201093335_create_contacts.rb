class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|   # テーブルの生成 contactsの内容をtに代入
      t.string :name                # nameカラムを追加
    end
  end
end
