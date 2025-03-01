import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:tflite/tflite.dart';
import 'package:image/image.dart' as img; // For image processing

class WasteSegregationPage extends StatefulWidget {
  const WasteSegregationPage({super.key});

  @override
  _WasteSegregationPageState createState() => _WasteSegregationPageState();
}

class _WasteSegregationPageState extends State<WasteSegregationPage> {
  File? _image;
  Uint8List? _webImage; // For storing image bytes in Flutter Web
  final ImagePicker _picker = ImagePicker();
  String _wasteType = ''; // To store the classification result
  bool _isImageSelected = false; // To track if an image is selected
  bool _isClassified = false; // To track if an image is classified

  @override
  void initState() {
    super.initState();
    _loadModel(); // Load the TFLite model on app startup
  }

  // Load the TFLite model
  Future<void> _loadModel() async {
    String? res = await Tflite.loadModel(
      model:
          "assets/final_model.tflite", // Ensure model is added to pubspec.yaml
      labels: "assets/labels.txt", // Ensure the label file is added as well
    );
    print("Model loaded: $res");
  }

  @override
  void dispose() {
    Tflite.close(); // Close the TFLite when the widget is disposed
    super.dispose();
  }

  // Pick image using camera
  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        if (kIsWeb) {
          pickedFile.readAsBytes().then((bytes) {
            setState(() {
              _webImage = bytes;
              _image = null; // Clear mobile image reference
              _isImageSelected = true;
              _isClassified = false; // Reset classification
              _wasteType = ''; // Clear previous result
            });
          });
        } else {
          _image = File(pickedFile.path);
          _webImage = null; // Clear web image reference
          _isImageSelected = true;
          _isClassified = false; // Reset classification
          _wasteType = ''; // Clear previous result
        }
      });
    }
  }

  // Resize image to the required size for the model (assuming 224x224)
  Future<Uint8List?> _resizeImage(Uint8List imageBytes) async {
    final img.Image? image = img.decodeImage(imageBytes);
    if (image != null) {
      final resizedImage = img.copyResize(image, width: 224, height: 224);
      return Uint8List.fromList(img.encodeJpg(resizedImage));
    }
    return null;
  }

  // Classify waste type based on image
  Future<void> _classifyWasteType() async {
    if (_image != null || _webImage != null) {
      List? output;
      try {
        Uint8List? resizedImage;

        if (kIsWeb && _webImage != null) {
          // Resize the web image
          resizedImage = await _resizeImage(_webImage!);
        } else if (_image != null) {
          // For mobile, load and resize image
          final imageBytes = await _image!.readAsBytes();
          resizedImage = await _resizeImage(imageBytes);
        }

        if (resizedImage != null) {
          print("Image selected. Resizing successful.");

          if (_image != null) {
            // For mobile: Use path-based classification
            output = await Tflite.runModelOnImage(
              path: _image!.path, // For mobile
              numResults: 8, // Number of classes (adjust based on model)
              threshold: 0.5, // Confidence threshold
            );
          } else if (kIsWeb && resizedImage != null) {
            // For web: Use bytes-based classification
            output = await Tflite.runModelOnBinary(
              binary: resizedImage, // Provide resized image bytes
              numResults: 8, // Number of classes (adjust based on model)
              threshold: 0.5, // Confidence threshold
            );
          }
        } else {
          print('No image selected or image resizing failed.');
        }

        print("Model output: $output");

        // Handle the output from the model with proper null checks
        if (output != null && output.isNotEmpty && output[0] is Map) {
          final Map<dynamic, dynamic> firstResult = output[0];
          setState(() {
            _wasteType =
                firstResult['label']?.toString() ?? 'Unable to classify';
            _isClassified = true;
          });
        } else {
          setState(() {
            _wasteType = 'Unable to classify';
            _isClassified = true;
          });
        }
      } catch (e) {
        print("Error during classification: $e");
        setState(() {
          _wasteType = 'Error during classification';
          _isClassified = true;
        });
      }
    }
  }

  // Handle re-uploading or replacing image
  void _reuploadImage() {
    setState(() {
      _image = null;
      _webImage = null;
      _isImageSelected = false;
      _isClassified = false; // Reset classification status
      _wasteType = '';
    });
    _pickImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SingleChildScrollView(
        child: _buildContentPage(
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20.0),
              _buildInstructions(),
              const SizedBox(height: 20.0),
              _buildImageDisplay(),
              const SizedBox(height: 20.0),
              _buildActionButton(),
              const SizedBox(height: 20.0),
              _buildWasteTypeDisplay(), // Displays the classification result
              if (_isClassified) // Show re-upload button if classified
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ElevatedButton(
                    onPressed: _reuploadImage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[700],
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 5.0,
                    ),
                    child: const Text(
                      'Re-upload Image',
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContentPage(Widget content) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green[50]!, Colors.lightGreen[100]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: content,
      ),
    );
  }

  Widget _buildInstructions() {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Instructions:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              '1. Take a clear photo of the waste item.\n'
              '2. Ensure good lighting for accurate classification.\n'
              '3. Tap the button below to capture the photo and get waste classification.',
              style: TextStyle(fontSize: 16.0, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageDisplay() {
    return Center(
      child: kIsWeb
          ? _webImage == null
              ? Text(
                  'No image selected.',
                  style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.memory(
                    _webImage!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
          : _image == null
              ? Text(
                  'No image selected.',
                  style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.file(
                    _image!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
    );
  }

  Widget _buildActionButton() {
    return ElevatedButton.icon(
      onPressed: _isImageSelected ? _classifyWasteType : _pickImage,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green[700],
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5.0,
      ),
      icon: Icon(
        _isImageSelected ? Icons.check : Icons.camera_alt,
        color: Colors.white,
      ),
      label: Text(
        _isImageSelected ? 'Classify Waste' : 'Pick an Image',
        style: const TextStyle(fontSize: 16.0, color: Colors.white),
      ),
    );
  }

  Widget _buildWasteTypeDisplay() {
    return _isClassified
        ? Text(
            'Waste Type: $_wasteType',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.green[800],
            ),
            textAlign: TextAlign.center,
          )
        : const SizedBox();
  }
}
