class Config {
  static String env = "";

  //接口的host
  static String get apiHost {
    switch (env) {
      case "devel":
        return "http://113.96.190.67:18085";
      case "prod":
        return "https://fi.rosuntrade.top/fiapi";
      default:
        return "http://113.96.190.67:18085";
    }
  }

  static String get packageName {
    switch (env) {
      case "devel":
        return "top.rosun.dev";
      case "prod":
        return "com.rosun.fi";
      default:
        return "top.rosun.dev";
    }
  }

  static String get appName {
    switch (env) {
      case "devel":
        return "Rosun Fi dev";
      case "prod":
        return "Rosun Fi";
      default:
        return "Rosun Fi dev";
    }
  }

  static String get appId {
    switch (env) {
      case "devel":
        return "IDA5lCoV";
      case "prod":
        return "IDAo782h";
      default:
        return "IDA5lCoV";
    }
  }

  static String get keyLisence {
    switch (env) {
      case "devel":
        return "dSAyA5QQtKqnZ6BxuYR+IcI52GndEW9TYE7rxS1kGHUI+N5gH8Bs3ghTtwBxMIv124dU/3VPE+pK/Ewm0Tc1ISAow+fTJpE2dF3x+W1YduHdETlSIuo2+nICf1zRDPRgHSsh8o07Xy0N8P89WpIE9+VKt1kF+ngZGjJFot09OTlf6sDpnrn2OdCuptPGSJbarwMW6vlJ/LUOFsInzvMoUzr/7bPN2uX/EaU1yr9J4Hq12GQDMTl+3t848UWb0dvjD1gpzsJj/SGzPJe6uDeGY64DTLNdctEaMF4CqXp9OeKqDaQXLjJY0YSf6/2MhKRdhNxyZ+O3XDLK5Sdy2rFk/A==";
      case "prod":
        return "Nq2xCDZBzSrA0lCDY/PuaytvbC5nwm9mpK8sTb6EY/uexAT4H5ViQ84dhvbMw0S3t8WEP289Aaiaxsmr9bTuDoZsGUGtiK28HhXctg7/RCbIwmOx9e+FlGdSzPLkCRt7gxRmVs+uM7S2z4Rx2uUrqKbBfw0j0D4naC9Vk9XaIluJi734BAj5cs8H3AOLEAyHvo0d2qkhm92yD3CRHh0fSXEZDfcIprae21d1shl6hEXcxE8l1LO0KcV+yj4gexvsHJ2y7r5HBwUZJtXVAMxEt8p1KoAzzTOV1zZZ7YzphQyHZ/Nc0pkf3FpvZBnGt/JogF9RdK+QLumiB1jHjQ41mw==";
      default:
        return "dSAyA5QQtKqnZ6BxuYR+IcI52GndEW9TYE7rxS1kGHUI+N5gH8Bs3ghTtwBxMIv124dU/3VPE+pK/Ewm0Tc1ISAow+fTJpE2dF3x+W1YduHdETlSIuo2+nICf1zRDPRgHSsh8o07Xy0N8P89WpIE9+VKt1kF+ngZGjJFot09OTlf6sDpnrn2OdCuptPGSJbarwMW6vlJ/LUOFsInzvMoUzr/7bPN2uX/EaU1yr9J4Hq12GQDMTl+3t848UWb0dvjD1gpzsJj/SGzPJe6uDeGY64DTLNdctEaMF4CqXp9OeKqDaQXLjJY0YSf6/2MhKRdhNxyZ+O3XDLK5Sdy2rFk/A==";
    }
  }
}
