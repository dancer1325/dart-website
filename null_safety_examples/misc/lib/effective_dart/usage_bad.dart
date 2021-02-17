// ignore_for_file: avoid_init_to_null, empty_constructor_bodies, final_not_initialized_constructor_1, prefer_is_not_empty, sort_constructors_first, type_annotate_public_apis, type_init_formals, unnecessary_brace_in_string_interps, unnecessary_getters_setters, unused_element, unused_local_variable, prefer_equal_for_default_values, use_rethrow_when_possible, prefer_is_empty, prefer_iterable_wheretype
import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'usage_good.dart';

class EnableableThing {
  bool isEnabled;
  EnableableThing(this.isEnabled);
}

void miscDeclAnalyzedButNotTested() {
  {
    dynamic optionalThing;
    // #docregion convert-null-equals
    // If you want null to be false:
    if (optionalThing?.isEnabled == true) {
      print("Have enabled thing.");
    }

    // If you want null to be true:
    if (optionalThing?.isEnabled != false) {
      print("Have enabled thing or nothing.");
    }
    // #enddocregion convert-null-equals
  }

  {
    // #docregion adjacent-strings-literals
    raiseAlarm('ERROR: Parts of the spaceship are on fire. Other ' +
        'parts are overrun by martians. Unclear which are which.');
    // #enddocregion adjacent-strings-literals
  }

  (String name, int year, int birth) {
    // #docregion string-interpolation
    'Hello, ' + name + '! You are ' + (year - birth).toString() + ' y...';
    // #enddocregion string-interpolation
  };

  (name, decade) {
    // #docregion string-interpolation-avoid-curly
    var greeting = 'Hi, ${name}! I love your ${decade}s costume.';
    // #enddocregion string-interpolation-avoid-curly
  };

  {
    // #docregion collection-literals
    var addresses = Map<String, Address>();
    var counts = Set<int>();
    // #enddocregion collection-literals
  }

  (Iterable lunchBox, Iterable words) {
    // #docregion dont-use-length
    if (lunchBox.length == 0) return 'so hungry...';
    if (!words.isEmpty) return words.join(' ');
    // #enddocregion dont-use-length
    return 'foo';
  };

  (Iterable people) {
    // #docregion avoid-forEach
    people.forEach((person) {
      /*...*/
    });

    // #enddocregion avoid-forEach
  };

  {
    // #docregion where-type
    var objects = [1, "a", 2, "b", 3];
    var ints = objects.where((e) => e is int);
    // #enddocregion where-type
  }

  {
    // #docregion cast-list
    var stuff = <dynamic>[1, 2];
    var ints = stuff.toList().cast<int>();
    // #enddocregion cast-list
  }

  {
    // #docregion cast-map
    var stuff = <dynamic>[1, 2];
    var reciprocals = stuff.map((n) => 1 / (n as int)).cast<double>();
    // #enddocregion cast-map
  }

  // #docregion cast-at-create
  List<int> singletonList(int value) {
    var list = []; // List<dynamic>.
    list.add(value);
    return list.cast<int>();
  }
  // #enddocregion cast-at-create

  // #docregion cast-iterate
  void printEvens(List<Object> objects) {
    // We happen to know the list only contains ints.
    for (var n in objects.cast<int>()) {
      if (n.isEven) print(n);
    }
  }
  // #enddocregion cast-iterate

  // #docregion cast-from
  int median(List<Object> objects) {
    // We happen to know the list only contains ints.
    var ints = objects.cast<int>();
    ints.sort();
    return ints[ints.length ~/ 2];
  }
  // #enddocregion cast-from

  {
    // #docregion where-type-2
    var objects = [1, "a", 2, "b", 3];
    var ints = objects.where((e) => e is int).cast<int>();
    // #enddocregion where-type-2
  }

  {
    // #docregion func-decl
    void main() {
      var localFunction = () {
        /*...*/
      };
    }
    // #enddocregion func-decl
  }

  (Iterable names) {
    // #docregion use-tear-off
    names.forEach((name) {
      print(name);
    });
    // #enddocregion use-tear-off
  };

  {
    // #docregion default-separator
    void insert(Object item, {int at: 0}) {/* ... */}
    // #enddocregion default-separator
  }

  {
    // #docregion default-value-null
    void error([String? message = null]) {
      stderr.write(message ?? '\n');
    }
    // #enddocregion default-value-null
  }

  {
    // ignore_for_file: only_throw_errors
    // #docregion rethrow
    try {
      somethingRisky();
    } catch (e) {
      if (!canHandle(e)) throw e;
      handle(e);
    }
    // #enddocregion rethrow
  }

  {
    // #docregion unnecessary-async
    Future<int> fastestBranch(Future<int> left, Future<int> right) async {
      return Future.any([left, right]);
    }
    // #enddocregion unnecessary-async
  }

  {
    // #docregion avoid-completer
    Future<bool> fileContainsBear(String path) {
      var completer = Completer<bool>();

      File(path).readAsString().then((contents) {
        completer.complete(contents.contains('bear'));
      });

      return completer.future;
    }
    // #enddocregion avoid-completer
  }

  // #docregion test-future-or
  Future<T> logValue<T>(FutureOr<T> value) async {
    if (value is T) {
      print(value);
      return value;
    } else {
      var result = await value;
      print(result);
      return result;
    }
  }
  // #enddocregion test-future-or

  (Map<Chest, Treasure> _opened) {
    // #docregion arrow-long
    Treasure? openChest(Chest chest, Point where) => _opened.containsKey(chest)
        ? null
        : _opened[chest] = (Treasure(where)..addAll(chest.contents));
    // #enddocregion arrow-long
  };
}

// #docregion this-dot-constructor
class ShadeOfGray {
  final int brightness;

  ShadeOfGray(int val) : brightness = val;

  ShadeOfGray.black() : this(0);

  // This won't parse or compile!
  // ShadeOfGray.alsoBlack() : black();
}
// #enddocregion this-dot-constructor

//----------------------------------------------------------------------------

class BadTeam extends Team {
  @override
  dynamic get log => null;

  @override
  // #docregion async-await
  Future<int> countActivePlayers(String teamName) {
    return downloadTeam(teamName).then((team) {
      if (team == null) return Future.value(0);

      return team.roster.then((players) {
        return players.where((player) => player.isActive).length;
      });
    }).catchError((e) {
      log.error(e);
      return 0;
    });
  }
  // #enddocregion async-await
}

//----------------------------------------------------------------------------

class Item {
  int get price => 0;
}

// #docregion no-null-init
Item? bestDeal(List<Item> cart) {
  Item? bestItem = null;

  for (var item in cart) {
    if (bestItem == null || item.price < bestItem.price) {
      bestItem = item;
    }
  }

  return bestItem;
}
// #enddocregion no-null-init

//----------------------------------------------------------------------------

// #docregion calc-vs-store1
class Circle1 {
  double radius;
  double area;
  double circumference;

  Circle1(double radius)
      : radius = radius,
        area = pi * radius * radius,
        circumference = pi * 2.0 * radius;
}
// #enddocregion calc-vs-store1

//----------------------------------------------------------------------------

// #docregion calc-vs-store2
class Circle2 {
  double _radius;
  double get radius => _radius;
  set radius(double value) {
    _radius = value;
    _recalculate();
  }

  double _area = 0.0;
  double get area => _area;

  double _circumference = 0.0;
  double get circumference => _circumference;

  Circle2(this._radius) {
    _recalculate();
  }

  void _recalculate() {
    _area = pi * _radius * _radius;
    _circumference = pi * 2.0 * _radius;
  }
}
// #enddocregion calc-vs-store2

//----------------------------------------------------------------------------

// #docregion dont-wrap-field
class Box {
  var _contents;
  get contents => _contents;
  set contents(value) {
    _contents = value;
  }
}
// #enddocregion dont-wrap-field

//----------------------------------------------------------------------------

// #docregion final
class Box1 {
  var _contents;
  get contents => _contents;
}
// #enddocregion final

//----------------------------------------------------------------------------

// #docregion this-dot
class Box2 {
  var value;

  void clear() {
    this.update(null);
  }

  void update(value) {
    this.value = value;
  }
}
// #enddocregion this-dot

//----------------------------------------------------------------------------

// #docregion field-init-at-decl
class ProfileMark {
  final String name;
  final DateTime start;

  ProfileMark(this.name) : start = DateTime.now();
  ProfileMark.unnamed()
      : name = '',
        start = DateTime.now();
}
// #enddocregion field-init-at-decl

//----------------------------------------------------------------------------

// #docregion field-init-as-param
class Point0 {
  double x, y;
  Point0(double x, double y)
      : x = x,
        y = y;
}
// #enddocregion field-init-as-param

//----------------------------------------------------------------------------

// #docregion dont-type-init-formals
class Point1 {
  double x, y;
  Point1(double this.x, double this.y);
}
// #enddocregion dont-type-init-formals

//----------------------------------------------------------------------------

// #docregion semicolon-for-empty-body
class Point2 {
  double x, y;
  Point2(this.x, this.y) {}
}
// #enddocregion semicolon-for-empty-body

//----------------------------------------------------------------------------
// ignore_for_file: unnecessary_const, unnecessary_new

void unnecessaryNewOrConst() {
  // #docregion no-new
  Widget build(BuildContext context) {
    return new Row(
      children: [
        new RaisedButton(
          child: new Text('Increment'),
        ),
        new Text('Click!'),
      ],
    );
  }
  // #enddocregion no-new

  {
    // #docregion no-const
    const primaryColors = const [
      const Color("red", const [255, 0, 0]),
      const Color("green", const [0, 255, 0]),
      const Color("blue", const [0, 0, 255]),
    ];
    // #enddocregion no-const
  }
}
