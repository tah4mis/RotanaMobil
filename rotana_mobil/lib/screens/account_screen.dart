import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/reservation_provider.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Hesabım'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Profil'),
              Tab(text: 'Rezervasyonlarım'),
              Tab(text: 'Tercihler'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildProfileTab(context),
            _buildReservationsTab(context),
            _buildPreferencesTab(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileTab(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      child: Icon(Icons.person, size: 50),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      authProvider.userName.isEmpty
                          ? 'Misafir Kullanıcı'
                          : authProvider.userName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              _buildInfoCard(
                context,
                'Kişisel Bilgiler',
                [
                  _buildInfoRow('Ad Soyad', authProvider.userName),
                  _buildInfoRow('E-posta', authProvider.userEmail),
                  _buildInfoRow('Telefon', authProvider.userPhone),
                ],
              ),
              const SizedBox(height: 16),
              _buildInfoCard(
                context,
                'Hesap İşlemleri',
                [
                  ListTile(
                    leading: const Icon(Icons.edit),
                    title: const Text('Profili Düzenle'),
                    onTap: () => _showEditProfileDialog(context, authProvider),
                  ),
                  ListTile(
                    leading: const Icon(Icons.lock),
                    title: const Text('Şifre Değiştir'),
                    onTap: () => _showChangePasswordDialog(context),
                  ),
                  ListTile(
                    leading: const Icon(Icons.notifications),
                    title: const Text('Bildirim Ayarları'),
                    onTap: () => _showNotificationSettingsDialog(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    authProvider.logout();
                    // Giriş ekranına yönlendirme
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                  ),
                  child: const Text('Çıkış Yap'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildReservationsTab(BuildContext context) {
    return Consumer<ReservationProvider>(
      builder: (context, reservationProvider, child) {
        final reservations = reservationProvider.reservations;
        
        if (reservations.isEmpty) {
          return const Center(
            child: Text('Henüz rezervasyonunuz bulunmamaktadır.'),
          );
        }

        return ListView.builder(
          itemCount: reservations.length,
          itemBuilder: (context, index) {
            final reservation = reservations[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                leading: _getIconForType(reservation.type),
                title: Text(reservation.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tarih: ${reservation.date.day}/${reservation.date.month}/${reservation.date.year}'),
                    Text('Durum: ${reservation.status}'),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    reservationProvider.removeReservation(reservation.id);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPreferencesTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoCard(
            context,
            'Uygulama Tercihleri',
            [
              SwitchListTile(
                title: const Text('Karanlık Mod'),
                subtitle: const Text('Uygulamayı karanlık temada kullan'),
                value: false,
                onChanged: (value) {
                  // Tema değiştirme işlemi
                },
              ),
              SwitchListTile(
                title: const Text('Bildirimler'),
                subtitle: const Text('Rezervasyon bildirimlerini al'),
                value: true,
                onChanged: (value) {
                  // Bildirim ayarı değiştirme
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoCard(
            context,
            'Dil ve Bölge',
            [
              ListTile(
                title: const Text('Dil'),
                subtitle: const Text('Türkçe'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Dil seçimi
                },
              ),
              ListTile(
                title: const Text('Para Birimi'),
                subtitle: const Text('TL'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Para birimi seçimi
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, String title, List<Widget> children) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(value.isEmpty ? 'Belirtilmemiş' : value),
        ],
      ),
    );
  }

  Icon _getIconForType(String type) {
    switch (type) {
      case 'flight':
        return const Icon(Icons.flight, color: Colors.blue);
      case 'restaurant':
        return const Icon(Icons.restaurant, color: Colors.green);
      case 'hotel':
        return const Icon(Icons.hotel, color: Colors.orange);
      case 'car':
        return const Icon(Icons.directions_car, color: Colors.purple);
      default:
        return const Icon(Icons.help, color: Colors.grey);
    }
  }

  void _showEditProfileDialog(BuildContext context, AuthProvider authProvider) {
    final nameController = TextEditingController(text: authProvider.userName);
    final phoneController = TextEditingController(text: authProvider.userPhone);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Profili Düzenle'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Ad Soyad'),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Telefon'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () {
              authProvider.updateProfile(
                nameController.text,
                phoneController.text,
              );
              Navigator.pop(context);
            },
            child: const Text('Kaydet'),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Şifre Değiştir'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Mevcut Şifre'),
            ),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Yeni Şifre'),
            ),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Yeni Şifre (Tekrar)'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () {
              // Şifre değiştirme işlemi
              Navigator.pop(context);
            },
            child: const Text('Kaydet'),
          ),
        ],
      ),
    );
  }

  void _showNotificationSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Bildirim Ayarları'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(
              title: const Text('Rezervasyon Bildirimleri'),
              value: true,
              onChanged: (value) {
                // Bildirim ayarı değiştirme
              },
            ),
            SwitchListTile(
              title: const Text('Kampanya Bildirimleri'),
              value: true,
              onChanged: (value) {
                // Bildirim ayarı değiştirme
              },
            ),
            SwitchListTile(
              title: const Text('Güncelleme Bildirimleri'),
              value: true,
              onChanged: (value) {
                // Bildirim ayarı değiştirme
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }
} 