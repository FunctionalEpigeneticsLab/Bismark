#!/bin/bash

bam=$1

lambda=$(samtools view $bam | grep Lambda | wc -l)
puc=$(samtools view $bam | grep pUC | wc -l)
echo -e "${bam},${lambda},${puc}" >> puc_lambda.csv

