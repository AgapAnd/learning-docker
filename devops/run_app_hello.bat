@echo off
echo "Hello World" application with Maven and Docker


echo Step 1. Checking files...

cd ../application

if not exist src/main/java/ru/agapov/app/Hello.java (
	echo File "Hello.java" not found
	goto end
)

if not exist pom.xml (
	echo File "pom.xml" not found
	goto end
)

if not exist Dockerfile (
	echo File "Dockerfile" not found
	goto end
)

if not exist docker-compose.yml (
	echo File "docker-compose.yml" not found
	goto end
)


echo Step 2. Making a docker image...

docker-compose build


echo Step 3. Running docker image...

docker-compose up


: end
pause