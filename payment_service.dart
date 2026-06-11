class PaymentService {
  Future<bool> pay(double amount) async {
    await Future.delayed(const Duration(seconds: 2));

    // You can later replace this with Stripe/JazzCash logic
    if (amount <= 0) return false;

    return true;
  }
}