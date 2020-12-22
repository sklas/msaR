#' as.sequences 
#' 
#' functionality to convert sequence objects into R lists that can be serialized to 
#' JS as JSON. Currently, this can handle character objects which are interpreted 
#' as filenames or several of the popular means of storing sequence data: \code{\link[ape]{DNAbin}}, 
#' \code{\link[Biostrings]{DNAStringSet}}, \code{\link[Biostrings]{AAStringSet}},
#' \code{\link[Biostrings]{RNAStringSet}}, \code{\link[Biostrings]{BStringSet}},
#' \code{\link[Biostrings]{DNAMultipleAlignment}}, \code{\link[Biostrings]{RNAMultipleAlignment}},
#'  or \code{\link[Biostrings]{AAMultipleAlignment}}.
#' 
#' @param seqs (Required.) the sequence/alignment to be displayed. A character vector,  \code{\link[ape]{DNAbin}}, \code{\link[Biostrings]{DNAStringSet}},  \code{\link[Biostrings]{AAStringSet}},
#' or \code{\link[Biostrings]{RNAStringSet}}.
#' 
#' @return A list of named lists where each sublist has name, id, and seq members. 
#'  
#' @importFrom ape as.alignment
#' @importFrom ape read.dna
#' @importFrom ape read.FASTA
#' @export
#' @rdname as.sequences
#' @examples 
#' seqfile <- system.file("sequences","AHBA.aln",package="msaR")
#' as.sequences(seqfile)
#' help("as.sequences)
#' 
#' if (requireNamespace("Biostrings", quietly = TRUE)) {
#'    seqs <- Biostrings::readDNAStringSet(seqfile)
#'    as.sequences(seqs)
#' }
#' 
as.sequences <- function(seqs) {
  # try character sequences first
  if (class(seqs)=="character") {
    try(sequences <- read.FASTA(seqs, type = "dna"))
    if (exists("sequences")) return(as.sequences(sequences))
    try(sequences <- read.FASTA(seqs, type = "aa"))
    if (exists("sequences")) return(as.sequences(sequences))
    return("Error reading your fasta file.")
  }
  #
  
  # then DNAbin and AAbin
  if (class(seqs) %in% c("AAbin", "DNAbin")) {
    
    aln     <- as.alignment(as.character(seqs))
    
    seqlist <-  lapply(seq(aln),  function(x){
      list(id=aln$nam[x], 
           name=aln$nam[x], 
           seq=aln$seq[x])})
    
    return(seqlist)
  }
  
  
  # Then Biostrings
  if (class(seqs) %in% c("DNAStringSet","AAStringSet", "RNAStringSet", "BStringSet", 
                         "DNAMultipleAlignment","RNAMultipleAlignment", "AAMultipleAlignment")) {
    
    # check for Biostring Namespace
    if (requireNamespace("Biostrings")) {
      
      if (class(seqs) %in% c("DNAStringSet", "RNAStringSet", "AAStringSet")) {
        
        seqlist <- lapply(seq(seqs), function(x){
          list(id=names(seqs[x]), 
               name=names(seqs[x]), 
               seq=unname(as.character(seqs[x])))
        })

        return(seqlist)
      }
      
      if (class(seqs)=="DNAMultipleAlignment"){
        return( as.sequences(Biostrings::DNAStringSet(seqs)))
      }
      
      if (class(seqs)=="RNAMultipleAlignment"){
        return( as.sequences(Biostrings::RNAStringSet(seqs)))
      }
      
      if (class(seqs)=="AAMultipleAlignment"){
        return( as.sequences(Biostrings::AAStringSet(seqs)))
      }
      
      stop("Invalid  seqs entry. Must be a character representing a filename")
      
    } else {
      stop("Biostrings must be loaded to convert Biostring objects.")
    }
  }
  
}

