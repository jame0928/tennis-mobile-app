class Registration {
  const Registration({
    required this.id,
    required this.tournamentCategoryId,
    required this.status,
    required this.paymentStatus,
  });

  final String id;
  final String tournamentCategoryId;
  final String status;
  final String paymentStatus;
}
