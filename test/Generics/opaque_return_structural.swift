// RUN: %target-typecheck-verify-swift -disable-availability-checking -enable-experimental-structural-opaque-types
// RUN: %target-swift-frontend -typecheck -debug-generic-signatures -disable-availability-checking -enable-experimental-structural-opaque-types %s 2>&1 | %FileCheck %s

protocol P {}
extension Int: P {}
struct S<T: P> {}

// CHECK-LABEL: Generic signature: <T where T : P>
func f0<T>(_ s: S<T>) -> some P { return 1 }

// CHECK-LABEL: Generic signature: <T where T : P>
func f1<T>() -> (some P, S<T>) { return (1, S()) }