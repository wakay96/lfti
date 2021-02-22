import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

class IdGenerator {
  static String generateV4() {
    Uuid uuid = Uuid(options: {'grng': UuidUtil.cryptoRNG});
    return uuid.v4();
  }
}
