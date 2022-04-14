class UserModel {
  String? userId;
  String? userName;
  String? userEmail;

  UserModel(this.userId, this.userName, this.userEmail);

  UserModel.fromJson(Map<String, dynamic> json, {String? documentId}) {
    userId = documentId;
    userName = json['userName'];
    userEmail = json['userEmail'];
  }

  Map<String, Object?> toJson() {
    return {
      'userName': userName,
      'userEmail': userEmail,
    };
  }

  @override
  String toString() {
    return 'UserModel{userId: $userId, userName: $userName, userEmail: $userEmail}';
  }
}
