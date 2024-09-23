enum ApiCallStatus { initial, success, failure }

enum NavItem { homePage, postPage, settingPage }

enum Lang { ar, en }

enum FormType { text, number, password, phone,email, date, color,
  multiline, dropdown, autoComplete, rTE, subDynForm,listSubDynForm }

enum UsrType { user,company }
enum JobCardType { user,company, userTender,companyTender }
enum PkgType { tender,job }

enum StepEnabling { sequential, individual }
enum ValidatorType {equalTo, notEmpty, textLength, phoneNumber, age, email }