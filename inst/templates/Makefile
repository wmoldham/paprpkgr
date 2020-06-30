RAW = ./inst/extdata/
RMD = ./inst/analysis/
PDF = ./inst/analysis/pdfs/
FIG = ./inst/manuscript/figures/
OUTPUTS = $(patsubst $(RMD)%.Rmd, $(PDF)%.pdf, $(wildcard $(RMD)*.Rmd))
FIGURES = $(patsubst $(FIG)%.R, $(FIG)%.pdf, $(wildcard $(FIG)*-figure.R))
PRINT = TRUE

KNIT = Rscript -e 'rmarkdown::render("$<", output_dir = "$(PDF)", params = list(print_plots = "$(PRINT)"))'

all: $(OUTPUTS) $(FIGURES)

clean:
		rm -f ./data/*.rda
		rm -f $(PDF)*.pdf
		rm -f $(FIG)*.pdf

clean-figs:
		rm -f $(FIG)*.pdf

# if either raw data or .Rmd change, reknit, and data outputs will be updated
$(PDF)01%.pdf: $(RMD)01%.Rmd $(RAW)dna-per-cell-number.xlsx
		$(KNIT)

# figures should be remade if any raw or clean data change
# this should go quickly, so don't need to parse each figure file seperately
$(FIG)%.pdf: $(FIG)%.R $(FIG)00-functions.R $(shell find ./data/*.rda) $(shell find $(RAW))
		Rscript -e 'source("$<")'

.PHONY: all clean clean-figs

.DELETE_ON_ERROR:

.SECONDARY:
