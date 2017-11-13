#! /bin/bash

#===============================================================================
#
#          FILE: cTagsCscopeLinuxAnyProduct.sh
#
#         USAGE: cTagsCscopeLinuxAnyProduct.sh in PROJECT_ROOT
#
#   DESCRIPTION:
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: lingfeng.hu@nokia.com
#  ORGANIZATION: NOKIA
#       CREATED: 2016
#      REVISION:  ---
#===============================================================================

function printHelp()
{
   echo "right usage:"
   echo "   $0 <component>"
   echo "<component>:"
   echo "	uec"
   echo "	cellc"
   echo "	rrom"
   echo "	enbc"
   echo "	tupc"
   echo "	mcec"
   echo "	all"
   echo "example:"
   echo "   $0 uec"
}

function debug()
{
	echo $*
}

if [[ $# -ne 1 ]]; then
	printHelp
	exit 1
fi

if [[ ! -f .config ]]
then
	echo "must run in PROJECT_ROOT(.config located directory)"
	exit 2
fi

component=`echo $1 | tr [a-z] [A-Z]`

case $component in
	"UEC")
        ;;
	"RROM")
		;;
	"CELLC")
		;;
	"ENBC")
		;;
	"TUPC")
		component="TUP"
		;;
	"MCEC")
		;;
	"ALL")
		;;
	*)
		printHelp
		exit 3
		;;
esac



projectDir=$(pwd)
productFile=${projectDir}/bts_sc_cplane_trunk.files

declare -a isarDir
isarDir+=(I_Interface)
isarDir+=(lteDo/I_Interface)
isarDir+=(lteDo/C_Application)
# declare -p isarDir

rromDir=C_Application/SC_RROM
uecDir=C_Application/SC_UEC
cellcDir=C_Application/SC_CELLC
mcecDir=C_Application/SC_MCEC
tupcDir=C_Application/SC_TUP
enbcDir=C_Application/SC_ENBC
commonDir=C_Application/SC_Common
lomDir=C_Application/SC_LOM

declare -a validPath
validPath+=(${commonDir})
validPath+=(${lomDir})
for p_isar in "${isarDir[@]}"
do
	validPath+=($p_isar)
done

if [[ "$component" != "ALL" ]]; then
	validPath+=(C_Application/SC_${component})
	debug "build $component database"
else
	validPath+=($rromDir)
	validPath+=($uecDir)
	validPath+=($cellcDir)
	validPath+=($mcecDir)
	validPath+=($tupcDir)
	validPath+=($enbcDir)
	debug "build $component database"
fi

# declare -p validPath

rm -rf $productFile

productFileGenStartTime=$(date +"%s")
for p in "${validPath[@]}"
do
	find $p -path "*Test*" -prune -o -path "*.svn" -prune -o -iname "*.[ch]" -type f -print -o -iname "*.[ch]pp" -print >> $productFile
done
productFileGenEndTime=$(date +"%s")
productFileGenTime=$(($productFileGenEndTime-$productFileGenStartTime))
echo "productFileGenTime: $productFileGenTime"

