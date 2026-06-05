import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../../../../core/security/session_timeout/session_timeout_service.dart';
import 'sign_in_page.dart';

// ─── Models inline ────────────────────────────────────────────────────────────

class PropertyModel {
  final String title;
  final String thumbnail; // URL de red
  final int rooms;
  final double area;
  final int floors;
  final double price;

  const PropertyModel({
    required this.title,
    required this.thumbnail,
    required this.rooms,
    required this.area,
    required this.floors,
    required this.price,
  });
}

class CategoryModel {
  final String title;
  final IconData icon;
  final Color color;

  const CategoryModel({
    required this.title,
    required this.icon,
    required this.color,
  });
}

// ─── Data mock ────────────────────────────────────────────────────────────────

const List<PropertyModel> properties = [
  PropertyModel(
    title: 'Modern Villa',
    thumbnail:
    'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=400&q=80',
    rooms: 4,
    area: 320,
    floors: 2,
    price: 540000,
  ),
  PropertyModel(
    title: 'City Penthouse',
    thumbnail:
    'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=400&q=80',
    rooms: 3,
    area: 210,
    floors: 1,
    price: 890000,
  ),
  PropertyModel(
    title: 'Cozy Cottage',
    thumbnail:
    'https://images.unsplash.com/photo-1480074568708-e7b720bb3f09?w=400&q=80',
    rooms: 2,
    area: 140,
    floors: 1,
    price: 260000,
  ),
  PropertyModel(
    title: 'Lakefront Home',
    thumbnail:
    'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=400&q=80',
    rooms: 5,
    area: 450,
    floors: 3,
    price: 1200000,
  ),
];

const List<CategoryModel> categories = [
  CategoryModel(title: 'Houses', icon: Icons.house_rounded, color: Color(0xffE5CE6A)),
  CategoryModel(title: 'Apartments', icon: Icons.apartment_rounded, color: Color(0xff6AB8E5)),
  CategoryModel(title: 'Villas', icon: Icons.villa_rounded, color: Color(0xffE56A8A)),
  CategoryModel(title: 'Offices', icon: Icons.business_rounded, color: Color(0xff6AE5A8)),
];

// ─── HomePage ─────────────────────────────────────────────────────────────────

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  Widget _buildHome() {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              // ── Header ──
              Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.grey.shade300,
                    child: const Icon(Icons.person, color: Colors.white, size: 26),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back!',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.grey),
                      ),
                      Text(
                        'Imran Sefat',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.logout_rounded),
                    onPressed: () {
                      SessionTimeoutService().stop();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const SignInPage()),
                        (route) => false,
                      );
                    },
                  ),
                  const Icon(Icons.notifications_none_outlined),
                ],
              ),
              const SizedBox(height: 24),
              // ── Search bar ──
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search...',
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // ── Categories ──
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 0.4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) =>
                    _CategoryButton(categoryModel: categories[index]),
              ),
              const SizedBox(height: 24),
              // ── Recommendations title ──
              Text(
                'Recommendations',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              // ── Horizontal list ──
              SizedBox(
                height: 270,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: properties.length,
                  itemBuilder: (context, index) =>
                      _RecommendationCard(propertyModel: properties[index]),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder(String label) => Center(child: Text(label));

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildHome(),
      _buildPlaceholder('Favourite Page'),
      _buildPlaceholder('Search Page'),
      _buildPlaceholder('Settings Page'),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12),
          ),
          child: SalomonBottomBar(
            unselectedItemColor: Colors.white,
            currentIndex: _currentIndex,
            onTap: (i) => setState(() => _currentIndex = i),
            items: [
              SalomonBottomBarItem(
                icon: const Icon(Icons.home),
                title: const Text('Home'),
                selectedColor: Colors.blue,
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.favorite_border),
                title: const Text('Likes'),
                selectedColor: Colors.pink,
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.search),
                title: const Text('Search'),
                selectedColor: Colors.orange,
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.settings),
                title: const Text('Settings'),
                selectedColor: Colors.teal,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Widgets internos ─────────────────────────────────────────────────────────

class _RecommendationCard extends StatelessWidget {
  const _RecommendationCard({required this.propertyModel});

  final PropertyModel propertyModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: navegar a detalles
      },
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.15),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen desde URL
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                propertyModel.thumbnail,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (ctx, child, progress) => progress == null
                    ? child
                    : Container(
                  height: 120,
                  color: Colors.grey.shade200,
                  child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                ),
                errorBuilder: (ctx, _, __) => Container(
                  height: 120,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.image_not_supported, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xffE5CE6A),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                'FOR SALE',
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              propertyModel.title,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              '${propertyModel.rooms} rooms · ${propertyModel.area.toInt()} ft² · ${propertyModel.floors} floor${propertyModel.floors > 1 ? 's' : ''}',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.grey),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  const _CategoryButton({required this.categoryModel});

  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: navegar a categoría
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                categoryModel.title,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: categoryModel.color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(categoryModel.icon, color: categoryModel.color, size: 24),
            ),
          ],
        ),
      ),
    );
  }
}