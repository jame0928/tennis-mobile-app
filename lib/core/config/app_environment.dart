enum Environment { staging, production }

class AppEnvironment {
  AppEnvironment._();

  static Environment current = Environment.staging;

  static String get baseUrl {
    switch (current) {
      case Environment.production:
        return 'https://api.example.com';
      case Environment.staging:
        return 'https://kitten-casualty-thousand.ngrok-free.dev';
    }
  }
}
