import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final String _userName = 'Usuario';

  // Páginas del menú
  final List<_PageItem> _pages = [
    _PageItem(
      title: 'Dashboard',
      icon: Icons.dashboard_rounded,
      content: _DashboardContent(),
    ),
    _PageItem(
      title: 'Mi Perfil',
      icon: Icons.person_rounded,
      content: _ProfileContent(),
    ),
    _PageItem(
      title: 'Configuración',
      icon: Icons.settings_rounded,
      content: _SettingsContent(),
    ),
    _PageItem(
      title: 'Estadísticas',
      icon: Icons.bar_chart_rounded,
      content: _StatsContent(),
    ),
    _PageItem(
      title: 'Notificaciones',
      icon: Icons.notifications_rounded,
      content: _NotificationsContent(),
    ),
  ];

  void _onDrawerItemTap(int index) {
    setState(() => _selectedIndex = index);
    Navigator.pop(context); // cerrar drawer
  }

  void _logout() {
    Navigator.pop(context); // cerrar drawer
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Cerrar sesión',
            style: TextStyle(fontWeight: FontWeight.w700)),
        content: const Text('¿Estás seguro de que quieres salir?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar',
                style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pushReplacementNamed(context, '/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7B2FBE),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Salir',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final page = _pages[_selectedIndex];

    return Scaffold(
      // ── AppBar ──────────────────────────────────────────────
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF4A90D9), Color(0xFF7B2FBE)],
            ),
          ),
        ),
        title: Text(
          page.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () => setState(() => _selectedIndex = 4),
          ),
        ],
      ),

      // ── Drawer ──────────────────────────────────────────────
      drawer: Drawer(
        child: Column(
          children: [
            // Header del drawer
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF4A90D9), Color(0xFF7B2FBE), Color(0xFFE91E8C)],
                ),
              ),
              accountName: Text(
                _userName,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              accountEmail: const Text(
                'usuario@email.com',
                style: TextStyle(color: Colors.white70),
              ),
              currentAccountPicture: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE91E8C), Color(0xFF4A90D9)],
                  ),
                ),
                child: const Icon(
                  Icons.person_rounded,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),

            // Items del menú
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedIndex == index;
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: isSelected
                          ? const LinearGradient(
                              colors: [
                                Color(0x207B2FBE),
                                Color(0x204A90D9),
                              ],
                            )
                          : null,
                    ),
                    child: ListTile(
                      leading: Icon(
                        _pages[index].icon,
                        color: isSelected
                            ? const Color(0xFF7B2FBE)
                            : Colors.grey.shade600,
                      ),
                      title: Text(
                        _pages[index].title,
                        style: TextStyle(
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w400,
                          color: isSelected
                              ? const Color(0xFF7B2FBE)
                              : Colors.grey.shade800,
                        ),
                      ),
                      trailing: isSelected
                          ? Container(
                              width: 4,
                              height: 24,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xFF7B2FBE),
                                    Color(0xFFE91E8C),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            )
                          : null,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      onTap: () => _onDrawerItemTap(index),
                    ),
                  );
                },
              ),
            ),

            const Divider(height: 1),

            // Ayuda y soporte
            ListTile(
              leading: Icon(Icons.help_outline_rounded,
                  color: Colors.grey.shade600),
              title: Text('Ayuda y Soporte',
                  style: TextStyle(color: Colors.grey.shade700)),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Próximamente...'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),

            // Cerrar sesión
            Container(
              margin: const EdgeInsets.fromLTRB(12, 0, 12, 16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF7B2FBE), Color(0xFFE91E8C)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.logout_rounded, color: Colors.white),
                title: const Text(
                  'Cerrar Sesión',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                onTap: _logout,
              ),
            ),
          ],
        ),
      ),

      // ── Body ────────────────────────────────────────────────
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: KeyedSubtree(
          key: ValueKey(_selectedIndex),
          child: page.content,
        ),
      ),
    );
  }
}

// ── Modelo de página ─────────────────────────────────────────────────────────
class _PageItem {
  final String title;
  final IconData icon;
  final Widget content;
  const _PageItem({
    required this.title,
    required this.icon,
    required this.content,
  });
}

// ── Dashboard ────────────────────────────────────────────────────────────────
class _DashboardContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner bienvenida
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF7B2FBE), Color(0xFF4A90D9)],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF7B2FBE).withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '¡Bienvenido! 👋',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Tienes 3 tareas pendientes hoy',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF7B2FBE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  child: const Text(
                    'Ver tareas',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          const Text(
            'Resumen',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),

          // Cards de estadísticas
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              _StatCard(
                label: 'Proyectos',
                value: '12',
                icon: Icons.folder_rounded,
                color: Color(0xFF7B2FBE),
              ),
              _StatCard(
                label: 'Completados',
                value: '8',
                icon: Icons.check_circle_rounded,
                color: Color(0xFF4A90D9),
              ),
              _StatCard(
                label: 'Pendientes',
                value: '3',
                icon: Icons.pending_rounded,
                color: Color(0xFFE91E8C),
              ),
              _StatCard(
                label: 'Mensajes',
                value: '24',
                icon: Icons.message_rounded,
                color: Color(0xFF00BCD4),
              ),
            ],
          ),
          const SizedBox(height: 24),

          const Text(
            'Actividad reciente',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),

          ..._buildActivityItems(),
        ],
      ),
    );
  }

  List<Widget> _buildActivityItems() {
    final items = [
      ('Proyecto Alpha actualizado', '2 min ago', Icons.update_rounded),
      ('Nueva tarea asignada', '1 hora ago', Icons.task_alt_rounded),
      ('Reunión programada', 'Ayer', Icons.event_rounded),
    ];
    return items
        .map(
          (item) => Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7B2FBE).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(item.$3,
                      color: const Color(0xFF7B2FBE), size: 20),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.$1,
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      Text(item.$2,
                          style: const TextStyle(
                              fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right_rounded, color: Colors.grey),
              ],
            ),
          ),
        )
        .toList();
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.15),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: color,
                ),
              ),
              Text(
                label,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Perfil ───────────────────────────────────────────────────────────────────
class _ProfileContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(30),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4A90D9), Color(0xFF7B2FBE)],
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFE91E8C), Color(0xFF4A90D9)],
                    ),
                  ),
                  child: const Icon(Icons.person_rounded,
                      size: 50, color: Colors.white),
                ),
                const SizedBox(height: 12),
                const Text('Usuario',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Colors.white)),
                const Text('usuario@email.com',
                    style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildProfileTile(Icons.person_outline, 'Nombre', 'Usuario'),
                _buildProfileTile(
                    Icons.email_outlined, 'Email', 'usuario@email.com'),
                _buildProfileTile(Icons.phone_outlined, 'Teléfono', '+593 00 000 0000'),
                _buildProfileTile(
                    Icons.location_on_outlined, 'Ciudad', 'Quito, Ecuador'),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF7B2FBE), Color(0xFFE91E8C)],
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Editar Perfil',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTile(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05), blurRadius: 10)
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF7B2FBE), size: 22),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
              Text(value,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Configuración ────────────────────────────────────────────────────────────
class _SettingsContent extends StatefulWidget {
  @override
  State<_SettingsContent> createState() => _SettingsContentState();
}

class _SettingsContentState extends State<_SettingsContent> {
  bool _notifications = true;
  bool _darkMode = false;
  bool _biometric = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text('Preferencias',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        _buildSwitch('Notificaciones', Icons.notifications_rounded,
            _notifications, (v) => setState(() => _notifications = v)),
        _buildSwitch('Modo Oscuro', Icons.dark_mode_rounded, _darkMode,
            (v) => setState(() => _darkMode = v)),
        _buildSwitch('Autenticación Biométrica', Icons.fingerprint_rounded,
            _biometric, (v) => setState(() => _biometric = v)),
        const SizedBox(height: 20),
        const Text('Cuenta',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        _buildOptionTile('Cambiar contraseña', Icons.lock_outline_rounded),
        _buildOptionTile('Idioma', Icons.language_rounded),
        _buildOptionTile('Privacidad', Icons.privacy_tip_outlined),
      ],
    );
  }

  Widget _buildSwitch(
      String label, IconData icon, bool value, Function(bool) onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05), blurRadius: 10)
        ],
      ),
      child: SwitchListTile(
        secondary: Icon(icon, color: const Color(0xFF7B2FBE)),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFF7B2FBE),
        contentPadding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildOptionTile(String label, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05), blurRadius: 10)
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF7B2FBE)),
        title: Text(label,
            style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.chevron_right_rounded, color: Colors.grey),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        onTap: () {},
      ),
    );
  }
}

// ── Estadísticas ─────────────────────────────────────────────────────────────
class _StatsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Estadísticas',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                _buildProgressCard('Proyectos completados', 0.75, const Color(0xFF7B2FBE)),
                _buildProgressCard('Tareas del mes', 0.58, const Color(0xFF4A90D9)),
                _buildProgressCard('Objetivos anuales', 0.40, const Color(0xFFE91E8C)),
                _buildProgressCard('Eficiencia', 0.88, const Color(0xFF00BCD4)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard(String label, double progress, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: color.withOpacity(0.15), blurRadius: 15, offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              Text('${(progress * 100).toInt()}%',
                  style: TextStyle(
                      color: color, fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: color.withOpacity(0.12),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 10,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Notificaciones ───────────────────────────────────────────────────────────
class _NotificationsContent extends StatelessWidget {
  final List<Map<String, dynamic>> _notifs = const [
    {
      'title': 'Nueva tarea asignada',
      'body': 'Se te asignó una tarea urgente',
      'time': '2 min',
      'icon': Icons.task_alt_rounded,
      'read': false,
    },
    {
      'title': 'Reunión en 30 min',
      'body': 'Recordatorio: reunión de equipo',
      'time': '28 min',
      'icon': Icons.event_rounded,
      'read': false,
    },
    {
      'title': 'Proyecto actualizado',
      'body': 'El proyecto Beta fue modificado',
      'time': '1 h',
      'icon': Icons.update_rounded,
      'read': true,
    },
    {
      'title': 'Comentario nuevo',
      'body': 'Alguien comentó en tu tarea',
      'time': '3 h',
      'icon': Icons.comment_rounded,
      'read': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _notifs.length,
      itemBuilder: (context, i) {
        final n = _notifs[i];
        final isRead = n['read'] as bool;
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isRead ? Colors.white : const Color(0xFFF3EAFF),
            borderRadius: BorderRadius.circular(16),
            border: isRead
                ? null
                : Border.all(
                    color: const Color(0xFF7B2FBE).withOpacity(0.2)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.04), blurRadius: 10),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: isRead
                      ? null
                      : const LinearGradient(
                          colors: [Color(0xFF7B2FBE), Color(0xFFE91E8C)]),
                  color: isRead ? Colors.grey.shade200 : null,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(n['icon'] as IconData,
                    color: isRead ? Colors.grey : Colors.white, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(n['title'] as String,
                        style: TextStyle(
                            fontWeight: isRead
                                ? FontWeight.w500
                                : FontWeight.w700)),
                    const SizedBox(height: 2),
                    Text(n['body'] as String,
                        style: const TextStyle(
                            fontSize: 13, color: Colors.grey)),
                  ],
                ),
              ),
              Text(n['time'] as String,
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        );
      },
    );
  }
}
