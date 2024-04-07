@echo off
setlocal
color 0f

REM Solicitar al usuario el nombre y apellido del cliente
echo Generador de repositorio - Reve Estudio Tecnico - v1.0
set /p nombre_cliente="Ingrese el nombre y apellido del cliente (en ese orden): "
set /p nombre_proyecto="Ingresar el nombre de proyecto: "

REM Separar el nombre y el apellido
for /f "tokens=1,2" %%A in ("%nombre_cliente%") do (
    set "nombre=%%A"
    set "apellido=%%B"
)

REM Obtener las iniciales del nombre y el apellido
set "iniciales_cliente=%nombre:~0,1%%apellido:~0,1%"

REM Generar un ID único para el cliente (puedes utilizar la fecha y hora actual)
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set datetime=%%I
set "ID_cliente=%iniciales_cliente%%datetime:~0,8%%datetime:~8,4%"

REM Crear el nombre de la carpeta con el formato deseado
set "nombre_carpeta=%nombre_cliente% - %nombre_proyecto% - %ID_cliente%"

REM Verificar si la carpeta "Clientes" existe
if exist "Clientes" (
    cd "Clientes"
) else (
    mkdir "Clientes"
    cd "Clientes"
)

REM Ahora puedes continuar con el resto de tu script aquí...


REM Verificar si el archivo de registro de clientes existe
if not exist registroClientes.csv (
    echo Creando nuevo archivo de registro de clientes...
    echo Cliente,Proyecto,ID > registroClientes.csv
)

REM Agregar el nuevo cliente al archivo de registro de clientes
echo %nombre_cliente%,%nombre_proyecto%,%ID_cliente%>> registroClientes.csv

REM Verificar si la carpeta del cliente ya existe
if exist "%nombre_cliente%" (
    echo La carpeta del cliente ya existe.
    cd "%nombre_cliente%"
) else (
    echo La carpeta del cliente no existe. Se creará una nueva.
    MD "%nombre_cliente%"
    cd "%nombre_cliente%"
)


REM Crear las subcarpetas necesarias
call :CrearSubcarpetas
goto :eof

:CrearSubcarpetas
        MD "%nombre_proyecto% - %ID_cliente%"
        CD "%nombre_proyecto% - %ID_cliente%"
        MD "Planos - %nombre_cliente% - %nombre_proyecto% - %ID_cliente%"
            CD "Planos - %nombre_cliente% - %nombre_proyecto% - %ID_cliente%"
            MD "exportPdf - %nombre_cliente% - %nombre_proyecto% - %ID_cliente%"
        CD ..
        MD "3D - %nombre_cliente% - %nombre_proyecto% - %ID_cliente%"
        MD "Renders - %nombre_cliente% - %nombre_proyecto% - %ID_cliente%"
            CD "Renders - %nombre_cliente% - %nombre_proyecto% - %ID_cliente%"
            MD "exportImg - %nombre_cliente% - %nombre_proyecto% - %ID_cliente%"
            MD "exportMpg - %nombre_cliente% - %nombre_proyecto% - %ID_cliente%"
        CD ..
        MD "Post - %nombre_cliente% - %nombre_proyecto% - %ID_cliente%"
            CD "Post - %nombre_cliente% - %nombre_proyecto% - %ID_cliente%"
            MD "basePsd - %nombre_cliente% - %nombre_proyecto% - %ID_cliente%"
            MD "baseAi - %nombre_cliente% - %nombre_proyecto% - %ID_cliente%"
            MD "baseAep - %nombre_cliente% - %nombre_proyecto% - %ID_cliente%"
        CD ..
        MD "Docs - %nombre_cliente% - %nombre_proyecto% - %ID_cliente%"
        MD "Notas - %nombre_cliente% - %nombre_proyecto% - %ID_cliente%"
        MD "Entrega - %nombre_cliente% - %nombre_proyecto% - %ID_cliente%"
            CD "Entrega - %nombre_cliente% - %nombre_proyecto% - %ID_cliente%"
            MD "exportPdf - %nombre_cliente% - %nombre_proyecto% - %ID_cliente%"
            MD "exportImg - %nombre_cliente% - %nombre_proyecto% - %ID_cliente%"
            MD "exportMpg - %nombre_cliente% - %nombre_proyecto% - %ID_cliente%"        
    exit /b