import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter_tts/flutter_tts.dart';

class CertificateScreen extends StatefulWidget {

  final String landNumber;
  final String selectedLanguage;

  const CertificateScreen({
    super.key,
    required this.landNumber,
    required this.selectedLanguage,
  });

  @override
  State<CertificateScreen> createState() =>
      _CertificateScreenState();
}

class _CertificateScreenState
    extends State<CertificateScreen> {

  final FlutterTts flutterTts =
      FlutterTts();

  Map<String, dynamic> getLandData() {

    Map<String, dynamic> database = {

      "634": {
        "name": "Ramesh Gowda",
        "village": "Mysore",
        "area": "2 Acres",
      },

      "568": {
        "name": "Suresh Patil",
        "village": "Bangalore",
        "area": "5 Acres",
      },

      "846": {
        "name": "Lakshmi Devi",
        "village": "Mandya",
        "area": "3 Acres",
      },
    };

    return database[
            widget.landNumber.toLowerCase()] ??

        {
          "name": "Unknown Farmer",
          "village": "Not Found",
          "area": "No Data",
        };
  }

  Future<void> speakSuccess() async {

    if (widget.selectedLanguage ==
        "Kannada") {

      await flutterTts.setLanguage(
          "kn-IN");

      await flutterTts.speak(
        "ನಿಮ್ಮ ಪ್ರಮಾಣಪತ್ರ ಯಶಸ್ವಿಯಾಗಿ ಡೌನ್‌ಲೋಡ್ ಆಯಿತು",
      );

    } else if (widget.selectedLanguage ==
        "Hindi") {

      await flutterTts.setLanguage(
          "hi-IN");

      await flutterTts.speak(
        "आपका प्रमाण पत्र सफलतापूर्वक डाउनलोड हो गया",
      );

    } else {

      await flutterTts.setLanguage(
          "en-US");

      await flutterTts.speak(
        "Your certificate downloaded successfully",
      );
    }
  }

  Future<void> downloadCertificate()
      async {

    final pdf = pw.Document();

    final data = getLandData();

    pdf.addPage(

      pw.Page(

        build: (pw.Context context) {

          return pw.Column(

            crossAxisAlignment:
                pw.CrossAxisAlignment.start,

            children: [

              pw.Text(
                "Government Verified Land Certificate",

                style: pw.TextStyle(
                  fontSize: 24,

                  fontWeight:
                      pw.FontWeight.bold,
                ),
              ),

              pw.SizedBox(height: 20),

              pw.Text(
                "Land Number: ${widget.landNumber}",
              ),

              pw.SizedBox(height: 10),

              pw.Text(
                "Farmer Name: ${data["name"]}",
              ),

              pw.SizedBox(height: 10),

              pw.Text(
                "Village: ${data["village"]}",
              ),

              pw.SizedBox(height: 10),

              pw.Text(
                "Land Area: ${data["area"]}",
              ),

              pw.SizedBox(height: 30),

              pw.Center(

                child: pw.BarcodeWidget(
                  barcode:
                      pw.Barcode.qrCode(),

                  data:
                      widget.landNumber,

                  width: 150,
                  height: 150,
                ),
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(

      onLayout: (format) async =>
          pdf.save(),
    );
  }

  @override
  void initState() {

    super.initState();

    Future.delayed(

      const Duration(seconds: 1),

      () async {

        await downloadCertificate();

        await speakSuccess();

        if (mounted) {

          ScaffoldMessenger.of(context)
              .showSnackBar(

            const SnackBar(

              content: Text(
                "Certificate Generated Successfully",
              ),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    final data = getLandData();

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Land Certificate",
        ),

        backgroundColor:
            Colors.green,
      ),

      backgroundColor:
          Colors.green.shade50,

      body: SingleChildScrollView(

        child: Center(

          child: Padding(

            padding:
                const EdgeInsets.all(20),

            child: Card(

              elevation: 10,

              shape:
                  RoundedRectangleBorder(

                borderRadius:
                    BorderRadius.circular(20),
              ),

              child: Padding(

                padding:
                    const EdgeInsets.all(20),

                child: Column(

                  mainAxisSize:
                      MainAxisSize.min,

                  children: [

                    const Icon(
                      Icons.verified,
                      color: Colors.green,
                      size: 80,
                    ),

                    const SizedBox(height: 20),

                    const Text(

                      "Government Verified Land Certificate",

                      textAlign:
                          TextAlign.center,

                      style: TextStyle(
                        fontSize: 22,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 30),

                    ListTile(

                      leading:
                          const Icon(Icons.numbers),

                      title:
                          const Text("Land Number"),

                      subtitle:
                          Text(widget.landNumber),
                    ),

                    ListTile(

                      leading:
                          const Icon(Icons.person),

                      title:
                          const Text("Farmer Name"),

                      subtitle:
                          Text(data["name"]),
                    ),

                    ListTile(

                      leading:
                          const Icon(Icons.location_on),

                      title:
                          const Text("Village"),

                      subtitle:
                          Text(data["village"]),
                    ),

                    ListTile(

                      leading:
                          const Icon(Icons.landscape),

                      title:
                          const Text("Land Area"),

                      subtitle:
                          Text(data["area"]),
                    ),

                    const SizedBox(height: 20),

                    QrImageView(

                      data:
                          widget.landNumber,

                      version:
                          QrVersions.auto,

                      size: 220,
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}