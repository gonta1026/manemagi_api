# SETUP

$ git clone https://github.com/gonta1026/manemagi_api.git

データベース作成（database.ymlでmysqlを指定）


```
$ rails db:create
```

テーブルを作成
```
$ rails db:migrate
```

seedデーターをいれる
```
$ rails db:seed
```

---

# VERSION

- ruby 2.7.2
- rails 6.1.3
- MySQL 8.0.23 

---

# DOC

- ER図（実際のテーブルとの若干の差異あり）
https://app.diagrams.net/#G1EDgGC41576pA6OTmn9zt6IMUjHpLyrD5

---

# Heroku


```
$ git push heroku main
```

```
$ heroku run rails db:migrate:reset DISABLE_DATABASE_ENVIRONMENT_CHECK=1
```

```
$ heroku run rails db:seed
```

動作が遅い問題については[スケジューラを追加](https://qiita.com/kyabetsuda/items/391044601a113f73667d)し対応済。
# FRONT

下記が FRONT（Next.js） になります。

- https://github.com/gonta1026/manemagi_front

