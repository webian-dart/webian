
class Data {
    
    static final empty = Data(Object());
    
    final dynamic data;
    
    Data(this.data);
    
    bool isEmpty() => this == empty;
    
    bool isNotEmpty() => !isEmpty();
    
}