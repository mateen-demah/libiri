package com.kinsaga.libiri

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.Log
import com.hover.sdk.api.Hover
import com.hover.sdk.api.HoverParameters

class MainActivity: FlutterActivity() {
  private val CHANNEL = "kinsaga.libiri/hover"

  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
      // This method is invoked on the main thread.
      call, result ->
      if (call.method == "allowco") {
        Hover.initialize(this);
        val coallowed = allowco()

        if (coallowed == true) {
          result.success("Cashout allowed")
        } else {
          result.error("FAILED", "something went wrong", null)
        }
      } else {
        result.notImplemented()
      }
    }
  }

  private fun allowco(): Boolean {
    // val batteryLevel: Int
    // if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
    //   val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
    //   batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
    // } else {
    //   val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
    //   batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
    // }

    // return batteryLevel
    try {
        Log.d("MainActivity", "Sims are = " + Hover.getPresentSims(this));
        Log.d("MainActivity", "Hover actions are = " + Hover.getAllValidActions(this));
    } catch (e: Exception) {
        Log.e("MainActivity", ">>>>>>>>>>>>>>>>>>>>hover exception<<<<<<<<<<<<<<<<<<<<", e);
    }

    try {
        val intent = HoverParameters.Builder(this)
            .request("d8c6993f").buildIntent()

        startActivityForResult(intent, 0)
        return true
    } catch (e: Exception) {
        Log.e("MainActivity", ">>>>>>>>>hover exception<<<<<<<<<<<", e);
        return false
    }
  }

}
