# MaryTTS 5.2 with unit selection and HSMM Voices

Based on [synesthesiam/marytts](https://hub.docker.com/r/synesthesiam/marytts).

[MaryTTS 5.2](http://mary.dfki.de) text to speech server and a collection [voices for various languages](#voices), both hidden semi-Markov model (HSMM) and unit selection for amd64 platform.

Also includes [txt2wav](https://github.com/marytts/marytts-txt2wav) utility for [command-line text to speech](#command-line-utility).

## Building

To build this image locally:

```bash
docker buildx build marytts:5.2 .
```

## Running

To run a MaryTTS server:

```bash
$ docker run -it -p 59125:59125 synesthesiam/marytts:5.2
```

You should now be able to access the server at [http://localhost:59125](http://localhost:59125)

Beware that this may consume a lot of RAM on a Raspberry Pi!

### Restricting Voices

*Feature not updated to work with non-HMS voices*

You can control which voices are loaded with `-v` or `--voice` arguments:

```bash
$ docker run -it -p 59125:59125 synesthesiam/marytts:5.2 --voice cmu-slt-hsmm --voice cmu-rms-hsmm
```

This will only loaded the necessary JARs for the specified voices, which may help conserve RAM on a Raspberry Pi.

A list of voices can be obtained with:

```bash
$ docker run -it synesthesiam/marytts:5.2 --voices
```

### Command-Line Utility

The [txt2wav](https://github.com/marytts/marytts-txt2wav) utility is included in the Docker image.
A bash wrapper script allows you to list voices and includes only the necessary JARs to reduce start-up time.

Copy the included [txt2wav script](docker/txt2wav) to somewhere in your `$PATH` and mark it executable.
This script runs the Docker image as the current user, maps your `$HOME` directory, and sets the working directory to `$PWD`.

List available voices:

```bash
$ txt2wav

voice	language
...
```

Generate WAV file:

```bash
$ txt2wav --voice cmu-slt-hsmm -o /path/to/tts.wav 'Welcome to the world of speech synthesis!'
```

Play directly:

```bash
$ txt2wav 'Welcome to the world of speech synthesis!' | aplay
```

### Online Mode

You can run `txt2wav` in an "online" mode where it will continuously read sentences from standard in, overwrite the output WAV file, and repeat the sentence back on standard out.

```bash
$ txt2wav --online -o /path/to/tts.wav

Reading sentences from stdin
...
```

Typing a sentence and pressing `<ENTER>` will overwrite `/path/to/tts.wav` and print the sentence back on standard out. To end the session, press `CTRL+D`.

## Voices

| Voice                                                                                   | Language        | Gender   | License                         | Samples                                                  |
| -----                                                                                   | ----------      | -------- | ---------                       | ---                                                      |
| [cmu-slt-hsmm](https://github.com/marytts/voice-cmu-slt-hsmm)                           | English (en-US) | Female   | [Arctic](licenses/ARCTIC)       | [Sample](samples/cmu-slt-hsmm.wav?raw=true)              |
| [cmu-bdl-hsmm](https://github.com/marytts/voice-cmu-bdl-hsmm)                           | English (en-US) | Male     | [Arctic](licenses/ARCTIC)       | [Sample](samples/cmu-bdl-hsmm.wav?raw=true)              |
| [cmu-rms-hsmm](https://github.com/marytts/voice-cmu-rms-hsmm)                           | English (en-US) | Male     | [Arctic](licenses/ARCTIC)       | [Sample](samples/cmu-rms-hsmm.wav?raw=true)              |
| [dfki-obadiah-hsmm](https://github.com/marytts/voice-dfki-obadiah-hsmm)                 | English (en-GB) | Male     | [By-ND-3.0](licenses/BY-ND-3.0) | [Sample](samples/dfki-obadiah-hsmm.wav?raw=true)         |
| [dfki-poppy-hsmm](https://github.com/marytts/voice-dfki-poppy-hsmm)                     | English (en-GB) | Female   | [By-ND-3.0](licenses/BY-ND-3.0) | [Sample](samples/dfki-poppy-hsmm.wav?raw=true)           |
| [dfki-prudence-hsmm](https://github.com/marytts/voice-prudence-slt-hsmm)                | English (en-GB) | Female   | [By-ND-3.0](licenses/BY-ND-3.0) | [Sample](samples/dfki-prudence-hsmm.wav?raw=true)        |
| [dfki-spike-hsmm](https://github.com/marytts/voice-dfki-spike-hsmm)                     | English (en-GB) | Male     | [By-ND-3.0](licenses/BY-ND-3.0) | [Sample](samples/dfki-spike-hsmm.wav?raw=true)           |
| [bits1-hsmm](https://github.com/marytts/voice-bits1-hsmm)                               | German (de)     | Female   | [By-ND-3.0](licenses/BY-ND-3.0) | [Sample](samples/bits1-hsmm.wav?raw=true)                |
| [bits3-hsmm](https://github.com/marytts/voice-bits3-hsmm)                               | German (de)     | Male     | [By-ND-3.0](licenses/BY-ND-3.0) | [Sample](samples/bits3-hsmm.wav?raw=true)                |
| [dfki-pavoque-neutral-hsmm](https://github.com/marytts/voice-dfki-pavoque-neutral-hsmm) | German (de)     | Male     | [By-ND-3.0](licenses/BY-ND-3.0) | [Sample](samples/dfki-pavoque-neutral-hsmm.wav?raw=true) |
| [enst-camille-hsmm](https://github.com/marytts/voice-enst-camille-hsmm)                 | French (fr)     | Female   | [By-SA-3.0](licenses/BY-SA-3.0) | [Sample](samples/enst-camille-hsmm.wav?raw=true)         |
| [enst-dennys-hsmm](https://github.com/marytts/voice-enst-dennys-hsmm)                   | French (fr)     | Male     | [By-SA-3.0](licenses/BY-SA-3.0) | [Sample](samples/enst-dennys-hsmm.wav?raw=true)          |
| [upmc-jessica-hsmm](https://github.com/marytts/voice-upmc-jessica-hsmm)                 | French (fr)     | Female   | [By-ND-3.0](licenses/BY-ND-3.0) | [Sample](samples/upmc-jessica-hsmm.wav?raw=true)         |
| [upmc-pierre-hsmm](https://github.com/marytts/voice-upmc-pierre-hsmm)                   | French (fr)     | Male     | [By-ND-3.0](licenses/BY-ND-3.0) | [Sample](samples/upmc-pierre-hsmm.wav?raw=true)          |
| [istc-lucia-hsmm](https://github.com/marytts/voice-istc-lucia-hsmm)                     | Italian (it)    | Female   | [By-ND-3.0](licenses/BY-ND-3.0) | [Sample](samples/istc-lucia-hsmm.wav?raw=true)           |
| [ac-irina-hsmm](https://github.com/marytts/voice-ac-irina)                              | Russian (ru)    | Female   | [By-SA-3.0](licenses/BY-SA-3.0) | [Sample](samples/ac-irina-hsmm.wav?raw=true)             |
| [stts-sv-hb-hsmm](https://github.com/HaraldBerthelsen/voice-stts-sv-hb-hsmm)            | Swedish (sv)    | Male     | Unknown                         | [Sample](samples/stts-sv-hb-hsmm.wav?raw=true)           |
| [cmu-nk-hsmm](https://github.com/marytts/voice-cmu-nk-hsmm)                             | Telugu (te)     | Female   | [By-ND-3.0](licenses/BY-ND-3.0) | [Sample](samples/cmu-nk-hsmm.wav?raw=true)               |
| [dfki-ot-hsmm](https://github.com/marytts/voice-dfki-ot-hsmm)                           | Turkish (tr)    | Male     | [By-ND-3.0](licenses/BY-ND-3.0) | [Sample](samples/dfki-ot-hsmm.wav?raw=true)              |
