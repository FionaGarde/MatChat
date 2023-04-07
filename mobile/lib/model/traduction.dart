import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matchat/globale.dart';

class Traduction {

 
  //un ou des constructeurs
  OnDeviceTranslator(
    {required this.sourceLanguage, required this.targetLanguage});

  //propriété
  external int get hashCode;
  final id = DateTime.now().microsecondsSinceEpoch.toString();
  external Type get runtimeType;
  final TranslateLanguage sourceLanguage;
  final TranslateLanguage targetLanguage;

  //méthode
  Future<void> close() =>
    _channel.invokeMethod('nlp#closeLanguageTranslator', {'id': id});

  dynamic noSuchMethod(
    Invocation invocation
  )
  dynamic object = 1;
  object.add(42); // Statically allowed, run-time error

  class MockList<T> implements List<T> {
    noSuchMethod(Invocation invocation) {
      log(invocation);
      super.noSuchMethod(invocation); // Will throw.
    }
  }
  void main() {
    MockList().add(42);
  }

  @pragma("vm:entry-point");
  @pragma("wasm:entry-point");
  external dynamic noSuchMethod(Invocation invocation);

  String toString();
  external String toString();

  bool operator ==(
    Object other
  );
  external bool operator ==(Object other);

}
