# R functions used to create a new post for Hexo blog system.
new_md_post <- function(post_name=NULL,template_name="template.Rmd",template_path=getwd(), 
                        post_path=getwd(),time_tag=FALSE){
    
    if(is.null(post_name)){
        post_name <- gsub(pattern = "^(.*)\\.[Rr]md$", "\\1", x = template_name)
    }
    
    input_file   <- paste(template_path,template_name, sep="/")
    # retrieve system date
    if(time_tag){
        current_time <- Sys.Date()
        out_file     <- paste0(post_path, "/", current_time, "-",post_name,".md")
    }else{
        out_file     <- paste0(post_path, "/", post_name,".md")
    }

    knitr::knit(input = input_file, output = out_file)
    print("New markdown post creat successfully!")
}


new_rmd_post <- function(post_name=NULL,template_name="template.Rmd",
                         template_path=getwd(), post_path=getwd()){
    if(is.null(post_name)){
        stop("A post name must be given!")
    }
    
    input_file   <- paste(template_path,template_name, sep="/")
    current_time <- Sys.Date()
    out_file     <- paste0(current_time, "-",post_name,".Rmd")
    fl_content   <- readLines(input_file)
    writeLines(fl_content, out_file)
    print("New Rmarkdown post creat successfully!")
}