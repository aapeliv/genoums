set -e

filename=$1

justname=$(echo "${filename%.*}")

echo "***** Processing ${justname}"

echo "***** Converting to fastq file..."
bedtools bamtofastq -i "${filename}" -fq "${justname}".fq

echo "***** bgzipping..."
bgzip -i "${justname}".fq

echo "***** Running fastqc...";
fastqc --contaminants /deps/contaminant_list.txt "${justname}".fq.gz -o .;

echo "***** Trimming with reformat.sh..."
reformat.sh -Xmx16g in="${justname}".fq.gz out="${justname}"_trimmed.fq.gz minlength=50 maxlength=150 overwrite=TRUE

echo "***** Building an index with salmon..."
salmon index -t "${justname}"_trimmed.fq.gz -i salmon_index/ --type puff

echo "***** Quantifying with salmon..."
salmon quant -i salmon_index/ -l A -r "${justname}".fq.gz -p 12 --output "${justname}"_quant;

echo "***** Done!"
