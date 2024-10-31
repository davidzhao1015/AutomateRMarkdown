library(rmarkdown)

# --------------------------------------

# Render a single group for PCA section

# -------------------------------------

groups <- c("KO-NC", "KO-HFD")

rmarkdown::render("heatmap-module.Rmd",
                  params = list(group_1 = groups[1], group_2 = groups[2]))

# ------------------------------------------------

# Iterate for multiple groups for Heatmap section

# ------------------------------------------------

groups_collection <- data.frame(group_1 = c("WT-NC", "KO-NC"), group_2
                                 = c("WT-HFD", "KO-HFD"), orders = c(1, 2))

print(groups_collection)

for (n in 1:nrow(groups_collection)) {
    
    group_1 = groups_collection$group_1[n]
    group_2 = groups_collection$group_2[n]
    order = groups_collection$orders[n]
    
    rmarkdown::render("heatmap-module.Rmd", 
                      output_file = paste0("heatmap_", group_1, "_", group_2, ".md"),
                      params = list(group_1 = group_1, 
                                    group_2 = group_2, 
                                    host = "Mice",
                                    order = order)) 
    
}

# ------------------------------------------------

# Iterate for multiple groups for PCA section

# ------------------------------------------------

groups_collection2 <- data.frame(group_1 = c("WT-NC", "KO-NC"), group_2
                                  = c("WT-HFD", "KO-HFD"), orders = c(1, 2))

print(groups_collection2)

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

# ---------------------------------

# Combine multiple rmarkdown files

# ---------------------------------

# Run the shell cat command (default shell) in R

system("cat heatmap_WT-NC_WT-HFD.md > combined_heatmap.md && echo '' >> combined_heatmap.md && cat heatmap_KO-NC_KO-HFD.md >> combined_heatmap.md")

system("cat pca_WT-NC_WT-HFD.md \> combined_pca.md && echo '' \>\>
combined_pca.md && cat pca_KO-NC_KO-HFD.md \>\> combined_pca.md")

system("cat combined_heatmap.md \> combined_two_modules.md && echo ''
\>\> combined_two_modules.md && cat combined_pca.md \>\>
combined_two_modules.md")