class CampeaoNetworkConstants {
  static const wsUrl = "http://192.168.0.17:8080/caldo-cana-campeao/";
  static const statusOk = 200;
  static final headers = {"Content-type": "application/json"};
  static const authorizationHeader = "Authorization";

  static addAuthorizationHeader(String token) {
    String userAuthorization = "Bearer " + token;
    CampeaoNetworkConstants.headers.update(
      authorizationHeader,
      (value) => userAuthorization,
      ifAbsent: () => userAuthorization,
    );
  }

  static removeAuthorizationHeader() {
    CampeaoNetworkConstants.headers.remove(authorizationHeader);
  }
}
