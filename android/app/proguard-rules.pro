# Flutter core rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-dontwarn io.flutter.embedding.**

# Preserve annotations, exceptions, and source file information for debugging
-keepattributes *Annotation*
-keepattributes Exceptions
-keepattributes SourceFile,LineNumberTable

# Remove logging in release builds
-assumenosideeffects class android.util.Log {
    public static *** d(...);
    public static *** v(...);
    public static *** i(...);
    public static *** w(...);
    public static *** e(...);
}

# Firebase rules
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.android.gms.**

# Stripe rules
-keep class com.stripe.android.** { *; }
-dontwarn com.stripe.android.**

# Razorpay rules
-keep class com.razorpay.** { *; }
-dontwarn com.razorpay.**

# OneSignal rules
-keep class com.onesignal.** { *; }
-dontwarn com.onesignal.**
-keep class com.google.android.gms.gcm.** { *; }
-dontwarn com.google.android.gms.gcm.**

# Provider rules (for provider package)
-keep class androidx.lifecycle.** { *; }
-dontwarn androidx.lifecycle.**
-keep class androidx.core.** { *; }
-dontwarn androidx.core.**

# GetX rules
-keep class get.** { *; }
-dontwarn get.**

# WebView rules
-keep class android.webkit.** { *; }
-dontwarn android.webkit.**

# Awesome Notifications rules
-keep class me.carda.awesome_notifications.** { *; }
-dontwarn me.carda.awesome_notifications.**

# Preserve your app model classes (replace with your package name)
-keep class com.example.myshop.model.** { *; }

# Prevent obfuscation of classes using reflection
-keepattributes Signature
-keepattributes EnclosingMethod