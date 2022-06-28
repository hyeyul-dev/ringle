# README

### Setting

설치 
1. docker : [Install Docker Desktop on Mac | Docker Documentation](https://docs.docker.com/desktop/mac/install/) -> 도커로 Elasticsearch 세팅

2. homebrew : [macOS 용 패키지 관리자 — Homebrew](https://brew.sh/index_ko)


```ruby
git clone https://github.com/hyeyul-dev/ringle.git
```

```ruby 
cd ringle 
docker-compose build
docker-compose up
```

데이터 생성

```ruby
rails db:migrate; rails db:seed
```

### ERD

![ERD](https://user-images.githubusercontent.com/48707618/176189891-210d8639-4710-4afc-aa40-523cd7f4b2dc.png)


## API 문서

### redoc
https://redocly.github.io/redoc/?nocors&url=http://localhost:3000/swagger_doc

### Postman
https://documenter.getpostman.com/view/12991109/UzBsHPsn
