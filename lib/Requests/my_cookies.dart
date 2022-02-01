class MyCookies {
  final Map<String, String> cookies = {};
  final cookies_interested = [
    'connect.sid',
    '_abck',
    'bm_sz',
    '_flowbox',
    'bm_sv'
  ];
  String parse(String cookies) {
    List<List<String>> sss = [];
    for (String s in cookies.split(';')) {
      sss.add(s.split(','));
    }
    for (List<String> ss in sss) {
      List<String>? t_ss;
      if (ss.length == 1 && stringStartIntersted(ss[0])) {
        t_ss = ss[0].split('=');
      } else if (ss.length >= 2 && stringStartIntersted(ss[1])) {
        t_ss = ss[1].split('=');
      }
      if (t_ss != null) this.cookies[t_ss[0]] = t_ss[1];
    }
    return '';
  }

  String cookiesString() {
    String s = '';
    for (var k in cookies.keys) {
      s += '$k=${cookies[k]};';
    }
    return s;
  }

  bool stringStartIntersted(String s) {
    bool rtr = false;
    int l = cookies_interested.length;
    int i = 0;
    while (i < l && !rtr) {
      rtr = s.startsWith(cookies_interested[i++]);
    }
    return rtr;
  }
}
