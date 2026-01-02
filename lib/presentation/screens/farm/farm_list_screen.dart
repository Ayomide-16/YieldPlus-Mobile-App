import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../data/repositories/farm_repository.dart';
import '../../../data/models/farm_model.dart';

class FarmListScreen extends StatefulWidget {
  const FarmListScreen({super.key});

  @override
  State<FarmListScreen> createState() => _FarmListScreenState();
}

class _FarmListScreenState extends State<FarmListScreen> {
  final _farmRepository = FarmRepository();
  List<FarmModel> _farms = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFarms();
  }

  Future<void> _loadFarms() async {
    try {
      final farms = await _farmRepository.getFarms();
      setState(() { _farms = farms; _isLoading = false; });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.error));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Farms')),
      floatingActionButton: FloatingActionButton(onPressed: _showAddFarmDialog, child: const Icon(Icons.add)),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _farms.isEmpty
              ? _buildEmptyState()
              : RefreshIndicator(onRefresh: _loadFarms, child: ListView.builder(padding: const EdgeInsets.all(16), itemCount: _farms.length, itemBuilder: (context, index) => _buildFarmCard(_farms[index]))),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(padding: const EdgeInsets.all(24), decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(20)), child: const Icon(Icons.agriculture, size: 64, color: AppColors.primary)),
            const SizedBox(height: 24),
            Text('No Farms Yet', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            const Text('Add your first farm to get started', style: TextStyle(color: AppColors.textSecondary)),
            const SizedBox(height: 24),
            ElevatedButton.icon(onPressed: _showAddFarmDialog, icon: const Icon(Icons.add), label: const Text('Add Farm')),
          ],
        ),
      ),
    );
  }

  Widget _buildFarmCard(FarmModel farm) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.landscape, color: AppColors.primary)),
        title: Text(farm.name, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            if (farm.size != null) Text('${farm.size} ${farm.sizeUnit}'),
            if (farm.country != null) Text('${farm.state ?? ""}, ${farm.country}'),
          ],
        ),
        trailing: PopupMenuButton(itemBuilder: (_) => [const PopupMenuItem(value: 'delete', child: Text('Delete'))], onSelected: (value) async { if (value == 'delete') { await _farmRepository.deleteFarm(farm.id); _loadFarms(); } }),
      ),
    );
  }

  void _showAddFarmDialog() {
    final nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Farm'),
        content: TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Farm Name')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(onPressed: () async { if (nameController.text.isNotEmpty) { await _farmRepository.createFarm(name: nameController.text); Navigator.pop(context); _loadFarms(); } }, child: const Text('Add')),
        ],
      ),
    );
  }
}
