## Deploy

```
$ bundle install --path vendor/bundle
$ bundle exec rake db:create
$ bundle exec rake db:migrate
$ bundle exec rake db:seed
$ cd frontend
$ npm install
$ cd ..
```

## Develop

```
$ bundle exec foreman start
```

http://localhost:5000/stream/index
