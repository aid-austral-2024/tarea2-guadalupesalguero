# Importar librerías
library(quarto)
library(glue)

# Diccionario de especialidades
especialidades <- c("8" = "Metalurgica", 
                    "9" = "Electrica", 
                    "17" = "Electronica", 
                    "18" = "Mecanica", 
                    "24" = "Industrial")

# Directorio de resultados
output_dir <- "../results/"

# Crear el directorio de resultados si no existe
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}

# Generar los HTML
for (codigo in names(especialidades)) {
  # Obtener el nombre de la especialidad
  nombre <- especialidades[codigo]
  
  # Nombre del archivo de salida
  temp_output <- paste0(codigo, "_", nombre, ".html")
  
  # Renderizar el informe
  quarto::quarto_render(
    input = "../index.qmd", 
    output_format = "html",
    output_file = temp_output,  # Guardar temporalmente en el directorio actual
    execute_params = list(especialidad = codigo)  # Parámetros
  )
  
  # Mover el archivo generado a la carpeta de resultados
  final_output <- file.path(output_dir, temp_output)
  file.rename(temp_output, final_output)
  
  message(glue("Informe generado: {final_output}"))
}



