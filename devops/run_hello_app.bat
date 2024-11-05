@echo off
cls
echo "Hello World" application
echo.


if not exist logs (
	md logs
)

set log_file=logs/hello_app.log

rem: > %log_file%


cd ../application
if exist bin (
	rd bin /s /q
	echo [%date%, %time:~,-3%] INFO A folder "application/bin" was deleted >> ../devops/%log_file%
)
md bin
cd ../devops
echo [%date%, %time:~,-3%] INFO A new folder "application/bin" was created >> %log_file%


echo Step 1. Checking necessary conditions for compiling and running app...
echo.
echo [%date%, %time:~,-3%] INFO Step 1. Checking necessary conditions for compiling and running application >> %log_file%

if not exist ../application/src/ru/agapov/app/Hello.java (
	echo File "Hello.java" was not found
	echo [%date%, %time:~,-3%] ERROR File "Hello.java" was not found >> %log_file%
	goto end
)
echo [%date%, %time:~,-3%] INFO File "Hello.java" - exists >> %log_file%


echo Step 2. Compiling application...
echo.
echo [%date%, %time:~,-3%] INFO Step 2. Compiling application >> %log_file%

docker run --rm -it -v "%cd%/..:/mnt" maven:3.6.3-openjdk-8-slim /usr/local/openjdk-8/bin/javac -d /mnt/application/bin /mnt/application/src/ru/agapov/app/Hello.java
echo [%date%, %time:~,-3%] INFO File "Hello.class" was compiled >> %log_file%


echo Step 3. Running application...
echo.
echo [%date%, %time:~,-3%] INFO Step 3. Running application >> %log_file%

docker run --rm -it -v "%cd%/..:/mnt" maven:3.6.3-openjdk-8-slim /usr/local/openjdk-8/bin/java -classpath /mnt/application/bin ru.agapov.app.Hello
echo [%date%, %time:~,-3%] INFO Application was successfully runned >> %log_file%
echo.


: end
pause