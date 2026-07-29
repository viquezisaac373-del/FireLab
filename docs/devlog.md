# Devlog — FireLab

## [28 de julio del 2026] — Primer objetivo jugable completado

**Logros:**
- Configuración inicial del repositorio (README, LICENSE, vision.md)
- Proyecto de Godot 4.7 inicializado con estructura modular (scenes/, scripts/, assets/)
- Escena base: terreno (plano), iluminación direccional, cámara
- Árbol simple (primitivas: cilindro + esfera) con máquina de estados de fuego (`HEALTHY`, `BURNING`, `BURNED`)
- Interacción del jugador: click izquierdo enciende, click derecho apaga (simulando agua)
- Sistema de propagación de fuego entre árboles cercanos, basado en distancia + probabilidad
- `WeatherSystem` (autoload) con dirección y fuerza de viento ajustables en tiempo real (flechas + Re Pág/Av Pág), que influye en la propagación

**Decisiones técnicas:**
- Godot 4.7 (Forward+), GDScript
- Árbol convertido en escena reutilizable (`tree.tscn`) para poder instanciar múltiples copias
- Grupo global `"trees"` para que cada árbol pueda detectar vecinos sin acoplamiento directo
- Propagación es una simplificación de diseño (distancia + alineación con viento + aleatoriedad), no un modelo físico real — pendiente de evolucionar en fases posteriores

**Pendiente / próximos pasos:**
- Indicador visual del viento (veleta o flecha 3D) en vez de solo teclas
- Sistema de agua más realista (partículas, lanzamiento con física)
- UI básica (estado del incendio, controles visibles)
- Terreno con más variación (no solo plano)
- Empezar a pensar en el "Laboratorio" de agentes extintores (Fase 2 de la visión)

**Notas:**
- Todo el código y assets versionados en `main`, sin ramas adicionales todavía
- `.gitignore` configurado correctamente para excluir `.godot/`
