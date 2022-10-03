#create migraion
#migrate create -ext sql -dir db/migration -seq init_schema

#run postgress in docker container
docker run --name postgres12 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12.2-alpine

#create new db in postgress without enter the container root
docker exec -it postgres12 createdb --username=root --owner=root simple_bank

#delete db in postgress without enter the container root
docker exec -it postgres12 dropdb  simple_bank 

#migrate up
migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up

#migrate down
migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down