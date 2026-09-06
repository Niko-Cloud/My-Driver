# my_driver — Build Plan & TODO

Phased so the core order flow (Customer ↔ Driver) works end-to-end before anything else.

## Phase 0 — Project setup
- [ ] Add dependencies: `firebase_core`, `firebase_auth`, `cloud_firestore` (or realtime db),
      `firebase_messaging`, `go_router`, state mgmt package (`flutter_riverpod` recommended),
      `freezed`/`json_serializable` (optional, for models), a Turso/libSQL client package.
- [ ] Configure Firebase project (Android/iOS) via FlutterFire CLI.
- [ ] Provision Turso database + connection for big data/image references.
- [ ] Set up `lib/` feature-first folder structure (see copilot-instructions.md).
- [ ] Set up `go_router` with placeholder routes for Customer/Driver/Admin shells.
- [ ] Replace default counter `main.dart` with real app shell + theming.

## Phase 1 — Authentication (shared: Customer + Driver)
- [ ] Sign up / login (email+password minimum; phone OTP if needed for Indonesia market).
- [ ] Role assignment on signup (customer vs driver) stored in Firebase.
- [ ] Auth state listener → route guard (redirect to correct role home).
- [ ] Basic profile screen (name, phone, photo).

## Phase 2 — Core order flow (MVP)
- [ ] **Customer**: get/display list of available drivers (live or polling).
- [ ] **Customer**: create an order ("buat pesanan") — pickup/destination, order details.
- [ ] **Driver**: order inbox — receive incoming order requests.
- [ ] **Driver**: accept/reject an order.
- [ ] Shared order-status enum + Firestore doc updates (pending → accepted → picked_up →
      in_progress → completed → cancelled).
- [ ] **Driver**: update order state through the lifecycle.
- [ ] **Customer**: track order status in real time.

## Phase 3 — Post-order features
- [ ] **Customer**: rate driver after order completion.
- [ ] **Driver**: view historical/past orders.
- [ ] **Customer**: view past orders.
- [ ] Push notifications for order events (new order, status change) — nice-to-have,
      build after core flow is stable.

## Phase 4 — Admin
- [ ] Admin auth/role gate (separate from customer/driver signup).
- [ ] CRUD drivers (list, create, edit, deactivate).
- [ ] CRUD food/order pricing rules.
- [ ] Reassign driver on an existing order.
- [ ] Cost/revenue dashboard (basic reporting from order + pricing data).

## Phase 5 — Last priority
- [ ] Driver membership/subscription management (admin-controlled).
- [ ] Polish push notifications, add notification preferences.

## Ongoing / cross-cutting
- [ ] Widget/unit tests for each completed feature (don't let `test/` stay empty).
- [ ] Wire Figma designs in as they're finalized (replace fast prototypes).
- [ ] Error/empty/loading states for every screen.
- [ ] Basic analytics/logging for order funnel (created → accepted → completed).
