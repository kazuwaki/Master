module Public::RoomsHelper
  def most_new_message_preview(room)
    # 最新メッセージのデータを取得する
    comment = room.chats.order(updated_at: :desc).limit(1)
    # 配列から取り出す
    comment = comment[0]
    # メッセージの有無を判定
    if comment.present?
      # メッセージがあれば内容を表示
      tag.p "#{comment.message}", class: "dm_list__content__link__box__message"
    else
      # メッセージがなければ[ まだメッセージはありません ]を表示
      tag.p "[ まだメッセージはありません ]", class: "dm_list__content__link__box__comment"
    end
  end

  # 相手ユーザー名を取得して表示するメソッド
  def opponent_customer(room)
    # 中間テーブルから相手ユーザーのデータを取得
    customer_room = room.customer_rooms.where.not(customer_id: current_customer)
    # 相手ユーザーの名前を取得
    name = customer_room[0].customer.name
    # 名前を表示
    tag.p "#{name}", class: "dm_list__content__link__box__name"
  end
end
