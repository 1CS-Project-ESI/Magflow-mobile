class Commande {
  // Final properties ensure these values can't be changed after creation
  final DateTime date;
  final String typecommande;
  final int id;
  final int validation;
  final String number;

  // Constructor with required parameters
  Commande({
    required this.date,
    required this.typecommande,
    required this.id,
    required this.validation,
    required this.number,
  });

  // Factory constructor for creating a default Commande object
  static Commande defaultCommande() {
    return Commande(
      date: DateTime.now(),
      typecommande: 'Default',
      id: 0,
      validation: 0,
      number: "0",
    );
  }

  // Static method to parse JSON data (assuming a proper implementation)
  static fromJson(commandeJson) {
    // Implement logic to parse JSON data and create a Commande object
    // This might involve error handling and null checks
  }
}
