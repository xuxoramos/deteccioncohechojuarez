# GlassBox
Sistema de detección temprana de posibles actos de cohecho en compras y licitaciones de obra pública para Ciudad Juárez.

# Intención
Se desea construir un sistema inteligence donde se ingresen los datos generales de una licitación y alguno de sus concursantes y que retorne una probabilidad entre 0 y 1 que ese concurso puede decantar en algún acto de cohecho, dado lo siguiente, pero sin limitarse a:
- Dependencia que anuncia la licitación
- Empresa concursante
- Monto
- Fechas
- Articulos u obra concursada
- Etc

# Datos disponibles
- *data/raw/Compras y Contratos Municipales Cd. Juarez COPIA (3).xlsx* - Archivo que contiene todas las compras y licitaciones, sus ganadores, sus participantes, la agencia de gobierno que lanza la convocatoria, etc.
- *Dependencias y Directores Cd. Juarez 2019.xlsx* - Catálogo que contiene las dependencias que forman el gobierno local de Cd. Juárez, y las personas que encabezan cada dependencia, unidad o departamento.
- *Tabla de Socios Padron de Proveedores Juárez Excel.xlsx* - Catálogo de socios de las empresas registradas como proveedores del gobierno de Cd. Juárez.

# Metodología
1. Comenzar con un análisis exploratorio. Se puede hacer un sanity check a través de la plataforma de Plan Estratégico Juárez, donde hay una serie de visualizaciones descriptivas para soportar la labor de análisis exploratorio.
2. Modelar las relaciones entre empresas, dependencias, montos, frecuencia de otorgamiento y otras variables a manera de grafo.