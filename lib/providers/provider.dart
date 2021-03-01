class ProviderOf<T> {
    
    Map<Symbol, dynamic> get items => Map.from(_items);
    Map<Symbol, dynamic> _items = Map();
    
    add(Symbol symbol, T item) {
        if (item != null && !has(symbol)) _items[symbol] = item;
    }
    
    remove(T item) {
        _items.removeWhere((key, value) => value == item);
    }
    
    bool has(Symbol symbol) {
        if(_items.isEmpty || symbol == null) return false;
        return _items.containsKey(symbol);
    }
    
    bool contains<E extends T>(Symbol symbol) {
        if(_canNotLookUp(symbol)) return false;
        return _items.containsKey(symbol) && _items[symbol] is E;
    }
    
    bool _canNotLookUp(Symbol symbol) {
        return _items.isEmpty || symbol == null;
    }
    
    E get<E extends T>(Symbol symbol) {
        if(contains<E>(symbol)) return _items[symbol] as E;
        return null;
    }
    
    E of<E extends T>() {
        if (_items.isEmpty) return null;
        var result = _items.values.firstWhere((value) {
            return value is E;
        }, orElse: () => null);
        return result;
    }
}
