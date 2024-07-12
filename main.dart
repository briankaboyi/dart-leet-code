void main() {
  print(Solution().maximumGain("cdbcbbaaabab", 4, 5));
}

class Solution {
  int maximumGain(String s, int x, int y) {
    var totalScore;

    RegExp abReg = RegExp(r'ab');
    RegExp baReg = RegExp(r'ba');

    Iterable<RegExpMatch> abMatches = abReg.allMatches(s);
    Iterable<RegExpMatch> baMatches = baReg.allMatches(s);
    if (x > y) {
      var result = matchesAlgo(s, abReg, abMatches);
      String updatedString = result['updatedString'];
      int count = result['count'] * x;
      var secondIteration =
          matchesAlgo(updatedString, baReg, baReg.allMatches(updatedString));
      totalScore = count + (secondIteration['count'] * y);
    } else {
      var result = matchesAlgo(s, baReg, baMatches);
      String updatedString = result['updatedString'];
      int count = result['count'] * y;
      var secondIteration =
          matchesAlgo(updatedString, abReg, abReg.allMatches(updatedString));
      totalScore = count + (secondIteration['count'] * x);
    }

    return totalScore;
  }
}

Map<String, dynamic> matchesAlgo(string, expression, matches) {
  int count = 0;
  String checkformatches(string, expression, matches) {
    int matches = expression.allMatches(string).length;
    if (expression.allMatches(string).length > 0) {
      count += matches;
      String replacedString = string.replaceAll(expression, '');

      return checkformatches(replacedString, expression, matches);
    }

    return string;
  }

  String updatedString = checkformatches(string, expression, matches);
  return {"count": count, 'updatedString': updatedString};
}
