		putdocx clear
		putdocx begin, pagesize(letter) font(Arial,12,black)	
		
		putdocx table Table1 = matrix(result) , rownames colnames
		putdocx save "Index.docx", replace
