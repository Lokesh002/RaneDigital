//import 'package:shared_preferences/shared_preferences.dart';

class SavedData {
  static String username;
  static String genId;
  static String department;
  static String userId;
  static List<String> lineData = [];
  static bool loggedIn = false;
  static String accountType;
  static String photoURL;
  static bool pfuAccess;
  static bool cssEditAccess;
  static bool cssViewAccess;
  static bool cssVerifyAccess;

  static bool qssEditAccess;
  static bool qssViewAccess;
  static bool qssVerifyAccess;
  static bool cssAddAccess;
  static bool qssAddAccess;
  static bool addNewUserAccess = false;
  static List<String> accessDept = [];
  static bool ftaEditAccess = false;
  static bool ftaAddAccess = false;
  static bool ftaViewAccess = false;
  static bool ftaDeleteAccess = false;

  static setUserName(String name) {
    username = name;
  }

  static String getUserName() {
    final name = username;
    if (name == null) {
      return null;
    } else
      return name;
  }

  static setGenId(String name) {
    genId = name;
  }

  static String getGenId() {
    final name = genId;
    if (name == null) {
      return null;
    } else
      return name;
  }

  static setDepartment(String name) {
    department = name;
  }

  static String getDepartment() {
    final name = department;
    if (name == null) {
      return null;
    } else
      return name;
  }

  static setUserId(String name) {
    userId = name;
  }

  static String getUserId() {
    final name = userId;
    if (name == null) {
      return null;
    } else
      return name;
  }

  static setLineData(var name) {
    lineData = name;
  }

  static List<String> getLineData() {
    final name = lineData;
    if (name == null) {
      return null;
    } else
      return name;
  }

  static setLoggedIn(bool name) {
    loggedIn = name;
  }

  static bool getLoggedIn() {
    final name = loggedIn;
    if (name == null) {
      return false;
    } else
      return name;
  }

  static setAccountType(String name) {
    accountType = name;
  }

  static String getAccountType() {
    final name = accountType;
    if (name == null) {
      return null;
    } else
      return name;
  }

//To be coded for getting Image
  static setProfileImage(String name) {
    photoURL = name;
  }

  static String getProfileImage() {
    final name = photoURL;
    if (name == null) {
      return null;
    } else
      return name;
  }

  static setPfuAccess(bool name) {
    pfuAccess = name;
  }

  static bool getPfuAccess() {
    final name = pfuAccess;
    if (name == null) {
      return null;
    } else
      return name;
  }

  static setCssEditAccess(bool name) {
    cssEditAccess = name;
  }

  static bool getCssEditAccess() {
    final name = cssEditAccess;
    if (name == null) {
      return null;
    } else
      return name;
  }

  static setCssViewAccess(bool name) {
    cssViewAccess = name;
  }

  static bool getCssViewAccess() {
    final name = cssViewAccess;
    if (name == null) {
      return null;
    } else
      return name;
  }

  static setQssEditAccess(bool name) {
    qssEditAccess = name;
  }

  static bool getQssEditAccess() {
    final name = qssEditAccess;
    if (name == null) {
      return null;
    } else
      return name;
  }

  static setQssViewAccess(bool name) {
    qssViewAccess = name;
  }

  static bool getQssViewAccess() {
    final name = qssViewAccess;
    if (name == null) {
      return null;
    } else
      return name;
  }

  static setQssVerifyAccess(bool name) {
    qssVerifyAccess = name;
  }

  static bool getQssVerifyAccess() {
    final name = qssVerifyAccess;
    if (name == null) {
      return null;
    } else
      return name;
  }

  static setCssVerifyAccess(bool name) {
    cssVerifyAccess = name;
  }

  static bool getCssVerifyAccess() {
    final name = cssVerifyAccess;
    if (name == null) {
      return null;
    } else
      return name;
  }

  static setCssAddAccess(bool name) {
    cssAddAccess = name;
  }

  static bool getCssAddAccess() {
    final name = cssAddAccess;
    if (name == null) {
      return null;
    } else
      return name;
  }

  static setQssAddAccess(bool name) {
    qssAddAccess = name;
  }

  static bool getQssAddAccess() {
    final name = qssAddAccess;
    if (name == null) {
      return null;
    } else
      return name;
  }

  static setAddNewUserAccess(bool name) {
    addNewUserAccess = name;
  }

  static bool getAddNewUserAccess() {
    final name = addNewUserAccess;
    if (name == null) {
      return false;
    } else
      return name;
  }

  static setAccessDept(List<String> name) {
    accessDept = name;
  }

  static List<String> getAccessDept() {
    final name = accessDept;
    if (name == null) {
      return null;
    } else
      return name;
  }

  static setFTAEditAccess(bool name) {
    ftaEditAccess = name;
  }

  static bool getFTAEditAccess() {
    final name = ftaEditAccess;
    if (name == null) {
      return false;
    } else
      return name;
  }

  static setFTAAddAccess(bool name) {
    ftaAddAccess = name;
  }

  static bool getFTAAddAccess() {
    final name = ftaAddAccess;
    if (name == null) {
      return false;
    } else
      return name;
  }

  static setFTAViewAccess(bool name) {
    ftaViewAccess = name;
  }

  static bool getFTAViewAccess() {
    final name = ftaViewAccess;
    if (name == null) {
      return false;
    } else
      return name;
  }

  static setFTADeleteAccess(bool name) {
    ftaDeleteAccess = name;
  }

  static bool getFTADeleteAccess() {
    final name = ftaDeleteAccess;
    if (name == null) {
      return false;
    } else
      return name;
  }
}
