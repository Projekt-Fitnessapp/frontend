class UserAccount {
  late String _id, google_id, imagePath, name, sex, birthdate, goal;

  UserAccount(this._id, this.google_id, this.imagePath, this.name, this.sex,
      this.birthdate, this.goal);

  UserAccount.fromJSON(Map<String, dynamic> importMap) {
    _id = importMap['_id'] ?? '';
    google_id = importMap['google_id'] ?? '';
    imagePath = importMap['imagePath'] ?? 'https://media.istockphoto.com/photos/close-up-photo-beautiful-amazing-she-her-lady-look-side-empty-space-picture-id1146468004?k=20&m=1146468004&s=612x612&w=0&h=oCXhe0yOy-CSePrfoj9d5-5MFKJwnr44k7xpLhwqMsY=';
    name = importMap['name'] ?? 'John Doe';
    birthdate = importMap['birthdate'] ?? '20';
    sex = importMap['sex'] ?? 'männlich';
    goal = importMap['goal'] ?? 'Muskeln aufbauen';
  }
}
