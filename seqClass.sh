#!/bin/bash
seq=$1
seq=$(echo $seq | tr a-z A-Z) # upper-case input seq
# I am assuming that sequences can contain more bases apart from ACGTU based on the 
# existing nomenclature. So I am adding modified all rules from the IUPAC (W: A/T, S: C/G, 
# M: A/C, K: G/T, R: A/G, Y: C/T, B: C/G/T, D: A/G/T, H: A/C/T, V:A/C/G, N:A/C/G/T, Z: Zero).
# I am also adding other defined letters that represent modified bases in DNA/RNA (X: xanthine)
# and in RNA (P: pseudouridine, I:inosine).
# I am also changing the message that is printed when only non-specific bases are available
# because I believe that if a regular DNA/RNA sequence is introduced, with a regular length,
# it would be identified. 
# Finally, I am mantaining the message of <Not DNA nor RNA> just in case there is a mistake in 
# the sequence.
if [[ $seq =~ ^[ACGTUWSMKRYBDHVNZXPI]+$ ]]; then  
	if [[ $seq =~ [T] ]]; then
		echo "The sequence is DNA"
	elif [[ $seq =~ [UPI] ]]; then
		echo "The sequence is RNA"
	else 
		echo "Write a longer sequence to identify whether it is 
DNA or RNA"
	fi
else
	echo "The sequence is not DNA nor RNA"
fi
# finds motifs
motif=$(echo $2 | tr a-z A-Z)
if [[ -n $motif ]]; then
	echo -en "Motif search enabled: looking for motif '$motif' in 
sequence '$seq'..."
	if [[ $seq =~ $motif ]]; then
		echo "MOTIF FOUND YES"
	else
		echo "MOTIF NOT FOUND"
	fi
fi
