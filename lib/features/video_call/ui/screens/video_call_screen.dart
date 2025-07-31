import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:telemedicine_platform_for_remote_areas/core/widgets/video_call.dart';


class VideoCallScreen extends StatefulWidget {
  final String channelName;
  final bool isIncoming;

  const VideoCallScreen({
    super.key,
    required this.channelName,
    this.isIncoming = false,
  });

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  bool _muted = false;
  bool _videoDisabled = false;
  bool _speakerOn = false;
  VideoCallService? _videoCallService;

  @override
  void initState() {
    super.initState();
    _initializeCall();
  }

  Future<void> _initializeCall() async {
    _videoCallService = context.read<VideoCallService>();
    await _videoCallService?.initializeAgora();
    await _videoCallService?.joinCall(
      widget.channelName,
      '', // Token - use empty for testing, implement token server for production
      0, // UID - 0 means auto-generate
    );
    setState(() {});
  }

  @override
  void dispose() {
    _videoCallService?.leaveCall();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          _buildVideoView(),
          _buildTopBar(),
          _buildBottomControls(),
        ],
      ),
    );
  }

  Widget _buildVideoView() {
    if (_videoCallService?.engine == null) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    return Stack(
      children: [
        // Remote video (full screen)
        _videoCallService!.remoteUid != null
            ? AgoraVideoView(
          controller: VideoViewController.remote(
            rtcEngine: _videoCallService!.engine!,
            canvas: VideoCanvas(uid: _videoCallService!.remoteUid), connection: RtcConnection(channelId: widget.channelName)
            ,
          ),
        )
            : Container(
          color: Colors.grey[900],
          child: const Center(
            child: Text(
              'Waiting for other participant to join...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),

        // Local video (small overlay)
        if (_videoCallService!.localUserJoined)
          Positioned(
            top: 100,
            right: 20,
            child: SizedBox(
              width: 120,
              height: 160,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: _videoDisabled
                    ? Container(
                  color: Colors.grey[800],
                  child: const Center(
                    child: Icon(
                      Icons.videocam_off,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                )
                    : AgoraVideoView(
                  controller: VideoViewController(
                    rtcEngine: _videoCallService!.engine!,
                    canvas: const VideoCanvas(uid: 0),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTopBar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withValues(alpha: 0.7),
              Colors.transparent,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Dr. AGM Reza',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      widget.isIncoming ? 'Incoming call...' : 'Connected',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomControls() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black.withValues(alpha: 0.8),
              Colors.transparent,
            ],
          ),
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildControlButton(
                icon: _muted ? Icons.mic_off : Icons.mic,
                onTap: _toggleMicrophone,
                isActive: !_muted,
              ),
              _buildControlButton(
                icon: _videoDisabled ? Icons.videocam_off : Icons.videocam,
                onTap: _toggleVideo,
                isActive: !_videoDisabled,
              ),
              _buildControlButton(
                icon: Icons.flip_camera_ios,
                onTap: _switchCamera,
                isActive: true,
              ),
              _buildControlButton(
                icon: _speakerOn ? Icons.volume_up : Icons.volume_down,
                onTap: _toggleSpeaker,
                isActive: _speakerOn,
              ),
              _buildControlButton(
                icon: Icons.call_end,
                onTap: _endCall,
                isActive: true,
                backgroundColor: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onTap,
    required bool isActive,
    Color? backgroundColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: backgroundColor ?? (isActive ? Colors.white.withValues(alpha: 0.2) : Colors.black.withValues(alpha: 0.5)),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }

  void _toggleMicrophone() {
    setState(() {
      _muted = !_muted;
    });
    _videoCallService?.toggleMicrophone(_muted);
  }

  void _toggleVideo() {
    setState(() {
      _videoDisabled = !_videoDisabled;
    });
    _videoCallService?.toggleVideo(_videoDisabled);
  }

  void _switchCamera() {
    _videoCallService?.toggleCamera();
  }

  void _toggleSpeaker() {
    setState(() {
      _speakerOn = !_speakerOn;
    });
    // Implement speaker toggle functionality
  }

  void _endCall() {
    Navigator.pop(context);
  }
}