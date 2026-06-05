enum Flavor {
  dev,
  prod,
}

class F {
  static late final Flavor appFlavor;

  static String get name => appFlavor.name;

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'dev';
      case Flavor.prod:
        return 'prod';
    }
  }

  static String get apiKey{
    switch (appFlavor) {
      case Flavor.dev:
        return '4EPEQPD29BS5RAGRJZ8HE33YR';
      case Flavor.prod:
        return '4EPEQPD29BS5RAGRJZ8HE33YR';
    }
  }

  static String get baseUrl{
    switch (appFlavor) {
      case Flavor.dev:
        return 'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/';
      case Flavor.prod:
        return 'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline';
    }
  }

}
