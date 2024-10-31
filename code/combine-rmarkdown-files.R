library(rmarkdown)

if (requireNamespace("rstudioapi", quietly = TRUE) && rstudioapi::isAvailable()) {
  setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
  print(getwd())  # Confirm the change
} else {
  print("rstudioapi is not available.")
}

# ------------------------------------------------

# Iterate for multiple groups for PCA section

# ------------------------------------------------

groups_collection2 <- data.frame(group_1 = c("WT-NC", "KO-NC"), 
                                 group_2 = c("WT-HFD", "KO-HFD"), 
                                 orders = c(1, 2))

# Iterate over different groups 
for (n in 1:nrow(groups_collection2)) {
      
    group_1 = groups_collection2$group_1[n]
    group_2 = groups_collection2$group_2[n]
    order = groups_collection2$orders[n]
    
    rmarkdown::render("pca-module.Rmd", 
                      output_file = paste0("pca_", group_1, "_", group_2, ".md"),
                      params = list(group_1 = group_1, 
                                    group_2 = group_2, 
                                    host = "Mice",
                                    order = order)) 
    
}

# ----------------------------------------

# Combine multiple rmarkdown files

# ---------------------------------------

# Run the shell cat command (default shell) in R

system("cat pca_WT-NC_WT-HFD.md > combined_pca.md && echo >> combined_pca.md && cat pca_KO-NC_KO-HFD.md >> combined_pca.md")

