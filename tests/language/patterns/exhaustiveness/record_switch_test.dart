// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// SharedOptions=--enable-experiment=patterns,records

enum Enum {a, b}
const r0 = (Enum.a, false);
const r1 = (Enum.b, false);
const r2 = (Enum.a, true);
const r3 = (Enum.b, true);

void exhaustiveSwitch((Enum, bool) r) {
  switch (r) /* Ok */ {
    case r0:
      print('(a, false)');
      break;
    case r1:
      print('(b, false)');
      break;
    case r2:
      print('(a, true)');
      break;
    case r3:
      print('(b, true)');
      break;
  }
}

void nonExhaustiveSwitch1((Enum, bool) r) {
  switch (r) /* Error */ {
//^^^^^^
// [analyzer] COMPILE_TIME_ERROR.NON_EXHAUSTIVE_SWITCH_STATEMENT
//        ^
// [cfe] The type '(Enum, bool)' is not exhaustively matched by the switch cases since it doesn't match '(Enum.b, false)'.
    case r0:
      print('(a, false)');
      break;
    case r2:
      print('(a, true)');
      break;
    case r3:
      print('(b, true)');
      break;
  }
}

void nonExhaustiveSwitch2((Enum, bool) r) {
  switch (r) /* Error */ {
//^^^^^^
// [analyzer] COMPILE_TIME_ERROR.NON_EXHAUSTIVE_SWITCH_STATEMENT
//        ^
// [cfe] The type '(Enum, bool)' is not exhaustively matched by the switch cases since it doesn't match '(Enum.a, false)'.
    case r1:
      print('(b, false)');
      break;
    case r2:
      print('(a, true)');
      break;
    case r3:
      print('(b, true)');
      break;
  }
}

void nonExhaustiveSwitchWithDefault((Enum, bool) r) {
  switch (r) /* Ok */ {
    case r0:
      print('(a, false)');
      break;
    default:
      print('default');
      break;
  }
}

void exhaustiveNullableSwitch((Enum, bool)? r) {
  switch (r) /* Ok */ {
    case r0:
      print('(a, false)');
      break;
    case r1:
      print('(b, false)');
      break;
    case r2:
      print('(a, true)');
      break;
    case r3:
      print('(b, true)');
      break;
    case null:
      print('null');
      break;
  }
}

void nonExhaustiveNullableSwitch1((Enum, bool)? r) {
  switch (r) /* Error */ {
//^^^^^^
// [analyzer] COMPILE_TIME_ERROR.NON_EXHAUSTIVE_SWITCH_STATEMENT
//        ^
// [cfe] The type '(Enum, bool)?' is not exhaustively matched by the switch cases since it doesn't match 'null'.
    case r0:
      print('(a, false)');
      break;
    case r1:
      print('(b, false)');
      break;
    case r2:
      print('(a, true)');
      break;
    case r3:
      print('(b, true)');
      break;
  }
}

void nonExhaustiveNullableSwitch2((Enum, bool)? r) {
  switch (r) /* Error */ {
//^^^^^^
// [analyzer] COMPILE_TIME_ERROR.NON_EXHAUSTIVE_SWITCH_STATEMENT
//        ^
// [cfe] The type '(Enum, bool)?' is not exhaustively matched by the switch cases since it doesn't match '(Enum.b, false)'.
    case r0:
      print('(a, false)');
      break;
    case r2:
      print('(a, true)');
      break;
    case r3:
      print('(b, true)');
      break;
    case null:
      print('null');
      break;
  }
}

void unreachableCase1((Enum, bool) r) {
  switch (r) /* Ok */ {
    case r0:
      print('(a, false) #1');
      break;
    case r1:
      print('(b, false)');
      break;
    case r2:
      print('(a, true)');
      break;
    case r3:
      print('(b, true)');
      break;
    case r0: // Unreachable
//  ^^^^
// [analyzer] HINT.UNREACHABLE_SWITCH_CASE
      print('(a, false) #2');
      break;
  }
}

void unreachableCase2((Enum, bool) r) {
  // TODO(johnniwinther): Should we avoid the unreachable error here?
  switch (r) /* Error */ {
    case r0:
      print('(a, false)');
      break;
    case r1:
      print('(b, false)');
      break;
    case r2:
      print('(a, true)');
      break;
    case r3:
      print('(b, true)');
      break;
    case null: // Unreachable
      print('null');
      break;
  }
}

void unreachableCase3((Enum, bool)? r) {
  switch (r) /* Ok */ {
    case r0:
      print('(a, false)');
      break;
    case r1:
      print('(b, false)');
      break;
    case r2:
      print('(a, true)');
      break;
    case r3:
      print('(b, true)');
      break;
    case null:
      print('null1');
      break;
    case null: // Unreachable
//  ^^^^
// [analyzer] HINT.UNREACHABLE_SWITCH_CASE
      print('null2');
      break;
  }
}
