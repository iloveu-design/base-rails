# Welcome to Base-Rails
## 테스트서버

http://rails.ufosoft.net

## 개발환경 구축

rbenv로 ruby 2.6.3을 설치합니다. rbenv가 설치되어 있지 않으면 [개발환경가이드](https://slowalk.parti.xyz/posts/29763)를 참고합니다.

```
rbenv install 2.6.3
```

설치되지 않을 경우 
```
RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl)" rbenv install  2.6.3
```


번들러를 설치합니다.

```
gem install bundler
````

프로젝트를 복사하고 해당 디렉토리로 들어가서 데이터베이스를 생성합니다.

```
bin/rails db:setup
```

서버를 띄우고 http://localhost:3000 에서 확인합니다.

```
bin/rails s
```

## capistrano 배포 가이드 
