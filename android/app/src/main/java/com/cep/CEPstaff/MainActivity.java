package com.cep.CEPstaff;

import android.os.Bundle;
import io.flutter.app.FlutterFragmentActivity;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import androidx.annotation.NonNull;
import io.flutter.embedding.engine.FlutterEngine;


public class MainActivity extends FlutterFragmentActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
  }
  
//   @Override
//   public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
//     GeneratedPluginRegistrant.registerWith(flutterEngine);
//     new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
//             .setMethodCallHandler(
//                 (call, result) -> {
//                     // Your existing code
//             }
//     );
// }
}


  
