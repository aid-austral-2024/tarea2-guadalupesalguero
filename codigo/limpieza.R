# Importar librerias
library(readxl)
library(dplyr)
library(ggplot2)
library(tidyr)


# Importar las tablas
data_academica_1 <- read_excel("../data_original/Analisis academico industrial 2001..2016.xlsx", skip = 4)
data_academica_2 <- read_excel("../data_original/Analisis academico industrial 2016..2024.xlsx", skip = 4)
alumnos <- read_excel("../data_original/Informacion Alumnos Industrial.xlsx", skip = 4)

# Cargar una funcion para hacer la limpieza de mis dos primeros dataset

procesar_dataset <- function(data) {
  
  # Pasar columnas a minuscula
  colnames(data) <- tolower(colnames(data))
  
  # Renombrar columnas
  data <- data %>%
    rename(
      apellido_nombres = `apellido y nombres`,
      nombre_carrera = nombre...3,
      especialidad = esp.,
      anio_ingreso = ingr.,
      cod_materia = materia,
      nombre_materia = `nombre de materia`,
      cod_estado = est,
      examen_regular = examen,
      examen_ap_directa = `examen ap directa`,
      tipo_secundario = `nombre estudio`,
      cod_postal = cod.pos.,
      escuela_secundaria = nombre...20,
      especialidad_secundario = `nombre estudio`
    )
  
  # Sacar las comillas de las fechas
  data$examen_regular <- gsub("'", "", data$examen_regular)
  data$examen_ap_directa <- gsub("'", "", data$examen_ap_directa)
  
  # Dividir columnas en fechas y notas
  exam <- strsplit(as.character(data$examen_regular), " - ")
  exam_ap <- strsplit(as.character(data$examen_ap_directa), " - ")
  
  data$fecha_examen_reg <- as.Date(sapply(exam, `[`, 1), format = "%d/%m/%Y")
  data$nota_examen_reg <- as.numeric(sapply(exam, `[`, 2))
  
  data$fecha_examen_ap <- as.Date(sapply(exam_ap, `[`, 1), format = "%d/%m/%Y")
  data$nota_examen_ap <- as.numeric(sapply(exam_ap, `[`, 2))
  
  # Crear la columna 'Cohorte'
  data <- data %>%
    mutate(cohorte = ifelse(anio_ingreso >= 2001, 
                            as.numeric(anio_ingreso), "2001"))
  
  # Crear la columna 'Aprobado'
  fecha_corte <- as.Date("2017-03-31")
  data <- data %>%
    mutate(aprobado = case_when(
      (!is.na(nota_examen_reg) & !is.na(fecha_examen_reg) & fecha_examen_reg 
       <= fecha_corte & nota_examen_reg >= 4) |
        (!is.na(nota_examen_ap) & !is.na(fecha_examen_ap) & fecha_examen_ap 
         <= fecha_corte & nota_examen_ap >= 4) ~ "Aprobado",
      
      (!is.na(nota_examen_reg) & !is.na(fecha_examen_reg) & fecha_examen_reg 
       > fecha_corte & nota_examen_reg >= 6) |
        (!is.na(nota_examen_ap) & !is.na(fecha_examen_ap) & fecha_examen_ap 
         > fecha_corte & nota_examen_ap >= 6) ~ "Aprobado",
      TRUE ~ "No aprobado"
    ))
  
  columnas <- c("legajo", "cod_materia", "nombre_materia", "recursa", "año", 
                "estado", "fecha_examen_reg", "nota_examen_reg", "fecha_examen_ap",
                "nota_examen_ap","cohorte", "aprobado")
  
  data <- data %>%
    select(all_of(columnas))
  
  return(data)
}


data_academica_1 <- procesar_dataset(data_academica_1)
data_academica_2 <- procesar_dataset(data_academica_2)

data_academica<- bind_rows(data_academica_1, data_academica_2)


write.csv(data_academica, "../data_clean/data_academica.csv", row.names = FALSE)



# Limpieza de datos Alumnos

# pasar todas las columnas a minuscula
colnames(alumnos) <- tolower(colnames(alumnos))

# Renombrar columnas
alumnos <- alumnos %>%
  rename(
    apellido_nombre = `apellido y nombres`,
    tipo_documento = t.doc.,
    especialidad = esp.,
    nombre_carrera_abrev = abrev.,
    plan = plan,
    nombre_consorcio = `nombre del consorcio`,
    anio_ingreso = ingr.,
    tipo_ingreso = ingreso,
    orientacion = orientación,
    nombre_carrera = `nombre del título`,
    cod_escuela = escuela,
    nombre_escuela_Secundaria = nombre...16,
    especialidad_secundario = `nombre estudio`,
    cod_estado_titulo = `cod. est.`,
    estado_titulo = `estado título`,
    cod_postal = cod.pos.,
    cod_estado_alumno = estado,
    estado_alumno = nombre...24,
    nombre_extension = `nombre extensión`,
    fecha_asim_plan = `f. asim.`,
    fecha_asim_plan_2023 = `fecha asimilación plan 2023`,
    link_tramite_sube = `link teámite sube`,
    fecha_tramite_sube = `inicio del tramite sube`,
    respuesta_sube = `respuesta sube`,
    tid_tram_sube_ministerio = `tid trámite ministerio`
  )


columnas_alumnos <- c("legajo", "apellido_nombre", "sexo", "especialidad",
                      "nombre_carrera", "plan", "anio_ingreso", "tipo_ingreso",
                      "plan", "cod_escuela", "nombre_escuela_Secundaria",
                      "especialidad_secundario", "estado_titulo", "cod_postal", 
                      "ciudad","cod_estado_alumno","estado_alumno")             

alumnos <- alumnos %>%
  select(all_of(columnas_alumnos))


write.csv(alumnos, "../data_clean/data_alumnos.csv", row.names = FALSE)

# Unir las tablas por legajo
data_combinada <- left_join(data_academica, alumnos, by = "legajo")
write.csv(data_combinada, "../data_clean/data_combinada.csv", row.names = FALSE)
