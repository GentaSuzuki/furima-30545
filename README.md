users テーブル

| Column          | Type   | Options    |
| --------------- | ------ | ---------- |
| nickname        | string | null:false |
| email           | string | null:false |
| password        | string | null:false |
| last_name       | string | null:false |
| first_name      | string | null:false |
| last_name_kana  | string | null:false |
| first_name_kana | string | null:false |
| birth_date      | date   | null:false |

Association

- has_many :items
- has_many :orders

items テーブル

| Column        | Type       | Options                      |
| ------------- | ---------- | ---------------------------- |
| name          | string     | null:false                   |
| description   | text       | null:false                   |
| price         | integer    | null:false                   |
| user          | references | null:false, foreign_key:true |
| images_id     | integer    | null:false                   |
| category_id   | integer    | null:false                   |
| condition_id  | integer    | null:false                   |
| postage_id    | integer    | null:false                   |
| prefecture_id | integer    | null:false                   |
| day_ship_id   | integer    | null:false                   |


Association

- belongs_to :user
- has_one :order

orders テーブル

| Column | Type       | Options                       |
| ------ | ---------- | ----------------------------- |
| user   | references | null:false, foreign_key: true |
| item   | references | null:false, foreign_key: true |

Association

- has_one :address
- belongs_to :user
- belongs_to :item

addresses テーブル

| Column          | Type       | Option                       |
| --------------- | ---------- | ---------------------------- |
| post_code       | string     | null:false                   |
| prefectures_id  | integer    | null:false, foreign_key:true |
| city            | string     | null:false                   |
| house_number    | string     | null:false                   |
| build_number    | string     |                              |
| phone_number    | string     | null:false                   |
| order           | references | null:false, foreign_key:true |

Association

- belongs_to :order