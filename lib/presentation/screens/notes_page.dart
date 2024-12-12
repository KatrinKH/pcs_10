import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  // Текстовые контроллеры для каждого поля
  final nameController = TextEditingController();
  final imageUrlController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();

  /* 
  CREATE - создание новой записи и сохранение в Supabase
  */

  void addNewNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Добавить новую запись'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              // Поля ввода данных
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Название'),
              ),
              TextField(
                controller: imageUrlController,
                decoration: const InputDecoration(labelText: 'URL изображения'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Описание'),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Цена'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          // Кнопка для сохранения
          TextButton(
            onPressed: () {
              saveNote();
              Navigator.pop(context);
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }

  void saveNote() async {
    // Преобразование строки с ценой в число
    final double? price = double.tryParse(priceController.text);

    // Сохранение данных в таблице 'notes' в Supabase
    await Supabase.instance.client
        .from('notes')
        .insert({
          'Name': nameController.text, // Поле Name
          'ImageURL': imageUrlController.text, // Поле ImageURL
          'Description': descriptionController.text, // Поле Description
          'Price': price, // Поле Price (как число)
        });

    // Очищаем поля после сохранения
    nameController.clear();
    imageUrlController.clear();
    descriptionController.clear();
    priceController.clear();
  }

  /* 
  READ - данные из таблицы Supabase
  */

  final _notesStream = Supabase.instance.client.from('notes').stream(primaryKey: ['id']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Записи'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewNote,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _notesStream,
        builder: (context, snapshot) {
          // Показ индикатора загрузки
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          // Загруженные данные
          final notes = snapshot.data;

          // Если данных нет
          if (notes == null || notes.isEmpty) {
            return const Center(child: Text('Нет записей'));
          }

          // Отображение списка записей
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];

              // Извлекаем данные для отображения
              final name = note['Name'] ?? 'Без названия';
              final imageUrl = note['ImageURL'] ?? '';
              final description = note['Description'] ?? 'Нет описания';
              final price = note['Price'] != null ? '\Р${note['Price']}' : 'Цена не указана';

              // Отображаем в виде карточки
              return Card(
                child: ListTile(
                  title: Text(name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (imageUrl.isNotEmpty) Image.network(imageUrl),
                      Text(description),
                      Text(price),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
