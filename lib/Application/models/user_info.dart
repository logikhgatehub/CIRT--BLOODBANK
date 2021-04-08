class UserInfor {
  final String user_id,
      user_name,
      user_address,
      user_phone,
      user_blood_type,
      illness;
  final int points;
  final bool isEligible, hasIllness;

  UserInfor(
       {this.user_id,
      this.user_name,
      this.user_address,
      this.user_phone,
      this.user_blood_type,
      this.isEligible,
      this.points,
      this.illness,
      this.hasIllness});
}
