import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class VideoRecording extends StatefulWidget {
  const VideoRecording({super.key});

  @override
  State<VideoRecording> createState() => _VideoRecordingState();
}

class _VideoRecordingState extends State<VideoRecording> {
  bool _hasPermission = false;
  bool _isSelfieMode = false;

  late CameraController _cameraController;

  @override
  void initState() {
    super.initState();
    _initPermissions();
  }

  Future<void> _initPermissions() async {
    final cameraPermission = await Permission.camera.request();
    final microphonePermission = await Permission.microphone.request();

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;
    final microphoneDenied = microphonePermission.isDenied ||
        microphonePermission.isPermanentlyDenied;

    if (!cameraDenied && !microphoneDenied) {
      _hasPermission = true;
      await _initCamera();
      setState(() {});
    }
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty) {
      return;
    }

    _cameraController = CameraController(
        cameras[_isSelfieMode ? 1 : 0], ResolutionPreset.ultraHigh);

    await _cameraController.initialize();
  }

  Future<void> _toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await _initCamera();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height,
        child: !_hasPermission || !_cameraController.value.isInitialized
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Requesting permissions ...",
                      style: TextStyle(color: Colors.white),
                    ),
                    Gaps.v20,
                    CircularProgressIndicator.adaptive(),
                  ],
                ),
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  CameraPreview(_cameraController),
                  Positioned(
                    top: Sizes.size16 + MediaQuery.of(context).padding.top,
                    left: Sizes.size16,
                    child: IconButton(
                      onPressed: _toggleSelfieMode,
                      icon: const Icon(Icons.cameraswitch),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
