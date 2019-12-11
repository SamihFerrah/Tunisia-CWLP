***command to concatenate variable labels
*concaténer le variable label de la var mère avec celui de la var fille, pour toutes les vars filles

cap program drop labeldum
program define labeldum
args varmere varfille

*local varmere repondant_rel
*local varfille relation_dum

local labelmere: variable label `varmere'
local labelmere=substr("`labelmere'",1,30)

levelsof `varmere', local(levels)

foreach lev of local levels  {
	local fille `varfille'`lev'
	local labelfille: variable label `fille' //limiter longueur
	local equal=strrpos("`labelfille'","==")
	local labelfilsub=substr("`labelfille'",`equal'+2,20)
	local concatlabel `labelmere'`labelfilsub' //limiter longueur
	label variable `fille' "`concatlabel'"
}

codebook `varfille'* 

end
