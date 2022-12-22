package com.vepiot.app


import android.os.Bundle
import android.os.PersistableBundle
import com.google.android.gms.common.ConnectionResult
import com.google.android.gms.common.GoogleApiAvailability
import io.flutter.embedding.android.FlutterFragmentActivity


class MainActivity: FlutterFragmentActivity() {
    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        checkGooglePlayServices()

        super.onCreate(savedInstanceState, persistentState)
    }

    override fun onResume() {
        checkGooglePlayServices()

        super.onResume()
    }

    private fun checkGooglePlayServices() {
        val api = GoogleApiAvailability.getInstance()
        val status = api.isGooglePlayServicesAvailable(this)
        if (status != ConnectionResult.SUCCESS) {
            api.makeGooglePlayServicesAvailable(this)
        }
    }

}
