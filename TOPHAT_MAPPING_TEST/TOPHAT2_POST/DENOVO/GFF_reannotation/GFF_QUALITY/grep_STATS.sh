#!/bin/bash
grep "Base level"           *.stats | sed "s/Base level//g"     	|sed "s/://g"	 >  Base.summary   
grep "Exon level"           *.stats | sed "s/Exon level//g"  		|sed "s/://g"	>  Exon.summary   
grep "Intron level"         *.stats | sed "s/Intron level//g"  		|sed "s/://g"	>  Intron.summary   
grep "Intron chain level"   *.stats | sed "s/Intron chain level//g"	|sed "s/://g"	   		>  Intron_chain.summary   
grep "Transcript level"     *.stats | sed "s/Transcript level//g"  	|sed "s/://g"	 			>  Transcript.summary   
grep "Locus level"          *.stats | sed "s/Locus level//g"  		|sed "s/://g"				>  Locus.summary   
