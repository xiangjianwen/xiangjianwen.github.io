# R functions used to create a new post for Hexo blog system.
new_md_post <- function(template_name="template.Rmd",post_name=NULL,template_path=getwd(),
                        post_path="../_posts",time_tag=FALSE, new_fig_path=TRUE){

    if(is.null(post_name)){
        post_name <- gsub(pattern = "^(.*)\\.[Rr]md$", "\\1", x = template_name)
    }

    input_file   <- paste(template_path,template_name, sep="/")
    
    if(time_tag){
        current_time <- Sys.Date()
        out_file     <- paste0(post_path, "/", current_time, "-", post_name,".md")
        out_dir      <- paste0(post_path, "/", current_time, "-", post_name)
    }else{
        out_file     <- paste0(post_path, "/", post_name,".md")
        out_dir      <- paste0(post_path, "/", post_name)
    }
    # if new_fig_path is FALSE, use united figure path to sotre figures
    # if this variable is TRUE, create an independent directory for post
    if (new_fig_path){
        dir.create(out_dir, showWarnings = TRUE, recursive = TRUE)
        # add fig.path option to Rmd file
        fl_content   <- readLines(input_file)
        new_content  <- sub(pattern = "fig.path=\".*\"", 
                            replacement = paste0("fig.path=\"", out_dir, "/\""), fl_content)
        writeLines(new_content, input_file)
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
