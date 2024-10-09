import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatosAprendiz extends StatelessWidget {
  final Map<String, dynamic> usuario;

  const DatosAprendiz({required this.usuario, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Título con estilo más elegante
          Row(
            children: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(CupertinoIcons.clear,
                    color: CupertinoColors.systemGrey),
                onPressed: () {
                  Navigator.pop(context); // Cierra el bottom sheet
                },
              ),
              const Expanded(
                child: Center(
                  child: Text(
                    'Detalles del Aprendiz',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: CupertinoColors.black, // Color más oscuro y suave
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),

          // Contenedor de la información con fondo sutil
          Container(
            decoration: BoxDecoration(
              color: CupertinoColors.secondarySystemFill,
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('Nombre de usuario:', usuario['username']),
                const SizedBox(height: 8.0),
                _buildInfoRow('Correo:', usuario['email'] ?? 'N/A'),
                const SizedBox(height: 8.0),
                _buildInfoRow('Tipo de Documento:',
                    usuario['tipo_documento_usuario'] ?? 'N/A'),
                const SizedBox(height: 8.0),
                _buildInfoRow('Género:', usuario['genero_usuario'] ?? 'N/A'),
                const SizedBox(height: 8.0),
                _buildInfoRow('Rol:', usuario['rol_usuario'] ?? 'N/A'),
              ],
            ),
          ),
        ],
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
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
            color: CupertinoColors.systemGrey,
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 16.0,
              color: CupertinoColors.black, // Color de texto mejorado
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

void mostrarBottomSheetAprendiz(
    BuildContext context, Map<String, dynamic> usuario) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: CupertinoColors.white, // Fondo blanco clásico
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return Container(
        height: 400, // Altura del BottomSheet
        padding: const EdgeInsets.only(top: 16),
        child: DatosAprendiz(usuario: usuario),
      );
    },
  );
}
