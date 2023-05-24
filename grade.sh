CPATH=".;../lib/hamcrest-core-1.3.jar;../lib/junit-4.13.2.jar"
rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests

if [[ -f student-submission/ListExamples.java ]]
    then 
        echo 'File found'

else
    echo 'FILE NOT FOUND!'
    exit
fi
cp -r *.java grading-area
cp -r student-submission/*.java grading-area

if [[ $? != 0 ]]
then 
    echo 'compile failed'
    exit
else
    echo 'compile success'
fi

cd grading-area
javac -cp $CPATH *.java
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > output.txt

result=$(grep -c 'OK' output.txt)
fails=$(grep -c -i 'caused by' output.txt)

if [[ $result > 0 ]]
then 
    echo 'all tests passed'
    exit
else
    echo 'tests failed'
fi
echo $fails