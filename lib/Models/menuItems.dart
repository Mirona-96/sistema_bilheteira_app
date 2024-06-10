import 'package:flutter/material.dart';
import 'package:sistema_bilheteira_app_teste_2/Models/menuDetalhes.dart';

final List<MenuDetalhes> menuItems = [
  MenuDetalhes(
    titulo: 'Pagina Inicial',
    icon: Icons.house,
    pagina: '/homepage',
  ),
  MenuDetalhes(
    titulo: 'Clientes',
    icon: Icons.person,
    pagina: '/clientes',
  ),
  MenuDetalhes(
    titulo: 'Bilhetes',
    icon: Icons.event,
    pagina: '/bilhetes',
  ),
  MenuDetalhes(
    titulo: 'Vendas',
    icon: Icons.shopping_cart,
    pagina: '/vendas',
  )
];
