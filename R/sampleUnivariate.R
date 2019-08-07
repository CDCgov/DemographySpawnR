
#' Univariate sampling of variables through a dataset
#'
#' Takes any dataset, checks format of each variable and based on distributions of the original variables
#' randomly samples into a new dataset n times.
#'
#' Returns distributionally similar dataset with user-specified number of rows
#'
#' @param inputData dataset that you want to sample from
#' @param n number of rows in output/simulated dataset
#' @param dateFormat format of the date variable(s) (if one exists) in the original dataset. Default is "YYYYMMDD."
#'     A set of formats can be input with c().
#'
#' @return A dataset with n rows that is distributionally similar to input dataset.
#'
#'
#' @export
#'
#'
#' @importFrom fitdistrplus fitdist gofstat
#' @importFrom lubridate as_date
#' @importFrom truncnorm rtruncnorm
#' @importFrom ks kde rkde
#' 
#' @examples
#' sampleUnivariate(dat, 10)

sampleUnivariate = function (inputData, n, dateFormat = "%Y%m%d") {
  
  simData = data.frame(matrix(nrow = n, ncol = ncol(inputData)))
  inputData = data.frame(inputData)
  ## getting distribution of each variable and randomly sampling from that to get new dataset
  
  possibleDates = which(sapply(inputData,
                               function(x)
                                 !all(is.na(lubridate::as_date(as.character(x),
                                                    format=dateFormat, tz = "America/New_York")))))
  
  possibleDates
  
  for (k in (unname(possibleDates))) {
    
    
    kernalDates = ks::kde(c(na.omit(as.numeric(lubridate::as_date(as.POSIXct(as.character(inputData[, k]), format = dateFormat))))))
    
    simData[, k] = lubridate::as_date(floor(ks::rkde(n, kernalDates)))
    
    simData[, k] = t(unname(data.frame(lapply(simData[, k], 
                                              function(cc) cc[sample(c(NA, TRUE), 
                                                                     prob = c(sum(is.na(inputData[, k])), nrow(inputData)-sum(is.na(inputData[, k]))),
                                                                     size = 1, replace = TRUE)]))))
    
    names(simData)[k] = names(inputData)[k]
  }
  #   
  
  
  for (i in 1:ncol(inputData))  { # (1)
    if (i %in% unname(possibleDates)) next
    
    # if (any(str_detect(complete.cases(as.character(inputData[,i])), datePattern))) {
    #
    #   dateFormatted = as.Date(as.charaMcter(inputData[,i]))
    #
    #
    #   dates2 = sample(seq(min(dateFormatted, na.rm = T),
    #                       max(dateFormatted, na.rm = T), by ="day"), n)
    #
    #   simData[,i] = dates2
    #
    # }
    #
    

    if (length(unique(inputData[, i])) < 10 ) {
      
      simData[,i] = sample(c(as.character(as.data.frame(table(inputData[,i], exclude = NULL))$Var1)), n, TRUE,
                           prob = c(as.data.frame(table(inputData[,i], exclude = NULL))$Freq)
      )
      
    }
    
    else if (!is.numeric(inputData[, i]) & nlevels(as.factor(inputData[,i])) > 10){simData[, i] = NA}
    
    else if (all(is.na(inputData[, i])) |
              (all(is.character(inputData[,i])) & length(unique(inputData[,i])) == nrow(inputData))) next
    
    ### RETURNS NA's
    
    
    else if (any(na.omit(inputData[,i]) %% 1 == 0)) {
      
      
      # fitNormal  <- fitdist(c(na.omit(inputData[,i])), "norm", method = "mle")
      # fitGamma   <- fitdist(c(na.omit(inputData[,i])), "gamma", method = "mle")
      # fitLogNorm <- fitdist(abs(inputData[,i]), "lnorm", method = "mme")
      # fitWeibull <- fitdist(inputData[,i], "weibull", method = "mge")
      
      
      # listFits = list(fitNormal, fitGamma)#, fitWeibull)
      # 
      # fits = gofstat(listFits, fitnames=c("norm", "gamma"))#, "weibull"))
      
      # simData[,i] = round(eval(parse(text = paste0("r", names(which.min(fits$aic)), '(', 'n, ',
      #                              listFits[[which.min(fits$aic)[[1]]]][[1]][[1]], ', ',
      #                              listFits[[which.min(fits$aic)[[1]]]][[1]][[2]], ')'))))
      if (min(inputData[,i], na.rm = T) == 0) {
        simData[, i] = truncnorm::rtruncnorm(n, mean = mean(inputData[, i], na.rm = T), sd = sd(inputData[, i], na.rm = T), a = min(inputData[, i], na.rm = T), b = Inf)
        simData[, i] = t(unname(data.frame(lapply(simData[, i], 
                                                  function(cc) cc[sample(c(NA, TRUE), 
                                                                         prob = c(sum(is.na(inputData[, i])), nrow(inputData)-sum(is.na(inputData[, i]))),
                                                                         size = 1, replace = TRUE)]))))
      }
      
      else {
        simData[, i] = round(truncnorm::rtruncnorm(n, mean = mean(inputData[, i], na.rm = T), sd = sd(inputData[, i], na.rm = T), a = min(inputData[, i], na.rm = T), b = Inf))
        
        
        ## Below, is a function that adds NA's randomly with a probability of insertion in each row 
        ## equal to the proportion of NA's in the original dataset
        
        simData[, i] = t(unname(data.frame(lapply(simData[, i], 
                                                  function(cc) cc[sample(c(NA, TRUE), 
                                                                         prob = c(sum(is.na(inputData[, i])), nrow(inputData)-sum(is.na(inputData[, i]))),
                                                                         size = 1, replace = TRUE)]))))
      }
      
    } else {
      
      # simData[,i] = eval(parse(text = paste0("r", names(which.min(fits$aic)), '(', 'n, ',
      #                              listFits[[which.min(fits$aic)[[1]]]][[1]][[1]], ', ',
      #                              listFits[[which.min(fits$aic)[[1]]]][[1]][[2]], ')')))
        simData[, i] = (truncnorm::rtruncnorm(n, mean = mean(inputData[,i], na.rm = T), sd = sd(inputData[,i], na.rm = T), a = min(inputData[, i], na.rm = T), b = Inf))
        
        
        ## Below, is a function that adds NA's randomly with a probability of insertion in each row 
        ## equal to the proportion of NA's in the original dataset
        
        simData[, i] = t(unname(data.frame(lapply(simData[, i], 
                                                function(cc) cc[sample(c(NA, TRUE), 
                                                                       prob = c(sum(is.na(inputData[, i])), nrow(inputData)-sum(is.na(inputData[, i]))),
                                                                       size = 1, replace = TRUE)]))))
    }
    
  } #close big for loop (1)
  
  
  names(simData) = names(inputData)
  return(data.frame(simData))
  
}

