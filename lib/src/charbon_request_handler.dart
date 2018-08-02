import "charbon_context.dart";

class CharbonRequestHandler {
  String get method => _method;
  String _method;

  String get path => _path;
  String _path;

  Function _handler;

  CharbonRequestHandler(this._method, this._path, this._handler);

  bool matches(CharbonContext charbonContext) {
    if (charbonContext.request.method == _method) {
      List<String> pathSegments = _path.split("/");
      List<String> requestPathSegments =
          charbonContext.request.uri.path.split("/");

      if (pathSegments.length == requestPathSegments.length) {
        for (int i = 0; i < pathSegments.length; i++) {
          String pathSegment = pathSegments[i];
          String requestPathSegment = requestPathSegments[i];

          if (!_match(pathSegment, requestPathSegment)) {
            return false;
          }
        }
        return true;
      }
    }

    return false;
  }

  bool _match(String pathNode, String requestNode) => pathNode == requestNode;

  void handle(CharbonContext charbonContext) {
    _handler(charbonContext);
  }
}