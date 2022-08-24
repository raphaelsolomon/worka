class NotificationModel {
  bool? email;
  bool? login;
  bool? newsletter;
  bool? update;

  setEmail(email){
    this.email = email;
  }

  setLogin(login){
    this.login = login;
  }

  setNewsLetter(newsletter){
    this.newsletter = newsletter;
  }

  setUpdate(update){
    this.update = update;
  }

  NotificationModel({this.email, this.login, this.newsletter, this.update});

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
          email: json["email"],
          login: json["login"],
          newsletter: json["newsletter"],
          update: json["update"]);
}
