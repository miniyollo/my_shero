import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final ImagePicker _picker = ImagePicker();
  List<File> _imageFiles = []; // List to store multiple images

  Future<void> _takePicture() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        _imageFiles.add(File(photo.path)); // Add new image to the list
      });
    }
  }

  Future<void> requestPermissions() async {
    final status = await [
      Permission.camera,
      Permission.photos, // or Permission.storage for Android if saving images
    ].request();

    bool isCameraAccessPermitted = status[Permission.camera]?.isGranted ?? false;
    bool isStorageImagePermitted = status[Permission.photos]?.isGranted ?? false; // Change to Permission.storage for Android if appropriate

    print("Camera Access: $isCameraAccessPermitted");
    print("Storage Access: $isStorageImagePermitted");
  }

  Widget _buildGridView() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemCount: _imageFiles.length,
      itemBuilder: (context, index) {
        return Image.file(_imageFiles[index], fit: BoxFit.cover);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Camera Access")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: _imageFiles.isEmpty ? Text("No images captured") : _buildGridView(),
            ),
            ElevatedButton(
              onPressed: _takePicture,
              child: Text("Open Camera"),
            ),
            ElevatedButton(
              onPressed: requestPermissions,
              child: Text("Request Permissions"),
            ),
          ],
        ),
      ),
    );
  }
}
