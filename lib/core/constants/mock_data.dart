/// Hardcoded sample data so every screen renders without a backend.
/// Replace with real repositories once Firebase/Turso are wired up
/// (see TODO.md).
library;

enum OrderStatus { searching, accepted, pickedUp, inProgress, completed, cancelled }

class NearbyDriver {
  const NearbyDriver({
    required this.name,
    required this.vehicle,
    required this.rating,
    required this.distanceKm,
    required this.etaMinutes,
    required this.isCar,
  });

  final String name;
  final String vehicle;
  final double rating;
  final double distanceKm;
  final int etaMinutes;
  final bool isCar;
}

const nearbyDrivers = [
  NearbyDriver(name: 'Andi Prasetyo', vehicle: 'Honda Beat', rating: 4.9, distanceKm: 0.4, etaMinutes: 2, isCar: false),
  NearbyDriver(name: 'Siti Rahma', vehicle: 'Yamaha Nmax', rating: 4.8, distanceKm: 0.7, etaMinutes: 4, isCar: false),
  NearbyDriver(name: 'Rudi Hartono', vehicle: 'Toyota Avanza', rating: 4.7, distanceKm: 1.1, etaMinutes: 6, isCar: true),
];

class OrderHistoryItem {
  const OrderHistoryItem({
    required this.route,
    required this.dateLabel,
    required this.vehicle,
    required this.price,
    required this.status,
    this.rating,
  });

  final String route;
  final String dateLabel;
  final String vehicle;
  final int price;
  final OrderStatus status;
  final double? rating;
}

const customerHistory = [
  OrderHistoryItem(route: 'Jl. Merdeka → Jl. Asia Afrika', dateLabel: 'Hari ini, 14:20', vehicle: 'Motor', price: 18000, status: OrderStatus.completed),
  OrderHistoryItem(route: 'Apartemen Cendana → Stasiun Kereta', dateLabel: 'Kemarin, 08:05', vehicle: 'Mobil', price: 42000, status: OrderStatus.completed, rating: 4.0),
  OrderHistoryItem(route: 'Kantor Pos → Rumah', dateLabel: '2 hari lalu, 19:40', vehicle: 'Motor', price: 0, status: OrderStatus.cancelled),
];

class DriverTripItem {
  const DriverTripItem({
    required this.customerName,
    required this.route,
    required this.dateLabel,
    required this.earning,
    required this.rating,
    this.note,
    this.cancelled = false,
  });

  final String customerName;
  final String route;
  final String dateLabel;
  final int earning;
  final double rating;
  final String? note;
  final bool cancelled;
}

const driverTrips = [
  DriverTripItem(customerName: 'Maria Dewi', route: 'Jl. Merdeka → Jl. Asia Afrika', dateLabel: 'Hari ini, 14:20', earning: 18000, rating: 5, note: '"Ramah & tepat waktu"'),
  DriverTripItem(customerName: 'Budi Santoso', route: 'Jl. Braga → Stasiun', dateLabel: 'Hari ini, 11:05', earning: 22500, rating: 4),
  DriverTripItem(customerName: 'Rina Wulandari', route: 'Dibatalkan penumpang', dateLabel: 'Kemarin, 19:40', earning: 0, rating: 0, cancelled: true),
];

class IncomingOrderRequest {
  const IncomingOrderRequest({
    required this.pickup,
    required this.destination,
    required this.distanceKm,
    required this.etaMinutes,
    required this.price,
  });

  final String pickup;
  final String destination;
  final double distanceKm;
  final int etaMinutes;
  final int price;
}

const incomingRequest = IncomingOrderRequest(
  pickup: 'Jl. Merdeka No. 12',
  destination: 'Jl. Asia Afrika No. 8',
  distanceKm: 4.2,
  etaMinutes: 14,
  price: 18000,
);

class ManagedDriver {
  const ManagedDriver({
    required this.name,
    required this.vehicle,
    required this.plate,
    required this.isActive,
    required this.isCar,
  });

  final String name;
  final String vehicle;
  final String plate;
  final bool isActive;
  final bool isCar;
}

const managedDrivers = [
  ManagedDriver(name: 'Andi Prasetyo', vehicle: 'Honda Beat', plate: 'D 4021 XA', isActive: true, isCar: false),
  ManagedDriver(name: 'Siti Rahma', vehicle: 'Yamaha Nmax', plate: 'D 2210 BQ', isActive: true, isCar: false),
  ManagedDriver(name: 'Rudi Hartono', vehicle: 'Toyota Avanza', plate: 'D 8871 CP', isActive: false, isCar: true),
  ManagedDriver(name: 'Maria Dewi', vehicle: 'Honda Vario', plate: 'D 3390 ZK', isActive: true, isCar: false),
];

class PricingRule {
  const PricingRule({
    required this.vehicle,
    required this.baseFare,
    required this.secondaryLabel,
    required this.secondaryValue,
  });

  final String vehicle;
  final int baseFare;
  final String secondaryLabel;
  final String secondaryValue;
}

const pricingRules = [
  PricingRule(vehicle: 'Motor', baseFare: 8000, secondaryLabel: 'Per kilometer', secondaryValue: 'Rp 2.400'),
  PricingRule(vehicle: 'Mobil', baseFare: 15000, secondaryLabel: 'Per kilometer', secondaryValue: 'Rp 4.200'),
  PricingRule(vehicle: 'Makanan', baseFare: 6000, secondaryLabel: 'Biaya layanan', secondaryValue: '10%'),
];

class RecentOrder {
  const RecentOrder({
    required this.id,
    required this.route,
    required this.timeLabel,
    required this.price,
    required this.status,
  });

  final String id;
  final String route;
  final String timeLabel;
  final int price;
  final OrderStatus status;
}

const recentOrders = [
  RecentOrder(id: '#OJ-2481', route: 'Andi → Maria', timeLabel: '14:20', price: 18000, status: OrderStatus.completed),
  RecentOrder(id: '#OJ-2480', route: 'Rudi → Budi', timeLabel: '13:52', price: 32000, status: OrderStatus.inProgress),
  RecentOrder(id: '#OJ-2479', route: 'Siti → Rina', timeLabel: '13:10', price: 15000, status: OrderStatus.cancelled),
];
