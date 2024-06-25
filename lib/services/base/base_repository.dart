
import 'package:s_box/services/api/api_hitter.dart';

class BaseRepository {
  final apiHitter = ApiHitter();
  final dio = ApiHitter().getDio();
}
