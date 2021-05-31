import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';

class FormatDateConstants {
  static const String dateTimeSearch = "yyyyMMdd";

  static String getDDMMYYFromStringDate(String strDate) {
    if (strDate.isEmpty) return "";
    var date = new DateFormat("MM/dd/yyyy hh:mm:ss aaa").parse(strDate);
    var result = formatDate(date, [dd, '/', mm, '/', yyyy]);
    return result;
  }

  static String getDDMMHHMMFromStringDate(String strDate) {
    if (strDate.isEmpty) return "";
    var date = new DateFormat("MM/dd/yyyy hh:mm:ss aaa").parse(strDate);
    var result = formatDate(date, [dd, '/', mm, ' ', HH, ':', nn]);
    return result;
  }

  static String converDateFormatddmmyyy(String strDate) {
    if (strDate.isEmpty) return "";
    var date = new DateFormat("MM/dd/yyyy hh:mm:ss aaa").parse(strDate);
    var result =
        formatDate(date, [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn, ':', ss]);
    return result;
  }

  static String converDateToHour(String strDate) {
    if (strDate.isEmpty) return "";
    var date = new DateFormat("MM/dd/yyyy hh:mm:ss aaa").parse(strDate);
    if (strDate.contains("PM")) {
      date.add(new Duration(hours: 12));
    }
    var result = formatDate(date, [HH, ':', nn]);
    return result;
  }

  static String getHHMMFromStringDate(String strDate) {
    if (strDate.isEmpty) return "";

    var date = new DateFormat("dd/MM/yyyy HH:mm").parse(strDate);
    var result = formatDate(date, [dd, '/', mm, ' ', HH, ':', nn]);
    return result;
  }

  static String getMMDDYYFromSDDMMYYYtringDate(String strDate) {
    if (strDate.isEmpty) return "";

    var date = new DateFormat("dd/MM/yyyy").parse(strDate);
    var result = formatDate(date, [mm, '/', dd, '/', yyyy]);
    return result;
  }

  static String getCurrentDate() {
    var result =
        formatDate(DateTime.now(), [mm, '/', dd, '/', yyyy, ' ', HH, ':', nn]);
    return result;
  }

  static String getCurrentDateDDMMYYYY() {
    var result = formatDate(DateTime.now(), [dd, '/', mm, '/', yyyy]);
    return result;
  }

  static String convertMiliseconstoDate(String date) {
    String strdate;
    if (date?.isEmpty ?? true) {
      strdate = "";
    } else {
      int milliseconds =
          int.parse(date.replaceAll('/Date(', '').replaceAll('+0700)/', ''));
      strdate =
          DateTime.fromMicrosecondsSinceEpoch(milliseconds * 1000).toString();
    }
    return strdate;
  }

  static String getCurrentDateMMDDYYYY() {
    var result = formatDate(DateTime.now(), [mm, '/', dd, '/', yyyy]);
    return result;
  }

  static String convertMilisecondToUTCDateTime(String date) {
    String strdate;
    if (date?.isEmpty ?? true) {
      strdate = "";
    } else {
      int milliseconds =
          int.parse(date.replaceAll('/Date(', '').replaceAll('+0700)/', ''));
      strdate =
          DateTime.fromMicrosecondsSinceEpoch(milliseconds * 1000).toString();
    }
    return strdate;
  }

  static String convertUTCDateTimeLong(int date) {
    if (date == null) {
      return "";
    }
    var result = formatDate(
        DateTime.fromMicrosecondsSinceEpoch(date * 1000)
            .add(Duration(hours: -7)),
        [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn]);
    return result;
  }

  static String convertUTCDateShort(int date) {
    var result = formatDate(
        DateTime.fromMicrosecondsSinceEpoch(date * 1000)
            .add(Duration(hours: -7)),
        [HH, ':', nn, ' ', dd, '/', mm]);
    return result;
  }

  static String convertUTCDateTimeShort(int date) {
    var result = formatDate(DateTime.fromMicrosecondsSinceEpoch(date * 1000),
        [dd, '/', mm, ' ', HH, ':', nn]);
    return result;
  }

  static String convertUTCDate(int date) {
    if (date == null) {
      return "";
    }
    var result = formatDate(DateTime.fromMicrosecondsSinceEpoch(date * 1000),
        [dd, '/', mm, '/', yyyy]);
    return result;
  }

  static String convertUTCTime(int date) {
    var result = formatDate(
        DateTime.fromMicrosecondsSinceEpoch(date * 1000), [HH, ':', nn]);
    return result;
  }

  static DateTime convertJsonDateToDateTime(String jsonDate) {
    if (jsonDate.length != 19) {
      return null;
    }
    if (jsonDate == null || jsonDate.isEmpty) {
      return null;
    }
    jsonDate = jsonDate.replaceAll("T", " ");
    DateTime datetime = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(jsonDate);
    return datetime;
  }

  static String convertDateTimeToStringT(DateTime dateTime) {
    if (dateTime == null) {
      return  "";
    }
    return DateFormat('yyyy-MM-ddT00:00:00').format(dateTime);
  }

  static String convertDateTimeToDDMMYYYY(String jsonDate) {
    var datetime = convertJsonDateToDateTime(jsonDate);
    var strDatetime = formatDate(datetime, [dd, '-', mm, '-', yyyy]);
    return strDatetime;
  }

  static String convertDateTimeToString(DateTime dateTime) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    return formattedDate;
  }
}
