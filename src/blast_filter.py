#!/usr/bin/env python
'''
Created on May 24, 2012

@author: binni
'''
import numpy as np
from Bio import SeqIO
from collections import defaultdict
import Bio

def main(file,N,db_file):
    
    original_db = list(SeqIO.parse(db_file, 'fasta'))
    original_db_dict = defaultdict(Bio.SeqRecord.SeqRecord)
    for i in original_db:
        original_db_dict[i.id] = i
        
    
    np.set_printoptions(suppress=True)
    with open(file) as f:
        lines = f.readlines()
    lines = [l.strip().split() for l in lines if l[0] != "#"]
    mat = np.array([ [v[2],v[3],v[4],v[5],v[6],v[7],v[8],v[9],v[10],v[11]] for v in lines]  ,dtype=float)
    id = np.array([ [l[0],l[1]] for l in lines],dtype=str)
    
    gaps = xrange(100,N-1,-1)
    for i in gaps:
        hit = (mat[:,0] >= i) & (mat[:,0] < i+1) &(mat[:,1] > 370)
        id_result = id[hit,:]
        mat_result = mat[hit,:]
        np.savetxt('.'.join([file,str(i)]),np.hstack((id_result,np.asarray(mat_result,dtype='str'))),delimiter='\t',fmt='%s' )
        for result in set(id_result[:,1]):
            try:
                del original_db_dict[result]
            except:
                1
        SeqIO.write(original_db_dict.values(), "%s.%s" %(db_file,i), "fasta")
            
                
        
    
    
        

if __name__ == '__main__':
    import sys
#    import argparse
#    parser = argparse.ArgumentParser(description='Filter results of blastall output file for each % down to N%')
#    parser.add_argument('f', metavar='file', type=str, help='File containing the blastall result')
#    parser.add_argument('N', metavar='N', type=int, help='Down to which percent you want')
#    parser.add_argument('d', metavar='file', type=str, help='The original db to trim')
#    args = parser.parse_args()
    
#    main(args.f, args.N, args.d)

    main(sys.argv[1],int(sys.argv[2]), sys.argv[3])
