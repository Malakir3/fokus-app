# アプリ名
Fokus

# 概要
Fokusはカロリー計算アプリです。毎日の食事メニューを記録すると、摂取カロリーを計算してグラフで表示します。
メニューの記録方法はシンプルで、食事した各メニューの量を、「多め」、「普通」、「少なめ」から選ぶだけです。

# 本番環境URL
[Fokus-app]~~(http://18.181.68.104/)~~ ←現在停止中です。

# テスト用情報
## Basic認証
~~- ID: test~~
~~- Password: 34807~~
## ユーザー情報
~~- Email: test12@com~~
~~- Password: pass12~~

# ローカルでの動作方法
ruby -v 2.6.5  
rails -v 6.0.0  

データをクローンしたいディレクトリに移動した後に、以下のコマンドを順に実行してください。  
`% git clone https://github.com/Malakir3/fokus-app.git`  
`% cd fokus-app`  
`% bundle install`  
`% yarn install`  
`% rails db:create`  
`% rails db:migrate`

# 制作背景
「お茶碗一杯のご飯は何gですか？」この質問に答えられる方は少ないのではないでしょうか。  
世の中に存在するカロリー計算アプリでは、食事したメニューの量を数値で入力する必要があります。
仮に、お茶碗一杯のご飯は平均で約150gである、という事実を知っていたとしても、あなたが普段使っているお茶碗が平均的な大きさとは限りません。つまり、あなたにとっての「普通」の量は、あなた自身でしかわかりません。  
ユーザーひとりひとりの基準に合わせてカロリー計算がしたい。そんな願いからFokusは誕生しました。

# 利用方法
## 基準登録
1. まずはユーザー新規登録を行って、ログインします。
2. ナビゲーションバーの「食事メニュー」ボタンをクリックします。一覧表示されている食品の画像の中から、基準登録したい画像をクリックすると、食品の詳細ページに遷移します。「基準登録」ボタンをクリックします。
3. 表示された5枚の写真を見て、あなたが思う「多め」、「普通」、「少なめ」の量を選択してください。「登録する」ボタンをクリックすると、そのメニューに対するあなたの基準がアプリに登録されます。

## 実績登録
1. ナビゲーションバーの「食事メニュー」ボタンをクリックします。一覧表示されている食品の画像の中から、あなたが食事したメニューの画像を選択し、「実績登録」ボタンをクリックします。（この時、そのメニューについてあなたの基準が未登録ならば「基準登録」ボタンが表示されてます。まずはそちらをクリックして基準登録を行ってください。）
2. 食事した日付、時間帯（朝食、昼食、夕食）、量（多め、普通、少なめ）を選択し、「登録する」ボタンをクリックします。
3. ナビゲーションバーの「食事基準」ボタンをクリックすると、登録済みの基準が一覧表示されます。基準を変更・削除したい場合は、メニュー名をクリックして該当するボタンを押してください。

## 実績閲覧
1. ナビゲーションバーの「食事実績」ボタンをクリックします。続いて「グラフ作成」ボタンをクリックすると、実績登録した食事について、一日ごとのカロリー摂取量がグラフで表示されます。
2. 食事実績を変更・削除したい場合は、食事実績一覧の中から対象項目を選んで、該当するボタンを押してください。

# 目指した課題解決
Fokusは、食事の量を感覚的に入力することにより、正確なカロリー値の素早い記録を実現しています。  
従来のカロリー計算アプリケーションでは、ユーザーが自身の食事量を正確に把握できない場合において、実際に食事した量と、アプリケーションに記録した食事量との間に誤差が生じ、正確なカロリー計算を行えないという課題がありました。特に、普段から料理に対して馴染みのない（私のような）ユーザーにとっては食品の分量を大きく見誤る可能性が高く、その誤差はより顕著に現れます。  
そこで、Fokusのユーザーは予め一つのメニューについて、それぞれ分量の異なる5種類の写真の中から、自身にとって「多め」、「普通」、「少なめ」だと感じる写真を選び、メニュー毎に登録します。各写真は分量の情報を有しているため、ユーザーは写真を選択することによって、間接的に分量を選択することができます。これにより、ユーザーの感覚に合わせて食事量を登録することができるため、より正確なカロリー計算を実現できています。

# 洗い出した要件
[要件定義(googleスプレッドシート)](https://docs.google.com/spreadsheets/d/1ZNXatKxcsyWj7Xd3kYDzX89nxGfBKaGZwT-P7MMiqpc/edit#gid=1059704997)

# DEMO
1. ログイン後、画面左部のメニューバーから行いたい操作を選択します。  
[![Image from Gyazo](https://i.gyazo.com/63de245b7a8904087d587cf2f282fe6d.jpg)](https://gyazo.com/63de245b7a8904087d587cf2f282fe6d)

2. 基準登録画面では、5種類の写真の中からそれぞれ「多め」、「普通」、「少なめ」だと感じる写真を選び、登録してください。  
[![Image from Gyazo](https://i.gyazo.com/37a7059f16ecd66c7deefe7802b1f104.jpg)](https://gyazo.com/37a7059f16ecd66c7deefe7802b1f104)

3. 食事実績画面では、登録した食事実績に基づき、日毎のカロリー摂取量をグラフで閲覧できます。  
[![Image from Gyazo](https://i.gyazo.com/676163a0169a84c44722c23c946b3ef6.jpg)](https://gyazo.com/676163a0169a84c44722c23c946b3ef6)

# 工夫したポイント
1. 食事実績を登録する際は、食事時間帯と食事量を、それぞれActiveHashを用いて登録するように設計しました。これにより、余計なデータをデータベースが保持する必要がなくなり、シンプルな形式でデータを保存することができるようになりました。
2. 食事基準が登録されていないメニューについては、メニュー詳細画面や食事実績一覧画面において、基準登録されていない旨を表示するようにしました。これにより、ユーザーに対して基準登録を促し、Fokusの機能を最大限に利用してもらえるようにしました。

# 使用技術（開発環境）
## バックエンド
Ruby, Ruby on rails

## フロントエンド
JavaScript, Ajax, Bootstrap

## データベース
MySQL, SequelPro

## インフラ
AWS(EC2), Capistrano

## Webサーバ（本番環境）
Nginx

## アプリケーションサーバ（本番環境）
unicorn

## ソース管理
GitHub, GitHubDesktop

## テスト
Rspec

## エディタ
VSCode


# 課題、実装予定の機能
1. 現状の実装では、食事実績のグラフを表示させるために、「グラフ作成」ボタンを押した時間帯でユーザーの食事実績データから日毎のカロリーを計算し、グラフ作成用テーブルに保存しています。また、ユーザーが食事実績ページを訪れる度、グラフ作成用テーブルのデータは削除される仕様となっています。そのため、グラフ作成用テーブルに対するデータ処理の回数が極端に多く、食事実績が多くなるとアプリの動作が重くなる可能性が考えられます。  
したがって、今後の課題として、サーバーの負担を軽減するデータベース設計・再構築を考えています。具体的には、ユーザーが食事実績をデータベースに保存する際に、食事量の「多め」、「普通」、「少なめ」という値を、分量に応じたカロリーの値に計算してから保存する処理にします。そして、グラフ作成の際には食事実績のテーブルを参照するように設定し、現状のグラフ作成用テーブルは削除します。
2. 現状は、食事によって自身が摂取したカロリーを計算して表示するアプリです。この機能に加えて、運動によって自身が消費したカロリーを計算して表示する機能も実装したいと考えています。これに伴い、グラフ表示は摂取カロリーと消費カロリーとを比較して閲覧できようにすることで、日々のカロリーの収支を把握できるようにします。この機能を実装することで、Fokusは単なる摂取カロリー計算アプリから、健康管理アプリに進化できると考えています。

# 開発秘話
Fokusというアプリケーションを通して、「普通とは一体何か？」というメッセージを伝えたいです。  
私達一人ひとりは、生まれ育った環境も個性もバラバラであり、それぞれ異なった判断基準を持っています。あなたにとっての「普通」は、他の誰かにとっては普通ではないかもしれません。  
そんな一人ひとり異なる基準にFocusしたい。そのFocusは、他の誰でもないあなたの基準に向かって、あなたが今日食事に使ったその鋭く尖ったForkで突き刺すように、まっすぐに。そんな思いから、'Focus'が'Fork'の'k'の文字を受け継ぎ、'Fokus'という名前が生まれました。


# テーブル設計

## Usersテーブル

| Column    | Type   | Options                   |
| --------- | ------ | ------------------------- |
| firstname | string | null: false               |
| lastname  | string | null: false               |
| nickname  | string | null: false               |
| birthday  | date   | null: false               |
| email     | string | null: false, unique: true |
| password  | string | null: false               |

### Association
- has_one :profile
- has_many :standards
- has_many :intakes


## Profilesテーブル
| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| user          | references | null: false, foreign_key: true |
| gender_id     | integer    |                                |
| prefecture_id | integer    |                                |
| hobby         | string     |                                |
| occupation    | string     |                                |
| introduction  | text       |                                |

### Association
- belongs_to :user


## Menusテーブル
| Column   | Type    | Options     |
| -------- | ------- | ----------- |
| title    | string  | null: false |
| amount   | integer | null: false |
| unit     | string  | null: false |
| calorie  | integer | null: false |
| bar_code | string  |             |

### Association
- has_many :standards
- has_many :intakes


## Standardsテーブル
| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| menu   | references | null: false, foreign_key: true |
| large  | integer    | null: false                    |
| medium | integer    | null: false                    |
| small  | integer    | null: false                    |

### Association
- belongs_to :user
- belongs_to :menu


## Intakesテーブル
| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| user      | references | null: false, foreign_key: true |
| menu      | references | null: false, foreign_key: true |
| date      | date       | null: false                    |
| timing_id | integer    | null: false                    |
| value_id  | integer    | null: false                    |

### Association
- belongs_to :user
- belongs_to :menu


## Graphsテーブル
| Column  | Type    | Options     |
| ------- | ------- | ----------- |
| date    | date    | null: false |
| calorie | integer | null: false |
