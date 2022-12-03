import 'package:path_provider/path_provider.dart';

class Files {
  Future<List<Uri>> files(String url) async {
    final library = await getLibraryDirectory();
    final files = library.list(recursive: true);
    return files.map((e) => e.uri).toList();
  }
}
