import 'package:overlay_support/overlay_support.dart';
import 'package:flutter/material.dart';

class NotificationProvider {
  static onShowBasicNotification() {
    //notification title
    showSimpleNotification(Text("Timer is about to end..! :)"),
        background: Colors.red);
  }

  static onFixedShowBasicNotification() {
    showSimpleNotification(
      //notification title
      Text("Timer is about to end..! :)"),
      background: Colors.red,
      //auto dismiss off
      autoDismiss: false,
      trailing: Builder(
          builder: (context) => FlatButton(
                child: Text(
                  "dismiss",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => OverlaySupportEntry.of(context).dismiss(),
              )),
    );
  }

  //Show custom UI as you want
  //you can use the ShowOverlayNotification function
  static onCustomShowBasicNotification() {
    showOverlayNotification(
      (BuildContext context) => customUI(context),
      duration: Duration(seconds: 5),
    );
  }

  static Card customUI(context) => Card(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: SafeArea(
            child: ListTile(
          leading: SizedBox.fromSize(
            size: Size(40, 40),
            child: ClipOval(
              child: Container(
                child: Icon(Icons.timer,color: Colors.red,),
              ),
            ),
          ),
          title: Text("Custom Notification"),
          subtitle: Text("Timer is about to end...! :)"),
          trailing: IconButton(
              icon: Icon(Icons.close),
              color: Colors.red,
              onPressed: () => OverlaySupportEntry.of(context).dismiss()),
        )),
      );
}
