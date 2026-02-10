## Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

## SQLite (required for Drift/sqlite3)
-keep class org.sqlite.** { *; }
-keep class sqlite.** { *; }

## Play Core (deferred components referenced by Flutter engine)
-dontwarn com.google.android.play.core.**
