class UserAccount {
  late String _id, google_id, name, sex, birthdate;

  UserAccount(this._id, this.google_id, this.name, this.sex, this.birthdate);

  UserAccount.fromJSON(Map<String, dynamic> importMap) {
    _id = importMap['_id'] ?? '';
    google_id = importMap['google_id'] ?? '';
    name = importMap['name'] ?? 'John Doe';
    birthdate = importMap['birthdate'] ?? '';
  }
}
