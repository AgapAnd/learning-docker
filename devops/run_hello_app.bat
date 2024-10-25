@echo off
cls
echo "Hello World" application
echo.
echo Step 1. Checking necessary conditions for compiling and running app...

if not exist ../application/src/ru/agapov/app/Hello.java (
	echo File "Hello.java" not found
	goto end
)
echo.


echo Step 2. Compiling application...
echo.

docker run -it -v "%cd%/..:/mnt" maven:3.6.3-openjdk-8-slim /usr/local/openjdk-8/bin/javac -d /mnt/application /mnt/application/src/ru/agapov/app/Hello.java


echo Step 3. Running application...
echo.

docker run -it -v "%cd%/..:/mnt" maven:3.6.3-openjdk-8-slim /usr/local/openjdk-8/bin/java -classpath /mnt/application ru.agapov.app.Hello
echo.


: end
pause