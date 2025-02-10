import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'appBrain.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;


late int _remoteUid=0;
late RtcEngine _engine;

class VideocallScreen extends StatefulWidget {
   VideocallScreen({super.key});

  @override

  State<VideocallScreen> createState() => _VideocallState();

}

class _VideocallState extends State<VideocallScreen> {

  @override
  void dispose() {
    _engine.leaveChannel();
    super.dispose();
  }
  @override
  void initState(){
    initAgora();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: _renderRemoteVideo(),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(150.0),
                child: Container(
                    height: 150, width: 150, child: _renderLocalPreview()),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 25.0, right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      icon: Icon(
                        Icons.call_end,
                        size: 44,
                        color: Colors.redAccent,
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Functions
  Future <void> initAgora()async {
    await [Permission.microphone, Permission.camera].request(); //علشان اوصل لل Mic/camra
    _engine = await RtcEngine.create(AgoraManager.appId);
    _engine.enableVideo();
    _engine.setEventHandler(
        RtcEngineEventHandler(
          joinChannelSuccess: (String channel, int uid, int elapsed) {
            print("local user $uid joined successfully");
          },
          userJoined: (int uid, int elapsed) {
            // player.stop();
            print("remote user $uid joined successfully");
            setState(() => _remoteUid = uid);
          },
          userOffline: (int uid, UserOfflineReason reason) {//لو الاتصال انقطع
            print("remote user $uid left call");
            setState(() => _remoteUid = 0);
            Navigator.of(context).pop(true);
          },
        )
    );

    await _engine.joinChannel(
        AgoraManager.token, AgoraManager.channelName, null, 0);

  }

  //current User View
  Widget _renderLocalPreview() {//دي للشخص الي عامل المكالمه
    return RtcLocalView.SurfaceView();
  }
//remote User View

  Widget _renderRemoteVideo() {//هنا الجخه الاخري
    if (_remoteUid != 0) {
      return RtcRemoteView.SurfaceView(
        uid: _remoteUid,
      );
    } else {
      return Text(
      "Calling …",
      style: Theme.of(context).textTheme.headlineMedium,
    textAlign: TextAlign.center,
    );
    }
    }
}
