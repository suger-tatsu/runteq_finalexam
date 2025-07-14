# 🎓 生徒グループ分けアプリ - 教育現場の“めんどう”を技術で解決

## 📌 概要

このアプリは、教師が生徒を「能力値」や「特技」に基づいて戦略的かつ公平にグループ分けできる教育支援ツールです。

- 能力バランスを考慮したグループ分け
- スキルを基にした柔軟な条件指定
- グループ結果のURLシェア機能（非ログインで閲覧可）

など、**教育現場の“あるあるな課題”を現実的に解決する実用志向アプリ**として開発しました。

---

## 🎮 デモサイト

🔗 [https://www.studentgroupwake.xyz/](https://www.studentgroupwake.xyz/) 
🔐 パスワード付きURLによるグループ結果の外部公開に対応

---

## 🔧 主な機能

- ✅ 生徒登録（最大5つの能力値・バリデーションあり）
- ✅ 特技（スキル）登録・検索（Ransack使用）
- ✅ 自動グループ分け（能力値の偏りを調整 / 重み付け対応）
- ✅ 結果シェア（共有URL自動生成・パスワード付き）
- ✅ ログイン機能（Devise + Googleログイン）
- ✅ 教師プロフィール編集（パスワード / アイコン変更）

---

## 🤖 今後の展望

- KMeansによる **AIグループ分け**（Python + Docker連携）
- 特技や傾向から能力をAIで自動予測 → 可視化（グラフ・タグ表示）

---

## 💻 使用技術

| 種別        | 内容                                      |
|-------------|-------------------------------------------|
| フロント    | Tailwind CSS / Turbo / Stimulus           |
| バックエンド| Ruby on Rails 8 / PostgreSQL              |
| 認証        | Devise / OmniAuth（Googleログイン）       |
| 検索        | Ransack                                   |
| アセット管理| Propshaft / jsbundling-rails / cssbundling-rails |
| デプロイ    | Render（本番） + Docker（開発） / Neon DB |

---

## 📁 セットアップ方法（ローカル開発）

このアプリは **Docker + Rails 8 + PostgreSQL** を用いた開発環境構成になっています。

### 🔸 必要環境（ホスト側）

- Docker / Docker Compose
- Git

---

### 🚀 開発環境での起動

```bash
git clone https://github.com/suger-tatsu/runteq_finalexam.git
cd runteq_finalexam
cp .env.sample .env       # 必要に応じて環境変数を編集
docker compose build
docker compose up
```

その後、下記にアクセス：
http://localhost:3000
---
## 💬 就活向けコメント

初年度は 年収280万円以上 を一つの目標にしています。
経験の浅さは承知のうえで、早期キャッチアップと現場貢献の覚悟をもって取り組んでいます。
給与水準よりも「成長できる環境」「誰かと一緒に価値をつくること」を大切にしています。
---
## 🧠 このアプリで証明したいこと

教育現場のリアルな課題を技術で解決しようとする「問題発見力」

UI/UX・セキュリティ・共有機能など「実用性を重視した設計力」

Devise + OmniAuth + Docker + Render + PostgreSQL まで自走で組み立てた「開発の地力」
---