#!/bin/bash
cat ./puc_lambda_header.csv > puc_lambda.csv
for i in $(ls *.bam)
do
./get_puc_lambda_derived_reads_one_sample.sh $i	&
done
