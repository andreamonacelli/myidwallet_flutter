///Definition of the DocumentType interface, crucial to implement the Strategy Design Pattern
abstract class DocumentType{
  Future<String> recognizeTextFromImage(String imagePath);
}