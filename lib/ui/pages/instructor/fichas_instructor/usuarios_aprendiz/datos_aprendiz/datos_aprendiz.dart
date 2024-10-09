import 'package:flutter/material.dart';

class DatosAprendiz extends StatelessWidget {
  final Map<String, dynamic> usuario;

  const DatosAprendiz({required this.usuario, super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0), // Bordes redondeados
      ),
      elevation: 8.0, // Sombra
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Ajusta el tamaño al contenido
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Flecha de regreso y título
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context); // Cierra el modal
                  },
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      'Detalles del Aprendiz',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87, // Color mejorado
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 48.0), // Para balancear el espacio con el icono
              ],
            ),
            const SizedBox(height: 16.0),

            // Imagen del usuario
            Center(
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage: usuario['face_register'] != null
                    ? NetworkImage(usuario['face_register']) // Carga la imagen de la API
                    : const AssetImage('assets/default_avatar.png') as ImageProvider, // Imagen por defecto
              ),
            ),
            const SizedBox(height: 16.0),

            // Información del aprendiz
            _buildInfoRow('Nombre de usuario:', usuario['username']),
            const SizedBox(height: 8.0), // Espaciado entre filas
            _buildInfoRow('Correo:', usuario['email'] ?? 'N/A'),
            const SizedBox(height: 8.0),
            _buildInfoRow('Tipo de Documento:', usuario['tipo_documento_usuario'] ?? 'N/A'),
            const SizedBox(height: 8.0),
            _buildInfoRow('Género:', usuario['genero_usuario'] ?? 'N/A'),
            const SizedBox(height: 8.0),
            _buildInfoRow('Rol:', usuario['rol_usuario'] ?? 'N/A'),
          ],
        ),
      ),
    );
  }

  // Widget helper para crear una fila de datos con estilo
  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: Colors.black87,
          ),
        ),
        const SizedBox(width: 8.0), // Espacio entre la etiqueta y el valor
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.black54, // Color más suave para el texto
            ),
            overflow: TextOverflow.ellipsis, // Para que no desborde
          ),
        ),
      ],
    );
  }
}

void mostrarModalAprendiz(BuildContext context, Map<String, dynamic> usuario) {
  showDialog(
    context: context,
    barrierDismissible: true, // Cierra el modal al hacer clic fuera de él
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Bordes redondeados
        ),
        elevation: 16, // Sombra
        backgroundColor: Colors.white, // Fondo blanco
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: DatosAprendiz(usuario: usuario), // Muestra el contenido del modal
        ),
      );
    },
  );
}
