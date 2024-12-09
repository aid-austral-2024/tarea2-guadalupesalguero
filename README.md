# **Automatización de Reportes Académicos UTN FRSN**

Este repositorio contiene la **Tarea 2** de la materia **Análisis Inteligente de Datos**, centrada en la automatización de reportes académicos para la **Universidad Tecnológica Nacional, Facultad Regional San Nicolás (UTN FRSN)**.

------------------------------------------------------------------------

## **Autores**

-   **María Guadalupe Salguero**

------------------------------------------------------------------------

## **Descripción del Proyecto**

<img src="images/DSC_4237_Moment.jpg" data-fig-align="center"
width="356" />

El objetivo principal del proyecto es automatizar la generación de reportes académicos anuales que describen el estado de los estudiantes a lo largo del año en curso.

Los informes se centran en analizar diferentes aspectos de las carreras de grado, como: 1. **Estado Académico General**: Distribución de estudiantes por estados académicos, incluyendo aprobados, en curso y recursantes. 2. **Desglose por Años y Género**: Enfoque en la inclusión y análisis de género en el marco de políticas institucionales. 3. **Análisis por Materias**: Evaluación de materias básicas y específicas, así como el desempeño comparativo de estudiantes provenientes de diferentes formaciones técnicas.

La automatización del proceso permite: - Generar informes personalizados por especialidad (e.g., Ingeniería Industrial). - Detallar aspectos clave, como materias con mayor índice de recursantes y el rendimiento por género. - Tomar decisiones estratégicas basadas en los resultados obtenidos.

------------------------------------------------------------------------

## **Datos Utilizados**

Los datos fueron extraídos de **Sysacad**, el sistema de gestión académica de la UTN FRSN, y contienen: - Información personal y académica de los estudiantes. - Historial académico detallado con materias, notas, estados y fechas.

------------------------------------------------------------------------

## **Objetivos**

1.  **Cargar y Limpiar los Datos**: Preparar los datos importados desde archivos en formato Excel (`.xlsx`) para su análisis.
2.  **Automatización de Informes**: Generar reportes dinámicos y personalizados por especialidad utilizando Quarto.
3.  **Identificación de Problemas Académicos**: Detectar materias críticas y grupos de estudiantes en riesgo.

------------------------------------------------------------------------

## **Estructura del Proyecto**

La estructura de archivos del repositorio es la siguiente:

``` plaintext
/tarea2-guadalupesalguero/
├── /codigo/                                  # Carpeta con scripts de limpieza y análisis
│    ├── limpieza.R                           # Script de limpieza y transformación de datos
│    ├── generar_informes.R                   # Automatización de reportes
├── /data_clean/                              # Datos procesados y listos para análisis
│    ├── data_academica.csv                   # Datos consolidados
│    ├── data_alumnos.csv                     # Datos de alumnos luego de la limpieza
│    ├── data_combinada.csv                   # Datos academicos luego de la limpieza
├── /data_original/                           # Datos extraidos del sistema de gestion
│    ├── Analisis academico 2001..2016.xlsx   # Datos academicos años 2001 - 2016
│    ├── Analisis academico 2016..2024.xlsx   # Datos academicos años 2016 - 2024
│    ├── Información Alumnos.xlsx             # Información de alumnos
├── /results/                                 # Reportes generados
│    ├── 17_Electronica.html                  # Reporte Ingeniería Electronica
│    ├── 18_Mecanica.html                     # Reporte Ingeniería Mecánica
│    ├── 24_Industrial.html                   # Reporte Ingeniería Industrial
│    ├── 8_Metalurgica.html                   # Reporte Ingeniería Metalúrgica
│    ├── 9_Electrica.html                     # Reporte Ingeniería Eléctrica
├── index.qmd                                 # Script Quarto para generar informes dinámicos
├── index.html                                # Ejemplo de informe
├── README.md                                 # Documentación del proyecto
├── enunciado.md                              # Descripción de la tarea
└── .gitignore                                # Archivos que Git ignorará
```

------------------------------------------------------------------------

## Instrucciones de Ejecución

1.  Preparación de Entorno:

-   Instalar Quarto: Instrucciones de instalación.
-   Instalar librerías necesarias en R: readxl, dplyr, ggplot2, kableExtra, entre otras.

2.  Ejecución del Análisis y Generación de Reportes: Ejecuta el archivo Quarto limpieza.qmd para limpiar los datos y generar los informes.

```         
quarto render limpieza.qmd
```

3.  Automatización de Informes:

Usa el script generar_informes.R para generar informes dinámicos por especialidad:

```         
source("codigo/generar_informes.R")
```

4.  Archivos Resultantes: Los reportes generados estarán disponibles en la carpeta `/results/` con nombres descriptivos como `24_Industrial.html`.

## Observaciones

Este proyecto fue desarrollado como parte de la materia Análisis Inteligente de Datos. Los datos no son reales, son una imitacion de las fuentes de datos para mantener la confidencialidad.
