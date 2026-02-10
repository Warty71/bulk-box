# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Bulk Box is a Yu-Gi-Oh! card collection tracker built with Flutter/Dart. It lets users search cards via the YGOProDeck API, organize them into boxes, and track quantities/conditions/rarities. Data is stored locally using Drift (SQLite).

## Build & Development Commands

```bash
flutter pub get                          # Install dependencies
flutter run                              # Run on connected device/emulator
flutter test                             # Run all tests
flutter analyze                          # Static analysis (uses flutter_lints)
flutter pub run build_runner build        # Code generation (freezed, json_serializable, drift)
flutter pub run build_runner watch        # Code generation in watch mode
```

After changing Drift tables, freezed classes, or JSON models, you **must** run `build_runner` to regenerate `*.g.dart` and `*.freezed.dart` files.

## Architecture

**Clean Architecture with BLoC pattern**, organized by feature:

```
lib/src/
├── core/           # Shared infrastructure (database, DI, routing, theme, widgets)
└── features/       # Feature modules, each with domain/data/presentation layers
    ├── home/       # Latest card sets display
    ├── search/     # Card search via YGOProDeck API
    ├── collection/ # Collection management (cards, boxes, bulk moves)
    ├── ygo_cards/  # Shared card data layer (API client, models, image caching)
    └── sorting/    # Sorting comparators
```

Each feature follows: **Domain** (repository contracts, entities) → **Data** (repository impls, datasources, models) → **Presentation** (screens, widgets, cubits).

### Key Architectural Decisions

- **State management:** Cubits (flutter_bloc). States use freezed union types (initial | loading | loaded | error).
- **Dependency injection:** GetIt service locator, configured in `core/di/injection_container.dart`. BoxesCubit is a singleton (refreshes after bulk moves); other cubits are factories.
- **Navigation:** GoRouter with `StatefulShellRoute.indexedStack` for three-tab bottom nav (Home `/`, Collection `/collection`, Search `/search`). Box detail view at `/collection/box/:boxId`.
- **Database:** Drift ORM, schema version 2. Three tables: `Cards` (cached API data), `Boxes` (user containers), `CollectionItems` (card slots with composite PK: cardId + setCode + setRarity + boxId).
- **Persistence:** HydratedBloc for settings state that survives app restarts.
- **API:** YGOProDeck API (`https://db.ygoprodeck.com/api/v7`) via Dio with rate limiting (18 req/s for images).

### Data Flow

1. Cards are fetched from YGOProDeck API and cached in the local `Cards` table
2. Users add cards to their collection as `CollectionItems`, optionally assigning to a `Box`
3. The same card can exist in multiple boxes with different set/rarity/quantity combinations
4. Images are cached locally on device via `ImageLocalDatasource`

## Environment

- Dart SDK: ^3.6.2
- Flutter stable channel
- Supports: Android (API 21+), iOS, Web, Linux, Windows, macOS
