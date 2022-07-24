FROM ghcr.io/ebell495/gradle:7.4.2
COPY . /zxcvbn4j
WORKDIR /zxcvbn4j
RUN gradle build
RUN mkdir ./fuzz/deps && find /zxcvbn4j/build/libs -name "zxcvbn*0.jar" -exec cp {} "/zxcvbn4j/fuzz/deps/zxcvbn.jar" \;
WORKDIR /zxcvbn4j/fuzz/src
# RUN echo $(ls -la /zxcvbn4j/fuzz/deps)
# RUN echo $(ls -la /zxcvbn4j/build/libs)
# Build the fuzz target
RUN javac -cp "../deps/*" fuzz_password_strength.java && jar cfme fuzz_password_strength.jar Manifest.txt fuzz_password_strength fuzz_password_strength.class && chmod u+x fuzz_password_strength.jar && cp fuzz_password_strength.jar /zxcvbn4j/fuzz/deps
WORKDIR /zxcvbn4j/fuzz/deps
