# README

# Clone and build:

1. Download and install [Docker Compose](https://docs.docker.com/compose/install/)
2. Clone repo
3. cd into repo
4. Run these commands with specified sequence
```bash
docker-compose build
docker-compose run web yarn install    
docker-compose run web bundle install     
docker-compose run web rails db:drop db:create db:migrate db:seed
docker-compose run web rails assets:precompile
docker-compose up
```