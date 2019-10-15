build:
	docker build -t php-docker-app .
run:
	docker run -p 9001:9001 -p 8080:80 --rm -it php-docker-app
rund:
	docker run --name php-docker-app -d php-docker-app
kill:
	docker kill php-docker-app

