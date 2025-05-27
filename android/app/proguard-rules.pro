# === Razorpay GPay Integration ===
-keep class com.google.android.apps.nbu.paisa.inapp.client.api.** { *; }
-dontwarn com.google.android.apps.nbu.paisa.inapp.client.api.**

# === Razorpay Core Classes ===
-keep class com.razorpay.** { *; }
-dontwarn com.razorpay.**

# === Keep Annotations that are referenced ===
-keep class proguard.annotation.Keep { *; }
-keep class proguard.annotation.KeepClassMembers { *; }

# === General Rules to Avoid Strip-Outs ===
-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}
-keepattributes *Annotation*, Signature
