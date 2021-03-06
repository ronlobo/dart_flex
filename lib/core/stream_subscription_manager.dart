part of dart_flex;

class StreamSubscriptionManager {
  
  final Map<String, StreamSubscriptionEntry> _entries = <String, StreamSubscriptionEntry>{};
  
  StreamSubscriptionManager();
  
  void add(String ident, StreamSubscription subscription, {bool flushExisting: false}) {
    StreamSubscriptionEntry entry = _entries[ident];
    
    if (entry == null) entry = _entries[ident] = new StreamSubscriptionEntry();
    else if (flushExisting) entry.flush();
    
    entry.add(subscription);
  }
  
  void flushIdent(String ident) {
    StreamSubscriptionEntry entry = _entries[ident];
    
    if (entry != null) entry.flush();
  }
  
  void flushAll() {
    _entries.forEach(
      (_, StreamSubscriptionEntry entry) => entry.flush()    
    );
  }
}

class StreamSubscriptionEntry {
  
  List<StreamSubscription> _list = <StreamSubscription>[];
  
  StreamSubscriptionEntry();
  
  void add(StreamSubscription subscription) => _list.add(subscription);
  
  void flush() {
    _list.forEach(
        (StreamSubscription subscription) => subscription.cancel()
    );
    
    _list = <StreamSubscription>[];
  }
  
}