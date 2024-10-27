@echo off
cls
echo "Hello World" application
echo.

if not exist logs (
	md logs
)

set log_file="logs/log.txt"

> %log_file% (
echo Date: %date%, time: %time%
)


echo Step 1. Checking necessary conditions for compiling and running app...
echo.
echo 	Step 1. Checking files >> %log_file%

if not exist ../application/src/ru/agapov/app/Hello.java (
	echo File "Hello.java" was not found
	echo [ERROR] File "Hello.java" was not found >> %log_file%
	goto end
)
echo [INFO] "Hello.java" - OK >> %log_file%

if exist ../application/bin/ru/agapov/app/Hello.class (
	echo [INFO] "Hello.class" - OK, compilation is not needed >> %log_file%
	goto running
)


echo Step 2. Compiling application...
echo.
echo 	Step 2. Compiling application >> %log_file%

docker run --rm -it -v "%cd%/..:/mnt" maven:3.6.3-openjdk-8-slim /bin/mkdir /mnt/application/bin
echo [INFO] A new folder "/bin" was made >> %log_file%

docker run --rm -it -v "%cd%/..:/mnt" maven:3.6.3-openjdk-8-slim /usr/local/openjdk-8/bin/javac -d /mnt/application/bin /mnt/application/src/ru/agapov/app/Hello.java
echo [INFO] File Hello.class was compiled >> %log_file%


: running
echo Step 3. Running application...
echo.
echo 	Step 3. Running application >> %log_file%

docker run --rm -it -v "%cd%/..:/mnt" maven:3.6.3-openjdk-8-slim /usr/local/openjdk-8/bin/java -classpath /mnt/application/bin ru.agapov.app.Hello
echo [INFO] Application was successfully runned >> %log_file%
echo.


: end
pause