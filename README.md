# Menaka model

Este codigo ejecuta el modelo de Menaka


Estando en la carpeta principal del proyecto, deberemos escribir el siguiente comando en la consola. 

```
addpath(genpath(pwd))
```
Esto agregara las carpeta al path de matlab. Esto nos permitira ejecutar cualquier funcion que este dentro de las carpetas del proyecto 

Luego para compilar el modelo deberemos escribir
```
ModelCompiler
```
Esto creara un fichero binario llamado "MenakaModel"

Para abrir el fichero de matlab que ejectura el modelo varias veces escribe:
```
open RunModel_SeveralParameters
```

Para ejecutar el script 

```
RunModel_SeveralParameters
```

Existe una fichero de matlab llamado "PlotSimulations" que permite visualizar los resultados.

```
PlotSimulations
```
