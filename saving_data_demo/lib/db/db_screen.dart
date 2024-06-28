import 'package:flutter/material.dart';
import 'package:saving_data_demo/db/db_provider.dart';

import 'client.dart';

class DBScreen extends StatefulWidget {
  const DBScreen({super.key});

  @override
  State<DBScreen> createState() => _DBScreenState();
}

class _DBScreenState extends State<DBScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQLite Demo'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final client = Client(firstName: 'CodeGym', lastName: 'Da Nang');
          DbProvider.newClient(client).then((value) {
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder(
          future: DbProvider.getClients(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            final clients = snapshot.data!;
            if (clients.isEmpty) {
              return const Center(
                child: Text('No clients found'),
              );
            }

            return ListView.builder(
              itemCount: clients.length,
              itemBuilder: (context, index) {
                final client = clients[index];
                return ListTile(
                  leading: Text(client.id.toString()),
                  title: Text(client.firstName ?? ''),
                  subtitle: Text(client.lastName ?? ''),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      DbProvider.deleteClient(client.id!).then((value) {
                        setState(() {});
                      });
                    },
                  ),
                );
              },
            );
          }),
    );
  }
}
