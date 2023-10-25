import 'package:contacts_list/entities/contact_entity.dart';
import '../repositories/back4app_repository.dart';

class BackFourAppService {
  BackFourAppRepository backFourAppRepository = BackFourAppRepository();

  saveContact(ContactEntity contactEntity) {
    return backFourAppRepository.create(contactEntity);
  }

  getAllContact() {
    return backFourAppRepository.fetchAll();
  }

  upadateContact(ContactEntity contactEntity) {
    return backFourAppRepository.update(contactEntity);
  }

  deleteContact(String id) {
    return backFourAppRepository.delete(id);
  }
}
