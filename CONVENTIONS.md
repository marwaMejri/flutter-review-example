# Conventions

The review agent reads this file from the base branch. To change a
convention, change this file in its own pull request.

The layers follow the
[Flutter guide to app architecture](https://docs.flutter.dev/app-architecture/guide).
Grouping the layers by feature is a team choice.

## Folders
- `lib/app/`: the app widget, the routes (`router.dart`) and the providers
  of the data sources and repositories (`app_providers.dart`). Only
  `lib/app/` imports from several features.
- `lib/core/`: code shared by the features: constants, theme, utils and
  shared widgets. `lib/core/` never imports a feature.
- `lib/features/<feature>/`: one feature, in three layers:
  - `data/`: `data_sources/`, `models/`, `repositories/`;
  - `domain/`: `entities/`, `repositories/`;
  - `presentation/`: `views/`, `view_models/`, `widgets/`.
- A feature never imports another feature. Code that two features need moves
  to `lib/core/`.
- `test/` has the same folders as `lib/`. Fakes go in
  `test/features/<feature>/fakes/`.

## Dependencies between layers
- `domain/` imports no other layer and no Flutter library: only Dart and
  `package:equatable`.
- `data/` imports `domain/`, never `presentation/`.
- `presentation/` imports `domain/`, never `data/`.
- Only `lib/app/app_providers.dart` creates data sources and repositories.

## Domain
- An entity extends `Equatable`, has only `final` fields and a `const`
  constructor, and lists every field in `props`.
- An entity has only the fields that the screens need.
- A repository is an `abstract interface class` in `domain/repositories/`. It
  returns entities, never models.

## Data
- A model has the shape of the backend answer. `fromJson` reads it and
  throws a `FormatException` when a field is missing or has another type.
  `toEntity()` turns it into an entity.
- A data source is an `abstract interface class` in `data/data_sources/`.
- An implementation has the name of its interface with the suffix `Impl`, in
  a file with the suffix `_impl.dart`: `ReleaseRepositoryImpl` in
  `release_repository_impl.dart`.

## Presentation
- A view only talks to its view model: it never reads a repository or a data
  source.
- One view model for each view. A view model extends `ChangeNotifier` and
  receives its repositories through its constructor.
- A view model is created with `ChangeNotifierProvider` in
  `lib/app/router.dart`, which disposes it when the route closes.
- The app uses no state management package other than `provider`.

## Navigation
- Routes are declared in `lib/app/router.dart` only.
- Screens navigate with `context.go(...)` or `context.push(...)`, never with
  `Navigator.push`.

## Design library
- Widgets come from `package:material_ui/material_ui.dart`.
- `package:flutter/material.dart` is imported only for a package that is not
  migrated yet, with `as legacy`, a `show` list, and a comment that names the
  package and says when to remove the import.
