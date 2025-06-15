class SentimentBarData {
  final int criterionId;
  final double positif;
  final double netral;
  final double negatif;

  const SentimentBarData({
    required this.criterionId,
    required this.positif,
    required this.netral,
    required this.negatif,
  });

  double get total => positif + netral + negatif;
}
