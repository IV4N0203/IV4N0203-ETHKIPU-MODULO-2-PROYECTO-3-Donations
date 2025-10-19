# IV4N0203-ETHKIPU-MODULO-2-PROYECTO-3-Donations
Contrato Donations

Proyecto 3 del Modulo 2 de Ethereum Developer Pack. 
Contrato educativo para gestionar donaciones en Ethereum
En este proyecto se trabajo con los siguientes temas:

Este contrato permite:

Recibir donaciones en ETH (vía donar(), receive(), o fallback()).

Registrar donantes en un mapping (historial de donaciones por dirección).

Retirar fondos solo por el beneficiario designado (patrón de acceso controlado).

Eventos y errores personalizados para transparencia y seguridad.

⚠️ Advertencia: Diseñado con fines educativos. No usar en producción sin auditoría.

Este fue el tercer proyecto práctico y con él abordamos los siguientes temas:

Funciones private, internal y payable

Mappings

Variables del tipo address y sus propiedades

Manipulación de Ether

Transferencias de Ether

Manejo de errores

Errores personalizados

Control de acceso

Modificadores (modifiers)

Constructores (constructors)

Modificadores de variables de estado (immutable y constant)

Patrones de seguridad y buenas prácticas

🚀 Cómo ejecutarlo

Abrir Remix: Ve a https://remix.ethereum.org.

Crear archivo:
Haz clic en "File Explorer" (icono de carpeta).
Crea un nuevo archivo llamado Donations.sol y pega el código.

Compilar:
Ve a la pestaña "Solidity Compiler".
Selecciona Compiler Version 0.8.26.
Haz clic en "Compile Donations.sol".

Desplegar:
Ve a la pestaña "Deploy & Run Transactions".
Selecciona el entorno "Injected Provider" (si usas MetaMask) o "JavaScript VM" (para pruebas locales).
Ingresa la dirección del beneficiario (ej: 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2).
Haz clic en "Deploy".

Interactuar:
Donar: Envía ETH a la dirección del contrato o llama a donar() con valor.
Retirar: Llama a retirar(_valor) solo desde la cuenta del beneficiario.

Contrato desplegado: https://sepolia.etherscan.io/address/0x464A035978D28cc9478aFf4e636F88C157F7F9B2

Direcion (Sepolia): 0x464A035978D28cc9478aFf4e636F88C157F7F9B2
