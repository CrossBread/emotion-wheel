# BLoC Architecture

See: [The Best Flutter Bloc Complete Course](https://www.youtube.com/watch?v=THCkkQ-V1-8&t=3993s)

## General API request Sequence Diagram

```mermaid

sequenceDiagram

    autonumber
    Note over User: HI
    %% Boxes Require Mermaid 9.4.0 / Android Studio Giraffe
    %% box Presentation
        actor User
        participant UI
        participant Bloc
        participant Repository
    %% end
    
    Note over UI: State: InitialStart
    Note over User: User wants to<br/>sync history.
    User->>UI: Taps Refresh
    
    UI->>Bloc: GetHistoryEvent(uuid)
    Bloc->>UI: yield HistoryLoading()
    
    Note over UI: State: Loading
    UI->>User: display LoadingWidget 
    
    Note right of Bloc: HistoryBloc has a reference to the<br/> corresponding Repository
    Bloc-)Repository: async getHistoryForUser(uuid)
    
    Note right of Repository: HistoryRepository has a reference to the<br/> corresponding API Data Provider
    Repository-)DataSource: async getRawHistoryForUser(uuid)
    
    Note right of DataSource: HistoryAPI accesses raw<br/>data via cloud/internet
    DataSource-)Network: async http.get(.../uuid);
    
    Note over Network: HTTP Response
    
    %% Return back up the Future<> chain    
    Network->>DataSource: JSON {"history": ...}
    DataSource->>Repository: return JSON String
    Repository->>Bloc: return HistoryModel
    
    alt is success
        Bloc->>UI: yield HistoryLoaded(history)
        
        Note over UI: State: HistoryLoaded
    else is failure
        Bloc->>UI: yield DataError(message)
        
        Note over UI: State: HistoryFailed
    end
        UI->>User: display ResultWidget 
    
```

Note: The Firebase API contains helpers and patterns that collapse parts of this architecture.</br>
For instance, a translator can be provided to the DataSource call so that it returns a model
object</br>
rather than raw JSON.
