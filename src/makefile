firmicutesdb: ../data/rdp_download_37281seqs.fa*
	formatdb -i $< -n ../data/$@ -p F
	blastall -p blastn -i ../data/clostridiales_example.fasta -d ../data/$@ -o ../result/$@blastall.out -m 9 -b 100000

clean:
	rm ../data/firmicutesdb*
	rm ../data/formatdb.log
	rm ../result/*blastall.out
