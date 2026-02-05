/// Short set code: first part before hyphen (e.g. DUNE-EN001 -> DUNE).
String shortSetCode(String setCode) {
  final i = setCode.indexOf('-');
  return i > 0 ? setCode.substring(0, i) : setCode;
}
