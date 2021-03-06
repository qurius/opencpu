#simple closure store for request data
req <- local({
  state = NULL;
  
  init <- function(reqdata){
    state <<- reqdata;
  };
  
  reset <- function(){
    init(NULL);
  }
  
  getvalue <- function(name){
    if(is.null(state)){
      stop("req not initiated.")
    }
    return(state[[name]]);
  };
  
  method <- function(){
    getvalue("METHOD");
  };
  
  uri <- function(){
    #this will result in relative url redirects
    #return(mount())
    
    #this will result in absolute url redirects
    return(fullmount())
  };
  
  mount <- function(){
    getvalue("MOUNT");
  };
  
  fullmount <- function(){
    getvalue("FULLMOUNT");    
  }
  
  path_info <- function(){
    getvalue("PATH_INFO");
  };  
  
  post <- function(){
    postvar = getvalue("POST");
    if(is.null(postvar)) {
      postvar = list();
    }
    return(postvar)
  };
  
  get <- function(){
    getvar = getvalue("GET");
    if(is.null(getvar)) {
      getvar = list();
    }
    return(lapply(getvar, parse_arg_prim))
  };
  
  args <- function(){
    if(method() %in% c("PUT", "POST")){
      return(post());
    } else {
      return(get());
    }
  };
  
  files <- function(){
    filevar = getvalue("FILES");
    if(is.null(filevar)) {
      filevar = list();
    }
    return(filevar)      
  };
  
  environment();
});