# BLoC Architecture

## What is a BLoC?

Blocs are related to Cubits. So, what's a Cubit? Specifically, methods are defined on a Cubit that
emit a new state for the Cubit's. The state could be a simple primitive type like int or String or
it could be a complex custom object like MyAppState.

Blocs are similar, but rather than a method call, Blocs listen for events and emit new states in
response. Each event will result in zero or more states emitted to the Bloc's state stream. This
stream can be listened to by widgets in the UI which will rebuild themselves accordingly.

```mermaid
flowchart
subgraph BLoC
bui[UI]
bloc{{bloc}}
end

subgraph Cubits
cui[UI]
cubit{{cubit}}
end

bui -->|events| bloc
bloc -->|state| bui

cui -->|method calls|cubit
cubit -->|state|cui

```

**Definition:** A BLoC is a ***B***usiness ***Lo***gic ***C***omponent. They satisfy the role
of [Uncle Bob's "
Use Cases"](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html).

In Uncle Bob's (or Robert C. Martin's) words:
> ### Use Cases
> The software in this layer contains application specific business rules. It encapsulates and
> implements all of the use cases of the system. These use cases orchestrate the flow of data to and
> from the entities, and direct those entities to use their enterprise wide business rules to
> achieve
> the goals of the use case.
>
> We do not expect changes in this layer to affect the entities. We also do not expect this layer to
> be affected by changes to externalities such as the database, the UI, or any of the common
> frameworks. This layer is isolated from such concerns.
>
> We do, however, expect that changes to the operation of the application will affect the use-cases
> and therefore the software in this layer. If the details of a use-case change, then some code in
> this layer will certainly be affected.

Further, the **Entities** Uncle Bob mentions here are the **Models** in BLoC Architecture.

## Clean Architecture with BLoC

```mermaid
%%{init: {'theme':'dark'}}%%

flowchart LR
User((User)) <--> UI
UI <--> Bloc{{Bloc}}
Bloc <--> Repository
Repository <--> DataSource
DataSource <--> Network[(DB or\nNetwork\netc.)]
Network
```

```mermaid
flowchart LR

subgraph pres[Presentation]
User
UI
end

subgraph dom[Business Domain]
Bloc
IRepo[Repository\nInterface]
end

subgraph data[Data]
RepoImpl[Repository\nImplementation]
DataSource
end

%%pres <--> dom <--> data
%%pres -->|Events| dom
%%dom -->|States| pres

User((User)) -->|Interactions| UI
UI -->|Widgets| User
UI[UI\nFlutter] -->|== Events =>\n<= State Stream ==| Bloc[BLoC]
%%Bloc -->|States| UI

Bloc -->|Repo Methods or other BLoCs| IRepo
IRepo -->|Models| Bloc{{Bloc}}
IRepo <--> RepoImpl
RepoImpl -->|Query Parameters| DataSource
DataSource -->|JSON| RepoImpl
DataSource <-->|JSON to Raw Data| Network[(External\nInterfaces)]
```

## General API request Sequence Diagram

See: [The Best Flutter Bloc Complete Course @ 66:33](https://www.youtube.com/watch?v=THCkkQ-V1-8&t=3993s)

```mermaid
%%{init: {'theme':'dark'}}%%
sequenceDiagram

    autonumber
    %% Boxes Require Mermaid 9.4.0 / Android Studio Giraffe
    %% box Presentation
        actor User
        participant UI
        participant Bloc
        participant Repository
        participant DataSource
        participant Network
    %% end
    
    Note right of User: sdfs 
    Note right of UI: sdfs 
    Note right of Bloc: sdfs 
    Note right of Repository: sdfs 
    Note right of DataSource: sdfs 
    
    
    %% Interactions start:
    Note over User: User opens app
    
    Note over UI: State: InitialStart
    UI->>User: display InitialState 
    
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
