import 'dart:io';
import 'package:flutter/material.dart';
import '../../DBHelper/DBHelper.dart';

class ViewNote extends StatelessWidget {
  final Map<String, dynamic> note;

  const ViewNote({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    // Debug: see exactly what keys/values are coming in.
    // Remove this print when everything works.
    // ignore: avoid_print
    print('ViewNote received map: $note');

    // Prefer DBHelper constants (these must exactly match your DB column names)
    final imagePath = (note[DBHelper.noteImg] ?? note['img'] ?? note['NoteImg'] ?? '') as String;
    final title = (note[DBHelper.noteTitle] ??
        note['title'] ??
        note['Title'] ??
        note['noteTitle'] ??
        note['NoteTitle'] ??
        "Untitled Note") as String;
    final subtitle = (note[DBHelper.noteSubTitle] ??
        note['subtitle'] ??
        note['NoteSubTitle'] ??
        '') as String;
    final description = (note[DBHelper.noteDescription] ??
        note['description'] ??
        note['noteDesc'] ??
        note['NoteDescription'] ??
        '') as String;

    final hasImage = imagePath.isNotEmpty && File(imagePath).existsSync();

    return Scaffold(
      appBar: AppBar(title: Text(title, overflow: TextOverflow.ellipsis)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (hasImage)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(File(imagePath), fit: BoxFit.cover),
            )
          else
            Container(
              height: 200,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.image_not_supported, size: 60, color: Colors.grey),
            ),

          const SizedBox(height: 20),

          Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),

          const SizedBox(height: 8),

          if (subtitle.isNotEmpty)
            Text(subtitle,
                style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: Colors.black54)),

          const SizedBox(height: 16),

          Text(description, style: const TextStyle(fontSize: 16, height: 1.5)),
        ]),
      ),
    );
  }
}
