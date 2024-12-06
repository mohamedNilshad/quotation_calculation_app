
String? validateEmptyField(String fieldName, String? value){
  if(value == null || value.isEmpty){
    return '$fieldName cannot be empty';
  }
  return null;
}
