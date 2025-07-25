## SmartBudget - Control de Gastos Personales

### Funcionalidades Principales
- 🔐 Registro e inicio de sesión de usuarios
- ➕ Registro de ingresos/gastos con categorías
- 📊 Reportes gráficos mensuales
- 🔔 Alertas cuando excedes límites de gastos

### Guía Rápida
1. **Registro**: 
   - Crea cuenta con email y contraseña
   - Completa tu perfil

2. **Agregar transacción**:
   - Toca "+" en la pantalla principal
   - Selecciona tipo (ingreso/gasto)
   - Elige categoría y completa datos

3. **Ver reportes**:
   - Navega a la pestaña "Estadísticas"
   - Selecciona mes/año para visualizar

4. **Límites de gastos**:
   - En "Configuración" define límites por categoría
   - Recibirás alertas automáticas al superarlos

## Resultados

### Resultado 1
A continuación, se muestra la primera imagen del resultado de la codificación:

![Pantalla_Inicio_Sesion](https://github.com/user-attachments/assets/413ea1a6-fb55-44a2-a395-f31746a401aa)

### Resultado 2
Aquí está la segunda imagen que muestra otro resultado:

![Pantalla_Home](https://github.com/user-attachments/assets/cabd4046-4c77-41d9-a44a-e9e5b43fe259)


## Instrucciones de ejecución

## 🚀 Requisitos Previos

Antes de ejecutar el proyecto, asegúrate de tener instalado lo siguiente:

- ✅ [Flutter SDK](https://docs.flutter.dev/get-started/install)
- ✅ [Firebase CLI](https://firebase.google.com/docs/cli)
- ✅ [Android Studio](https://developer.android.com/studio) (o tu emulador de preferencia)
- ✅ Un dispositivo emulador o físico configurado
- ✅ Una cuenta de Firebase con un proyecto configurado

---

## ⚙️ Configuración Inicial

### 1. Clonar el repositorio

```bash
git clone https://github.com/tu-usuario/tu-repo.git
cd tu-repo
```

### 2. Conectar con Firebase

1. Ve a Firebase Console, crea un nuevo proyecto o usa uno existente.


2. Agrega una app Android al proyecto con tu package name.


3. Descarga el archivo google-services.json y colócalo en la ruta:


```bash
android/app/google-services.json
```

4. Verifica que tu archivo android/build.gradle y android/app/build.gradle estén correctamente configurados con los plugins de Firebase.



3. Instalar dependencias

```bash
flutter clean
flutter pub get

```
▶️ Correr la Aplicación

Con un emulador Android corriendo o un dispositivo conectado, ejecuta:

```bash
flutter run
```

🛠️ Comandos Útiles

```bash
flutter doctor       # Verifica que todo esté correctamente instalado
flutter devices      # Muestra los dispositivos disponibles
flutter build apk    # Genera el APK para producción

```