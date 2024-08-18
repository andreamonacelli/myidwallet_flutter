///Definition of the DocumentType interface, crucial to implement the Strategy Design Pattern
abstract class DocumentType{
  Future<Map<String, Object?>> recognizeTextFromImage(String imagePath, String nation);
}