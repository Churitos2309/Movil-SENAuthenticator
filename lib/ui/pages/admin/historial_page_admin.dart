import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Asegúrate de que esta librería esté importada para manejar las fechas
import 'tabla/graficas.dart';
import 'package:reconocimiento_app/services/api_services.dart';

class HistorialAdminPage extends StatefulWidget {
  const HistorialAdminPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HistorialAdminPageState createState() => _HistorialAdminPageState();
}

class _HistorialAdminPageState extends State<HistorialAdminPage> {
  int totalUsuarios = 0;
  int registradosHoy = 0;
  String diaMayorEntrada = "";
  int usuariosMayorEntrada = 0;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    ApiService apiService = ApiService();

    try {
      // Obtener todos los usuarios de la API
      List<dynamic> usuarios = await apiService.get('usuarios/');

      // Filtrar los usuarios registrados hoy
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      int countHoy = usuarios.where((usuario) {
        String dateJoined = usuario['date_joined'].substring(0, 10);
        return dateJoined == today;
      }).length;

      // Calcular el día con mayor registro
      Map<String, int> registrosPorDia = {};

      for (var usuario in usuarios) {
        String dateJoined = usuario['date_joined'].substring(0, 10);

        if (registrosPorDia.containsKey(dateJoined)) {
          registrosPorDia[dateJoined] = registrosPorDia[dateJoined]! + 1;
        } else {
          registrosPorDia[dateJoined] = 1;
        }
      }

      // Identificar el día con mayor entrada
      String diaConMayorEntrada = "";
      int mayorEntradas = 0;

      registrosPorDia.forEach((fecha, count) {
        if (count > mayorEntradas) {
          mayorEntradas = count;
          diaConMayorEntrada = fecha;
        }
      });

      // Convertir la fecha a un día de la semana
      String diaDeLaSemana =
          DateFormat('EEEE').format(DateTime.parse(diaConMayorEntrada));

      // Actualizar el estado con los valores obtenidos
      setState(() {
        totalUsuarios = usuarios.length;
        registradosHoy = countHoy;
        diaMayorEntrada =
            "$diaDeLaSemana, $diaConMayorEntrada ($mayorEntradas registros)";
        usuariosMayorEntrada = mayorEntradas;
      });
    } catch (e) {
      print('Error al obtener los datos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Campo Azul: Total Aprendices
              _buildCard(
                title: "Total Aprendices",
                value:
                    "$totalUsuarios\nAprendices en total", // Aquí se agregó la etiqueta
                // subtitle: "",
                colors: [Colors.blue.shade200, Colors.blue.shade500],
              ),
              const SizedBox(height: 16.0),

              // Campo Verde: Registrados Hoy (Usuarios registrados hoy)
              _buildCard(
                title: "Registrados Hoy",
                value:
                    "$registradosHoy\nTotal de ingresos hoy", // Aquí se agregó la etiqueta
                // subtitle: "",
                colors: [Colors.green.shade200, Colors.green.shade500],
              ),
              const SizedBox(height: 16.0),

              // Campo Naranja: Día con Mayor Entrada
              _buildCard(
                title: "Día con Mayor Entrada",
                // ignore: unnecessary_string_interpolations
                value: "$diaMayorEntrada",
                // subtitle: "",
                colors: [Colors.orange.shade200, Colors.orange.shade500],
              ),
              const SizedBox(height: 16.0),

              // Importar y mostrar el widget de gráficas
              const Graficas(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String value,
    required List<Color> colors,
  }) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: colors.first.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis, // Evitar el desbordamiento
              maxLines: 1, // Máximo una línea
            ),
            const SizedBox(height: 8.0),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
              overflow: TextOverflow.ellipsis, // Evitar el desbordamiento
              maxLines: 1, // Máximo una línea
            ),
          ],
        ),
      ),
    );
  }
}
