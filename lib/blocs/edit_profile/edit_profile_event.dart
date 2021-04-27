abstract class EditProfileEvent {}

class OnChangeProfile extends EditProfileEvent {
  String name;
  String email;
  String mobileNumber;
  String information;
  OnChangeProfile({this.name, this.email, this.mobileNumber, this.information});
}
