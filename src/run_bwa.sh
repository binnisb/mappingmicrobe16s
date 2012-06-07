module add bioinfo-tools
module add bwa
module add samtools

for f in `ls ../data/rdp*`
do
  filename=$(basename $f)
  extension=${filename##*.}
  filename=${filename%.*}
  extension=${filename##*.}
  if [[( -f ../data/bwa_index/rdpbwa_index.$extension.bwt && -f ../data/samind/$(basename $f).fai)]];
  then
    echo "files exists: " ../data/bwa_index/rdpbwa_index.$extension.bwt " and " ../data/samind/$(basename $f).fai
  else
    echo ../data/samind/$(basename $f).fai
    echo ../data/bwa_index/rdpbwa_index.$extension.bwt
    bwa index -a bwtsw -p ../data/bwa_index/rdpbwa_index.$extension $f >> rdpbwa.sbatch.out 
    samtools faidx $f
    mv $f.fai ../data/samind/
  fi
done
wait

#for f in `ls ../data/bwa_index/rdpbwa_index.*.bwt`
#do
#  filename=$(basename $f)
#  extension=${filename##*.}
#  filename=${filename%.*}
#  extension=${filename##*.}

#  bwa aln -t 4 -n 0.04 ../data/bwa_index/$filename ../data/clostridiales_example.fasta > ../data/alignments/clostridiales_$filename.sai  
#  bwa samse ../data/bwa_index/$filename ../data/alignments/clostridiales_$filename.sai ../data/clostridiales_example.fasta > ../data/alignments/clostridiales_$filename.sam
#done



for f in `ls ../data/samind/*.fai`
do
  filename=$(basename $f)
  extension=${filename##*.}
  filename=${filename%.*}
  extension=${filename##*.}
  filename=${filename%.*}
  extension=${filename##*.}

  samtools import $f ../data/alignments/clostridiales_rdpbwa_index.$extension.sam ../data/alignments/clostridiales_rdpbwa_index.$extension.bam
  samtools sort ../data/alignments/clostridiales_rdpbwa_index.$extension.bam ../data/alignments/clostridiales_rdpbwa_index.$extension.sorted
  samtools index ../data/alignments/clostridiales_rdpbwa_index.$extension.sorted.bam
done
echo "done and done"

