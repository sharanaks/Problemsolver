import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:speech_to_text/speech_to_text.dart'
    as stt;
import 'package:flutter_tts/flutter_tts.dart';

import 'certificate_screen.dart';

void main() {
  runApp(const FarmerApp());
}

class FarmerApp extends StatelessWidget {
  const FarmerApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: 'Farmer Land App',

      theme: ThemeData(
        primarySwatch: Colors.green,
      ),

      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {

  late stt.SpeechToText _speech;

  final FlutterTts flutterTts =
      FlutterTts();

  final LocalAuthentication auth =
      LocalAuthentication();

  bool _isListening = false;

  String selectedLanguage =
      "English";

  String _text =
      "Press microphone and speak land number";

  @override
  void initState() {

    super.initState();

    _speech = stt.SpeechToText();
  }

  Future<void> speakText(
      String text) async {

    if (selectedLanguage ==
        "Kannada") {

      await flutterTts.setLanguage(
          "kn-IN");

    } else if (selectedLanguage ==
        "Hindi") {

      await flutterTts.setLanguage(
          "hi-IN");

    } else {

      await flutterTts.setLanguage(
          "en-US");
    }

    await flutterTts.speak(text);
  }

  void _listen() async {

    if (!_isListening) {

      await speakText(

        selectedLanguage ==
                "Kannada"

            ? "ದಯವಿಟ್ಟು ನಿಮ್ಮ ಜಮೀನು ಸಂಖ್ಯೆ ಹೇಳಿ"

            : selectedLanguage ==
                    "Hindi"

                ? "कृपया अपनी भूमि संख्या बताएं"

                : "Tell me your land number",
      );

      bool available =
          await _speech.initialize();

      if (available) {

        setState(() {
          _isListening = true;
        });

        _speech.listen(

          localeId:

              selectedLanguage ==
                      "Kannada"

                  ? "kn_IN"

                  : selectedLanguage ==
                          "Hindi"

                      ? "hi_IN"

                      : "en_US",

          onResult: (result) {

            setState(() {

              _text =
                  result.recognizedWords;
            });
          },
        );
      }

    } else {

      setState(() {
        _isListening = false;
      });

      _speech.stop();
    }
  }

  Future<bool> authenticateUser()
      async {

    bool authenticated = false;

    try {

      authenticated =
          await auth.authenticate(

        localizedReason:
            'Verify your identity',
      );

      if (authenticated) {

        ScaffoldMessenger.of(context)
            .showSnackBar(

          const SnackBar(
            content: Text(
              "Authentication Successful",
            ),
          ),
        );
      }

    } catch (e) {

      print(e);
    }

    return authenticated;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        width: double.infinity,

        decoration: BoxDecoration(

          gradient: LinearGradient(

            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,

            colors: [

              Colors.green.shade700,
              Colors.green.shade50,
            ],
          ),
        ),

        child: SafeArea(

          child: SingleChildScrollView(

            child: Padding(

              padding:
                  const EdgeInsets.all(20),

              child: Column(

                children: [

                  const SizedBox(height: 20),

                  const CircleAvatar(

                    radius: 60,

                    backgroundColor:
                        Colors.white,

                    child: Icon(
                      Icons.agriculture,
                      size: 70,
                      color: Colors.green,
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Text(

                    "Smart Farmer Land Assistant",

                    textAlign:
                        TextAlign.center,

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(

                    "Voice Based Land Record System",

                    textAlign:
                        TextAlign.center,

                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 40),

                  Container(

                    padding:
                        const EdgeInsets.all(25),

                    decoration: BoxDecoration(

                      color: Colors.white,

                      borderRadius:
                          BorderRadius.circular(
                              25),

                      boxShadow: const [

                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),

                    child: Column(

                      children: [

                        const Text(

                          "Choose Language",

                          style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        DropdownButton<String>(

                          value:
                              selectedLanguage,

                          isExpanded: true,

                          items: const [

                            DropdownMenuItem(
                              value: "English",
                              child:
                                  Text("English"),
                            ),

                            DropdownMenuItem(
                              value: "Kannada",
                              child:
                                  Text("ಕನ್ನಡ"),
                            ),

                            DropdownMenuItem(
                              value: "Hindi",
                              child:
                                  Text("हिंदी"),
                            ),
                          ],

                          onChanged: (value) {

                            setState(() {

                              selectedLanguage =
                                  value!;
                            });
                          },
                        ),

                        const SizedBox(height: 25),

                        Container(

                          width: double.infinity,

                          padding:
                              const EdgeInsets.all(
                                  20),

                          decoration:
                              BoxDecoration(

                            color:
                                Colors.green.shade50,

                            borderRadius:
                                BorderRadius.circular(
                                    20),

                            border: Border.all(
                              color:
                                  Colors.green.shade200,
                            ),
                          ),

                          child: Text(

                            _text,

                            textAlign:
                                TextAlign.center,

                            style:
                                const TextStyle(
                              fontSize: 22,
                              fontWeight:
                                  FontWeight.w500,
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        GestureDetector(

                          onTap: _listen,

                          child: Container(

                            height: 90,
                            width: 90,

                            decoration:
                                BoxDecoration(

                              shape:
                                  BoxShape.circle,

                              color: Colors.green,

                              boxShadow: [

                                BoxShadow(
                                  color:
                                      Colors.green.shade200,
                                  blurRadius: 15,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),

                            child: Icon(

                              _isListening
                                  ? Icons.mic
                                  : Icons.mic_none,

                              color: Colors.white,

                              size: 45,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        Text(

                          _isListening
                              ? "Listening..."
                              : "Tap microphone and say land number",

                          textAlign:
                              TextAlign.center,

                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),

                        const SizedBox(height: 30),

                        SizedBox(

                          width: double.infinity,
                          height: 55,

                          child:
                              ElevatedButton.icon(

                            icon: const Icon(
                              Icons.fingerprint,
                            ),

                            onPressed:
                                () async {

                              bool success =
                                  await authenticateUser();

                              if (success) {

                                Navigator.push(

                                  context,

                                  MaterialPageRoute(

                                    builder:
                                        (context) =>

                                            CertificateScreen(

                                      landNumber:
                                          _text,

                                      selectedLanguage:
                                          selectedLanguage,
                                    ),
                                  ),
                                );
                              }
                            },

                            style:
                                ElevatedButton.styleFrom(

                              backgroundColor:
                                  Colors.green,

                              foregroundColor:
                                  Colors.white,

                              shape:
                                  RoundedRectangleBorder(

                                borderRadius:
                                    BorderRadius.circular(
                                        15),
                              ),
                            ),

                            label: const Text(

                              "Verify Identity",

                              style: TextStyle(
                                fontSize: 18,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}