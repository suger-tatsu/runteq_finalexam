# runteq_finalexam
■サービス概要
学校教育などのグループワークにおいて、それぞれの得意分野や、好きな科目、趣味などでそれぞれの人間の強味を発揮できるグループ分けを自動的に行うアプリ。また、それぞれの個性に沿ったグループで、平等なグループ分けを実装したい。

■ このサービスへの思い・作りたい理由
学生時代に自分自身がグループワークなどで活躍できることが少なく、みんなそれぞれに、活躍の場を提供されたいと感じたから

■ ユーザー層について
基本的には、学校教育などで使用できるようにしたい。それぞれの個性が出せるグループや、弱みをカバーできるグループなど作っていくことで、平等なグループを作成する

■サービスの利用イメージ
まずグループ分けを施したい、教師側に人物の名前、性別、その子が習い事などで習得しているもの（ピアノなど）、その人の協調性などの性質、その子の運動神経や学力などの客観視が必要かつ、具体的な数値を出しやすい項目を入力してもらう、小学校や中学校のグループワークメインで視野に入れている為、学科などは考えていない（レクリエーションや、体育のグループ分けなど）
グループ分けは、例えば、バスケのチームを作ろうとなったときに、身長や、スポーツが得意な子の優先順位で並び替えその順番から1番上の子、一番下の子のようにクループに入れていく
過去の実績や資格をAIに評価してもらいスコアリングしてもらうのも面白そうだが、その技術を実装できるかどうかが問題
生徒間ではグループが作られた際にそのグループでチャットする機能、グループに対してのフィードバックを送る機能を備えたい
■ ユーザーの獲得について
ある程度の質でグループを作ることで教育者の層に支持を集める
■ サービスの差別化ポイント・推しポイント
グループ分けの対象となる人の人となりで、適切なグループ分けを行う、また趣味などの項目で面白いグループ分けができるなど

■ 機能候補
mvpまでにほしい機能　教師側の機能　グループ分けするユーザーの登録機能（名前、、性別、その人の協調性などの性質、得意なこと、苦手なこと、得意な科目、長手な科目、身長、体重など）、身長によるソート機能、出来る限り均等なグループ分けの実装（身長、運動神経の2つのパラメータからグループを作成できるように）　生徒たちの機能　作られたグループのチャット　フィードバック機能　
なぜ　身長と運動神経に絞ったのか、体育のグループで大きく差が出やすいのが身長差と運動神経だと考えたから
　
mvp後にほしい機能
出来る限り均等なグループ分けの実装（たとえば数学の問題のグループ分けで、出来ない人だけのグループになったり、役割分担が必要なグループ分けで、役割が偏らないように　3つ以上のパラメータでグループ分けの実装、特技タグにグループ分け　またその両方の実装）特技のタグ作成、タグ付け機能　　
生徒たちの機能　フィードバック機能
■ 機能の実装方針予定
項目としての候補
名前
性
身長
体重
運動神経
学力（文系）（スコアをつける）
学力（理系）（スコアをつける）
リーダーシップ（スコアをつける）
協調性（スコアをつける）
そのほかピアノが弾けるなどグループを決めるのにほしい個性をタグ付けできるように

それぞれの性質を１～１０点満点でスコアリングできるようにする。そして、例えばバスケチームを作ろうという場合運動神経に1.5倍、身長に１倍かけたものをスコアとしてソートしそのソートされた表をもとにグループ分けを行うグループ分け、グループワークを行う時にリーダーシップの取れないグループが作られることが内容に最低限リーダーシップが取れる人間を（６以上？）を１人選出する機能