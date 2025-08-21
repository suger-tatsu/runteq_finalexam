# 🎓 生徒グループ分けアプリ — 教育現場の“めんどう”を技術で解決

## 📌 概要
教師が生徒を **能力値** や **特技** に基づいて、公平かつ戦略的にグループ分けできる教育支援ツールです。  
教育現場の「あるある課題」を実用的な設計で解決します。

- 能力バランスを考慮した自動グループ分け  
- 特技ベースの柔軟な条件指定  
- 結果のURLシェア（パスワード付き・閲覧のみ）  

---

## 🎮 デモ
- Web: [https://www.studentgroupwake.xyz/](https://www.studentgroupwake.xyz/)  
- 備考: グループ結果は **パスワード付きURL** で外部公開に対応（閲覧専用）

---

## 🔧 主な機能
- ✅ 生徒登録（任意の能力項目：**最大5つ**／バリデーションあり）  
- ✅ 特技（スキル）登録・検索（**Ransack**）  
- ✅ **自動グループ分け**（能力値の偏りを調整／**重み付け**対応）  
- ✅ 結果シェア（共有URL自動生成／**パスワード保護**）  
- ✅ ログイン（**Devise** + **Googleログイン**/OmniAuth）  
- ✅ 教師プロフィール編集（パスワード／アイコン）  

---

## 🤖 今後の予定（Roadmap）
- **AIグループ分け**：K-Means などのクラスタリング（**Python + Docker** 連携）  
- スキルや傾向から能力を **自動推定** し可視化（グラフ／タグ表示）  

---

## 🛠 技術スタック
| 区分 | 採用技術 |
|------|--------------------------------------------|
| フロント | Tailwind CSS / Turbo / Stimulus |
| サーバ | Ruby on Rails 8 / PostgreSQL |
| 認証 | Devise / OmniAuth（Google） |
| 検索 | Ransack |
| アセット管理 | Propshaft / jsbundling-rails / cssbundling-rails |
| インフラ | Render（本番） / Neon（DB） / Docker（開発） |

---

## 🧪 ローカル開発（Docker）
```bash
git clone https://github.com/suger-tatsu/runteq_finalexam.git
cd runteq_finalexam
cp .env.sample .env   # 必要に応じて環境変数を設定
docker compose build
docker compose up
🧠 このアプリで示す力
現場課題を要件化し解決する 問題発見・設計力

認証／検索／共有など、運用を見据えた 実用志向の実装力

Devise + OmniAuth + Docker + Render + PostgreSQL を単独で構成・デプロイした 自走力

補足
「AIグループ分け」は開発中のため、Roadmap に明記しています。

年収や希望条件は、公開リポジトリではなく 職務経歴書・自己PR資料 側で記載予定です。

yaml
コピーする
編集する