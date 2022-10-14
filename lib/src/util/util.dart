class Util {
  String urlValida(String url) {
    if (Uri.parse(url).isAbsolute) {
      return url;
    } else {
      return 'https://www.solvetic.com/uploads/tutorials/monthly_02_2018/264f3cdbfcb773a1da48921c2f7ce14d.png';
    }
  }
}
