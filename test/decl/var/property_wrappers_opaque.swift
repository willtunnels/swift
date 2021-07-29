// RUN: %target-typecheck-verify-swift -swift-version 5 -disable-availability-checking

protocol P { }

@propertyWrapper
struct WrapperWithDefaultInit<T> { // expected-note{{'T' declared as parameter to type 'WrapperWithDefaultInit'}}
  private var stored: T?

  var wrappedValue: T {
    get { stored! }
    set { stored = newValue }
  }

  init() {
    self.stored = nil
  }
}

// FB7699647 - crash with opaque result type and property wrappers.
struct FB7699647 {
  @WrapperWithDefaultInit var property: some P // expected-error{{generic parameter 'T' could not be inferred}}
  @WrapperWithDefaultInit() var otherProperty: some P // expected-error{{generic parameter 'T' could not be inferred}}
}

struct FB7699647b {
  @WrapperWithDefaultInit var property: some P // expected-error{{generic parameter 'T' could not be inferred}}
}
