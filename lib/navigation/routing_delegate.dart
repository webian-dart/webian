import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webian/navigation/destinations/destination.dart';
import 'package:webian/navigation/destinations/destination_page.dart';

typedef DestinationPage PageBuilder(Destination destination);

abstract class RoutingDelegate extends RouterDelegate<Destination>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<Destination> {
  List<Destination> get destinations =>
      cache.pages.map((it) => it.destination).toList();

  final DestinationPagesCache cache = DestinationPagesCache();
  Map<Destination, PageBuilder> _routes;
  final Builder? underlayWidget;
  final Builder? overlayWidget;

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  RoutingDelegate({
    GlobalKey<NavigatorState>? key,
    Map<Destination, PageBuilder>? routes,
    this.underlayWidget,
    this.overlayWidget,
  })  : this._routes = routes ?? Map<Destination, PageBuilder>(),
        navigatorKey = key ?? GlobalKey<NavigatorState>() {
    cache.pages = (() {
      final dest = _extractStartDestination(_routes);
      assert(dest.isToSomewhere == true);
      final page = _routes[dest]?.call(dest);
      assert(page is DestinationPage);
      return List<DestinationPage>.from([page], growable: false);
    }());
  }

  static RoutingDelegate of(BuildContext context) {
    final delegate = Router.of(context).routerDelegate;
    assert(delegate is RoutingDelegate,
        'The Router.routerDelegate of this context\'s Router is not of the RoutingDriver type.');
    return delegate as RoutingDelegate;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (underlayWidget != null) underlayWidget as Widget,
        _navigator(context),
        if (overlayWidget != null) overlayWidget as Widget,
      ],
    );
  }

  Navigator _navigator(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: cache.pages,
      onPopPage: (route, result) {
        final page = cache.pages.lastWhere(
            (it) => it.destination.uri.path == route.settings.name,
            orElse: () => NowhereDestinationPage());
        if (page.isToNowhere || !page.destination.isHomeDestination) {
          return route.didPop(result);
        } else {
          return false;
        }
      },
    );
  }

  void onPopped(BuildContext context, Destination destination);

  @override
  Destination get currentConfiguration => cache.pages.last.destination;

  @override
  Future<void> setInitialRoutePath(Destination destination) {
    return SynchronousFuture<void>(null);
  }

  @override
  Future<void> setNewRoutePath(Destination destination) async {
    return SynchronousFuture<void>(null);
  }

  void printPages() {
    print("${describeIdentity(this)}.destinations:  $destinations");
    print("${describeIdentity(this)}.cachedPages:  ${cache.pages}");
  }

  static Destination _extractStartDestination(
      Map<Destination, PageBuilder> routes) =>
      routes.keys.firstWhere(
        (it) => it.uri.path == Destination.START_PATH,
        orElse: () => Destination.nowhere,
      );

  void update(List<Destination> destinations) {
    final pages = cache.copyPages;
    final oldDestination = pages.map((e) => e.destination);
    final List<DestinationPage> newPages = [];
    for (Destination destination in destinations) {
      if (oldDestination.contains(destination)) {
        final page = pages.firstWhere((it) => it.destination == destination);
        pages.remove(page);
        newPages.add(page);
      } else if (_routes.containsKey(destination)) {
        newPages.add(makeNewPageFor(destination));
      }
    }
    cache.pages = newPages;
  }

  DestinationPage makeNewPageFor(Destination destination) =>
      _routes[destination]?.call(destination) ?? NowhereDestinationPage();
}

class DestinationPagesCache {
  List<DestinationPage> _pages = List<DestinationPage>.unmodifiable([]);
  List<DestinationPage> get pages => _pages;
  List<DestinationPage> get copyPages => _pages.toList(growable: true);
  set pages(List<DestinationPage> value) {
    _pages = List<DestinationPage>.unmodifiable(value);
  }
}
