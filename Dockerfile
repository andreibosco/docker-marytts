FROM openjdk:8-jre as base-amd64

# FROM arm32v7/openjdk:8-jre as base-armv7

# FROM arm64v8/openjdk:8-jre as base-arm64

# -----------------------------------------------------------------------------

# ARG TARGETARCH
# ARG TARGETVARIANT
# FROM base-$TARGETARCH$TARGETVARIANT

ENV MARY_BASE=/marytts

COPY lib/ ${MARY_BASE}/lib/
COPY jar/ ${MARY_BASE}/jar/
COPY voices/* ${MARY_BASE}/lib/
COPY bin/ ${MARY_BASE}/bin/

WORKDIR ${MARY_BASE}

# Download unit selection voices (en-US and en-GB)
RUN mkdir -p temp
ADD https://github.com/marytts/voice-cmu-slt/releases/download/v5.2/voice-cmu-slt-5.2.zip temp
ADD https://github.com/marytts/voice-cmu-bdl/releases/download/v5.2/voice-cmu-bdl-5.2.zip temp
ADD https://github.com/marytts/voice-cmu-rms/releases/download/v5.2/voice-cmu-rms-5.2.zip temp
ADD https://github.com/marytts/voice-dfki-spike/releases/download/v5.2/voice-dfki-spike-5.2.zip temp
ADD https://github.com/marytts/voice-dfki-prudence/releases/download/v5.2/voice-dfki-prudence-5.2.zip temp
ADD https://github.com/marytts/voice-dfki-poppy/releases/download/v5.2/voice-dfki-poppy-5.2.zip temp
ADD https://github.com/marytts/voice-dfki-obadiah/releases/download/v5.2/voice-dfki-obadiah-5.2.zip temp
RUN unzip temp/voice-cmu-slt-5.2.zip
RUN unzip temp/voice-cmu-bdl-5.2.zip
RUN unzip temp/voice-cmu-rms-5.2.zip
RUN unzip temp/voice-dfki-spike-5.2.zip
RUN unzip temp/voice-dfki-prudence-5.2.zip
RUN unzip temp/voice-dfki-poppy-5.2.zip
RUN unzip temp/voice-dfki-obadiah-5.2.zip
RUN rm -rf temp

EXPOSE 15195

ENTRYPOINT ["bash", "/marytts/bin/marytts-server"]
