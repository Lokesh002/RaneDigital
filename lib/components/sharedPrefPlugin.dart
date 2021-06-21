import 'package:shared_preferences/shared_preferences.dart';

class SavedDataPlugin {
  setUserName(String name) async {
    final savedUserName = await SharedPreferences.getInstance();
    await savedUserName.setString('userName', name);
  }

  Future<String> getUserName() async {
    final savedUserName = await SharedPreferences.getInstance();
    final name = savedUserName.getString('userName');
    if (name == null) {
      return null;
    } else
      return name;
  }

  setGenId(String name) async {
    final savedUserName = await SharedPreferences.getInstance();
    await savedUserName.setString('genId', name);
  }

  Future<String> getGenId() async {
    final savedUserName = await SharedPreferences.getInstance();
    final name = savedUserName.getString('genId');
    if (name == null) {
      return null;
    } else
      return name;
  }

//  setPhone(String name) async {
//    final savedUserName = await SharedPreferences.getInstance();
//    await savedUserName.setString('Phone', name);
//  }
//
//  Future<String> getPhone() async {
//    final savedUserName = await SharedPreferences.getInstance();
//    final name = savedUserName.getString('Phone');
//    if (name == null) {
//      return null;
//    } else
//      return name;
//  }

  setDepartment(String name) async {
    final savedUserName = await SharedPreferences.getInstance();
    await savedUserName.setString('department', name);
  }

  Future<String> getDepartment() async {
    final savedUserName = await SharedPreferences.getInstance();
    final name = savedUserName.getString('department');
    if (name == null) {
      return null;
    } else
      return name;
  }

  setUserId(String name) async {
    final savedUserName = await SharedPreferences.getInstance();
    await savedUserName.setString('userId', name);
  }

  Future<String> getUserId() async {
    final savedUserName = await SharedPreferences.getInstance();
    final name = savedUserName.getString('userId');
    if (name == null) {
      return null;
    } else
      return name;
  }

  setLineData(var lineData) async {
    final savedUserName = await SharedPreferences.getInstance();
    await savedUserName.setStringList('lineData', lineData);
  }

  Future<List<String>> getLineData() async {
    final savedUserName = await SharedPreferences.getInstance();
    final name = savedUserName.getStringList('lineData');
    if (name == null) {
      return null;
    } else
      return name;
  }
//  setAccessToken(String name) async {
//    final savedUserName = await SharedPreferences.getInstance();
//    await savedUserName.setString('AccessToken', name);
//  }
//
//  Future<String> getAccessToken() async {
//    final savedUserName = await SharedPreferences.getInstance();
//    final name = savedUserName.getString('AccessToken');
//    if (name == null) {
//      return null;
//    } else
//      return name;
//  }

//  setBalance(int name) async {
//    final savedUserName = await SharedPreferences.getInstance();
//
//    await savedUserName.setInt('Balance', name == null ? 0 : name);
//  }

//  Future<int> getBalance() async {
//    final savedUserName = await SharedPreferences.getInstance();
//    final name = savedUserName.getInt('Balance');
//    if (name == null) {
//      return 0;
//    } else
//      return name;
//  }

  setLoggedIn(bool name) async {
    final savedUserName = await SharedPreferences.getInstance();
    await savedUserName.setBool('LoggedIn', name);
  }

  Future<bool> getLoggedIn() async {
    final savedUserName = await SharedPreferences.getInstance();
    final name = savedUserName.getBool('LoggedIn');
    if (name == null) {
      return false;
    } else
      return name;
  }

  setAccountType(String name) async {
    final savedUserName = await SharedPreferences.getInstance();
    await savedUserName.setString('accountType', name);
  }

  Future<String> getAccountType() async {
    final savedUserName = await SharedPreferences.getInstance();
    final name = savedUserName.getString('accountType');
    if (name == null) {
      return null;
    } else
      return name;
  }

//To be coded for getting Image
  setProfileImage(String name) async {
    final savedUserName = await SharedPreferences.getInstance();
    await savedUserName.setString('photoURL', name);
  }

  Future<String> getProfileImage() async {
    final savedUserName = await SharedPreferences.getInstance();
    final name = savedUserName.getString('photoURL');
    if (name == null) {
      return null;
    } else
      return name;
  }

//  setPrimaryColor(int name) async {
//    final savedUserName = await SharedPreferences.getInstance();
//    await savedUserName.setInt('PRIMARY', name);
//  }
//
//  Future<int> getPrimaryColor() async {
//    final savedUserName = await SharedPreferences.getInstance();
//    final name = savedUserName.getInt('PRIMARY');
//    if (name == null) {
//      return null;
//    } else
//      return name;
//  }
//
//  setAccentColor(int name) async {
//    final savedUserName = await SharedPreferences.getInstance();
//    await savedUserName.setInt('ACCENT', name);
//  }
//
//  Future<int> getAccentColor() async {
//    final savedUserName = await SharedPreferences.getInstance();
//    final name = savedUserName.getInt('ACCENT');
//    if (name == null) {
//      return null;
//    } else
//      return name;
//  }

  setPfuAccess(bool name) async {
    final savedUserName = await SharedPreferences.getInstance();
    await savedUserName.setBool('pfuAccess', name);
  }

  Future<bool> getPfuAccess() async {
    final savedUserName = await SharedPreferences.getInstance();
    final name = savedUserName.getBool('pfuAccess');
    if (name == null) {
      return null;
    } else
      return name;
  }

  setCssEditAccess(bool name) async {
    final savedUserName = await SharedPreferences.getInstance();
    await savedUserName.setBool('cssEditAccess', name);
  }

  Future<bool> getCssEditAccess() async {
    final savedUserName = await SharedPreferences.getInstance();
    final name = savedUserName.getBool('cssEditAccess');
    if (name == null) {
      return null;
    } else
      return name;
  }

  setCssViewAccess(bool name) async {
    final savedUserName = await SharedPreferences.getInstance();
    await savedUserName.setBool('cssViewAccess', name);
  }

  Future<bool> getCssViewAccess() async {
    final savedUserName = await SharedPreferences.getInstance();
    final name = savedUserName.getBool('cssViewAccess');
    if (name == null) {
      return null;
    } else
      return name;
  }

  setQssEditAccess(bool name) async {
    final savedUserName = await SharedPreferences.getInstance();
    await savedUserName.setBool('qssEditAccess', name);
  }

  Future<bool> getQssEditAccess() async {
    final savedUserName = await SharedPreferences.getInstance();
    final name = savedUserName.getBool('qssEditAccess');
    if (name == null) {
      return null;
    } else
      return name;
  }

  setQssViewAccess(bool name) async {
    final savedUserName = await SharedPreferences.getInstance();
    await savedUserName.setBool('qssViewAccess', name);
  }

  Future<bool> getQssViewAccess() async {
    final savedUserName = await SharedPreferences.getInstance();
    final name = savedUserName.getBool('qssViewAccess');
    if (name == null) {
      return null;
    } else
      return name;
  }

  setQssVerifyAccess(bool name) async {
    final savedUserName = await SharedPreferences.getInstance();
    await savedUserName.setBool('qssVerifyAccess', name);
  }

  Future<bool> getQssVerifyAccess() async {
    final savedUserName = await SharedPreferences.getInstance();
    final name = savedUserName.getBool('qssVerifyAccess');
    if (name == null) {
      return null;
    } else
      return name;
  }

  setCssVerifyAccess(bool name) async {
    final savedUserName = await SharedPreferences.getInstance();
    await savedUserName.setBool('cssVerifyAccess', name);
  }

  Future<bool> getCssVerifyAccess() async {
    final savedUserName = await SharedPreferences.getInstance();
    final name = savedUserName.getBool('cssVerifyAccess');
    if (name == null) {
      return null;
    } else
      return name;
  }

  setCssAddAccess(bool name) async {
    final savedUserName = await SharedPreferences.getInstance();
    await savedUserName.setBool('cssAddAccess', name);
  }

  Future<bool> getCssAddAccess() async {
    final savedUserName = await SharedPreferences.getInstance();
    final name = savedUserName.getBool('cssAddAccess');
    if (name == null) {
      return null;
    } else
      return name;
  }

  setQssAddAccess(bool name) async {
    final savedUserName = await SharedPreferences.getInstance();
    await savedUserName.setBool('qssAddAccess', name);
  }

  Future<bool> getQssAddAccess() async {
    final savedUserName = await SharedPreferences.getInstance();
    final name = savedUserName.getBool('qssAddAccess');
    if (name == null) {
      return null;
    } else
      return name;
  }

  setAddNewUserAccess(bool name) async {
    final savedUserName = await SharedPreferences.getInstance();
    await savedUserName.setBool('addNewUserAccess', name);
  }

  Future<bool> getAddNewUserAccess() async {
    final savedUserName = await SharedPreferences.getInstance();
    final name = savedUserName.getBool('addNewUserAccess');
    if (name == null) {
      return false;
    } else
      return name;
  }

  setAccessDept(List<String> name) async {
    final savedUserName = await SharedPreferences.getInstance();
    await savedUserName.setStringList('accessDept', name);
  }

  Future<List<String>> getAccessDept() async {
    final savedUserName = await SharedPreferences.getInstance();
    final name = savedUserName.getStringList('accessDept');
    if (name == null) {
      return null;
    } else
      return name;
  }

  setFTAEditAccess(bool name) async {
    final savedUserName = await SharedPreferences.getInstance();
    await savedUserName.setBool('FTAEditAcces', name);
  }

  Future<bool> getFTAEditAccess() async {
    final savedUserName = await SharedPreferences.getInstance();
    final name = savedUserName.getBool('FTAEditAcces');
    if (name == null) {
      return false;
    } else
      return name;
  }

  setFTAAddAccess(bool name) async {
    final savedUserName = await SharedPreferences.getInstance();
    await savedUserName.setBool('FTAAddAccess', name);
  }

  Future<bool> getFTAAddAccess() async {
    final savedUserName = await SharedPreferences.getInstance();
    final name = savedUserName.getBool('FTAAddAccess');
    if (name == null) {
      return false;
    } else
      return name;
  }

  setFTAViewAccess(bool name) async {
    final savedUserName = await SharedPreferences.getInstance();
    await savedUserName.setBool('FTAViewAccess', name);
  }

  Future<bool> getFTAViewAccess() async {
    final savedUserName = await SharedPreferences.getInstance();
    final name = savedUserName.getBool('FTAViewAccess');
    if (name == null) {
      return false;
    } else
      return name;
  }

  setFTADeleteAccess(bool name) async {
    final savedUserName = await SharedPreferences.getInstance();
    await savedUserName.setBool('FTADeleteAccess', name);
  }

  Future<bool> getFTADeleteAccess() async {
    final savedUserName = await SharedPreferences.getInstance();
    final name = savedUserName.getBool('FTADeleteAccess');
    if (name == null) {
      return false;
    } else
      return name;
  }
}
