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
| birth_date      | string | null:false |

Association

- has_many :items
- has_many :orders

items テーブル

| Column  | Type       | Options                      |
| ------- | ---------- | ---------------------------- |
| name    | string     | null:false                   |
| genre   | integer    | null:false                   |
| price   | integer    | null:false                   |
| user    | references | null:false, foreign_key:true |

Association

- belongs_to :users
- has_one :orders

orders テーブル

| Column | Type       | Options                       |
| ------ | ---------- | ----------------------------- |
| user   | references | null:false, foreign_key: true |
| item   | references | null:false, foreign_key: true |

Association

- has_one :addresses
- belongs_to :users

addresses テーブル

| Column          | Type       |
| --------------- | ---------- |
| post_code       | string     |
| prefectures_id  | integer    |
| city            | string     |
| house_number    | string     |
| build_number    | string     |
| order           | references |

Association

- belongs_to :order