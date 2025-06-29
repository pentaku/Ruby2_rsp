class Rsp
  def initialize
    puts "じゃんけん..."
  end

  # じゃんけんで何を出すのか入力させるメソッド
  def get_user_input
    puts "0(グー)1(ちょき)2(パー)3(戦わない)"
    user_input = gets.chomp # ユーザーの入力を取得
    input = user_input.tr('０-９', '0-9').to_i # 全角数字を半角に変換し、数字へ変換

    # userが入力した値が3以上だったら再入力してもらう
    while input > 3
      puts "入力が正しくありません。0~3で入力してください。"
      puts "じゃんけん..."
      puts "0(グー)1(ちょき)2(パー)3(戦わない)"
      user_input = gets.chomp # ユーザーの入力を取得
      input = user_input.tr('０-９', '0-9').to_i # 全角数字を半角に変換し、数字へ変換
    end
    @input = input
  end

  def janken
    hand_type = ["グー","チョキ","パー","戦わない"]
    my_hand = @input
    pc_hand = rand(0..3)
    puts "============================"
    puts "あなた：#{hand_type[my_hand]}を出しました"
    puts "相手：#{hand_type[pc_hand]}を出しました"
    puts "============================"

    # 自分が3を選択したら終了
    if my_hand === 3 || pc_hand === 3
      return :exit # ゲームを終了するためにシンボルを返す
    end

    case [my_hand, pc_hand]
    when[0, 1], [1, 2], [2, 0]
      return :win
    when [1, 0], [2, 1], [0, 2]
      return :lose
    else
      return :draw
    end
  end

  def acchimuite_hoi(attacker)
    directions = ["上", "下", "左", "右"]

    puts "あっち向いて〜"
    puts "0(上) 1(下) 2(左) 3(右)"

    directions_input = gets.chomp # ユーザーの入力を取得
    player_dir = directions_input.tr('０-９', '0-9').to_i # 全角数字を半角に変換し、数字へ変換

    while player_dir > 3
      puts "入力が正しくありません。0~3で入力してください。"
      puts "あっち向いて〜"
      puts "0(上) 1(下) 2(左) 3(右)"
      directions_input = gets.chomp # ユーザーの入力を取得
      player_dir = directions_input.tr('０-９', '0-9').to_i # 全角数字を半角に変換し、数
    end

    pc_dir = rand(0..3) #pcの向く方向を生成する。
    puts "ホイ！"
    puts "============================"
    puts "あなた：#{directions[player_dir]}"
    puts "コンピューター：#{directions[pc_dir]}"
    puts "============================"

    if player_dir == pc_dir
      return attacker # 勝敗がついたときは attacker(:player または :computer) を返す
    else
      return :no_result
    end
  end
end

  # ゲームの開始
  rsp = Rsp.new

  loop do
    rsp.get_user_input # ユーザーから手を取得（0〜3）
    puts "ホイ！" #取得した後にホイ！と出力
    rsp_result = rsp.janken # じゃんけん勝敗（結果をシンボルで返す）
    break if rsp_result == :exit # 戦わないが選択されたらたらループを抜ける(終了)→3

    #引き分けだった時の処理フロー
    if rsp_result == :draw
      puts "あいこで〜"
      rsp.get_user_input # あいこの場合、再度入力を受け付ける
      puts "ショ！" # あいこの際に「ショ」と表示
      rsp_result = rsp.janken # じゃんけん勝敗（結果をシンボルで返す）
      break if rsp_result == :exit # 戦わないが選択されたらたらループを抜ける(終了)→3
      puts "あいこで〜"#勝敗がつかない場合はあいこで〜にする
      next # ユーザーの手から取得に戻る。つまりは再試合
    end

    if rsp_result == :win #ジャンケンで勝ったらattackerに:playerを入れる
      attacker = :player
    else #ジャンケンで負けたらattackerに:computerを入れる
      attacker = :computer
    end
    hoi_result = rsp.acchimuite_hoi(attacker)


    case hoi_result
    when :player
      puts "あなたの勝ちです"
      break
    when :computer
      puts "コンピューターの勝ちです"
      break
    when :no_result
      puts "じゃんけん..."
      next # あっち向いてホイで決着つかなければ、ジャンケンからやり直す
    end
  end
