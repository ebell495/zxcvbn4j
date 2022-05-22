FROM gradle:jdk11
COPY . /zxcvbn4j
WORKDIR /zxcvbn4j
RUN gradle build
RUN mkdir ./fuzz/deps && find ./build/libs -name "zxcvbn*.jar" -exec cp {} "/zxcvbn4j/fuzz/deps/zxcvbn.jar" \;
WORKDIR /zxcvbn4j/fuzz/src
# Build the fuzz target
RUN javac -cp "../deps/*" fuzz.java && jar cfme fuzz.jar Manifest.txt fuzz fuzz.class && chmod u+x fuzz.jar && cp fuzz.jar /zxcvbn4j/fuzz/deps
WORKDIR /zxcvbn4j/fuzz/deps