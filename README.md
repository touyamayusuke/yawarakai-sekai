# 柔らかい世界掲示板

## 概要

このアプリは Ruby on Rails 製の掲示板です。投稿内容を ChatGPT API で「柔らかい世界」な文章に変換し、原文と柔らかい文を切り替えて表示できます。

- 通常モード: 投稿の原文を表示
- 柔らかい世界モード: ChatGPT APIで変換された柔らかい文を表示
- 投稿一覧・詳細で切り替え可能

## 主な機能
- ユーザー認証（Devise）
- 投稿・削除
- 投稿内容の柔らかい世界変換（OpenAI GPT-3.5 Turbo）
- 原文/柔らかい文の切り替えUI

## セットアップ

1. 必要なパッケージをインストール

```zsh
bundle install
npm install # or yarn install
```

2. データベースをセットアップ

```zsh
bin/rails db:migrate
```

3. OpenAI APIキーの設定

`.zshrc` などに以下を追加し、ターミナルを再起動してください。

```zsh
export OPENAI_API_KEY="sk-..."
```

4. サーバ起動

```zsh
bin/dev
```

## 柔らかい世界モードの使い方

- 投稿フォームから投稿すると、ChatGPT APIで柔らかい文が自動生成されます
- ページ上部の「原文モード」「柔らかい世界モード」ボタンで表示を切り替えられます
- 投稿詳細でも切り替え可能

## 注意事項
- OpenAI APIキーは有効なものを使用してください
- APIリクエスト失敗時は柔らかい文が生成されません
- Turbo/StimulusによるUI切り替えを利用しています

## 開発・カスタマイズ
- コントローラ: `app/controllers/posts_controller.rb`
- 投稿表示: `app/views/posts/_post.html.erb`
- 柔らかい世界UI: Stimulusコントローラ `app/javascript/controllers/gentle_mode_all_controller.js` など

## ライセンス
MIT
