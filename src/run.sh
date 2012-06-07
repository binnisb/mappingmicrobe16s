module add bioinfo-tools
module add blast
#make firmicutesdb
for f in `ls ../data/rdp*` 
do
  filename=$(basename $f)
  extension=${filename##*.}
  filename=${filename%.*}
  formatdb -i $f -n ../result/firmicutesdb.$extension -p F
  blastall -p blastn -i ../data/clostridiales_example.fasta -d ../result/firmicutesdb.$extension -o ../result/blast.out.$extension -m 9 -b 100000

done
