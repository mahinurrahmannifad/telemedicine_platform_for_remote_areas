
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';

class VideoCallService {
  static const String appId = "your_agora_app_id"; // Replace with your Agora App ID
  RtcEngine? _engine;
  bool _localUserJoined = false;
  int? _remoteUid;

  Future<bool> initializeAgora() async {
    await [Permission.microphone, Permission.camera].request();

    _engine = createAgoraRtcEngine();
    await _engine!.initialize(const RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine!.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          _localUserJoined = true;
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          _remoteUid = remoteUid;
        },
        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          _remoteUid = null;
        },
      ),
    );

    await _engine!.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine!.enableVideo();
    await _engine!.startPreview();

    return true;
  }

  Future<void> joinCall(String channelName, String token, int uid) async {
    await _engine?.joinChannel(
      token: token,
      channelId: channelName,
      uid: uid,
      options: const ChannelMediaOptions(),
    );
  }

  Future<void> leaveCall() async {
    await _engine?.leaveChannel();
  }

  Future<void> dispose() async {
    await _engine?.release();
  }

  bool get localUserJoined => _localUserJoined;
  int? get remoteUid => _remoteUid;
  RtcEngine? get engine => _engine;

  Future<void> toggleCamera() async {
    await _engine?.switchCamera();
  }

  Future<void> toggleMicrophone(bool muted) async {
    await _engine?.muteLocalAudioStream(muted);
  }

  Future<void> toggleVideo(bool disabled) async {
    await _engine?.muteLocalVideoStream(disabled);
  }
}