# Welcome to Base-Rails
## 테스트서버

http://rails.ufosoft.net

## 개발환경 구축

rbenv로 ruby 2.6.5을 설치합니다. rbenv가 설치되어 있지 않으면 [개발환경가이드](https://slowalk.parti.xyz/posts/29763)를 참고합니다.

```
rbenv install 2.6.5
```

설치되지 않을 경우 
```
RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl)" rbenv install  2.6.5
```


번들러를 설치합니다.

```
gem install bundler
````
mysql2가 설치되지 않을 경우 
* try 1
```
gem install mysql2 -- --with-opt-dir="$(brew --prefix openssl)"
```
* try 2
```
bundle config --local build.mysql2 "--with-ldflags=-L/usr/local/opt/openssl/lib --with-cppflags=-I/usr/local/opt/openssl/include"
```
* try 3
```
gem install mysql2 -v '0.5.2' -- --with-cflags=\"-I/usr/local/opt/openssl/include\" --with-ldflags=\"-L/usr/local/opt/openssl/lib\"
```
프로젝트를 복사하고 해당 디렉토리로 들어가서 데이터베이스를 생성합니다.

```
bin/rails db:setup
```

서버를 띄우고 http://localhost:3000 에서 확인합니다.

```
bin/rails s
```

개발 환경인 경우 초기 관리자 계정이 설정되며 `db/seeds.rb` 에서 확인 가능합니다. 사용자가 없을 경우 다음과 같이 실행합니다.

```
bin/rails db:seed
```

## capistrano 배포 가이드 
