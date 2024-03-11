#' Create sequence of overlapping population graphs for whole dataset.

rm( list=ls() )
library( d3r )
library( igraph )
library( gstudio )
library( popgraph )
library( jsonlite )


load("df_snps.rda")
load("df_samples.rda")
raw <- as.data.frame( df_samples )

# Add Fst to the df_snps 

if( !("Fst" %in% names(df_snps))) { 

  df_snps$Hs <- NA
  df_snps$Ht <- NA
  df_snps$Fst <- NA
  
  for( i in seq(1,nrow(df_snps))) { 
    theLoc <- df_snps$Name[i]
    
    res <- Fst( data.frame( Population = df_samples$Population, 
                            Locus = df_samples[,theLoc]) )
    
    df_snps$Fst[i] <- res$Fst[1]
    df_snps$Hs[i] <- res$Hs[1]
    df_snps$Ht[i] <- res$Ht[1]
    df_snps[1,]  
    
    if( (i %% 100) == 0 ) {
      cat(i,"\n")
    }
  }
  
  save(df_snps, file = "df_snps.rda")
}








source("humanCoordinates.R")

## Variables
baseCtr <- 1
fileCtr <- 1
numLoci <- nrow( df_snps )
windowSize <- 40 
contig <- "chr2"
groups <- raw$Population


data.frame( Population = as.character( levels( groups ) ) ) |>
  left_join(coordinates[ , c( "Population",
                              "Latitude",
                              "Longitude")],
            by="Population") -> df_coords 

# Prepare output folder
paste( contig, windowSize, sep="_") -> outDir


#if( !dir.exists(outDir) ) {
#  dir.create( outDir )
#} else { 
#  system( paste("rm ",outDir,"/*.json", sep="") )
#}

#'  died so I skipped
#'  
#' fileCtr <- 1288;  baseCtr <- 26741

toSkip <- c(1288, 1289, 1289,
            1660 )

while( baseCtr < (numLoci - 40) ) { 
  
  ## Added this to skip problematic topological regions (the ones that die)
  if( !(fileCtr %in% toSkip ) )  { 
  
    newBaseEnd <- baseCtr + 39 
    graphName <- paste(outDir, "/graph_chr2_",windowSize,"bp_",fileCtr,".json", sep="")
    cat(graphName, baseCtr, newBaseEnd, "\n")
    
    # Do not replace if you've already done it
    if( !file.exists(graphName)) { 
      
      loci <- df_snps$Name[ baseCtr:newBaseEnd]
      data <- to_mv( raw[, loci ]  )
      
      g <- popgraph(data, groups = groups)
      
      # Add the node attributes
      vertex_attr(g)$id <- vertex_attr(g)$name 
      vertex_attr(g)$longitude <- df_coords$Longitude
      vertex_attr(g)$latitude <- df_coords$Latitude 
      
      write( d3_igraph(g), file = graphName )
      dat <- read_json( graphName  )
      
      for( i in seq(1,length(dat$nodes)) ) { 
        dat$nodes[i][[1]]$name <- NULL
        dat$nodes[i][[1]]$`_row` <- NULL
        dat$nodes[i][[1]]$size <- unlist( dat$nodes[i][[1]]$size )
        dat$nodes[i][[1]]$group <- "All"
      }
      
      # Add the graph attributes
      locusData <- df_snps[ df_snps$Name %in% loci, ]
      dat$loci <- locusData$Name
      dat$location <- locusData$Location
      dat$p <- locusData$p
      dat$Ho <- locusData$Ho
      dat$He <- locusData$He
      dat$attributes <- NULL
      
      #toJSON( dat, pretty = TRUE )
      write_json( dat, path = graphName, pretty = TRUE, auto_unbox=TRUE )
      
    }
  }
  
  
  
  # Save the graph 
  fileCtr <- fileCtr + 1
  baseCtr <- baseCtr + 20 
}