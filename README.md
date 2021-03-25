# テーブル設計

## Usersテーブル

| Column     | Type   | Options                   |
| ---------- | ------ | ------------------------- |
| first_name | string | null: false               |
| last_name  | string | null: false               |
| nickname   | string | null: false               |
| birthday   | date   | null: false               |
| email      | string | null: false, unique: true |
| password   | string | null: false               |

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
| amount    | integer    | null: false                    |

### Association
- belongs_to :user
- belongs_to :menu