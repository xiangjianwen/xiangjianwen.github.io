# a R function used to create a new post for Hexo blog system.
new_md_post <- function(post_name=NULL,template_path=getwd(), post_path=getwd(),
                     template_name="template.Rmd"){
    if(is.null(post_name)){
        stop("A post name must be given!")
    }
    
    input_file   <- paste(template_path,template_name, sep="/")
    current_time <- Sys.Date()
    out_file     <- paste0(current_time, "-",post_name,".md")
    knitr::knit(input = input_file, output = out_file)
    print("New markdown post creat successfully!")
}


new_rmd_post <- function(post_name=NULL,template_path=getwd(), post_path=getwd(),
                        template_name="template.Rmd"){
    if(is.null(post_name)){
        stop("A post name must be given!")
    }
    
    input_file   <- paste(template_path,template_name, sep="/")
    current_time <- Sys.Date()
    out_file     <- paste0(current_time, "-",post_name,".Rmd")
    knitr::knit(input = input_file, output = out_file)
    print("New Rmarkdown post creat successfully!")
}