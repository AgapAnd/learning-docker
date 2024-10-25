@echo off
cls
echo "Hello World" application
echo.
echo Step 1. Checking necessary conditions...

if not exist ../application/src/ru/agapov/app/Hello.java (
	echo File "Hello.java" not found
	goto end
)
echo.


echo Step 2. Running application...
echo.

docker run -it -v "%cd%/..:/mnt" maven:3.6.3-openjdk-8-slim /usr/local/openjdk-8/bin/javac -d /mnt/application/bin /mnt/application/src/ru/agapov/app/Hello.java

docker run -it -v "%cd%/..:/mnt" maven:3.6.3-openjdk-8-slim /usr/local/openjdk-8/bin/java -classpath /mnt/application/bin ru.agapov.app.Hello
echo.


: end
pause