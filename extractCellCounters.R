# Function that extracts the counts of marker types from .xml cell counter files
# generated with imageJ/Fiji cell counter plugin.
# Dependencies: xml2, purrr, dplyr, tibble, tidyr

# Function to count markers in a single XML file
count_markers <- function(file_path) {
  # Read XML file
  xml_data <- read_xml(file_path)
  
  # Extract all Marker_Type nodes
  marker_types <- xml_find_all(xml_data, ".//Marker_Type")
  
  # Create a named vector to store counts
  counts <- map_dbl(marker_types, ~ {
    type_name <- xml_text(xml_find_first(.x, "./Name"))
    markers <- xml_find_all(.x, "./Marker")
    length(markers)
  })
  
  # Get type names
  type_names <- map_chr(marker_types, ~ xml_text(xml_find_first(.x, "./Name")))
  names(counts) <- type_names
  
  # Add filename and convert to tibble
  as_tibble(as.list(counts)) %>% 
    mutate(filename = basename(file_path), .before = 1)
}

# Function to process all XML files in a folder
extractCellCounters <- function(folder_path) {
  # Get all XML files in the folder
  xml_files <- list.files(path = folder_path, 
                          pattern = "\\.xml$", 
                          full.names = TRUE)
  
  # Process all files and combine results
  result <- map_dfr(xml_files, count_markers)
  
  # Replace NA with 0 for types that exist in some files but not others
  result <- result %>% 
    mutate(across(-filename, ~ tidyr::replace_na(.x, 0)))
  
  return(result)
}

# Example usage:
#results <- extractCellCounters("path/to/your/xml/files")
# View(results)
