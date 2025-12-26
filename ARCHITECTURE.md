# Mohit Portfolio — Architecture

This document summarizes the application's architecture, tech stack, startup flow, data flows, component responsibilities, and quick run / troubleshooting notes. It includes a compact Mermaid diagram that maps the major runtime components and their interactions.

## 1. Executive summary
- Platform: Flutter (primary target: Web). Native Android/iOS folders exist but `firebase_options.dart` is currently configured for Web.
- Pattern: MVVM (ViewModels implemented as `ChangeNotifier`) with `provider` for DI/binding.
- Back-end & hosting: Firebase (Firestore + Remote Config + Hosting). Email delivery via EmailJS (client-side).
- Runtime config: `Remote Config` returns a JSON string `build_config` that is parsed into `BuildConfig` at startup; it supplies EmailJS keys, `imageBaseUrl`, and other runtime values.

## 2. High-level tech stack
- Flutter (Dart)
- State: provider (ChangeNotifier) — MVVM
- Firebase: firebase_core, cloud_firestore, firebase_remote_config
- UI: Material3, google_fonts, flutter_animate, cached_network_image, carousel_slider
- Persistence: SharedPreferences (theme)
- Email: EmailJS REST API (client-side)
- Hosting: Firebase Hosting (build/web)

## 3. Startup sequence (simplified)
1. `main()` (`lib/main.dart`)
   - `WidgetsFlutterBinding.ensureInitialized()`
   - `Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)`
   - `RemoteConfigService.instance.init()` — fetches and parses `build_config`
   - `themeController.loadTheme()` (SharedPreferences)
   - `runApp(MyApp())`
2. `MyApp` (`lib/app.dart`) builds `MaterialApp`, assigns navigator key and themes and loads `HomeScreen`.

## 4. Runtime components & responsibilities
- UI (Screens & Widgets) — `lib/screens/*`
  - Composed into sections (Hero, Projects, Skills, Contact, Footer).
  - `HomeScreen` orchestrates sections in a single-page scroll view.
- ViewModels — `lib/view_model/*`
  - ChangeNotifier classes that own state and expose methods to mutate it. Examples:
    - `HomeViewModel` — nav/menu/scroll state
    - `PortfolioViewModel` — project list provider
    - `ContactInfoViewModel` — form controllers, Firestore + EmailJS submit flow
- Services — `lib/core/services/*`
  - `RemoteConfigService` — fetch & parse `build_config` JSON
  - (Other services live under `core/services` if present)
- Config / Constants — `lib/core/config/*`, `lib/core/constants/*`
  - `BuildConfig` model (parsed from Remote Config JSON)
  - `AppConstants` provides responsive helpers and references `RemoteConfigService.instance.buildConfig`
- Widgets — `lib/core/widgets/*` contains reusable UI helpers (toasts, base widget for MVVM binding, etc.)

## 5. Data flow (Contact form example)
1. User fills form in `ContactInfo` widget.
2. `ContactInfoViewModel.submitForm()`:
   - Validates form
   - Writes a new doc to Firestore collection `contact_messages` with `emailSent: false`
   - Calls EmailJS REST API (fetching keys from `BuildConfig` from Remote Config)
   - Updates Firestore document with email status and error message (if any)
   - Shows toast and resets form

Rationale: Firestore write first ensures messages are captured even if email fails.

## 6. Remote Config & assets
- Remote Config key: `build_config` (JSON string)
- `BuildConfig` fields: Firebase client keys, `emailJsServiceId`, `template_id`, `emailJsPublicKey`, `imageBaseUrl`
- Many UI images are loaded by composing `imageBaseUrl` + path (so Remote Config must provide a correct base URL or images may 404)

## 7. Security & operational notes
- `firebase_options.dart` contains public client keys (safe to commit). Do not add server secrets here.
- EmailJS is called from the client using public keys — acceptable for portfolio but not ideal for high-security apps.
- `RemoteConfigService.init()` currently throws if `build_config` is empty — this will crash the app at startup if the Remote Config key is missing. Consider adding a local fallback or defensive handling.

## 8. Mermaid architecture diagram
- This diagram illustrates the major components and calls.

```mermaid
flowchart LR
  subgraph Client[Flutter Web Client]
    A[Main (main.dart)] --> B[Firebase.initializeApp]
    B --> C[RemoteConfigService]
    C --> D[BuildConfig]
    A --> E[MyApp (MaterialApp)]
    E --> F[HomeScreen]
    F --> G[Sections]
    G --> H[ContactInfo]
    H --> VM[ContactInfoViewModel]
  end

  subgraph Backend[Firescape & 3rd-party]
    I[Firestore] -->|store contact| J[contact_messages collection]
    K[EmailJS API] -->|send email| L[Recipient Inbox]
  end

  VM -->|write| J
  VM -->|HTTP POST (EmailJS)| K
  C -->|reads| I
  style Client fill:#f8f9fb,stroke:#333
  style Backend fill:#fff6f0,stroke:#333
```

> Note: GitHub and many Markdown renderers support Mermaid diagrams. If your viewer doesn't, open the file in a Mermaid-enabled renderer.

## 9. File → responsibility quick map (key files)
- `pubspec.yaml` — dependencies & Flutter settings
- `lib/main.dart` — bootstrap: Firebase & Remote Config init
- `lib/app.dart` — MaterialApp, theme wiring, root navigator
- `lib/firebase_options.dart` — generated Firebase web options
- `lib/core/config/build_config.dart` — typed model for Remote Config JSON
- `lib/core/services/remote_config_service.dart` — get & parse `build_config`
- `lib/core/constants/app_constants.dart` — responsive helpers + `imageBaseUrl` accessor
- `lib/core/widgets/base_widget.dart` — small MVVM binding helper (ChangeNotifierProvider)
- `lib/core/widgets/custom_toast.dart` — overlay toast UI
- `lib/view_model/contact_info_view_model.dart` — contact form logic (Firestore + EmailJS)
- `lib/screens/contact_info/contact_info.dart` — contact form UI
- `lib/screens/home/home_screen.dart` — page composition
- `lib/data.dart` — static project list (constructs image URLs via `imageBaseUrl`)

## 10. How to run quick checks locally
1. Install toolchain per `README.md` (Flutter SDK, Node.js, Firebase CLI, FlutterFire CLI)
2. Fetch deps:

```bash
flutter pub get
```

3. Static analysis & tests:

```bash
flutter analyze
flutter test
```

4. Run the web app (Chrome):

```bash
flutter run -d chrome
```

Warnings to watch for at runtime:
- If `Remote Config` key `build_config` is missing or empty, app will throw during startup (RemoteConfigService throws). Add a fallback during development.
- If you target Android/iOS, `DefaultFirebaseOptions` currently only supports Web and will throw for non-web platforms.

## 11. Recommended next steps (top-priority)
1. Add a fallback `build_config` bundled in the app (or defensive code path) so Remote Config absence doesn't crash the app.
2. If you want to run on Android/iOS, run `flutterfire configure` to generate native `firebase_options.dart` entries or guard initialization for non-web.
3. Add unit tests for `ContactInfoViewModel` (mock Firestore and mock HTTP for EmailJS) and for `RemoteConfigService` (mock remote config fetch). 
4. Optionally add a small CI job (GitHub Actions) that runs `flutter analyze` and `flutter test` on PRs.

---

If you'd like, I can now:
- Implement the Remote Config fallback (modify `RemoteConfigService` + `BuildConfig.fromJson` fallback),
- Generate `ARCHITECTURE.md` (done), and
- Run `flutter analyze` and `flutter test` and report issues.

Tell me which you'd like me to run next and I'll proceed.

