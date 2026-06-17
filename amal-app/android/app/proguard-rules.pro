-keep class com.amal.** { *; }
-keep class com.google.api.client.** { *; }
-keep class com.google.auth.** { *; }
-keep class com.google.common.** { *; }
-keep class com.google.protobuf.** { *; }

# Flutter
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Firebase
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }

# Hive
-keep class com.hive.** { *; }

# Local notifications
-keep class com.dexterous.** { *; }

# YouTube Player
-keep class com.youtube.** { *; }

# Preserve line numbers for debugging
-keepattributes SourceFile,LineNumberTable
-renamesourcefileattribute SourceFile

# Preserve custom exceptions
-keep public class * extends java.lang.Exception
-keep public class * extends java.lang.RuntimeException