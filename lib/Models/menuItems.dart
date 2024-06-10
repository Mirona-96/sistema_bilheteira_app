import 'package:flutter/material.dart';
import 'package:sistema_bilheteira_app_teste_2/Models/menuDetalhes.dart';

final List<MenuDetalhes> menuItems = [
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
  ),
  MenuDetalhes(
    titulo: 'Relatórios',
    icon: Icons.assessment,
    pagina: '/relatorios',
  ),
];
