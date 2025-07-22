
# Mantiene todo lo relacionado con Flutter
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Previene que se eliminen métodos anotados con @JavascriptInterface
-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}

# Para que no se eliminen anotaciones necesarias
-keepattributes *Annotation*

# Si usas Gson (JSON), añade esto:
-keep class com.google.gson.** { *; }
-keep class * implements com.google.gson.TypeAdapter

# Evita eliminar clases usadas en reflexión en general
-keepclassmembers class * {
    public <init>(...);
}

# Evita que R8 se queje por clases faltantes de componentes diferidos que no usas

-dontwarn com.google.android.play.core.**
-dontwarn io.flutter.embedding.engine.deferredcomponents.**
