import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
// Add imports for using MediaStore on Android
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_path_provider/android_path_provider.dart';

class AudioRecordPage extends StatefulWidget {
  const AudioRecordPage({Key? key}) : super(key: key);

  @override
  State<AudioRecordPage> createState() => _AudioRecordPageState();
}

class _AudioRecordPageState extends State<AudioRecordPage> {
  final Record _record = Record();
  final TextEditingController _controller = TextEditingController();

  Timer? _timer;
  int _time = 0;
  bool _isRecording = false;
  String? _audioPath;

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  Future<void> requestPermission() async {
    var microphoneStatus = await Permission.microphone.request();
    var storageStatus = await Permission.audio.request();

    print('Microphone Permission: $microphoneStatus');
    print('Storage Permission: $storageStatus');

    if (microphoneStatus != PermissionStatus.granted ||
        storageStatus != PermissionStatus.granted) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Permissions error'),
          content: Text(
              'This app needs microphone and storage permissions to function.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        _time++;
      });
    });
  }

  String _formatDuration(int seconds) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(seconds ~/ 3600);
    final minutes = twoDigits((seconds % 3600) ~/ 60);
    final secondsPart = twoDigits(seconds % 60);
    return [if (seconds >= 3600) hours, minutes, secondsPart].join(':');
  }

  Future<void> _startRecording() async {
    // Ensure permissions are granted
    await requestPermission();

    // Define the file name
    String fileName = 'recording_${DateTime.now().millisecondsSinceEpoch}.m4a';
    String? path;

    if (Platform.isAndroid) {
      // Use getExternalStorageDirectory for Android to save in app-specific directory
      final dir = await getExternalStorageDirectory();
      path = '${dir?.path}/$fileName';
    } else if (Platform.isIOS) {
      // For iOS, use the application documents directory
      final dir = await getApplicationDocumentsDirectory();
      path = '${dir.path}/$fileName';
    }

    // Start recording
    await _record.start(path: path);
    setState(() {
      _isRecording = true;
      _audioPath = path;
    });

    print('Recording started: $_audioPath');
  }

  Future<void> _stopRecording() async {
    final path = await _record.stop();
    _timer?.cancel();

    setState(() {
      _isRecording = false;
      _time = 0;
    });

    print('Recording stopped and saved to: $path');
  }

  @override
  void dispose() {
    _timer?.cancel();
    _record.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Recorder'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _isRecording ? null : _startRecording,
              child: Text(_isRecording ? 'Recording...' : 'Start Recording'),
            ),
            ElevatedButton(
              onPressed: !_isRecording ? null : _stopRecording,
              child: Text('Stop Recording'),
            ),
            SizedBox(height: 20),
            Text(
              'Record Duration: ${_formatDuration(_time)}',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
