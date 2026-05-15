shopt -s extglob globasciiranges
SAVEIFS=$IFS
tput init
IFS=$(echo -en "\n\b")
WHITE=$(tput setaf 7)
CYAN=$(tput setaf 6)
PURPLE=$(tput setaf 5)
BLUE=$(tput setaf 4)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
BLACK=$(tput setaf 0)
NC=$(tput sgr0)
PURPLEYELLOW=$(tput setaf 5)$(tput setab 3)
YELLOWPURPLE=$(tput setaf 3)$(tput setab 5)
YELLOWGREEN=$(tput setaf 3)$(tput setab 2)
BLACKCYAN=$(tput setaf 0)$(tput setab 6)
BLACKPURPLE=$(tput setaf 0)$(tput setab 5)
BLACKBLUE=$(tput setaf 0)$(tput setab 4)
BLACKBLUE2=$(tput setaf 0)$(tput setab 20)
BLACKGOLD=$(tput setaf 0)$(tput setab 3)
BLACKYELLOW=$(tput setaf 0)$(tput setab 11)
BLACKGREEN=$(tput setaf 0)$(tput setab 2)
BLACKRED=$(tput setaf 0)$(tput setab 1)
BLACKSILVER=$(tput setaf 0)$(tput setab 242)
BLACKCRYSTAL=$(tput setaf 0)$(tput setab 99)
BLACKRUBY=$(tput setaf 0)$(tput setab 160)
BLACKSAPPHIRE=$(tput setaf 0)$(tput setab 26)
BLACKEMERALD=$(tput setaf 0)$(tput setab 34)
BLACKFIRERED=$(tput setaf 0)$(tput setab 130)
BLACKLEAFGREEN=$(tput setaf 0)$(tput setab 82)
BLACKCOLOSSEUM=$(tput setaf 0)$(tput setab 186)
BLACKXD=$(tput setaf 0)$(tput setab 62)
BLACKDIAMOND=$(tput setaf 0)$(tput setab 38)
BLACKPEARL=$(tput setaf 0)$(tput setab 176)
BLACKPLATINUM=$(tput setaf 0)$(tput setab 216)
BLACKHEARTGOLD=$(tput setaf 0)$(tput setab 184)
BLACKSOULSILVER=$(tput setaf 0)$(tput setab 245)
BLACKBLACK=$(tput setaf 0)$(tput setab 236)
BLACKWHITE=$(tput setaf 0)$(tput setab 7)
BLACKBLACK2=$(tput setaf 0)$(tput setab 235)
BLACKWHITE2=$(tput setaf 0)$(tput setab 253)
BLACKX=$(tput setaf 0)$(tput setab 12)
BLACKY=$(tput setaf 0)$(tput setab 88)
BLACKOMEGARUBY=$(tput setaf 0)$(tput setab 161)
BLACKALPHASAPPHIRE=$(tput setaf 0)$(tput setab 27)
BLACKSUN=$(tput setaf 0)$(tput setab 178)
BLACKMOON=$(tput setaf 0)$(tput setab 182)
BLACKULTRASUN=$(tput setaf 0)$(tput setab 179)
BLACKULTRAMOON=$(tput setaf 0)$(tput setab 181)
BLACKPIKA=$(tput setaf 0)$(tput setab 228)
BLACKEEVEE=$(tput setaf 0)$(tput setab 222)
BLACKSWORD=$(tput setaf 0)$(tput setab 197)
BLACKSHIELD=$(tput setaf 0)$(tput setab 81)
BLACKBRILLIANTDIAMOND=$(tput setaf 0)$(tput setab 38)
BLACKSHININGPEARL=$(tput setaf 0)$(tput setab 176)
BLACKLEGENDSARCEUS=$(tput setaf 0)$(tput setab 61)



# dependances tput (normaly already installed on debian, viu and rust environment to compile viu, ffmpeg, imagemagick for convert, lynx
checkdependances() {
	if [ -f "/usr/bin/lynx" ] ; then 
		touch ./ #does basicly nothing
	else 
		echo "lynx not found, installing ......" 
		installdependances 
	fi
	if [ -f "/usr/bin/curl" ] ; then 
		touch ./ #does basicly nothing
	else 
		echo "curl not found, installing ......" 
		installdependances 
	fi
	if [ -f "/usr/bin/cc" ] ; then 
		touch ./ #does basicly nothing
	else 
		echo "build-essential not found, installing ......" 
		installdependances 
	fi
	if [ -f "/usr/bin/git" ] ; then 
		touch ./ #does basicly nothing
	else 
		echo "git not found, installing ......" 
		installdependances 
	fi
	if [ -f "/usr/bin/convert" ] ; then 
		touch ./
	else 
		echo "convert/imagemagick not found, installing ......" 
		installdependances 
	fi
	if [ -f "/usr/bin/ffmpeg" ] ; then
		touch ./
	else 
		echo "ffmpeg not found, installing ......" 
		installdependances 
	fi
	
	
	#~ if [ -f "/usr/bin/gm" ] ; then 
		#~ touch ./ #does basicly nothing
	#~ else 
		#~ echo "gm not found, installing ......" 
		#~ installdependances 
	#~ fi
	if [ -f "/home/`whoami`/.cargo/bin/rustc" ] ; then
		touch ./
	else 
		echo "rust not found, installing ......" 
		installdependances 
	fi
}

installdependances () {
	echo "Installing dependencies ...."
	determineOS() {
		isWSL() { #assume os is wsl
			wsl=$(uname -a | grep WSL)
			if echo $wsl | grep WSL ; then return 0 ; else return 1  ; fi
		}
		isDebian() {
			if [ -e `whereis apt | cut -d" " -f2` ] ; then return 0 ; else return 1 ; fi
		}
		isArch() {
			#also manjaro
			#if pacman exist
			if [ -e `whereis pacman | cut -d" " -f2` ] ; then return 0 ; else return 1 ; fi
		}
		isRedhat() {
			#if rpm exist
			if [ -e `whereis rpm | cut -d" " -f2` ] ; then return 0 ; else return 1 ; fi

		}
		if isWSL; then  
			if isDebian ;then 
				echo "wsldebian"
				return 1 #wsldebian
			fi 
			if isArch ;then 
				echo "wslarch"
				return 2 #wslarch 
			fi
			if isRedhat ;then 
				echo "wslredhat"
				return 3 #wslredhat
			fi
		else
			if isDebian ;then 
				echo "debian"
				return 4 #debian
			fi 
			if isArch ;then 
				echo "arch"
				return 5 #arch 
			fi
			if isRedhat ;then 
				echo "redhat"
				return 6 #redhat
			fi
		fi 	
	}
	compileviu () {
			source $HOME/.cargo/env
			localdir=$(pwd)
			cd ~
			git clone https://github.com/atanunq/viu.git
			cd viu/
			cargo install --path .
			#~ cd ..
			cd $localdir
	}
	determineOS
	local OStype=$?
	echo $OStype
	case $OStype in 
		1) #wsldebian
			sudo apt-get install ffmpeg imagemagick lynx git curl build-essential
			curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh #installing rust
			compileviu
		;;
		2)#wslarch
			curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
			compileviu
		;;
		3)#wslredhat
			curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
			compileviu
		;;
		
		4)#debian
			sudo apt-get install ffmpeg imagemagick lynx git curl build-essential
			curl https://sh.rustup.rs -sSf | sh
			compileviu
		;;
		5)#arch
			curl https://sh.rustup.rs -sSf | sh
			compileviu
		;;
		6)#redhat
			curl https://sh.rustup.rs -sSf | sh
			compileviu
		;;
		*)
			echo ""
		;;
	esac
}


testcolor(){
	end=$(( $(tput colors)-1 ))
	w=8
	for c in $(seq 0 $end); do
		eval "$(printf "tput setaf 0;tput setab %3s   " "$c")"; echo -n "$_"
		[[ $c -ge $(( w*2 )) ]] && offset=2 || offset=0
		[[ $(((c+offset) % (w-offset))) -eq $(((w-offset)-1)) ]] && echo
	done
	tput init
}
definegen () {
	if [ "$number" -lt 1 ] || [ "$number" -gt 1025 ]; then
		echo "0"
	elif [ "$number" -lt 152 ]; then
		echo "1"
	elif [ "$number" -lt 252 ]; then
		echo "2"
	elif [ "$number" -lt 387 ]; then
		echo "3"
	elif [ "$number" -lt 494 ]; then
		echo "4"
	elif [ "$number" -lt 650 ]; then
		echo "5"
	elif [ "$number" -lt 722 ]; then
		echo "6"
	elif [ "$number" -lt 810 ]; then
		echo "7"
	elif [ "$number" -lt 906 ]; then
		echo "8"
	elif [ "$number" -lt 1026 ]; then
		echo "9"
	fi
}
generatepkmnlistfrompkmndb() {
	#$1 = output file (default: pkmn.list)
	local outputfile="${1:-pkmn.list}"
	echo "Generating Pokémon list from pokemondb.net..."
	
	# Get English names and numbers from main pokedex page
	lynx -dump https://pokemondb.net/pokedex/all | grep -E '^\s*[0-9]+\s+#' | head -n 1025 | while read line; do
		num=$(echo "$line" | awk '{print $1}')
		name=$(echo "$line" | awk '{print $3}' | sed 's/#//')
		
		# Format number to 3 digits
		fnum=$(printf "%03d" $num)
		
		# Get French and Japanese names from individual pokemon page
		local fr_name=""
		local jp_name=""
		local romaji=""
		
		# Try to get alternative names from pokemon page
		local pagedump=$(lynx -dump "https://pokemondb.net/pokedex/$name" 2>/dev/null)
		
		# Extract French name (usually in parentheses after English name in some format)
		# This is a simplified approach - pokemondb has different language names in the HTML
		fr_name="$name"  # Fallback to English name
		jp_name=""
		romaji=""
		
		# Output format: num|english|french|japanese|romaji
		# For now, we'll use English for missing translations
		echo "$fnum|$name|$fr_name|$jp_name|$romaji"
		sleep 0.1  # Be nice to the server
	done > "$outputfile"
	
echo "List generated in $outputfile"
}

shtolistofpkmn () {
	#Read the #pkmnlist# block from the running script itself ($BASH_SOURCE),
	#or from ./pokedex / ./pokedex.sh as fallbacks (development mode).
	local self="${BASH_SOURCE[0]:-$0}"
	local src=""
	if [ -f "$self" ]; then
		src="$self"
	elif [ -f ./pokedex ]; then
		src="./pokedex"
	elif [ -f ./pokedex.sh ]; then
		src="./pokedex.sh"
	fi
	sed -n '/^#pkmnlist#/,/^_pkmnlist_/p' "$src" | sed '1d' | sed '$d'
}
formatname () {
	#$1= rawname
	namef=`echo $1 | sed 's~é~e~g'`
	namef=`echo $namef | sed 's~è~e~g'`
	namef=`echo $namef | sed 's~ê~e~g'`
	namef=`echo $namef | sed 's/.*/\L&/'`
	echo $namef
}
formatnumber() {
	#$1=number  -> 4 digits left-padded (e.g. 25 -> 0025, 1025 -> 1025)
	local n
	n=$(echo "$1" | sed 's/^0*//')
	[ -z "$n" ] && n=0
	printf "%04d\n" "$n"
}
urlnumber() {
	#$1=number  -> "URL flavour": 3 digits if <1000, 4 digits otherwise.
	#Used for serebii.net which historically uses 3-digit ids.
	local n
	n=$(echo "$1" | sed 's/^0*//')
	[ -z "$n" ] && n=0
	if [ "$n" -lt 1000 ]; then
		printf "%03d\n" "$n"
	else
		printf "%04d\n" "$n"
	fi
}
intnumber() {
	#$1=number with potential leading zeros -> safe decimal int (e.g. 0008 -> 8)
	#Useful before any (( )) or arithmetic.
	local n
	n=$(echo "$1" | sed 's/^0*//')
	[ -z "$n" ] && n=0
	echo "$n"
}
formkey() {
	#$1=number  $2=form slug (optional)  -> "0025" or "0025-alola"
	local num
	num=$(formatnumber "$1")
	if [ -n "$2" ] && [ "$2" != "default" ]; then
		echo "${num}-${2}"
	else
		echo "${num}"
	fi
}
parseformkey() {
	#$1=key (e.g. "0025-alola")  -> echoes "number form" separated by space
	local key="$1"
	local num="${key%%-*}"
	local form=""
	if [[ "$key" == *-* ]]; then
		form="${key#*-}"
	fi
	echo "$num" "$form"
}
pkmnnametoenglishname () {
	#$1 = name in any language -> english name
	shtolistofpkmn | grep -w "$(formatname $1)" | cut -d "|" -f2 | head -1
}
pkmntonumber () {
	#$1= name
	shtolistofpkmn | grep -w $(formatname $1) | cut -d "|" -f1 | head -1
}
numbertopkmn () {
	#$1 = number  $2 = lang
	#11-field format: num|en|fr|de|it|es|jp|romaji|ko|zh-hans|zh-hant
	number=$(formatnumber $1)
	local field=2
	case "$2" in
		en|"")              field=2  ;;
		fr|french)          field=3  ;;
		de|german)          field=4  ;;
		it|italian)         field=5  ;;
		es|spanish)         field=6  ;;
		jp|japanese)        field=7  ;;
		romaji)             field=8  ;;
		ko|kr|korean)       field=9  ;;
		zhs|zh-hans|zh-cn)  field=10 ;;
		zht|zh-hant|zh-tw)  field=11 ;;
		*)                  field=2  ;;
	esac
	shtolistofpkmn | grep -w "$number" | cut -d "|" -f${field} | head -1
}

###############################################################################
#                          ALTERNATIVE FORMS SUPPORT                          #
###############################################################################
# The list of known forms is embedded at the bottom of this file between
# markers `#pkmnformlist#` ... `_pkmnformlist_`.
# Format: NUMBER|FORM_SLUG|DISPLAY_NAME|URL_SLUG
#   NUMBER     : 4-digit dex number (e.g. 0006)
#   FORM_SLUG  : short slug used in filenames/markers  (e.g. mega-x, alola, gmax)
#   DISPLAY    : human-readable label                  (e.g. "Mega Charizard X")
#   URL_SLUG   : pokemondb name segment for sprites    (e.g. charizard-mega-x)
#
# A pokémon NOT in this list = only the default form is downloaded/built.
# To extend support, simply add lines in the #pkmnformlist# block (or in an
# external `pkmnforms.list` file -- it overrides the embedded list when present).

shtolistofforms () {
	#./pkmnforms.list overrides the embedded list. Otherwise read from the
	#running script itself, or fall back to ./pokedex / ./pokedex.sh.
	if [ -f ./pkmnforms.list ]; then
		cat ./pkmnforms.list
		return 0
	fi
	local self="${BASH_SOURCE[0]:-$0}"
	local src=""
	if [ -f "$self" ]; then
		src="$self"
	elif [ -f ./pokedex ]; then
		src="./pokedex"
	elif [ -f ./pokedex.sh ]; then
		src="./pokedex.sh"
	fi
	sed -n '/^#pkmnformlist#/,/^_pkmnformlist_/p' "$src" | sed '1d;$d'
}

formsfornumber () {
	#$1 = number  -> outputs one form slug per line ("" for default).
	#The default form is always emitted first (empty line).
	local num
	num=$(formatnumber "$1")
	echo ""   # default form
	shtolistofforms | grep "^${num}|" | cut -d'|' -f2
}

formdisplayname () {
	#$1 = number $2 = form slug
	local num
	num=$(formatnumber "$1")
	if [ -z "$2" ]; then
		numbertopkmn "$num"
		return
	fi
	shtolistofforms | grep "^${num}|${2}|" | cut -d'|' -f3 | head -1
}

formurlslug () {
	#$1 = number $2 = form slug  -> pokemondb URL name (e.g. charizard-mega-x)
	#For a handful of multi-form pokemon, pokemondb has NO image at the bare
	#name slug (e.g. /artwork/large/giratina.jpg is 404) and only serves the
	#named default form (giratina-altered, shaymin-land, ...). Map them here.
	local num name
	num=$(formatnumber "$1")
	name=$(filtername $(formatname $(numbertopkmn "$num")))
	if [ -z "$2" ]; then
		case "$num" in
			0487) echo "giratina-altered"  ; return ;;
			0492) echo "shaymin-land"      ; return ;;
			0741) echo "oricorio-baile"    ; return ;;
			0745) echo "lycanroc-midday"   ; return ;;
			0746) echo "wishiwashi-solo"   ; return ;;
			0875) echo "eiscue-ice"        ; return ;;
			0877) echo "morpeko-full-belly"; return ;;
			0892) echo "urshifu-single-strike"; return ;;
			0905) echo "enamorus-incarnate"; return ;;
		esac
		echo "$name"
	else
		local custom
		custom=$(shtolistofforms | grep "^${num}|${2}|" | cut -d'|' -f4 | head -1)
		if [ -n "$custom" ]; then
			echo "$custom"
		else
			echo "${name}-${2}"
		fi
	fi
}

showdownslug () {
	#$1 = number  $2 = form key (optional)
	#-> Pokemon Showdown sprite id, e.g.
	#   (0006, mega-x)        -> charizard-megax
	#   (0052, gmax)          -> meowth-gmax
	#   (0785, "")            -> tapukoko          (multi-word default)
	#   (0122, galar)         -> mrmime-galar
	#   (0892, rapid)         -> urshifu-rapidstrike
	#   (0892, gmax)          -> urshifu-gmax       (single-strike is default)
	#   (0892, gmax-rapid)    -> urshifu-rapidstrikegmax
	#   (1017, hearthflame)   -> ogerpon-hearthflame
	#   (0128, paldea-combat) -> tauros-paldeacombat
	#Used as a fallback source for back sprites of gen 6+ pokemon and
	#many alternative forms which pokemondb does not host.
	local num rawname basename
	num=$(formatnumber "$1")
	rawname=$(filtername "$(formatname "$(numbertopkmn "$num")")")
	# Multi-word pokemon names (Tapu Koko, Mr. Rime, Iron Bundle...) carry
	# hyphens in the pokemondb slug but Showdown removes them.
	basename="${rawname//-/}"
	if [ -z "$2" ]; then
		echo "$basename"
		return
	fi
	local pokemondb_slug formpart
	pokemondb_slug=$(formurlslug "$num" "$2")
	# Strip the bare name prefix so we keep only the form portion.
	formpart="${pokemondb_slug#${rawname}-}"
	formpart=$(echo "$formpart" | sed \
		-e 's/single-strike-//' \
		-e 's/-single-strike//' \
		-e 's/gigantamax/gmax/' \
		-e 's/alolan/alola/' \
		-e 's/galarian/galar/' \
		-e 's/hisuian/hisui/' \
		-e 's/paldean/paldea/' \
		-e 's/-mask$//' \
		-e 's/-breed$//' \
		-e 's/-build$//' \
		-e 's/-rider$//')
	formpart="${formpart//-/}"
	if [ -z "$formpart" ]; then
		echo "$basename"
	else
		echo "${basename}-${formpart}"
	fi
}

listallforms () {
	#Outputs one line per (number, form) combination including the default form.
	#Format: KEY|DISPLAY     where KEY is "0006" or "0006-mega-x"
	local num form key disp
	for ((i=1; i<=1025; i++)); do
		num=$(formatnumber "$i")
		while IFS= read -r form; do
			key=$(formkey "$num" "$form")
			disp=$(formdisplayname "$num" "$form")
			echo "${key}|${disp}"
		done < <(formsfornumber "$num")
	done
}

#################part of image producing
showallsprite () {
	#$3 column number
	# $1 = min 1 $2=max 1025
	#$4 = width
	#$5 shiny yes or no
	#$6= set resize for image produce
	if [[ "$5" == yes ]];then
		cd allshinypng
	else
		cd allpng
	fi
	cp ../pkmn.list ./
	for ((i = $1 ; i <= $2 ; i = $i + $3)); do
		cmd1="convert"
		cmd2=""
		for ((j = $i ; j <= ($i + ($3 - 1)) ; j++ )); do
			if [[ $j -le 1025 ]]; then
				number=$(formatnumber $j)
			else
				number="empty"
			fi
				cmd2="$cmd2 $number.png"
		done
		cmd3=" +append $i.$3.res.png"
		cmd="$cmd1$cmd2$cmd3"
		#~ echo $cmd
		eval $cmd
		
		viu -t "$i.$3.res.png"
		if [[ "$6" == no ]];then
			nil=nil
		else
			convert "$i.$3.res.png" -resize $4 "$(pkmntonumber $(numbertopkmn $i)).result.png"
		fi		
		
	done
	rm *.res.png
	rm pkmn.list
	cd ..
}
producefullimage () {
	#$1=shape square long tall
	case $1 in
		"square")
			#$2=width
			#$3 = shinyness yes or no
			three=30
			showallsprite 1 1025 30 $2 $3
		;;
		"long")
			#$2=width
			#$3=lengh
			#$4 = shinyness yes or no
			three=`echo $2`
			showallsprite 1 1025 $2 $3 $4
		;;
		*)
		;;
	esac
	if [[ "$3" == yes || "$4" == yes ]];then
		cd allshinypng
	else
		cd allpng
	fi
	convert *.result.png -append ../result/finalresult.png
	rm ./*.result.png
	cd ..

}
#######################################
filtername(){
	#$1 name
	name=$1
	case $name in
		"nidoranf")name="nidoran-f";;
		"nidoranm")name="nidoran-m";;
		"mrmime")name="mr-mime";;
		"mimejr")name="mime-jr";;
		"mrrime")name="mr-rime";;
		"type:null")name="type-null";;
		"farfetch'd")name="farfetchd";;
		"sirfetch'd")name="sirfetchd";;
		"tapubulu")name="tapu-bulu";;
		"tapufini")name="tapu-fini";;
		"tapukoko")name="tapu-koko";;
		"tapulele")name="tapu-lele";;
		*)
			# Default: lowercase, strip accents, apostrophes/dots/colons,
			# convert spaces to hyphens, convert venus/mars symbols (♀/♂)
			# to -f/-m for pokemondb URL slugs. Collapses double hyphens.
			name=$(echo "$name" \
				| tr '[:upper:]' '[:lower:]' \
				| sed 's/é/e/g; s/è/e/g; s/ê/e/g; s/à/a/g; s/â/a/g; s/î/i/g; s/ô/o/g; s/û/u/g; s/ç/c/g; s/ñ/n/g' \
				| sed 's/♀/-f/g; s/♂/-m/g' \
				| tr -d "'.:" | tr ' ' '-' \
				| sed 's/--*/-/g')
		;;
	esac
	echo $name
}
locationcolorizer(){
	echo "colorizing"
}
convertartworktopng(){
	#$1=filename
	convert $1.jpg $1.png
	rm $1.jpg
	color=$(convert $1.png -format "%[pixel:p{0,0}]" info:-)
	convert $1.png -alpha off -bordercolor $color -border 1 \( +clone -fuzz 30% -fill none -floodfill +0+0 $color -alpha extract -geometry 200% -blur 0x0.5 -morphology erode square:1 -geometry 50% \) -compose CopyOpacity -composite -shave 1 $1.png
	convert -trim $1.png $1.png
	convert $1.png -resize x150 $1.png
}
#~ convertpngtopng(){
	#~ convert $1.png $1.jpg
	#~ rm $1.png
	#~ convert $1.jpg $1.png
	#~ rm $1.jpg
	#~ color=$(convert $1.png -format "%[pixel:p{0,0}]" info:-)
	#~ convert $1.png -alpha off -bordercolor $color -border 1 \( +clone -fuzz 5% -fill none -floodfill +0+0 $color -alpha extract -geometry 200% -blur 0x0.5 -morphology erode square:1 -geometry 50% \) -compose CopyOpacity -composite -shave 1 $1.png
	#~ #convert -trim $1.png $1.png
	#~ #convert $1.png -resize x96 $1.png

#~ }


getallimage () {
	# $1 = min 1 $2=max 1025
	# serebii layout:
	#   #1   .. #905 -> https://www.serebii.net/swordshield/pokemon/<3-digit>.png
	#   #906 ..      -> https://www.serebii.net/scarletviolet/pokemon/<raw int>.png
	mkdir -p allpng
	echo -e "${YELLOW} get all image"
	local i name number n url
	for ((i = $1 ; i <= $2 ; i++)); do
		name=$(numbertopkmn "$i")
		number=$(pkmntonumber "$name")
		if [ -f "allpng/$number.png" ]; then
			echo -n "${BLACKYELLOW}${number}${NC}${BLACKYELLOW}E|${NC}"
			continue
		fi
		n=$(intnumber "$number")
		if [ "$n" -le 905 ]; then
			url="https://www.serebii.net/swordshield/pokemon/$(urlnumber "$number").png"
		else
			url="https://www.serebii.net/scarletviolet/pokemon/${n}.png"
		fi
		if curl -sfA "Mozilla/5.0" "$url" -o "./allpng/$number.png"; then
			convert -trim "./allpng/$number.png" "./allpng/$number.png" 2>/dev/null
			convert "./allpng/$number.png" -resize x150 "./allpng/$number.png" 2>/dev/null
			echo -n "${YELLOW}${number}a|${NC}"
		else
			rm -f "./allpng/$number.png"
			echo -n "${RED}${number}X|${NC}"
		fi
	done
	echo
}
getallshinyimage () {
	# $1 = min 1 $2=max 1025
	# serebii shiny layout:
	#   #1   .. #905 -> https://www.serebii.net/Shiny/SWSH/<3-digit>.png
	#   #906 ..      -> https://www.serebii.net/Shiny/SV/<raw int>.png
	mkdir -p allshinypng
	echo -e "${GREEN} get all shiny image"
	local i name number n url
	for ((i = $1 ; i <= $2 ; i++)); do
		name=$(numbertopkmn "$i")
		number=$(pkmntonumber "$name")
		if [ -f "allshinypng/$number.png" ]; then
			echo -n "${BLACKGREEN}${number}${NC}${BLACKYELLOW}E|${NC}"
			continue
		fi
		n=$(intnumber "$number")
		if [ "$n" -le 905 ]; then
			url="https://www.serebii.net/Shiny/SWSH/$(urlnumber "$number").png"
		else
			url="https://www.serebii.net/Shiny/SV/${n}.png"
		fi
		if curl -sfA "Mozilla/5.0" "$url" -o "./allshinypng/$number.png"; then
			convert -trim "./allshinypng/$number.png" "./allshinypng/$number.png" 2>/dev/null
			convert "./allshinypng/$number.png" -resize x150 "./allshinypng/$number.png" 2>/dev/null
			echo -n "${GREEN}${number}s|${NC}"
		else
			rm -f "./allshinypng/$number.png"
			echo -n "${RED}${number}X|${NC}"
		fi
	done
	echo
}
getallshoutmp3 () {
	#$1 = min 1 $2 = max 1025
	#https://play.pokemonshowdown.com/audio/cries/<name>.mp3
	mkdir -p allshoutmp3
	echo -e "${CYAN} get all cries (mp3)${NC}"
	for ((i = $1 ; i <= $2 ; i++)); do
		name=$(numbertopkmn $i)
		number=$(pkmntonumber $name)
		# pokemonshowdown slug = lowercase, ♀→f, ♂→m, strip accents,
		# then drop every non a-z0-9 (spaces, dots, dashes, apostrophes, colons).
		local slug=$(echo "$name" \
			| tr '[:upper:]' '[:lower:]' \
			| sed 's/♀/f/g; s/♂/m/g' \
			| sed 's/é/e/g; s/è/e/g; s/ê/e/g; s/ë/e/g; s/à/a/g; s/â/a/g; s/ä/a/g; s/î/i/g; s/ï/i/g; s/ô/o/g; s/ö/o/g; s/û/u/g; s/ü/u/g; s/ç/c/g; s/ñ/n/g' \
			| sed 's/[^a-z0-9]//g')
		if [ -f "allshoutmp3/${number}.mp3" ]; then
			echo -n "${BLACKCYAN}${number}${NC}${BLACKYELLOW}E${NC}${CYAN}|"
		else
			curl -sf "https://play.pokemonshowdown.com/audio/cries/${slug}.mp3" -o "allshoutmp3/${number}.mp3" \
				&& echo -n "${CYAN}${number}!${NC}${CYAN}|" \
				|| { rm -f "allshoutmp3/${number}.mp3"; echo -n "${RED}${number}X${NC}${CYAN}|"; }
		fi
	done
	echo
}
getallshoutogg () {
	#$1 = min 1 $2 = max 1025
	mkdir -p allshoutogg
	getallshoutmp3 "$1" "$2"
	echo -e "${CYAN} convert mp3 -> ogg${NC}"
	local i number mp3 ogg
	for ((i = $1; i <= $2; i++)); do
		number=$(formatnumber "$i")
		mp3="allshoutmp3/${number}.mp3"
		ogg="allshoutogg/${number}.ogg"
		[ -f "$ogg" ] && continue
		[ -f "$mp3" ] && ffmpeg -hide_banner -loglevel error -y -i "$mp3" "$ogg" </dev/null
	done
}

#########################get data from pkmndb###################


#########################get image from pkmndb#####################################################################################################################

getallartworkfrompkmndb(){
	#$1 min  $2 max  -- iterates known forms for each pokemon
	mkdir -p allartwork
	echo -e "${PURPLE} get all artwork (with forms)${NC}"
	for ((i = $1 ; i <= $2 ; i++)); do
		number=$(formatnumber $i)
		while IFS= read -r form; do
			local key urlslug fbase
			key=$(formkey "$number" "$form")
			urlslug=$(formurlslug "$number" "$form")
			fbase="allartwork/${key}_artwork"
			if [ -f "${fbase}.png" ]; then
				echo -n "${BLACKPURPLE}${key}${NC}${YELLOW}E${NC}|"
			else
				if curl -sfA "Mozilla/5.0" "https://img.pokemondb.net/artwork/large/${urlslug}.jpg" -o "${fbase}.jpg" && [ -s "${fbase}.jpg" ]; then
					echo -n "${PURPLE}${key}a|${NC}"
					convertartworktopng "${fbase}"
				elif [ -z "$form" ] && curl -sfA "Mozilla/5.0" "https://www.serebii.net/pokemon/art/$(intnumber "$number").png" -o "${fbase}.png" && [ -s "${fbase}.png" ]; then
					# Fallback for very recent DLC/gen-9 mons that pokemondb
					# does not yet host an artwork/large JPG for. serebii has
					# a PNG artwork at /pokemon/art/<int>.png.
					rm -f "${fbase}.jpg"
					convert -trim "${fbase}.png" "${fbase}.png" 2>/dev/null
					convert "${fbase}.png" -resize x150 "${fbase}.png" 2>/dev/null
					echo -n "${PURPLE}${key}A|${NC}"
				else
					rm -f "${fbase}.jpg" "${fbase}.png"
					[ -z "$form" ] && echo -n "${RED}${key}${NC}|"
				fi
			fi
		done < <(formsfornumber "$number")
	done
	echo -e "${NC}"
}
getallfrontspritefrompkmndb(){
	#$1 min  $2 max -- form-aware
	mkdir -p allfrontsprite
	echo -e "${BLUE} get all front (with forms)${NC}"
	for ((i = $1 ; i <= $2 ; i++)); do
		number=$(formatnumber $i)
		while IFS= read -r form; do
			local key urlslug fpath
			key=$(formkey "$number" "$form")
			urlslug=$(formurlslug "$number" "$form")
			fpath="allfrontsprite/${key}_front_normal.png"
			if [ -f "$fpath" ] && [ -s "$fpath" ]; then
				echo -n "${BLACKBLUE}${key}${NC}${YELLOW}E${NC}|"
			else
				# Sources, in priority order:
				#  1. pokemondb BW           (gen 1-5 default forms)
				#  2. pokemondb HOME         (universal, all gens, all forms)
				#  3. play.pokemonshowdown   (BW-style for gen 6+ niche forms)
				local sdslug
				sdslug=$(showdownslug "$number" "$form")
				if curl -sfA "Mozilla/5.0" "https://img.pokemondb.net/sprites/black-white/normal/${urlslug}.png" -o "$fpath" && [ -s "$fpath" ]; then
					echo -n "${BLUE}${key}fn|${NC}"
				elif curl -sfA "Mozilla/5.0" "https://img.pokemondb.net/sprites/home/normal/${urlslug}.png" -o "$fpath" && [ -s "$fpath" ]; then
					echo -n "${BLUE}${key}FN|${NC}"
				elif curl -sfA "Mozilla/5.0" "https://play.pokemonshowdown.com/sprites/gen5/${sdslug}.png" -o "$fpath" && [ -s "$fpath" ]; then
					echo -n "${BLUE}${key}sd|${NC}"
				else
					rm -f "$fpath"
					echo -n "${RED}${key}X${NC}|"
				fi
			fi
		done < <(formsfornumber "$number")
	done
	echo -e "${NC}"
}
getallbackspritefrompkmndb(){
	#$1 min  $2 max -- form-aware
	mkdir -p allbacksprite
	echo -e "${CYAN} get all back (with forms)${NC}"
	for ((i = $1 ; i <= $2 ; i++)); do
		number=$(formatnumber $i)
		while IFS= read -r form; do
			local key urlslug fpath
			key=$(formkey "$number" "$form")
			urlslug=$(formurlslug "$number" "$form")
			fpath="allbacksprite/${key}_back_normal.png"
			if [ -f "$fpath" ] && [ -s "$fpath" ]; then
				echo -n "${BLACKCYAN}${key}${NC}${YELLOW}E${NC}|"
			else
				# Pokemondb only has back sprites for gen 1-5 (BW); for gen 6+
				# (and Mega/regional forms) we fall back to Pokemon Showdown's
				# /sprites/gen5-back/ set, which covers most defaults and many
				# of the alternative forms.
				local sdslug
				sdslug=$(showdownslug "$number" "$form")
				if curl -sfA "Mozilla/5.0" "https://img.pokemondb.net/sprites/black-white/back-normal/${urlslug}.png" -o "$fpath" && [ -s "$fpath" ]; then
					echo -n "${CYAN}${key}bn|${NC}"
				elif curl -sfA "Mozilla/5.0" "https://play.pokemonshowdown.com/sprites/gen5-back/${sdslug}.png" -o "$fpath" && [ -s "$fpath" ]; then
					echo -n "${CYAN}${key}BN|${NC}"
				else
					rm -f "$fpath"
					echo -n "${RED}${key}X${NC}|"
				fi
			fi
		done < <(formsfornumber "$number")
	done
	echo -e "${NC}"
}
getallfrontshinyspritefrompkmndb(){
	#$1 min  $2 max -- form-aware
	mkdir -p allfrontshinysprite
	echo -e "${GREEN} get all front shiny (with forms)${NC}"
	for ((i = $1 ; i <= $2 ; i++)); do
		number=$(formatnumber $i)
		while IFS= read -r form; do
			local key urlslug fpath
			key=$(formkey "$number" "$form")
			urlslug=$(formurlslug "$number" "$form")
			fpath="allfrontshinysprite/${key}_front_shiny.png"
			if [ -f "$fpath" ] && [ -s "$fpath" ]; then
				echo -n "${BLACKGREEN}${key}${NC}${YELLOW}E${NC}|"
			else
				local sdslug
				sdslug=$(showdownslug "$number" "$form")
				if curl -sfA "Mozilla/5.0" "https://img.pokemondb.net/sprites/black-white/shiny/${urlslug}.png" -o "$fpath" && [ -s "$fpath" ]; then
					echo -n "${GREEN}${key}fs|${NC}"
				elif curl -sfA "Mozilla/5.0" "https://img.pokemondb.net/sprites/home/shiny/${urlslug}.png" -o "$fpath" && [ -s "$fpath" ]; then
					echo -n "${GREEN}${key}FS|${NC}"
				elif curl -sfA "Mozilla/5.0" "https://play.pokemonshowdown.com/sprites/gen5-shiny/${sdslug}.png" -o "$fpath" && [ -s "$fpath" ]; then
					echo -n "${GREEN}${key}sd|${NC}"
				else
					rm -f "$fpath"
					echo -n "${RED}${key}X${NC}|"
				fi
			fi
		done < <(formsfornumber "$number")
	done
	echo -e "${NC}"
}
getallbackshinyspritefrompkmndb(){
	#$1 min  $2 max -- form-aware
	mkdir -p allbackshinysprite
	echo -e "${WHITE} get all back shiny (with forms)${NC}"
	for ((i = $1 ; i <= $2 ; i++)); do
		number=$(formatnumber $i)
		while IFS= read -r form; do
			local key urlslug fpath
			key=$(formkey "$number" "$form")
			urlslug=$(formurlslug "$number" "$form")
			fpath="allbackshinysprite/${key}_back_shiny.png"
			if [ -f "$fpath" ] && [ -s "$fpath" ]; then
				echo -n "${BLACKWHITE}${key}${NC}${YELLOW}E${NC}|"
			else
				local sdslug
				sdslug=$(showdownslug "$number" "$form")
				if curl -sfA "Mozilla/5.0" "https://img.pokemondb.net/sprites/black-white/back-shiny/${urlslug}.png" -o "$fpath" && [ -s "$fpath" ]; then
					echo -n "${WHITE}${key}bs|${NC}"
				elif curl -sfA "Mozilla/5.0" "https://play.pokemonshowdown.com/sprites/gen5-back-shiny/${sdslug}.png" -o "$fpath" && [ -s "$fpath" ]; then
					echo -n "${WHITE}${key}BS|${NC}"
				else
					rm -f "$fpath"
					echo -n "${RED}${key}X${NC}|"
				fi
			fi
		done < <(formsfornumber "$number")
	done
	echo -e "${NC}"
}

##########################################IMAAAAAAAAAAAAAAAAAGE####################################################################################

getallspritefrompkmndb(){
	#$ 1min $2 max
	getallimage $1 $2
	getallshinyimage $1 $2
	getallartworkfrompkmndb $1 $2
	getallfrontspritefrompkmndb $1 $2
	getallbackspritefrompkmndb $1 $2
	getallfrontshinyspritefrompkmndb $1 $2
	getallbackshinyspritefrompkmndb $1 $2
}
getalllocationfrompkmndb(){
	# $1 = min $2 = max
	echo -e "${PURPLE} get all location"
	mkdir -p alllocation
	for ((i = $1 ; i <= $2 ; i++)); do
		number=$(formatnumber $i)
		name=$(numbertopkmn $number)
		name=$(filtername $name)
		#~ echo -n "$number $name get location"
		if [ -f "alllocation/""$number"".location" ]; then
			echo -n "${BLACKPURPLE}""$number""${NC}${BLACKYELLOW}E${NC}${PURPLE}|"
		else
			if lynx -dump https://pokemondb.net/pokedex/$name | grep "Page not found" ; then
				echo "pkmn do not exist or name.html unreachable" #maybe create blank file on purpuse
			else
				#~ echo -n "$number $name get location|"
				echo -n "$number""l|"
				cmd=$(echo "lynx --dump https://pokemondb.net/pokedex/""$name"" | sed -n '/Where to/,/Answer/p' | sed -e 's~\[[0-9][0-9][0-9]]~~g' | sed -e 's~\[[0-9][0-9]]~~g' | sed '1d' | sed '\$d' | sed 's/^[ \t]*//' | sed '/^$/d' | sed 's~é~e~g' > alllocation/$number.location")
			fi
		fi
		eval $cmd
	done
	echo -e "${NC}"
	
}
getallmovesgenxfrompkmndb(){
	# $1 = min  $2 = max  $3 = gen
	# Parses pokemondb.net/pokedex/<name>/moves/<gen> and keeps every
	# movepool section (level-up, Egg moves, TM/HM, Move Tutor, reminder,
	# Pre-evolution, Transfer-only, Special moves), preserving the per-game
	# banner that pokemondb prints just above each block.
	local gen=$3
	echo -e "${CYAN} get all moves gen${gen}${NC}"
	mkdir -p "allmoves/gen${gen}"
	local i number name url page out
	for ((i = $1 ; i <= $2 ; i++)); do
		number=$(formatnumber "$i")
		name=$(numbertopkmn "$number")
		name=$(filtername "$name")
		out="allmoves/gen${gen}/${number}.moves"
		if [ -f "$out" ]; then
			echo -n "${BLACKCYAN}${number}g${gen}${NC}${BLACKYELLOW}E${NC}${CYAN}|"
			continue
		fi
		# Gen-specific URL; some pokemon don't exist in old gens (404 page).
		url="https://pokemondb.net/pokedex/${name}/moves/${gen}"
		page=$(lynx -dump "$url" 2>/dev/null)
		if [ -z "$page" ] || echo "$page" | grep -q "Page not found"; then
			# Fallback: the default /pokedex/<name> page sometimes has the
			# moves section inline (used by gen 8 pages on pokemondb).
			page=$(lynx -dump "https://pokemondb.net/pokedex/${name}" 2>/dev/null)
			if [ -z "$page" ] || echo "$page" | grep -q "Page not found"; then
				echo -n "${RED}${number}g${gen}X${NC}${CYAN}|"
				: > "$out"
				continue
			fi
		fi
		# Extract from first "Moves learnt by level up" (with the banner
		# line just before, if any) down to "Privacy Policy".
		echo "$page" | awk '
			/Moves learnt by level up/ && !started {
				started=1
				if (p2!="") print p2
				if (p1!="") print p1
			}
			started {
				if (/Privacy Policy/) exit
				print
				next
			}
			{ p2=p1; p1=$0 }
		' | sed -e 's/\[[0-9]\+\]//g' \
		      -e 's/^   //' \
		      -e 's/é/e/g' \
		      -e '/^[[:space:]]*$/d' \
		    > "$out"
		echo -n "${CYAN}${number}g${gen}m${NC}|"
	done
	echo
}
getallentryfrompkmndb(){ ####ONLINE
	# $1 = min $2 = max
	echo -e "${GREEN} get all entry"
	mkdir -p allentry
	
	for ((i = $1 ; i <= $2 ; i++)); do
		number=$(formatnumber $i)
		name=$(numbertopkmn $number)
		name=$(filtername $name)
			#~ if lynx -dump https://pokemondb.net/pokedex/pdddd | grep "Page not found" ; then 
				#~ echo "page not found!"
			#~ else 
				#~ echo "page found" 
			#~ fi
		if [ -f "allentry/""$number"".entry" ]; then
			echo -n "${BLACKGREEN}""$number""${NC}${BLACKYELLOW}E${NC}${GREEN}|"
		else
			if lynx -dump https://pokemondb.net/pokedex/$name | grep "Page not found" ; then 
				echo "pkmn do not exist or name.html unreachable"
			else
				echo -n "$number""e|"
				cmd=$(echo "lynx -dump https://pokemondb.net/pokedex/$name | sed -e 's~\[[0-9][0-9][0-9]]~~g' | sed -e 's~\[[0-9][0-9]]~~g' | sed -e 's~\[[0-9]]~~g' | sed -e '\$d' | sed 's/^[ \t]*//' | sed 's~é~e~g' | sed 's~\^~ -~g' | sed '/^$/d' | sed -e '\$d' | sed '/^$/d' | sed -n '/Pokedex data/,/Moves learned by/p' | sed -n '/Pokedex entries/,/Moves learned by/p' | sed -e '1d' | sed '/^$/d' > allentry/$number.entry")

			fi
		fi
		eval $cmd
	done
	echo -e "${NC}"
}
getallinfofrompkmndb(){ ###ONLINE
	# $1 = min $2 = max
	echo -e "${BLUE} get all info"
	mkdir -p allinfo
	for ((i = $1 ; i <= $2 ; i++)); do
		number=$(formatnumber $i)
		name=$(numbertopkmn $number)
		name=$(filtername $name)
		if [ -f "allinfo/""$number"".info" ]; then
			echo -n "${BLACKBLUE}""$number""${NC}${BLACKYELLOW}E${NC}${BLUE}|"
		else
			if lynx -dump https://pokemondb.net/pokedex/$name | grep "Page not found" ; then 
				echo "pkmn do not exist or name.html unreachable"
			else
				echo -n "$number""i|"
				cmd=$(echo "lynx -dump https://pokemondb.net/pokedex/$name | sed -n '/Pokédex data/,/Pokédex entries/p' | sed -e 's~\[[0-9][0-9][0-9]]~~g' | sed -e 's~\[[0-9][0-9]]~~g' | sed -e 's~\[[0-9]]~~g' | sed -e '\$d' | sed 's/^[ \t]*//' | sed 's~é~e~g' | sed 's~\^~ -~g' | sed -e '1d' | sed '/^$/d' > allinfo/$number.info")
			fi
		fi
		eval $cmd
	done
	echo -e "${NC}"
}

# ---------------------------------------------------------------------------
# Scrape multilingual names (English, French, Japanese, Romaji, Korean,
# Chinese-Simplified, Chinese-Traditional) for a range of pokémon and write
# them in `pkmn.list` format (8 fields).
#
#   Primary source : pokemondb.net  (full set, but a few new entries are blank)
#   Fallback       : serebii.net pokedex-sv  (provides FR/Korean/romaji)
#
# Output goes to STDOUT so it can be piped or redirected:
#       ./pokedex.sh -g langs > pkmn.list.new
# ---------------------------------------------------------------------------
getalllangsfrompkmndb () {
	# $1 = min (default 1)   $2 = max (default 1025)
	# Output format (11 fields): num|en|fr|de|it|es|jp|romaji|ko|zh-hans|zh-hant
	# All names are lowercased.
	local lo=${1:-1} hi=${2:-1025}
	local i num en0 slug D L Lflat
	local en fr de it es jp rom ko zhs zht jpf kof

	# helper: pull a Latin-language line by header
	_lang() {
		local hdr="$1" txt="$2"
		echo "$txt" | grep -m1 -E "^[[:space:]]+${hdr}[[:space:]]" | sed "s/^[[:space:]]*${hdr}[[:space:]]*//" | xargs
	}
	# helper: serebii html-decode
	_dec() {
		python3 -c 'import sys,html; print(html.unescape(sys.stdin.read().strip()))' 2>/dev/null
	}

	for ((i=lo; i<=hi; i++)); do
		num=$(formatnumber "$i")
		en0=$(numbertopkmn "$num" en)
		slug=$(filtername "$(formatname "$en0")")

		en=""; fr=""; de=""; it=""; es=""; jp=""; rom=""; ko=""; zhs=""; zht=""

		# --- Try pokemondb (lynx) ---
		D=$(lynx -dump "https://pokemondb.net/pokedex/${slug}" 2>/dev/null)
		if echo "$D" | grep -q 'Other languages'; then
			L=$(echo "$D" | sed -n '/Other languages/,/Name origin\|Where to find\|Privacy Policy/p' | head -n 22)
			en=$(_lang  English  "$L")
			fr=$(_lang  French   "$L")
			de=$(_lang  German   "$L")
			it=$(_lang  Italian  "$L")
			es=$(_lang  Spanish  "$L")
			jpf=$(echo "$L" | grep -m1 -E '^[[:space:]]+Japanese[[:space:]]' | sed 's/^[[:space:]]*Japanese[[:space:]]*//')
			jp=$(echo  "$jpf" | sed -E 's/[[:space:]]*\([^)]*\)[[:space:]]*$//' | xargs)
			rom=$(echo "$jpf" | grep -oP '\(\K[^)]+' | head -1)
			kof=$(echo "$L" | grep -m1 -E '^[[:space:]]+Korean[[:space:]]' | sed 's/^[[:space:]]*Korean[[:space:]]*//')
			ko=$(echo "$kof" | sed -E 's/[[:space:]]*\([^)]*\)[[:space:]]*$//' | xargs)
			zhs=$(echo "$L" | tr -s ' ' | grep -m1 'Chinese (Simplified)'  | sed 's/.*Chinese (Simplified)[[:space:]]*//'  | xargs)
			zht=$(echo "$L" | tr -s ' ' | grep -m1 'Chinese (Traditional)' | sed 's/.*Chinese (Traditional)[[:space:]]*//' | xargs)
			# Lynx wraps long Chinese lines: retry on flattened text.
			if [ -z "$zhs" ] || [ -z "$zht" ]; then
				Lflat=$(echo "$L" | tr '\n' ' ' | tr -s ' ')
				[ -z "$zhs" ] && zhs=$(echo "$Lflat" | grep -oP 'Chinese \(Simplified\)\s*\K\S+'  | head -1)
				[ -z "$zht" ] && zht=$(echo "$Lflat" | grep -oP 'Chinese \(Traditional\)\s*\K\S+' | head -1)
			fi
		fi

		# --- Fallback: serebii pokedex-sv (gets fr/de/ko/romaji, no IT/ES/Chinese) ---
		# Serebii uses two slug conventions: with hyphens (e.g. nidoran-f) for
		# legacy pokémon and without hyphens (e.g. ironboulder) for paradoxes.
		if [ -z "$fr" ] && [ -z "$de" ] && [ -z "$ko" ]; then
			local slug2="${slug//-/}"
			local -a slugs=("$slug")
			[ "$slug2" != "$slug" ] && slugs+=("$slug2")
			for s in "${slugs[@]}"; do
				D=$(curl -s "https://www.serebii.net/pokedex-sv/${s}/" 2>/dev/null)
				if [ -n "$D" ] && echo "$D" | grep -q '<b>French</b>'; then
					rom=${rom:-$(echo "$D" | grep -oE '<b>Japan</b>:[[:space:]]*</td><td>[^<]+'  | head -1 | sed 's/.*<td>//' | _dec)}
					fr=$(echo  "$D" | grep -oE '<b>French</b>:[[:space:]]*</td><td>[^<]+' | head -1 | sed 's/.*<td>//' | _dec)
					de=$(echo  "$D" | grep -oE '<b>German</b>:[[:space:]]*</td><td>[^<]+' | head -1 | sed 's/.*<td>//' | _dec)
					ko=$(echo  "$D" | grep -oE '<b>Korean</b>:[[:space:]]*</td><td>[^<]+' | head -1 | sed 's/.*<td>//' | _dec)
					break
				fi
			done
		fi

		# Default English to embedded list when scraping failed
		[ -z "$en" ] && en="$en0"

		# Lowercase every Latin-script name (preserves CJK/Hangul untouched).
		_lc() { echo "$1" | sed -E 's/^(.*)$/\L\1/'; }
		en=$(_lc "$en"); fr=$(_lc "$fr"); de=$(_lc "$de")
		it=$(_lc "$it"); es=$(_lc "$es"); rom=$(_lc "$rom")

		printf '%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s\n' \
			"$num" "$en" "$fr" "$de" "$it" "$es" "$jp" "$rom" "$ko" "$zhs" "$zht"
		# Be polite to the server
		sleep 0.2
	done
}

getallmovesfromallgenfrompkmndb(){
	#~ #$1 min $2 max
		getallmovesgenxfrompkmndb 1 151 1
		getallmovesgenxfrompkmndb 1 251 2	
		getallmovesgenxfrompkmndb 1 386 3		
		getallmovesgenxfrompkmndb 1 493 4
		getallmovesgenxfrompkmndb 1 649 5
		getallmovesgenxfrompkmndb 1 721 6
		getallmovesgenxfrompkmndb 1 809 7
		getallmovesgenxfrompkmndb 1 905 8
		getallmovesgenxfrompkmndb 1 1025 9
}
catpkmfileofpkdx(){
	#$1 number
	#The standalone pokedex bundles every .pkmn after a `_start_pokedex_`
	#marker. When this script has been concatenated with its data (i.e. the
	#`_start_pokedex_` marker is present in the running file), read FROM the
	#running file ($0 / BASH_SOURCE) -- this works even when the binary has
	#been moved/installed to /usr/bin or copied elsewhere.
	number=$(formatnumber $1)
	local self="${BASH_SOURCE[0]:-$0}"
	if [ -f "$self" ] && grep -aq '^_start_pokedex_$' "$self"; then
		cat "$self"
	elif [ -f ./pokedex ]; then
		cat ./pokedex
	else
		cat "pkmnfile/${number}.pkmn"
	fi
}
showlocationfrompkmnfile() {
	#$1 = number
	number=$(formatnumber $1)
	cmd=$(echo "catpkmfileofpkdx $1 | sed -n '/^_start_location_"$number"_/,/^_stop_location_"$number"_/p'| sed '1d' | sed '\$d' | cat -")
	eval $cmd
}
showinfofrompkmnfile(){
	#$1 = number
	number=$(formatnumber $1)
	cmd=$(echo "catpkmfileofpkdx $1 | sed -n '/^_start_info_"$number"_/,/^_stop_info_"$number"_/p'| sed '1d' | sed '\$d' | cat -")
	eval $cmd
	
}
showentryfrompkmnfile(){
	#$1 = number
	number=$(formatnumber $1)
	cmd=$(echo "catpkmfileofpkdx $1 | sed -n '/^_start_entry_"$number"_/,/^_stop_entry_"$number"_/p'| sed '1d' | sed '\$d' | cat -")
	eval $cmd
	
}
showmovesfrompkmnfile(){
	#$1 = number $2 gen
	number=$(formatnumber $1)
	cmd=$(echo "catpkmfileofpkdx $1 | sed -n '/^_start_moves""$2""_"$number"_/,/^_stop_moves""$2""_"$number"_/p'| sed '1d' | sed '\$d' | cat -")
	eval $cmd
	
}
showpngfrompkmnfile () {
	#$1 = number $2=heigh on png
	number=$(formatnumber $1)
	cmd=$(echo "catpkmfileofpkdx $1 | sed -n '/^_start_png_"$number"_/,/^_stop_png_"$number"_/p'| sed '1d' | sed '\$d' | viu -t")
	if [[ -n $2 ]];then
		cmd="$cmd"" -h ""$2"" -"
	else
		cmd="$cmd"" -"
	fi
	eval $cmd
}

########### only show through viu, need to extract proper png
showshinypngfrompkmnfile () {
	#$1 = number $2=heigh on png
	number=$(formatnumber $1)
	cmd=$(echo "catpkmfileofpkdx $1 | sed -n '/^_start_png_shiny_"$number"_/,/^_stop_png_shiny_"$number"_/p'| sed '1d' | sed '\$d' | viu -t")
	if [[ -n $2 ]];then
		cmd="$cmd"" -h ""$2"" -"
	else
		cmd="$cmd"" -"
	fi
	eval $cmd
}
showartworkfrompkmnfile () {
	#$1 = number $2=heigh on png
	number=$(formatnumber $1)
	cmd=$(echo "catpkmfileofpkdx $1 | sed -n '/^_start_artwork_"$number"_/,/^_stop_artwork_"$number"_/p'| sed '1d' | sed '\$d' | viu -t")
	if [[ -n $2 ]];then
		cmd="$cmd"" -h ""$2"" -"
	else
		cmd="$cmd"" -"
	fi
	eval $cmd
}
showfrontnormalfrompkmnfile () {
	#$1 = number $2=heigh on png
	number=$(formatnumber $1)
	cmd=$(echo "catpkmfileofpkdx $1 | sed -n '/^_start_front_normal_"$number"_/,/^_stop_front_normal_"$number"_/p'| sed '1d' | sed '\$d' | viu -t")
	if [[ -n $2 ]];then
		cmd="$cmd"" -h ""$2"" -"
	else
		cmd="$cmd"" -"
	fi
	eval $cmd
}
showbacknormalfrompkmnfile () {
	#$1 = number $2=heigh on png
	number=$(formatnumber $1)
	cmd=$(echo "catpkmfileofpkdx $1 | sed -n '/^_start_back_normal_"$number"_/,/^_stop_back_normal_"$number"_/p'| sed '1d' | sed '\$d' | viu -t")
	if [[ -n $2 ]];then
		cmd="$cmd"" -h ""$2"" -"
	else
		cmd="$cmd"" -"
	fi
	eval $cmd
}
showfrontshinyfrompkmnfile () {
	#$1 = number $2=heigh on png
	number=$(formatnumber $1)
	cmd=$(echo "catpkmfileofpkdx $1 | sed -n '/^_start_front_shiny_"$number"_/,/^_stop_front_shiny_"$number"_/p'| sed '1d' | sed '\$d' | viu -t")
	if [[ -n $2 ]];then
		cmd="$cmd"" -h ""$2"" -"
	else
		cmd="$cmd"" -"
	fi
	eval $cmd
}
showbackshinyfrompkmnfile () {
	#$1 = number $2=heigh on png
	number=$(formatnumber $1)
	cmd=$(echo "catpkmfileofpkdx $1 | sed -n '/^_start_back_shiny_"$number"_/,/^_stop_back_shiny_"$number"_/p'| sed '1d' | sed '\$d' | viu -t")
	if [[ -n $2 ]];then
		cmd="$cmd"" -h ""$2"" -"
	else
		cmd="$cmd"" -"
	fi
	eval $cmd
}
######################################
showallimagefrompkmnfile() {
	#$1 = number $2=heigh on png
	showpngfrompkmnfile $1 $2
	showshinypngfrompkmnfile $1 $2
	showartworkfrompkmnfile $1 $2
	showfrontnormalfrompkmnfile $1 $2
	showbacknormalfrompkmnfile $1 $2
	showfrontshinyfrompkmnfile $1 $2
	showbackshinyfrompkmnfile $1 $2
}

playshoutfrompkmnfile () {
	#$1 = number
	number=$(formatnumber $1)
	cmd=$(echo "catpkmfileofpkdx $1 | sed -n '/^_start_shout_"$number"_/,/^_stop_shout_"$number"_/p'| sed '1d' | sed '\$d' | play -t ogg - >/dev/null 2>&1")
	eval $cmd
}
showtypefrominfoofpkmnfile(){
	#1 number $2 form $3 type 1 or 2
	#~ | head -n 1
	if [ -z "$2" ]; then
		#~ echo "teeeeeeeeeeeeeeet"
		showinfofrompkmnfile $1 | grep "Type " | sed -r 's/.*defenses.*//g' | sed '/^$/d' | sed 's/Type//g' | sed 's/^[ \t]*//g' | cut -d" " -f1-2 | tr ' ' ':' | tr '\n' '|' | sed '$ s/.$//' && echo -ne "\n"
	else
		#~ echo "$2 eeeeeeeeeeeeeeeeeefsdfsdf"
		if [ -z "$3" ]; then
			cmd=$(echo "showinfofrompkmnfile $1 | grep "Type " | sed -r 's/.*defenses.*//g' | sed '/^$/d' | sed 's/Type//g' | sed 's/^[ \t]*//g' | cut -d\" \" -f1-2 | tr ' ' ':' | tr '\n' '|' | cut -d\"|\" -f""$2") # " && echo -ne \"\n\""
			eval $cmd
		else
			cmd=$(echo "showinfofrompkmnfile $1 | grep "Type " | sed -r 's/.*defenses.*//g' | sed '/^$/d' | sed 's/Type//g' | sed 's/^[ \t]*//g' | cut -d\" \" -f1-2 | tr ' ' ':' | sed 's/$/:/g' | tr '\n' '|' | cut -d\"|\" -f""$2"" | cut -d\":\" -f""$3") #" | tr '\n' '' && echo -ne \"\n\""
			eval $cmd
		fi
	fi
}
showabilitiesfrominfoofpkmnfile(){
	#1 number $2 form $3 abilitiesnumber
	if [ -z "$2" ]; then
		#~ echo "teeeeeeeeeeeeeeet"
		showinfofrompkmnfile $1 | sed -n '/^Abilities/,/Local/p' | sed -r 's/.*Local.*/|/g' | cut -d"." -f2 | cut -d"(" -f1 | sed 's/^[ \t]*//g' | tr '\n' ':' | sed 's/ :/:/g' | sed 's/:|:/|/g' | sed '$ s/.$//' && echo -ne "\n"
	else
		#~ echo "$2 eeeeeeeeeeeeeeeeeefsdfsdf"
		if [ -z "$3" ]; then
			cmd=$(echo "showinfofrompkmnfile $1 | sed -n '/^Abilities/,/Local/p' | sed -r 's/.*Local.*/|/g' | cut -d\".\" -f2 | cut -d\"(\" -f1 | sed 's/^[ \t]*//g' | tr '\n' ':' | sed 's/ :/:/g' | sed 's/:|:/|/g' | cut -d\"|\" -f""$2")
			eval $cmd
		else
			cmd=$(echo "showinfofrompkmnfile $1 | sed -n '/^Abilities/,/Local/p' | sed -r 's/.*Local.*/|/g' | cut -d\".\" -f2 | cut -d\"(\" -f1 | sed 's/^[ \t]*//g' | tr '\n' ':' | sed 's/ :/:/g' | sed 's/|:/|/g' | cut -d\"|\" -f""$2"" | cut -d":" -f"""$3"")
			eval $cmd
		fi
	fi
	#~ showinfofrompkmnfile $1 | sed -n '/^Abilities/,/Local/p' | sed -r 's/.*Local.*/|/g' | cut -d"." -f2 | cut -d"(" -f1 | sed 's/^[ \t]*//g' | tr '\n' ':' | sed 's/ :/:/g' | sed 's/:|:/|/g' | sed '$ s/.$//' && echo -ne "\n"
}
####Show get base stat from pkmn file####
showhpfrominfoofpkmnfile(){
	#1 number $2 form
	if [ -z "$2" ]; then
		showinfofrompkmnfile $1 | sed -n '/^Base stats/,/^Total/p' | sed '1d' | sed '$d' | grep HP | sed 's/[[:blank:]]//g' | sed -e "s/[^ 0-9']//g" | tr '\n' ' ' && echo -ne "\n"
	else
		cmd=$(echo "showinfofrompkmnfile $1 | sed -n '/^Base stats/,/^Total/p' | sed '1d' | sed '$d' | grep HP | sed 's/[[:blank:]]//g' | sed -e \"s/[^ 0-9']//g\" | tr '\n' ' ' | cut -d\" \" -f""$2")
		eval $cmd
	fi
}
showatkfrominfoofpkmnfile(){
	#1 number $2 form
	if [ -z "$2" ]; then
		showinfofrompkmnfile $1 | sed -n '/^Base stats/,/^Total/p' | sed '1d' | sed '$d' | grep Attack | sed 's/[[:blank:]]//g' | sed -e "s/[^ 0-9']//g" | tr '\n' ' ' && echo -ne "\n"
	else
		cmd=$(echo "showinfofrompkmnfile $1 | sed -n '/^Base stats/,/^Total/p' | sed '1d' | sed '$d' | grep Attack | sed 's/[[:blank:]]//g' | sed -e \"s/[^ 0-9']//g\" | tr '\n' ' ' | cut -d\" \" -f""$2")
		eval $cmd
	fi
}
showdeffrominfoofpkmnfile(){
	#1 number $2 form
	if [ -z "$2" ]; then
		showinfofrompkmnfile $1 | sed -n '/^Base stats/,/^Total/p' | sed '1d' | sed '$d' | grep Defense | sed 's/[[:blank:]]//g' | sed -e "s/[^ 0-9']//g" | tr '\n' ' ' && echo -ne "\n"
	else
		cmd=$(echo "showinfofrompkmnfile $1 | sed -n '/^Base stats/,/^Total/p' | sed '1d' | sed '$d' | grep Defense | sed 's/[[:blank:]]//g' | sed -e \"s/[^ 0-9']//g\" | tr '\n' ' ' | cut -d\" \" -f""$2")
		eval $cmd
	fi
}
showsatkfrominfoofpkmnfile(){
	#1 number $2 form
	if [ -z "$2" ]; then
		showinfofrompkmnfile $1 | sed -n '/^Base stats/,/^Total/p' | sed '1d' | sed '$d' | grep "Sp. Atk" | sed 's/[[:blank:]]//g' | sed -e "s/[^ 0-9']//g" | tr '\n' ' ' && echo -ne "\n"
	else
		cmd=$(echo "showinfofrompkmnfile $1 | sed -n '/^Base stats/,/^Total/p' | sed '1d' | sed '$d' | grep \"Sp. Atk\" | sed 's/[[:blank:]]//g' | sed -e \"s/[^ 0-9']//g\" | tr '\n' ' ' | cut -d\" \" -f""$2")
		eval $cmd
	fi
}
showsdeffrominfoofpkmnfile(){
	#1 number $2 form
	if [ -z "$2" ]; then
		showinfofrompkmnfile $1 | sed -n '/^Base stats/,/^Total/p' | sed '1d' | sed '$d' | grep "Sp. Def" | sed 's/[[:blank:]]//g' | sed -e "s/[^ 0-9']//g" | tr '\n' ' ' && echo -ne "\n"
	else
		cmd=$(echo "showinfofrompkmnfile $1 | sed -n '/^Base stats/,/^Total/p' | sed '1d' | sed '$d' | grep \"Sp. Def\" | sed 's/[[:blank:]]//g' | sed -e \"s/[^ 0-9']//g\" | tr '\n' ' ' | cut -d\" \" -f""$2")
		eval $cmd
	fi
}
showspdfrominfoofpkmnfile(){
	#1 number $2 form
	if [ -z "$2" ]; then
		showinfofrompkmnfile $1 | sed -n '/^Base stats/,/^Total/p' | sed '1d' | sed '$d' | grep Speed | sed 's/[[:blank:]]//g' | sed -e "s/[^ 0-9']//g" | tr '\n' ' ' && echo -ne "\n"
	else
		cmd=$(echo "showinfofrompkmnfile $1 | sed -n '/^Base stats/,/^Total/p' | sed '1d' | sed '$d' | grep Speed | sed 's/[[:blank:]]//g' | sed -e \"s/[^ 0-9']//g\" | tr '\n' ' ' | cut -d\" \" -f""$2")
		eval $cmd
	fi
}
showallstatsfrominfopkmnfile() {
	#$1=number $2 form
	showhpfrominfoofpkmnfile $1 $2
	showatkfrominfoofpkmnfile $1 $2
	showdeffrominfoofpkmnfile $1 $2
	showsatkfrominfoofpkmnfile $1 $2
	showsdeffrominfoofpkmnfile $1 $2
	showspdfrominfoofpkmnfile $1 $2
}
showevyieldfrominfopkmnfile() {
	#$1 number $2 form $3 evyield index
	
	if [ -z "$2" ]; then
		showinfofrompkmnfile $1 | grep "EV yield" | sed "s/^EV yield//g" | sed 's/[[:blank:]]//g' | sed 's/[0-9]/& /g' | sed 's/,/:/g' | tr '\n' '|' | sed '$ s/.$//' && echo -ne "\n"
	else
		if [ -z "$3" ]; then
			cmd=$(echo "showinfofrompkmnfile $1 | grep \"EV yield\" | sed \"s/^EV yield//g\" | sed 's/[[:blank:]]//g' | sed 's/[0-9]/& /g' | sed 's/,/:/g' | tr '\n' '|' | cut -d\"|\" -f""$2")
			eval $cmd
		else
			cmd=$(echo "showinfofrompkmnfile $1 | grep \"EV yield\" | sed \"s/^EV yield//g\" | sed 's/[[:blank:]]//g' | sed 's/[0-9]/& /g' | sed 's/,/:/g' | sed 's/$/:/g' | tr '\n' '|' | cut -d\"|\" -f""$2"" | cut -d\":\" -f""$3")
			eval $cmd
		fi
	fi
}
showcatchratefrominfopkmnfile() {
	#$1 number
	showinfofrompkmnfile $1 | grep "Catch rate" | sed 's/—/ /g' | sed 's/Catch rate//g' | sed 's/^[ \t]*//g' | uniq | cut -d" " -f1
}
showbasefriendshipfrominfopkmnfile() {
	#$1 number
	showinfofrompkmnfile $1 | grep "Base Friendship" | sed 's/Base Friendship//g' | sed 's/^[ \t]*//g' | uniq | cut -d" " -f1
}
showbaseexpfrominfopkmnfile() {
	#$1 number
	showinfofrompkmnfile $1 | grep "Base Exp." | sed 's/Base Exp.//g' | sed 's/^[ \t]*//g' | uniq | cut -d" " -f1
}
showgrowthratefrominfopkmnfile() {
	#$1 number
	showinfofrompkmnfile $1 | grep "Growth Rate" | sed 's/Growth Rate//g' | sed 's/^[ \t]*//g' | uniq
}
showegggroupfrominfopkmnfile() {
	#$1 number
	showinfofrompkmnfile $1 | grep "Egg Groups" | sed 's/Egg Groups//g' | sed 's/^[ \t]*//g' | uniq | sed 's/,//g' | sed -r 's/.*Undiscovered.*//g' | sed 's/Water 1/Water1/g' | sed 's/Water 2/Water2/g' | sed 's/Water 3/Water3/g' | sed 's/ /:/g' | sed 's/Water1/Water 1/g' | sed 's/Water2/Water 2/g' | sed 's/Water3/Water 3/g'
}
showgenderfrominfopkmnfile() {
	#$1 number
	showinfofrompkmnfile $1 | grep "Gender" | sed 's/Gender //g' | sed 's/Genderless//g' | sed 's/^[ \t]*//g' | uniq | sed 's/% male//g' | sed 's/% female//g' | sed 's/,//g'
}
showeggcyclefrominfopkmnfile() {
	#$1 number
	showinfofrompkmnfile $1 | grep "Egg cycles" | sed 's/Egg cycles//g' | sed 's/^[ \t]*//g' | cut -d" " -f1 | uniq
}
showallinfofrominfopkmnfile(){
	#$1 number $2 form
	echo "EV Yield ""$(showevyieldfrominfopkmnfile $1 $2)"
	echo "Catch Rate ""$(showcatchratefrominfopkmnfile $1)"
	echo "Base Friendship ""$(showbasefriendshipfrominfopkmnfile $1)"
	echo "Base Exp ""$(showbaseexpfrominfopkmnfile $1)"
	echo "Growth Rate ""$(showgrowthratefrominfopkmnfile $1)"
	echo "Egg Group ""$(showegggroupfrominfopkmnfile $1)"
	echo "Gender ""$(showgenderfrominfopkmnfile $1)"
	echo "Egg Cycle ""$(showeggcyclefrominfopkmnfile $1)"
}
showevolutionchartfrominfopkmnfile() {
	#$1 number $2 form $3 evo stat
	if [ -z "$1" ]; then
		echo ""
	else
		if [ -z "$2" ]; then
				showinfofrompkmnfile $1 | sed -n '/^Evolution chart/,/Pokedex entries/p' | sed -n '/^Evolution chart/,/changes/p' | grep -C4 ")" | sed 's/ Fire Stone/ FeuStone/g' | sed 's/ Water Stone/ EauStone/g' | sed 's/Normal/--/g' | sed 's/Fire/--/g' | sed 's/Water/--/g' | sed 's/Electric/--/g' | sed 's/Grass/--/g' | sed 's/Ice/--/g' | sed 's/Fighting/--/g' | sed 's/Poison/--/g' | sed 's/Ground/--/g' | sed 's/Flying/--/g' | sed 's/Psychic/--/g' | sed 's/Bug/--/g' | sed 's/Rock/--/g' | sed 's/Ghost/--/g' | sed 's/Dragon/--/g' | sed 's/Dark/--/g' | sed 's/Steel/--/g' | sed 's/Fairy/--/g' | sed 's/ · //g' | sed ':a;N;$!ba;s/--\n#/|#/g' | sed 's/--//g' | sed '1d' | sed '$d' | sed '/^$/d' | sed 's/ FeuStone/ Fire Stone/g' | sed 's/ EauStone/ Water Stone/g'| tr '\n' ' ' | sed 's/ |/|/g' | sed 's/$/|/g' | sed 's/ |/|/g' | sed 's/,//g' | sed 's/ (/:(/g' | sed 's/) /):/g' && echo -ne "\n"
		else
			if [ -z "$3" ]; then
			#
				#~ | sed -n '/^Evolution chart/,/Pokedex entries/p' | sed -n '/^Evolution chart/,/changes/p' | grep -C4 ")" | sed 's/ Fire Stone/ FeuStone/g' | sed 's/ Water Stone/ EauStone/g' | sed 's/Normal/--/g' | sed 's/Fire/--/g' | sed 's/Water/--/g' | sed 's/Electric/--/g' | sed 's/Grass/--/g' | sed 's/Ice/--/g' | sed 's/Fighting/--/g' | sed 's/Poison/--/g' | sed 's/Ground/--/g' | sed 's/Flying/--/g' | sed 's/Psychic/--/g' | sed 's/Bug/--/g' | sed 's/Rock/--/g' | sed 's/Ghost/--/g' | sed 's/Dragon/--/g' | sed 's/Dark/--/g' | sed 's/Steel/--/g' | sed 's/Fairy/--/g' | sed 's/ · //g' | sed ':a;N;$!ba;s/--\n#/|#/g' | sed 's/--//g' | sed '1d' | sed '$d' | sed '/^$/d' | sed 's/ FeuStone/ Fire Stone/g' | sed 's/ EauStone/ Water Stone/g'| tr '\n' ' ' | sed 's/ |/|/g' | sed 's/$/|/g' | sed 's/ |/|/g' | cut -d"|" -f1
				cmd=$(echo "showinfofrompkmnfile $1 | sed -n '/^Evolution chart/,/Pokedex entries/p' | sed -n '/^Evolution chart/,/changes/p' | grep -C4 \")\" | sed 's/ Fire Stone/ FeuStone/g' | sed 's/ Water Stone/ EauStone/g' | sed 's/Normal/--/g' | sed 's/Fire/--/g' | sed 's/Water/--/g' | sed 's/Electric/--/g' | sed 's/Grass/--/g' | sed 's/Ice/--/g' | sed 's/Fighting/--/g' | sed 's/Poison/--/g' | sed 's/Ground/--/g' | sed 's/Flying/--/g' | sed 's/Psychic/--/g' | sed 's/Bug/--/g' | sed 's/Rock/--/g' | sed 's/Ghost/--/g' | sed 's/Dragon/--/g' | sed 's/Dark/--/g' | sed 's/Steel/--/g' | sed 's/Fairy/--/g' | sed 's/ · //g' | sed ':a;N;\$!ba;s/--\n#/|#/g' | sed 's/--//g' | sed '1d' | sed '\$d' | sed '/^$/d' | sed 's/ FeuStone/ Fire Stone/g' | sed 's/ EauStone/ Water Stone/g'| tr '\n' ' ' | sed 's/ |/|/g' | sed 's/$/|/g' | sed 's/ |/|/g' | cut -d\"|\" -f""$2"" | sed 's/,//g' | sed 's/ (/:(/g' | sed 's/) /):/g'")
				eval $cmd
			# use while res = empty string  
				
			else
				cmd2=$(echo "showinfofrompkmnfile $1 | sed -n '/^Evolution chart/,/Pokedex entries/p' | sed -n '/^Evolution chart/,/changes/p' | grep -C4 \")\" | sed 's/ Fire Stone/ FeuStone/g' | sed 's/ Water Stone/ EauStone/g' | sed 's/Normal/--/g' | sed 's/Fire/--/g' | sed 's/Water/--/g' | sed 's/Electric/--/g' | sed 's/Grass/--/g' | sed 's/Ice/--/g' | sed 's/Fighting/--/g' | sed 's/Poison/--/g' | sed 's/Ground/--/g' | sed 's/Flying/--/g' | sed 's/Psychic/--/g' | sed 's/Bug/--/g' | sed 's/Rock/--/g' | sed 's/Ghost/--/g' | sed 's/Dragon/--/g' | sed 's/Dark/--/g' | sed 's/Steel/--/g' | sed 's/Fairy/--/g' | sed 's/ · //g' | sed ':a;N;\$!ba;s/--\n#/|#/g' | sed 's/--//g' | sed '1d' | sed '\$d' | sed '/^$/d' | sed 's/ FeuStone/ Fire Stone/g' | sed 's/ EauStone/ Water Stone/g'| tr '\n' ' ' | sed 's/ |/|/g' | sed 's/$/|/g' | sed 's/ |/|/g' | cut -d\"|\" -f""$2"" | sed 's/,//g' | sed 's/ (/:(/g' | sed 's/) /):/g' | cut -d\":\" -f""$3")
				eval $cmd2			
			fi
		fi
	fi
	
	#~ | sed -n '/^Evolution chart/,/Pokedex entries/p' | sed -n '/^Evolution chart/,/changes/p' | grep -C4 ")" | sed 's/ Fire Stone/ FeuStone/g' | sed 's/ Water Stone/ EauStone/g' | sed 's/Normal/--/g' | sed 's/Fire/--/g' | sed 's/Water/--/g' | sed 's/Electric/--/g' | sed 's/Grass/--/g' | sed 's/Ice/--/g' | sed 's/Fighting/--/g' | sed 's/Poison/--/g' | sed 's/Ground/--/g' | sed 's/Flying/--/g' | sed 's/Psychic/--/g' | sed 's/Bug/--/g' | sed 's/Rock/--/g' | sed 's/Ghost/--/g' | sed 's/Dragon/--/g' | sed 's/Dark/--/g' | sed 's/Steel/--/g' | sed 's/Fairy/--/g' | sed 's/ · //g' | sed ':a;N;$!ba;s/--\n#/|#/g' | sed 's/--//g' | sed '1d' | sed '$d' | sed '/^$/d' | sed 's/ FeuStone/ Fire Stone/g' | sed 's/ EauStone/ Water Stone/g'| tr '\n' ' ' | sed 's/ |/|/g' | cut -d"|" -f1
	#~ res1=
	#~ res2=`showinfofrompkmnfile $1 | sed -n '/^Evolution chart/,/Pokedex entries/p' | sed -n '/^Evolution chart/,/changes/p' | sed '1d' | sed '$d' | grep -C4 "(" | tr '\n' ' ' | sed 's/#/\n/g' | sed '/^$/d' | sed 's/(/\n(/g' | sed 's/ Fire Stone/ FeuStone/g' | sed 's/ Water Stone/ EauStone/g' | sed 's/ Normal//g' | sed 's/ Fire//g' | sed 's/ Water//g' | sed 's/ Electric//g' | sed 's/ Grass//g' | sed 's/ Ice//g' | sed 's/ Fighting//g' | sed 's/ Poison//g' | sed 's/ Ground//g' | sed 's/ Flying//g' | sed 's/ Psychic//g' | sed 's/ Bug//g' | sed 's/ Rock//g' | sed 's/ Ghost//g' | sed 's/ Dragon//g' | sed 's/ Dark//g' | sed 's/ Steel//g' | sed 's/ Fairy//g' | grep -A1 "(" | sed 's/--/|/g' | tr '\n' ' ' | sed 's/  / /g'| sed 's/) /)!/g' | sed 's/ | /|/g' | sed 's/ (/:(/g' | sed 's/ ·//g' | sed 's/ FeuStone/ Fire Stone/g' | sed 's/ EauStone/ Water Stone/g' && echo -ne "\n"`
	
}

showall() {
	#$1 = number
	showallimagefrompkmnfile $1
	playshoutfrompkmnfile $1
	showlocationfrompkmnfile $1
	showallinfofrominfopkmnfile $1
	showallstatsfrominfopkmnfile $1
	showentryfrompkmnfile $1
	showevolutionchartfrominfopkmnfile $1
}

##########################

showpkdxpage () {
	#$1= number
	if [ $1 -lt 1026 ]; then 
		showpngfrompkmnfile $1 16
		playshoutfrompkmnfile $1
		showlocationfrompkmnfile $1
		showentryfrompkmnfile $number
		showinfofrompkmnfile $number
		for ((i = $(definegen $1) ; i <= 9 ; i++));do
			showmovesfrompkmnfile $number $i
		done
	else
		echo "This pokémon does not exist."
	fi
}

##########building pokedex#########################
getall(){
	getallentryfrompkmndb 1 1025
	getallinfofrompkmndb 1 1025
	getalllocationfrompkmndb 1 1025
	getallmovesfromallgenfrompkmndb
	getallshoutogg 1 1025
	getallspritefrompkmndb 1 1025
}

# ---------------------------------------------------------------------------
# Build a single .pkmn file (form-aware).
#   Marker convention inside the file:
#     _start_<section>_<key>_   ...   _stop_<section>_<key>_
#   where <key> is "0006" (default form) or "0006-mega-x" (alternative form).
#
#   Image sections are emitted once per known form.
#   Text sections (info/entry/location/moves) only use the default form's
#   data because pokemondb serves all forms on the same page.
# ---------------------------------------------------------------------------
buildpkmnfile () {
	#$1 pkmn number (1..1025, may be padded)
	mkdir -p pkmnfile
	number=$(formatnumber "$1")
	name=$(numbertopkmn "$number")
	local gen
	gen=$(intnumber "$(definegen)")
	rm -f "pkmnfile/$number.pkmn"
	touch "pkmnfile/$number.pkmn"
	local f="pkmnfile/$number.pkmn"

	_emit() {
		# $1=section name  $2=key  $3=source file (optional)
		printf '\n_start_%s_%s_\n' "$1" "$2" >> "$f"
		[ -n "$3" ] && [ -f "$3" ] && cat "$3" >> "$f"
		printf '\n_stop_%s_%s_\n'  "$1" "$2" >> "$f"
	}

	# --- Text sections (default form data) ---
	_emit location "$number" "alllocation/$number.location"
	_emit info     "$number" "allinfo/$number.info"
	_emit entry    "$number" "allentry/$number.entry"

	# --- Moves: from origin gen up to gen 9 ---
	local g
	for ((g=gen; g<=9; g++)); do
		_emit "moves${g}" "$number" "allmoves/gen${g}/${number}.moves"
	done

	# --- Cry (default form only) ---
	if [ -f "allshoutogg/$number.ogg" ]; then
		_emit shout "$number" "allshoutogg/$number.ogg"
	elif [ -f "allshoutogg/empty.ogg" ]; then
		_emit shout "$number" "allshoutogg/empty.ogg"
	else
		_emit shout "$number" ""
	fi

	# --- Images: one section per known form ---
	while IFS= read -r form; do
		local key="$number"
		[ -n "$form" ] && key="${number}-${form}"
		_emit png          "$key" "allpng/${key}.png"
		_emit png_shiny    "$key" "allshinypng/${key}.png"
		_emit artwork      "$key" "allartwork/${key}_artwork.png"
		_emit front_normal "$key" "allfrontsprite/${key}_front_normal.png"
		_emit back_normal  "$key" "allbacksprite/${key}_back_normal.png"
		_emit front_shiny  "$key" "allfrontshinysprite/${key}_front_shiny.png"
		_emit back_shiny   "$key" "allbackshinysprite/${key}_back_shiny.png"
	done < <(formsfornumber "$number")
}

buildallpkmnfile () {
	# $1 = min 1 $2=max 1025
	for ((i = $1 ; i <= $2 ; i++)); do
		#~ echo -n "$number "
		name=$(numbertopkmn $i )
		number=$(pkmntonumber $name)
		if [ -f "pkmnfile/""$number"".pkmn" ]; then
			echo -ne "${BLACKWHITE}""$number""${NC}${BLACKYELLOW}E${NC}"
		else
			echo -ne "${WHITE}""$number""p|${NC}"
			buildpkmnfile $(formatnumber $i)
		fi
		
	done
}

concatenateallpkmnfile () {
	# $1 = min 1 $2=max 1025
	rm -f all.pkmn
	touch all.pkmn
	for ((i = $1 ; i <= $2 ; i++)); do
		name=$(numbertopkmn $i )
		number=$(pkmntonumber $name)
		echo "Concatenating $number $name ..."
		echo -e "\n_start_""$number""$name""_\n" >> all.pkmn
		cat "./pkmnfile/$number.pkmn" >> all.pkmn
		echo -e "\n_end_""$number""$name""_\n" >> all.pkmn
	done
}

buildingpkdx () {
	# $1 = min 1 $2=max 1025
	rm -f pokedex
	touch pokedex
	echo "Concatenating pokedex.sh and all.pkmn to pokedex ..."
	cat pokedex.sh >> pokedex
	echo -e "\n_start_pokedex_\n" >> pokedex
	concatenateallpkmnfile $1 $2
	cat all.pkmn >> pokedex
	echo -e "\n_stop_pokedex_\n" >> pokedex
}
buildall(){
	buildallpkmnfile 1 1025
	buildingpkdx 1 1025
}
cppokedextousrbin () {
	if [ -f ./pokedex ]; then
		echo -e "Pokedex detected in current directory\nCopy to /usr/bin/ ? [y,n]"
		read r
		if [ $r == y ]; then
			sudo cp pokedex /usr/bin/
		else
			echo "Not copied"
		fi
	fi
}
###############################################################################
#                                CLI / HELP                                   #
###############################################################################

show_help () {
cat <<HELP
${PURPLE}pokedex.sh${NC}  --  Terminal Pokédex (gen 1 → 9, 1025 Pokémon, with forms)

${YELLOW}USAGE${NC}
    pokedex [OPTION] [ARGS...]

${YELLOW}LOOKUP${NC}
    -f, --find NAME              Print the dex number of NAME (any language).
    -n, --name NUMBER [LANG]     Print the name of pokémon NUMBER.
                                 LANG = en | fr | jp | romaji
                                      | ko (Korean) | zh-hans (Chinese Simp.)
                                      | zh-hant (Chinese Trad.)
                                 default: en
    -e, --english NAME           Convert any-language name -> English name.
    -L, --list-forms             List every (number, form) pair known.

${YELLOW}SHOW (read from compiled .pkmn files)${NC}
    -s, --show TYPE NUMBER [FORM] [EXTRA]
        TYPE = image | shinyimage | artwork | frontnormal | backnormal
             | frontshiny | backshiny | shout | location | info | entry
             | hp | atk | def | satk | sdef | spd | allstat
             | type | abilities | evyield | catchrate | basefriendship
             | baseexp | growthrate | egggroup | gender | eggcycle
             | allinfo | evolution | all
    -s moves NUMBER GEN              -- movepool for the given generation 1..9
        Examples:
            pokedex -s artwork 6 mega-x       # mega-charizard X artwork
            pokedex -s allstat 25             # pikachu base stats
            pokedex -s moves 6 4              # charizard's gen-4 movepool
            pokedex -s all 150                # full mewtwo page

${YELLOW}DOWNLOAD (from pokemondb / serebii / showdown)${NC}
    -g, --get TYPE [MIN MAX]
        TYPE = sprites | image | shinyimage | artwork | frontnormal
             | backnormal | frontshiny | backshiny | shout | location
             | info | entry | moves | langs | all
        Note: `langs` rebuilds the multilingual name list (en/fr/jp/romaji/
              ko/zh-hans/zh-hant) by scraping pokemondb (and serebii fallback)
              and prints to stdout. Redirect:  -g langs > pkmn.list
        MIN/MAX default to 1..1025 if omitted.
        Image types are FORM-AWARE: every form listed in #pkmnformlist#
        is downloaded with its own URL slug (e.g. charizard-mega-x).

${YELLOW}BUILD${NC}
    -b, --build TARGET
        TARGET = pkmn   build pkmnfile/NNNN.pkmn for every pokémon
                pkdx   concatenate all .pkmn files into ./pokedex
                all    pkmn + pkdx
                full   download everything + build all + build pkdx

    -i, --install                Copy ./pokedex to /usr/bin/ (asks confirmation)
    -h, --help                   Show this help and exit
    -v, --version                Print version

${YELLOW}COMPLETE BUILD WORKFLOW${NC}
    The full pipeline (≈ several hours, several GB) is:

        # 1. Make the script executable
        chmod +x pokedex.sh

        # 2. Install dependencies (lynx, curl, build-essential, git,
        #    imagemagick, ffmpeg, rust+cargo, viu) -- done automatically
        #    on first run on Debian/Ubuntu/WSL-Debian; on Arch/RedHat
        #    install: ffmpeg imagemagick lynx git curl base-devel
        #    then re-run.
        ./pokedex.sh -h

        # 3. (Optional) override the embedded form list with your own:
        cp /dev/null pkmnforms.list
        # ... add lines NUMBER|SLUG|DISPLAY|URL_SLUG ...

        # 4. Download every asset (long: scrapes pokemondb + serebii +
        #    play.pokemonshowdown.com).  Resumable: existing files are
        #    skipped.
        ./pokedex.sh -g all
        # Equivalent to running each individually:
        #   ./pokedex.sh -g entry
        #   ./pokedex.sh -g info
        #   ./pokedex.sh -g location
        #   ./pokedex.sh -g moves
        #   ./pokedex.sh -g shout
        #   ./pokedex.sh -g sprites      # all 7 image categories

        # 5. Build the per-pokémon binary blobs (.pkmn files):
        ./pokedex.sh -b pkmn

        # 6. Concatenate the script + all .pkmn files into a single
        #    self-contained executable named ./pokedex :
        ./pokedex.sh -b pkdx

        # 7. (Optional) install system-wide:
        ./pokedex.sh -i
        # Now you can call it from anywhere:
        pokedex -s all 25

        # Shortcut: steps 4-6 in one go
        ./pokedex.sh -b full

${YELLOW}FORMS${NC}
    Form slugs follow pokemondb URL conventions:
        mega        (Mega Evolution)        e.g.  pokedex -s artwork 3 mega
        mega-x / mega-y                     e.g.  pokedex -s artwork 6 mega-x
        gmax        (Gigantamax)            e.g.  pokedex -s artwork 25 gmax
        alola | galar | hisui | paldea      regional forms
        primal      (Primal Kyogre/Groudon)
        origin | sky | therian | unbound | crowned-sword | crowned-shield ...

    \`pokedex -L\` lists every form bundled with this pokedex.
    Add custom entries via ./pkmnforms.list (overrides the embedded list).

HELP
}

show_version () {
	echo "pokedex.sh 2026.1 — 1025 Pokémon, gen 1-9, forms-aware"
}

# ---------------------------------------------------------------------------
# Dispatcher table for "-s/--show TYPE NUMBER [FORM] [EXTRA]".
# Forms are not yet wired through every individual show* function (they read
# from the .pkmn file using the key as marker suffix). The KEY is built by
# formkey "$NUMBER" "$FORM" -- show*frompkmnfile then operates on that key.
# ---------------------------------------------------------------------------
do_show () {
	local type="$1"; shift
	local num="$1"; shift
	# `moves` takes (NUMBER GEN) only -- no form positional arg.
	# Other types take (NUMBER [FORM] [EXTRA]).
	local form="" extra=""
	if [ "$type" = "moves" ]; then
		extra="${1:-}"
	else
		form="${1:-}"
		shift 2>/dev/null || true
		extra="${1:-}"
	fi
	local key
	num=$(formatnumber "$num")
	key=$(formkey "$num" "$form")
	case "$type" in
		image)        showpngfrompkmnfile "$key" "$extra" ;;
		shinyimage)   showshinypngfrompkmnfile "$key" "$extra" ;;
		artwork)      showartworkfrompkmnfile "$key" "$extra" ;;
		frontnormal)  showfrontnormalfrompkmnfile "$key" "$extra" ;;
		backnormal)   showbacknormalfrompkmnfile "$key" "$extra" ;;
		frontshiny)   showfrontshinyfrompkmnfile "$key" "$extra" ;;
		backshiny)    showbackshinyfrompkmnfile "$key" "$extra" ;;
		allimage)     showallimagefrompkmnfile "$key" "$extra" ;;
		shout)        playshoutfrompkmnfile "$num" ;;
		location)     showlocationfrompkmnfile "$num" ;;
		info)         showinfofrompkmnfile "$num" ;;
		entry)        showentryfrompkmnfile "$num" ;;
		moves)        showmovesfrompkmnfile "$num" "$extra" ;;
		hp)           showhpfrominfoofpkmnfile "$num" "$form" ;;
		atk)          showatkfrominfoofpkmnfile "$num" "$form" ;;
		def)          showdeffrominfoofpkmnfile "$num" "$form" ;;
		satk)         showsatkfrominfoofpkmnfile "$num" "$form" ;;
		sdef)         showsdeffrominfoofpkmnfile "$num" "$form" ;;
		spd)          showspdfrominfoofpkmnfile "$num" "$form" ;;
		allstat)      showallstatsfrominfopkmnfile "$num" "$form" ;;
		type)         showtypefrominfoofpkmnfile "$num" "$form" "$extra" ;;
		abilities)    showabilitiesfrominfoofpkmnfile "$num" "$form" "$extra" ;;
		evyield)      showevyieldfrominfopkmnfile "$num" "$form" "$extra" ;;
		catchrate)    showcatchratefrominfopkmnfile "$num" ;;
		basefriendship) showbasefriendshipfrominfopkmnfile "$num" ;;
		baseexp)      showbaseexpfrominfopkmnfile "$num" ;;
		growthrate)   showgrowthratefrominfopkmnfile "$num" ;;
		egggroup)     showegggroupfrominfopkmnfile "$num" ;;
		gender)       showgenderfrominfopkmnfile "$num" ;;
		eggcycle)     showeggcyclefrominfopkmnfile "$num" ;;
		allinfo)      showallinfofrominfopkmnfile "$num" "$form" ;;
		evolution)    showevolutionchartfrominfopkmnfile "$num" "$form" "$extra" ;;
		all)          showall "$num" ;;
		*)            echo "Unknown show type: $type" >&2 ; return 1 ;;
	esac
}

do_get () {
	local type="$1"; shift
	local min="${1:-1}"
	local max="${2:-1025}"
	case "$type" in
		sprites|all)     getallspritefrompkmndb "$min" "$max" ;;
		image)           getallimage "$min" "$max" ;;
		shinyimage)      getallshinyimage "$min" "$max" ;;
		artwork)         getallartworkfrompkmndb "$min" "$max" ;;
		frontnormal)     getallfrontspritefrompkmndb "$min" "$max" ;;
		backnormal)      getallbackspritefrompkmndb "$min" "$max" ;;
		frontshiny)      getallfrontshinyspritefrompkmndb "$min" "$max" ;;
		backshiny)       getallbackshinyspritefrompkmndb "$min" "$max" ;;
		shout)           getallshoutogg "$min" "$max" ;;
		location)        getalllocationfrompkmndb "$min" "$max" ;;
		info)            getallinfofrompkmndb "$min" "$max" ;;
		entry)           getallentryfrompkmndb "$min" "$max" ;;
		moves)           getallmovesfromallgenfrompkmndb ;;
		langs|languages) getalllangsfrompkmndb "$min" "$max" ;;
		everything)      getall ;;
		*)               echo "Unknown get type: $type" >&2 ; return 1 ;;
	esac
	# When 'all' is requested, also chain the textual + audio data
	if [ "$type" = "all" ]; then
		getallentryfrompkmndb "$min" "$max"
		getallinfofrompkmndb "$min" "$max"
		getalllocationfrompkmndb "$min" "$max"
		getallmovesfromallgenfrompkmndb
		getallshoutogg "$min" "$max"
	fi
}

do_build () {
	case "$1" in
		pkmn)  buildallpkmnfile 1 1025 ;;
		pkdx)  buildingpkdx 1 1025 ;;
		all)   buildall ;;
		full)  getall; buildall ;;
		*)     echo "Unknown build target: $1" >&2 ; return 1 ;;
	esac
}

pokedex_main () {
	if [ $# -eq 0 ]; then
		show_help
		return 0
	fi
	case "$1" in
		-h|--help)         show_help ;;
		-v|--version)      show_version ;;
		-f|--find)         shift; pkmntonumber "$@" ;;
		-n|--name)         shift; numbertopkmn "$@" ;;
		-e|--english)      shift; pkmnnametoenglishname "$@" ;;
		-L|--list-forms)   listallforms ;;
		-s|--show)         shift; do_show "$@" ;;
		-g|--get)          shift; do_get "$@" ;;
		-b|--build)        shift; do_build "$@" ;;
		-i|--install)      cppokedextousrbin ;;
		*)
			echo "Unknown option: $1" >&2
			echo "Try: pokedex -h" >&2
			return 1
		;;
	esac
}

###############################################################################
#                                  ENTRY POINT                                #
###############################################################################
checkdependances
pokedex_main "$@"
IFS=$SAVEIFS

exit 0

#############
<< 'MULTILINE-COMMENT'
#pkmnlist#
0001|bulbasaur|bulbizarre|bisasam|bulbasaur|bulbasaur|フシギダネ|fushigidane|이상해씨|妙蛙种子|妙蛙種子
0002|ivysaur|herbizarre|bisaknosp|ivysaur|ivysaur|フシギソウ|fushigisou|이상해풀|妙蛙草|妙蛙草
0003|venusaur|florizarre|bisaflor|venusaur|venusaur|フシギバナ|fushigibana|이상해꽃|妙蛙花|妙蛙花
0004|charmander|salamèche|glumanda|charmander|charmander|ヒトカゲ|hitokage|파이리|小火龙|小火龍
0005|charmeleon|reptincel|glutexo|charmeleon|charmeleon|リザード|lizardo|리자드|火恐龙|火恐龍
0006|charizard|dracaufeu|glurak|charizard|charizard|リザードン|lizardon|리자몽|喷火龙|噴火龍
0007|squirtle|carapuce|schiggy|squirtle|squirtle|ゼニガメ|zenigame|꼬부기|杰尼龟|傑尼龜
0008|wartortle|carabaffe|schillok|wartortle|wartortle|カメール|kameil|어니부기|卡咪龟|卡咪龜
0009|blastoise|tortank|turtok|blastoise|blastoise|カメックス|kamex|거북왕|水箭龟|水箭龜
0010|caterpie|chenipan|raupy|caterpie|caterpie|キャタピー|caterpie|캐터피|绿毛虫|綠毛蟲
0011|metapod|chrysacier|safcon|metapod|metapod|トランセル|transel|단데기|铁甲蛹|鐵甲蛹
0012|butterfree|papilusion|smettbo|butterfree|butterfree|バタフリー|butterfree|버터플|巴大蝶|巴大蝶
0013|weedle|aspicot|hornliu|weedle|weedle|ビードル|beedle|뿔충이|独角虫|獨角蟲
0014|kakuna|coconfort|kokuna|kakuna|kakuna|コクーン|cocoon|딱충이|铁壳蛹|鐵殼蛹
0015|beedrill|dardargnan|bibor|beedrill|beedrill|スピアー|spear|독침붕|大针蜂|大針蜂
0016|pidgey|roucool|taubsi|pidgey|pidgey|ポッポ|poppo|구구|波波|波波
0017|pidgeotto|roucoups|tauboga|pidgeotto|pidgeotto|ピジョン|pigeon|피죤|比比鸟|比比鳥
0018|pidgeot|roucarnage|tauboss|pidgeot|pidgeot|ピジョット|pigeot|피죤투|大比鸟|大比鳥
0019|rattata|rattata|rattfratz|rattata|rattata|コラッタ|koratta|꼬렛|小拉达|小拉達
0020|raticate|rattatac|rattikarl|raticate|raticate|ラッタ|ratta|레트라|拉达|拉達
0021|spearow|piafabec|habitak|spearow|spearow|オニスズメ|onisuzume|깨비참|烈雀|烈雀
0022|fearow|rapasdepic|ibitak|fearow|fearow|オニドリル|onidrill|깨비드릴조|大嘴雀|大嘴雀
0023|ekans|abo|rettan|ekans|ekans|アーボ|arbo|아보|阿柏蛇|阿柏蛇
0024|arbok|arbok|arbok|arbok|arbok|アーボック|arbok|아보크|阿柏怪|阿柏怪
0025|pikachu|pikachu|pikachu|pikachu|pikachu|ピカチュウ|pikachu|피카츄|皮卡丘|皮卡丘
0026|raichu|raichu|raichu|raichu|raichu|ライチュウ|raichu|라이츄|雷丘|雷丘
0027|sandshrew|sabelette|sandan|sandshrew|sandshrew|サンド|sand|모래두지|穿山鼠|穿山鼠
0028|sandslash|sablaireau|sandamer|sandslash|sandslash|サンドパン|sandpan|고지|穿山王|穿山王
0029|nidoran♀|nidoran♀|nidoran♀|nidoran♀|nidoran♀|ニドラン♀|nidoran♀|니드런♀|尼多兰|尼多蘭
0030|nidorina|nidorina|nidorina|nidorina|nidorina|ニドリーナ|nidorina|니드리나|尼多娜|尼多娜
0031|nidoqueen|nidoqueen|nidoqueen|nidoqueen|nidoqueen|ニドクイン|nidoqueen|니드퀸|尼多后|尼多后
0032|nidoran♂|nidoran♂|nidoran♂|nidoran♂|nidoran♂|ニドラン♂|nidoran♂|니드런♂|尼多朗|尼多朗
0033|nidorino|nidorino|nidorino|nidorino|nidorino|ニドリーノ|nidorino|니드리노|尼多力诺|尼多力諾
0034|nidoking|nidoking|nidoking|nidoking|nidoking|ニドキング|nidoking|니드킹|尼多王|尼多王
0035|clefairy|mélofée|piepi|clefairy|clefairy|ピッピ|pippi|삐삐|皮皮|皮皮
0036|clefable|mélodelfe|pixi|clefable|clefable|ピクシー|pixy|픽시|皮可西|皮可西
0037|vulpix|goupix|vulpix|vulpix|vulpix|ロコン|rokon|식스테일|六尾|六尾
0038|ninetales|feunard|vulnona|ninetales|ninetales|キュウコン|kyukon|나인테일|九尾|九尾
0039|jigglypuff|rondoudou|pummeluff|jigglypuff|jigglypuff|プリン|purin|푸린|胖丁|胖丁
0040|wigglytuff|grodoudou|knuddeluff|wigglytuff|wigglytuff|プクリン|pukurin|푸크린|胖可丁|胖可丁
0041|zubat|nosferapti|zubat|zubat|zubat|ズバット|zubat|주뱃|超音蝠|超音蝠
0042|golbat|nosferalto|golbat|golbat|golbat|ゴルバット|golbat|골뱃|大嘴蝠|大嘴蝠
0043|oddish|mystherbe|myrapla|oddish|oddish|ナゾノクサ|nazonokusa|뚜벅쵸|走路草|走路草
0044|gloom|ortide|duflor|gloom|gloom|クサイハナ|kusaihana|냄새꼬|臭臭花|臭臭花
0045|vileplume|rafflesia|giflor|vileplume|vileplume|ラフレシア|ruffresia|라플레시아|霸王花|霸王花
0046|paras|paras|paras|paras|paras|パラス|paras|파라스|派拉斯|派拉斯
0047|parasect|parasect|parasek|parasect|parasect|パラセクト|parasect|파라섹트|派拉斯特|派拉斯特
0048|venonat|mimitoss|bluzuk|venonat|venonat|コンパン|kongpang|콘팡|毛球|毛球
0049|venomoth|aéromite|omot|venomoth|venomoth|モルフォン|morphon|도나리|摩鲁蛾|摩魯蛾
0050|diglett|taupiqueur|digda|diglett|diglett|ディグダ|digda|디그다|地鼠|地鼠
0051|dugtrio|triopikeur|digdri|dugtrio|dugtrio|ダグトリオ|dugtrio|닥트리오|三地鼠|三地鼠
0052|meowth|miaouss|mauzi|meowth|meowth|ニャース|nyarth|나옹|喵喵|喵喵
0053|persian|persian|snobilikat|persian|persian|ペルシアン|persian|페르시온|猫老大|貓老大
0054|psyduck|psykokwak|enton|psyduck|psyduck|コダック|koduck|고라파덕|可达鸭|可達鴨
0055|golduck|akwakwak|entoron|golduck|golduck|ゴルダック|golduck|골덕|哥达鸭|哥達鴨
0056|mankey|férosinge|menki|mankey|mankey|マンキー|mankey|망키|猴怪|猴怪
0057|primeape|colossinge|rasaff|primeape|primeape|オコリザル|okorizaru|성원숭|火暴猴|火爆猴
0058|growlithe|caninos|fukano|growlithe|growlithe|ガーディ|gardie|가디|卡蒂狗|卡蒂狗
0059|arcanine|arcanin|arkani|arcanine|arcanine|ウインディ|windie|윈디|风速狗|風速狗
0060|poliwag|ptitard|quapsel|poliwag|poliwag|ニョロモ|nyoromo|발챙이|蚊香蝌蚪|蚊香蝌蚪
0061|poliwhirl|têtarte|quaputzi|poliwhirl|poliwhirl|ニョロゾ|nyorozo|슈륙챙이|蚊香君|蚊香君
0062|poliwrath|tartard|quappo|poliwrath|poliwrath|ニョロボン|nyorobon|강챙이|蚊香泳士|蚊香泳士
0063|abra|abra|abra|abra|abra|ケーシィ|casey|캐이시|凯西|凱西
0064|kadabra|kadabra|kadabra|kadabra|kadabra|ユンゲラー|yungerer|윤겔라|勇基拉|勇基拉
0065|alakazam|alakazam|simsala|alakazam|alakazam|フーディン|foodin|후딘|胡地|胡地
0066|machop|machoc|machollo|machop|machop|ワンリキー|wanriky|알통몬|腕力|腕力
0067|machoke|machopeur|maschock|machoke|machoke|ゴーリキー|goriky|근육몬|豪力|豪力
0068|machamp|mackogneur|machomei|machamp|machamp|カイリキー|kairiky|괴력몬|怪力|怪力
0069|bellsprout|chétiflor|knofensa|bellsprout|bellsprout|マダツボミ|madatsubomi|모다피|喇叭芽|喇叭芽
0070|weepinbell|boustiflor|ultrigaria|weepinbell|weepinbell|ウツドン|utsudon|우츠동|口呆花|口呆花
0071|victreebel|empiflor|sarzenia|victreebel|victreebel|ウツボット|utsubot|우츠보트|大食花|大食花
0072|tentacool|tentacool|tentacha|tentacool|tentacool|メノクラゲ|menokurage|왕눈해|玛瑙水母|瑪瑙水母
0073|tentacruel|tentacruel|tentoxa|tentacruel|tentacruel|ドククラゲ|dokukurage|독파리|毒刺水母|毒刺水母
0074|geodude|racaillou|kleinstein|geodude|geodude|イシツブテ|isitsubute|꼬마돌|小拳石|小拳石
0075|graveler|gravalanch|georok|graveler|graveler|ゴローン|golone|데구리|隆隆石|隆隆石
0076|golem|grolem|geowaz|golem|golem|ゴローニャ|golonya|딱구리|隆隆岩|隆隆岩
0077|ponyta|ponyta|ponita|ponyta|ponyta|ポニータ|ponyta|포니타|小火马|小火馬
0078|rapidash|galopa|gallopa|rapidash|rapidash|ギャロップ|gallop|날쌩마|烈焰马|烈焰馬
0079|slowpoke|ramoloss|flegmon|slowpoke|slowpoke|ヤドン|yadon|야돈|呆呆兽|呆呆獸
0080|slowbro|flagadoss|lahmus|slowbro|slowbro|ヤドラン|yadoran|야도란|呆壳兽|呆殼獸
0081|magnemite|magnéti|magnetilo|magnemite|magnemite|コイル|coil|코일|小磁怪|小磁怪
0082|magneton|magnéton|magneton|magneton|magneton|レアコイル|rarecoil|레어코일|三合一磁怪|三合一磁怪
0083|farfetch'd|canarticho|porenta|farfetch’d|farfetch’d|カモネギ|kamonegi|파오리|大葱鸭|大蔥鴨
0084|doduo|doduo|dodu|doduo|doduo|ドードー|dodo|두두|嘟嘟|嘟嘟
0085|dodrio|dodrio|dodri|dodrio|dodrio|ドードリオ|dodorio|두트리오|嘟嘟利|嘟嘟利
0086|seel|otaria|jurob|seel|seel|パウワウ|pawou|쥬쥬|小海狮|小海獅
0087|dewgong|lamantine|jugong|dewgong|dewgong|ジュゴン|jugon|쥬레곤|白海狮|白海獅
0088|grimer|tadmorv|sleima|grimer|grimer|ベトベター|betbeter|질퍽이|臭泥|臭泥
0089|muk|grotadmorv|sleimok|muk|muk|ベトベトン|betbeton|질뻐기|臭臭泥|臭臭泥
0090|shellder|kokiyas|muschas|shellder|shellder|シェルダー|shellder|셀러|大舌贝|大舌貝
0091|cloyster|crustabri|austos|cloyster|cloyster|パルシェン|parshen|파르셀|刺甲贝|刺甲貝
0092|gastly|fantominus|nebulak|gastly|gastly|ゴース|ghos|고오스|鬼斯|鬼斯
0093|haunter|spectrum|alpollo|haunter|haunter|ゴースト|ghost|고우스트|鬼斯通|鬼斯通
0094|gengar|ectoplasma|gengar|gengar|gengar|ゲンガー|gangar|팬텀|耿鬼|耿鬼
0095|onix|onix|onix|onix|onix|イワーク|iwark|롱스톤|大岩蛇|大岩蛇
0096|drowzee|soporifik|traumato|drowzee|drowzee|スリープ|sleepe|슬리프|催眠貘|催眠貘
0097|hypno|hypnomade|hypno|hypno|hypno|スリーパー|sleeper|슬리퍼|引梦貘人|引夢貘人
0098|krabby|krabby|krabby|krabby|krabby|クラブ|crab|크랩|大钳蟹|大鉗蟹
0099|kingler|krabboss|kingler|kingler|kingler|キングラー|kingler|킹크랩|巨钳蟹|巨鉗蟹
0100|voltorb|voltorbe|voltobal|voltorb|voltorb|ビリリダマ|biriridama|찌리리공|霹雳电球|霹靂電球
0101|electrode|électrode|lektrobal|electrode|electrode|マルマイン|marumine|붐볼|顽皮雷弹|頑皮雷彈
0102|exeggcute|noeunoeuf|owei|exeggcute|exeggcute|タマタマ|tamatama|아라리|蛋蛋|蛋蛋
0103|exeggutor|noadkoko|kokowei|exeggutor|exeggutor|ナッシー|nassy|나시|椰蛋树|椰蛋樹
0104|cubone|osselait|tragosso|cubone|cubone|カラカラ|karakara|탕구리|卡拉卡拉|卡拉卡拉
0105|marowak|ossatueur|knogga|marowak|marowak|ガラガラ|garagara|텅구리|嘎啦嘎啦|嘎啦嘎啦
0106|hitmonlee|kicklee|kicklee|hitmonlee|hitmonlee|サワムラー|sawamular|시라소몬|飞腿郎|飛腿郎
0107|hitmonchan|tygnon|nockchan|hitmonchan|hitmonchan|エビワラー|ebiwalar|홍수몬|快拳郎|快拳郎
0108|lickitung|excelangue|schlurp|lickitung|lickitung|ベロリンガ|beroringa|내루미|大舌头|大舌頭
0109|koffing|smogo|smogon|koffing|koffing|ドガース|dogars|또가스|瓦斯弹|瓦斯彈
0110|weezing|smogogo|smogmog|weezing|weezing|マタドガス|matadogas|또도가스|双弹瓦斯|雙彈瓦斯
0111|rhyhorn|rhinocorne|rihorn|rhyhorn|rhyhorn|サイホーン|sihorn|뿔카노|独角犀牛|獨角犀牛
0112|rhydon|rhinoféros|rizeros|rhydon|rhydon|サイドン|sidon|코뿌리|钻角犀兽|鑽角犀獸
0113|chansey|leveinard|chaneira|chansey|chansey|ラッキー|lucky|럭키|吉利蛋|吉利蛋
0114|tangela|saquedeneu|tangela|tangela|tangela|モンジャラ|monjara|덩쿠리|蔓藤怪|蔓藤怪
0115|kangaskhan|kangourex|kangama|kangaskhan|kangaskhan|ガルーラ|garura|캥카|袋兽|袋獸
0116|horsea|hypotrempe|seeper|horsea|horsea|タッツー|tattu|쏘드라|墨海马|墨海馬
0117|seadra|hypocéan|seemon|seadra|seadra|シードラ|seadra|시드라|海刺龙|海刺龍
0118|goldeen|poissirène|goldini|goldeen|goldeen|トサキント|tosakinto|콘치|角金鱼|角金魚
0119|seaking|poissoroy|golking|seaking|seaking|アズマオウ|azumao|왕콘치|金鱼王|金魚王
0120|staryu|stari|sterndu|staryu|staryu|ヒトデマン|hitodeman|별가사리|海星星|海星星
0121|starmie|staross|starmie|starmie|starmie|スターミー|starmie|아쿠스타|宝石海星|寶石海星
0122|mr. mime|m. mime|pantimos|mr. mime|mr. mime|バリヤード|barrierd|마임맨|魔墙人偶|魔牆人偶
0123|scyther|insécateur|sichlor|scyther|scyther|ストライク|strike|스라크|飞天螳螂|飛天螳螂
0124|jynx|lippoutou|rossana|jynx|jynx|ルージュラ|rougela|루주라|迷唇姐|迷唇姐
0125|electabuzz|élektek|elektek|electabuzz|electabuzz|エレブー|eleboo|에레브|电击兽|電擊獸
0126|magmar|magmar|magmar|magmar|magmar|ブーバー|boober|마그마|鸭嘴火兽|鴨嘴火獸
0127|pinsir|scarabrute|pinsir|pinsir|pinsir|カイロス|kailios|쁘사이저|凯罗斯|凱羅斯
0128|tauros|tauros|tauros|tauros|tauros|ケンタロス|kentauros|켄타로스|肯泰罗|肯泰羅
0129|magikarp|magicarpe|karpador|magikarp|magikarp|コイキング|koiking|잉어킹|鲤鱼王|鯉魚王
0130|gyarados|léviator|garados|gyarados|gyarados|ギャラドス|gyarados|갸라도스|暴鲤龙|暴鯉龍
0131|lapras|lokhlass|lapras|lapras|lapras|ラプラス|laplace|라프라스|拉普拉斯|拉普拉斯
0132|ditto|métamorph|ditto|ditto|ditto|メタモン|metamon|메타몽|百变怪|百變怪
0133|eevee|évoli|evoli|eevee|eevee|イーブイ|eievui|이브이|伊布|伊布
0134|vaporeon|aquali|aquana|vaporeon|vaporeon|シャワーズ|showers|샤미드|水伊布|水伊布
0135|jolteon|voltali|blitza|jolteon|jolteon|サンダース|thunders|쥬피썬더|雷伊布|雷伊布
0136|flareon|pyroli|flamara|flareon|flareon|ブースター|booster|부스터|火伊布|火伊布
0137|porygon|porygon|porygon|porygon|porygon|ポリゴン|porygon|폴리곤|多边兽|多邊獸
0138|omanyte|amonita|amonitas|omanyte|omanyte|オムナイト|omnite|암나이트|菊石兽|菊石獸
0139|omastar|amonistar|amoroso|omastar|omastar|オムスター|omstar|암스타|多刺菊石兽|多刺菊石獸
0140|kabuto|kabuto|kabuto|kabuto|kabuto|カブト|kabuto|투구|化石盔|化石盔
0141|kabutops|kabutops|kabutops|kabutops|kabutops|カブトプス|kabutops|투구푸스|镰刀盔|鐮刀盔
0142|aerodactyl|ptéra|aerodactyl|aerodactyl|aerodactyl|プテラ|ptera|프테라|化石翼龙|化石翼龍
0143|snorlax|ronflex|relaxo|snorlax|snorlax|カビゴン|kabigon|잠만보|卡比兽|卡比獸
0144|articuno|artikodin|arktos|articuno|articuno|フリーザー|freezer|프리져|急冻鸟|急凍鳥
0145|zapdos|électhor|zapdos|zapdos|zapdos|サンダー|thunder|썬더|闪电鸟|閃電鳥
0146|moltres|sulfura|lavados|moltres|moltres|ファイヤー|fire|파이어|火焰鸟|火焰鳥
0147|dratini|minidraco|dratini|dratini|dratini|ミニリュウ|miniryu|미뇽|迷你龙|迷你龍
0148|dragonair|draco|dragonir|dragonair|dragonair|ハクリュー|hakuryu|신뇽|哈克龙|哈克龍
0149|dragonite|dracolosse|dragoran|dragonite|dragonite|カイリュー|kairyu|망나뇽|快龙|快龍
0150|mewtwo|mewtwo|mewtu|mewtwo|mewtwo|ミュウツー|mewtwo|뮤츠|超梦|超夢
0151|mew|mew|mew|mew|mew|ミュウ|mew|뮤|梦幻|夢幻
0152|chikorita|germignon|endivie|chikorita|chikorita|チコリータ|chicorita|치코리타|菊草叶|菊草葉
0153|bayleef|macronium|lorblatt|bayleef|bayleef|ベイリーフ|bayleaf|베이리프|月桂叶|月桂葉
0154|meganium|méganium|meganie|meganium|meganium|メガニウム|meganium|메가니움|大竺葵|大竺葵
0155|cyndaquil|héricendre|feurigel|cyndaquil|cyndaquil|ヒノアラシ|hinoarashi|브케인|火球鼠|火球鼠
0156|quilava|feurisson|igelavar|quilava|quilava|マグマラシ|magmarashi|마그케인|火岩鼠|火岩鼠
0157|typhlosion|typhlosion|tornupto|typhlosion|typhlosion|バクフーン|bakphoon|블레이범|火暴兽|火爆獸
0158|totodile|kaiminus|karnimani|totodile|totodile|ワニノコ|waninoko|리아코|小锯鳄|小鋸鱷
0159|croconaw|crocrodil|tyracroc|croconaw|croconaw|アリゲイツ|alligates|엘리게이|蓝鳄|藍鱷
0160|feraligatr|aligatueur|impergator|feraligatr|feraligatr|オーダイル|ordile|장크로다일|大力鳄|大力鱷
0161|sentret|fouinette|wiesor|sentret|sentret|オタチ|otachi|꼬리선|尾立|尾立
0162|furret|fouinar|wiesenior|furret|furret|オオタチ|ootachi|다꼬리|大尾立|大尾立
0163|hoothoot|hoothoot|hoothoot|hoothoot|hoothoot|ホーホー|hoho|부우부|咕咕|咕咕
0164|noctowl|noarfang|noctuh|noctowl|noctowl|ヨルノズク|yorunozuku|야부엉|猫头夜鹰|貓頭夜鷹
0165|ledyba|coxy|ledyba|ledyba|ledyba|レディバ|rediba|레디바|芭瓢虫|芭瓢蟲
0166|ledian|coxyclaque|ledian|ledian|ledian|レディアン|redian|레디안|安瓢虫|安瓢蟲
0167|spinarak|mimigal|webarak|spinarak|spinarak|イトマル|itomaru|페이검|圆丝蛛|圓絲蛛
0168|ariados|migalos|ariados|ariados|ariados|アリアドス|ariados|아리아도스|阿利多斯|阿利多斯
0169|crobat|nostenfer|iksbat|crobat|crobat|クロバット|crobat|크로뱃|叉字蝠|叉字蝠
0170|chinchou|loupio|lampi|chinchou|chinchou|チョンチー|chonchie|초라기|灯笼鱼|燈籠魚
0171|lanturn|lanturn|lanturn|lanturn|lanturn|ランターン|lantern|랜턴|电灯怪|電燈怪
0172|pichu|pichu|pichu|pichu|pichu|ピチュー|pichu|피츄|皮丘|皮丘
0173|cleffa|mélo|pii|cleffa|cleffa|ピィ|py|삐|皮宝宝|皮寶寶
0174|igglybuff|toudoudou|fluffeluff|igglybuff|igglybuff|ププリン|pupurin|푸푸린|宝宝丁|寶寶丁
0175|togepi|togepi|togepi|togepi|togepi|トゲピー|togepy|토게피|波克比|波克比
0176|togetic|togetic|togetic|togetic|togetic|トゲチック|togechick|토게틱|波克基古|波克基古
0177|natu|natu|natu|natu|natu|ネイティ|naty|네이티|天然雀|天然雀
0178|xatu|xatu|xatu|xatu|xatu|ネイティオ|natio|네이티오|天然鸟|天然鳥
0179|mareep|wattouat|voltilamm|mareep|mareep|メリープ|merriep|메리프|咩利羊|咩利羊
0180|flaaffy|lainergie|waaty|flaaffy|flaaffy|モココ|mokoko|보송송|茸茸羊|茸茸羊
0181|ampharos|pharamp|ampharos|ampharos|ampharos|デンリュウ|denryu|전룡|电龙|電龍
0182|bellossom|joliflor|blubella|bellossom|bellossom|キレイハナ|kireihana|아르코|美丽花|美麗花
0183|marill|marill|marill|marill|marill|マリル|maril|마릴|玛力露|瑪力露
0184|azumarill|azumarill|azumarill|azumarill|azumarill|マリルリ|marilli|마릴리|玛力露丽|瑪力露麗
0185|sudowoodo|simularbre|mogelbaum|sudowoodo|sudowoodo|ウソッキー|usokkie|꼬지모|树才怪|樹才怪
0186|politoed|tarpaud|quaxo|politoed|politoed|ニョロトノ|nyorotono|왕구리|蚊香蛙皇|蚊香蛙皇
0187|hoppip|granivol|hoppspross|hoppip|hoppip|ハネッコ|hanecco|통통코|毽子草|毽子草
0188|skiploom|floravol|hubelupf|skiploom|skiploom|ポポッコ|popocco|두코|毽子花|毽子花
0189|jumpluff|cotovol|papungha|jumpluff|jumpluff|ワタッコ|watacco|솜솜코|毽子棉|毽子棉
0190|aipom|capumain|griffel|aipom|aipom|エイパム|eipam|에이팜|长尾怪手|長尾怪手
0191|sunkern|tournegrin|sonnkern|sunkern|sunkern|ヒマナッツ|himanuts|해너츠|向日种子|向日種子
0192|sunflora|héliatronc|sonnflora|sunflora|sunflora|キマワリ|kimawari|해루미|向日花怪|向日花怪
0193|yanma|yanma|yanma|yanma|yanma|ヤンヤンマ|yanyanma|왕자리|蜻蜻蜓|蜻蜻蜓
0194|wooper|axoloto|felino|wooper|wooper|ウパー|upah|우파|乌波|烏波
0195|quagsire|maraiste|morlord|quagsire|quagsire|ヌオー|nuoh|누오|沼王|沼王
0196|espeon|mentali|psiana|espeon|espeon|エーフィ|eifie|에브이|太阳伊布|太陽伊布
0197|umbreon|noctali|nachtara|umbreon|umbreon|ブラッキー|blacky|블래키|月亮伊布|月亮伊布
0198|murkrow|cornèbre|kramurx|murkrow|murkrow|ヤミカラス|yamikarasu|니로우|黑暗鸦|黑暗鴉
0199|slowking|roigada|laschoking|slowking|slowking|ヤドキング|yadoking|야도킹|呆呆王|呆呆王
0200|misdreavus|feuforêve|traunfugil|misdreavus|misdreavus|ムウマ|muma|무우마|梦妖|夢妖
0201|unown|zarbi|icognito|unown|unown|アンノーン|unknown|안농|未知图腾|未知圖騰
0202|wobbuffet|qulbutoké|woingenau|wobbuffet|wobbuffet|ソーナンス|sonans|마자용|果然翁|果然翁
0203|girafarig|girafarig|girafarig|girafarig|girafarig|キリンリキ|kirinriki|키링키|麒麟奇|麒麟奇
0204|pineco|pomdepik|tannza|pineco|pineco|クヌギダマ|kunugidama|피콘|榛果球|榛果球
0205|forretress|foretress|forstellka|forretress|forretress|フォレトス|foretos|쏘콘|佛烈托斯|佛烈托斯
0206|dunsparce|insolourdo|dummisel|dunsparce|dunsparce|ノコッチ|nokocchi|노고치|土龙弟弟|土龍弟弟
0207|gligar|scorplane|skorgla|gligar|gligar|グライガー|gliger|글라이거|天蝎|天蠍
0208|steelix|steelix|stahlos|steelix|steelix|ハガネール|haganeil|강철톤|大钢蛇|大鋼蛇
0209|snubbull|snubbull|snubbull|snubbull|snubbull|ブルー|bulu|블루|布鲁|布魯
0210|granbull|granbull|granbull|granbull|granbull|グランブル|granbulu|그랑블루|布鲁皇|布魯皇
0211|qwilfish|qwilfish|baldorfish|qwilfish|qwilfish|ハリーセン|harysen|침바루|千针鱼|千針魚
0212|scizor|cizayox|scherox|scizor|scizor|ハッサム|hassam|핫삼|巨钳螳螂|巨鉗螳螂
0213|shuckle|caratroc|pottrott|shuckle|shuckle|ツボツボ|tsubotsubo|단단지|壶壶|壺壺
0214|heracross|scarhino|skaraborn|heracross|heracross|ヘラクロス|heracros|헤라크로스|赫拉克罗斯|赫拉克羅斯
0215|sneasel|farfuret|sniebel|sneasel|sneasel|ニューラ|nyula|포푸니|狃拉|狃拉
0216|teddiursa|teddiursa|teddiursa|teddiursa|teddiursa|ヒメグマ|himeguma|깜지곰|熊宝宝|熊寶寶
0217|ursaring|ursaring|ursaring|ursaring|ursaring|リングマ|ringuma|링곰|圈圈熊|圈圈熊
0218|slugma|limagma|schneckmag|slugma|slugma|マグマッグ|magmag|마그마그|熔岩虫|熔岩蟲
0219|magcargo|volcaropod|magcargo|magcargo|magcargo|マグカルゴ|magcargot|마그카르고|熔岩蜗牛|熔岩蝸牛
0220|swinub|marcacrin|quiekel|swinub|swinub|ウリムー|urimoo|꾸꾸리|小山猪|小山豬
0221|piloswine|cochignon|keifel|piloswine|piloswine|イノムー|inomoo|메꾸리|长毛猪|長毛豬
0222|corsola|corayon|corasonn|corsola|corsola|サニーゴ|sunnygo|코산호|太阳珊瑚|太陽珊瑚
0223|remoraid|rémoraid|remoraid|remoraid|remoraid|テッポウオ|teppouo|총어|铁炮鱼|鐵炮魚
0224|octillery|octillery|octillery|octillery|octillery|オクタン|okutank|대포무노|章鱼桶|章魚桶
0225|delibird|cadoizo|botogel|delibird|delibird|デリバード|delibird|딜리버드|信使鸟|信使鳥
0226|mantine|démanta|mantax|mantine|mantine|マンタイン|mantain|만타인|巨翅飞鱼|巨翅飛魚
0227|skarmory|airmure|panzaeron|skarmory|skarmory|エアームド|airmd|무장조|盔甲鸟|盔甲鳥
0228|houndour|malosse|hunduster|houndour|houndour|デルビル|delvil|델빌|戴鲁比|戴魯比
0229|houndoom|démolosse|hundemon|houndoom|houndoom|ヘルガー|hellgar|헬가|黑鲁加|黑魯加
0230|kingdra|hyporoi|seedraking|kingdra|kingdra|キングドラ|kingdra|킹드라|刺龙王|刺龍王
0231|phanpy|phanpy|phanpy|phanpy|phanpy|ゴマゾウ|gomazou|코코리|小小象|小小象
0232|donphan|donphan|donphan|donphan|donphan|ドンファン|donfan|코리갑|顿甲|頓甲
0233|porygon2|porygon2|porygon2|porygon2|porygon2|ポリゴン２|porygon2|폴리곤2|多边兽２型|多邊獸Ⅱ
0234|stantler|cerfrousse|damhirplex|stantler|stantler|オドシシ|odoshishi|노라키|惊角鹿|驚角鹿
0235|smeargle|queulorior|farbeagle|smeargle|smeargle|ドーブル|doble|루브도|图图犬|圖圖犬
0236|tyrogue|debugant|rabauz|tyrogue|tyrogue|バルキー|balkie|배루키|无畏小子|無畏小子
0237|hitmontop|kapoera|kapoera|hitmontop|hitmontop|カポエラー|kapoerer|카포에라|战舞郎|戰舞郎
0238|smoochum|lippouti|kussilla|smoochum|smoochum|ムチュール|muchul|뽀뽀라|迷唇娃|迷唇娃
0239|elekid|élekid|elekid|elekid|elekid|エレキッド|elekid|에레키드|电击怪|電擊怪
0240|magby|magby|magby|magby|magby|ブビィ|buby|마그비|鸭嘴宝宝|鴨嘴寶寶
0241|miltank|écrémeuh|miltank|miltank|miltank|ミルタンク|miltank|밀탱크|大奶罐|大奶罐
0242|blissey|leuphorie|heiteira|blissey|blissey|ハピナス|happinas|해피너스|幸福蛋|幸福蛋
0243|raikou|raikou|raikou|raikou|raikou|ライコウ|raikou|라이코|雷公|雷公
0244|entei|entei|entei|entei|entei|エンテイ|entei|앤테이|炎帝|炎帝
0245|suicune|suicune|suicune|suicune|suicune|スイクン|suicune|스이쿤|水君|水君
0246|larvitar|embrylex|larvitar|larvitar|larvitar|ヨーギラス|yogiras|애버라스|幼基拉斯|幼基拉斯
0247|pupitar|ymphect|pupitar|pupitar|pupitar|サナギラス|sanagiras|데기라스|沙基拉斯|沙基拉斯
0248|tyranitar|tyranocif|despotar|tyranitar|tyranitar|バンギラス|bangiras|마기라스|班基拉斯|班基拉斯
0249|lugia|lugia|lugia|lugia|lugia|ルギア|lugia|루기아|洛奇亚|洛奇亞
0250|ho-oh|ho-oh|ho-oh|ho-oh|ho-oh|ホウオウ|houou|칠색조|凤王|鳳王
0251|celebi|celebi|celebi|celebi|celebi|セレビィ|celebi|세레비|时拉比|時拉比
0252|treecko|arcko|geckarbor|treecko|treecko|キモリ|kimori|나무지기|木守宫|木守宮
0253|grovyle|massko|reptain|grovyle|grovyle|ジュプトル|juptile|나무돌이|森林蜥蜴|森林蜥蜴
0254|sceptile|jungko|gewaldro|sceptile|sceptile|ジュカイン|jukain|나무킹|蜥蜴王|蜥蜴王
0255|torchic|poussifeu|flemmli|torchic|torchic|アチャモ|achamo|아차모|火稚鸡|火稚雞
0256|combusken|galifeu|jungglut|combusken|combusken|ワカシャモ|wakasyamo|영치코|力壮鸡|力壯雞
0257|blaziken|braségali|lohgock|blaziken|blaziken|バシャーモ|bursyamo|번치코|火焰鸡|火焰雞
0258|mudkip|gobou|hydropi|mudkip|mudkip|ミズゴロウ|mizugorou|물짱이|水跃鱼|水躍魚
0259|marshtomp|flobio|moorabbel|marshtomp|marshtomp|ヌマクロー|numacraw|늪짱이|沼跃鱼|沼躍魚
0260|swampert|laggron|sumpex|swampert|swampert|ラグラージ|laglarge|대짱이|巨沼怪|巨沼怪
0261|poochyena|medhyèna|fiffyen|poochyena|poochyena|ポチエナ|pochiena|포챠나|土狼犬|土狼犬
0262|mightyena|grahyèna|magnayen|mightyena|mightyena|グラエナ|graena|그라에나|大狼犬|大狼犬
0263|zigzagoon|zigzaton|zigzachs|zigzagoon|zigzagoon|ジグザグマ|jiguzaguma|지그제구리|蛇纹熊|蛇紋熊
0264|linoone|linéon|geradaks|linoone|linoone|マッスグマ|massuguma|직구리|直冲熊|直衝熊
0265|wurmple|chenipotte|waumpel|wurmple|wurmple|ケムッソ|kemusso|개무소|刺尾虫|刺尾蟲
0266|silcoon|armulys|schaloko|silcoon|silcoon|カラサリス|karasalis|실쿤|甲壳茧|甲殼繭
0267|beautifly|charmillon|papinella|beautifly|beautifly|アゲハント|agehunt|뷰티플라이|狩猎凤蝶|狩獵鳳蝶
0268|cascoon|blindalys|panekon|cascoon|cascoon|マユルド|mayuld|카스쿤|盾甲茧|盾甲繭
0269|dustox|papinox|pudox|dustox|dustox|ドクケイル|dokucale|독케일|毒粉蛾|毒粉蛾
0270|lotad|nénupiot|loturzel|lotad|lotad|ハスボー|hassboh|연꽃몬|莲叶童子|蓮葉童子
0271|lombre|lombre|lombrero|lombre|lombre|ハスブレロ|hasubrero|로토스|莲帽小童|蓮帽小童
0272|ludicolo|ludicolo|kappalores|ludicolo|ludicolo|ルンパッパ|runpappa|로파파|乐天河童|樂天河童
0273|seedot|grainipiot|samurzel|seedot|seedot|タネボー|taneboh|도토링|橡实果|橡實果
0274|nuzleaf|pifeuil|blanas|nuzleaf|nuzleaf|コノハナ|konohana|잎새코|长鼻叶|長鼻葉
0275|shiftry|tengalice|tengulist|shiftry|shiftry|ダーテング|dirteng|다탱구|狡猾天狗|狡猾天狗
0276|taillow|nirondelle|schwalbini|taillow|taillow|スバメ|subame|테일로|傲骨燕|傲骨燕
0277|swellow|hélédelle|schwalboss|swellow|swellow|オオスバメ|ohsubame|스왈로|大王燕|大王燕
0278|wingull|goélise|wingull|wingull|wingull|キャモメ|camome|갈모매|长翅鸥|長翅鷗
0279|pelipper|bekipan|pelipper|pelipper|pelipper|ペリッパー|pelipper|패리퍼|大嘴鸥|大嘴鷗
0280|ralts|tarsal|trasla|ralts|ralts|ラルトス|ralts|랄토스|拉鲁拉丝|拉魯拉絲
0281|kirlia|kirlia|kirlia|kirlia|kirlia|キルリア|kirlia|킬리아|奇鲁莉安|奇魯莉安
0282|gardevoir|gardevoir|guardevoir|gardevoir|gardevoir|サーナイト|sirnight|가디안|沙奈朵|沙奈朵
0283|surskit|arakdo|gehweiher|surskit|surskit|アメタマ|ametama|비구술|溜溜糖球|溜溜糖球
0284|masquerain|maskadra|maskeregen|masquerain|masquerain|アメモース|amemoth|비나방|雨翅蛾|雨翅蛾
0285|shroomish|balignon|knilz|shroomish|shroomish|キノココ|kinococo|버섯꼬|蘑蘑菇|蘑蘑菇
0286|breloom|chapignon|kapilz|breloom|breloom|キノガッサ|kinogassa|버섯모|斗笠菇|斗笠菇
0287|slakoth|parecool|bummelz|slakoth|slakoth|ナマケロ|namakero|게을로|懒人獭|懶人獺
0288|vigoroth|vigoroth|muntier|vigoroth|vigoroth|ヤルキモノ|yarukimono|발바로|过动猿|過動猿
0289|slaking|monaflèmit|letarking|slaking|slaking|ケッキング|kekking|게을킹|请假王|請假王
0290|nincada|ningale|nincada|nincada|nincada|ツチニン|tutinin|토중몬|土居忍士|土居忍士
0291|ninjask|ninjask|ninjask|ninjask|ninjask|テッカニン|tekkanin|아이스크|铁面忍者|鐵面忍者
0292|shedinja|munja|ninjatom|shedinja|shedinja|ヌケニン|nukenin|껍질몬|脱壳忍者|脫殼忍者
0293|whismur|chuchmur|flurmel|whismur|whismur|ゴニョニョ|gonyonyo|소곤룡|咕妞妞|咕妞妞
0294|loudred|ramboum|krakeelo|loudred|loudred|ドゴーム|dogohmb|노공룡|吼爆弹|吼爆彈
0295|exploud|brouhabam|krawumms|exploud|exploud|バクオング|bakuong|폭음룡|爆音怪|爆音怪
0296|makuhita|makuhita|makuhita|makuhita|makuhita|マクノシタ|makunoshita|마크탕|幕下力士|幕下力士
0297|hariyama|hariyama|hariyama|hariyama|hariyama|ハリテヤマ|hariteyama|하리뭉|铁掌力士|鐵掌力士
0298|azurill|azurill|azurill|azurill|azurill|ルリリ|ruriri|루리리|露力丽|露力麗
0299|nosepass|tarinor|nasgnet|nosepass|nosepass|ノズパス|nosepass|코코파스|朝北鼻|朝北鼻
0300|skitty|skitty|eneco|skitty|skitty|エネコ|eneco|에나비|向尾喵|向尾喵
0301|delcatty|delcatty|enekoro|delcatty|delcatty|エネコロロ|enekororo|델케티|优雅猫|優雅貓
0302|sableye|ténéfix|zobiris|sableye|sableye|ヤミラミ|yamirami|깜까미|勾魂眼|勾魂眼
0303|mawile|mysdibule|flunkifer|mawile|mawile|クチート|kucheat|입치트|大嘴娃|大嘴娃
0304|aron|galekid|stollunior|aron|aron|ココドラ|cokodora|가보리|可可多拉|可可多拉
0305|lairon|galegon|stollrak|lairon|lairon|コドラ|kodora|갱도라|可多拉|可多拉
0306|aggron|galeking|stolloss|aggron|aggron|ボスゴドラ|bossgodora|보스로라|波士可多拉|波士可多拉
0307|meditite|méditikka|meditie|meditite|meditite|アサナン|asanan|요가랑|玛沙那|瑪沙那
0308|medicham|charmina|meditalis|medicham|medicham|チャーレム|charem|요가램|恰雷姆|恰雷姆
0309|electrike|dynavolt|frizelbliz|electrike|electrike|ラクライ|rakurai|썬더라이|落雷兽|落雷獸
0310|manectric|élecsprint|voltenso|manectric|manectric|ライボルト|livolt|썬더볼트|雷电兽|雷電獸
0311|plusle|posipi|plusle|plusle|plusle|プラスル|prasle|플러시|正电拍拍|正電拍拍
0312|minun|négapi|minun|minun|minun|マイナン|minun|마이농|负电拍拍|負電拍拍
0313|volbeat|muciole|volbeat|volbeat|volbeat|バルビート|barubeat|볼비트|电萤虫|電螢蟲
0314|illumise|lumivole|illumise|illumise|illumise|イルミーゼ|illumise|네오비트|甜甜萤|甜甜螢
0315|roselia|rosélia|roselia|roselia|roselia|ロゼリア|roselia|로젤리아|毒蔷薇|毒薔薇
0316|gulpin|gloupti|schluppuck|gulpin|gulpin|ゴクリン|gokulin|꼴깍몬|溶食兽|溶食獸
0317|swalot|avaltout|schlukwech|swalot|swalot|マルノーム|marunoom|꿀꺽몬|吞食兽|吞食獸
0318|carvanha|carvanha|kanivanha|carvanha|carvanha|キバニア|kibanha|샤프니아|利牙鱼|利牙魚
0319|sharpedo|sharpedo|tohaido|sharpedo|sharpedo|サメハダー|samehader|샤크니아|巨牙鲨|巨牙鯊
0320|wailmer|wailmer|wailmer|wailmer|wailmer|ホエルコ|hoeruko|고래왕자|吼吼鲸|吼吼鯨
0321|wailord|wailord|wailord|wailord|wailord|ホエルオー|whaloh|고래왕|吼鲸王|吼鯨王
0322|numel|chamallot|camaub|numel|numel|ドンメル|donmel|둔타|呆火驼|呆火駝
0323|camerupt|camérupt|camerupt|camerupt|camerupt|バクーダ|bakuuda|폭타|喷火驼|噴火駝
0324|torkoal|chartor|qurtel|torkoal|torkoal|コータス|cotoise|코터스|煤炭龟|煤炭龜
0325|spoink|spoink|spoink|spoink|spoink|バネブー|baneboo|피그점프|跳跳猪|跳跳豬
0326|grumpig|groret|groink|grumpig|grumpig|ブーピッグ|boopig|피그킹|噗噗猪|噗噗豬
0327|spinda|spinda|pandir|spinda|spinda|パッチール|patcheel|얼루기|晃晃斑|晃晃斑
0328|trapinch|kraknoix|knacklion|trapinch|trapinch|ナックラー|nuckrar|톱치|大颚蚁|大顎蟻
0329|vibrava|vibraninf|vibrava|vibrava|vibrava|ビブラーバ|vibrava|비브라바|超音波幼虫|超音波幼蟲
0330|flygon|libégon|libelldra|flygon|flygon|フライゴン|flygon|플라이곤|沙漠蜻蜓|沙漠蜻蜓
0331|cacnea|cacnea|tuska|cacnea|cacnea|サボネア|sabonea|선인왕|刺球仙人掌|刺球仙人掌
0332|cacturne|cacturne|noktuska|cacturne|cacturne|ノクタス|noctus|밤선인|梦歌仙人掌|夢歌仙人掌
0333|swablu|tylton|wablu|swablu|swablu|チルット|tyltto|파비코|青绵鸟|青綿鳥
0334|altaria|altaria|altaria|altaria|altaria|チルタリス|tyltalis|파비코리|七夕青鸟|七夕青鳥
0335|zangoose|mangriff|sengo|zangoose|zangoose|ザングース|zangoose|쟝고|猫鼬斩|貓鼬斬
0336|seviper|séviper|vipitis|seviper|seviper|ハブネーク|habunake|세비퍼|饭匙蛇|飯匙蛇
0337|lunatone|séléroc|lunastein|lunatone|lunatone|ルナトーン|lunatone|루나톤|月石|月石
0338|solrock|solaroc|sonnfel|solrock|solrock|ソルロック|solrock|솔록|太阳岩|太陽岩
0339|barboach|barloche|schmerbe|barboach|barboach|ドジョッチ|dojoach|미꾸리|泥泥鳅|泥泥鰍
0340|whiscash|barbicha|welsar|whiscash|whiscash|ナマズン|namazun|메깅|鲶鱼王|鯰魚王
0341|corphish|écrapince|krebscorps|corphish|corphish|ヘイガニ|heigani|가재군|龙虾小兵|龍蝦小兵
0342|crawdaunt|colhomard|krebutack|crawdaunt|crawdaunt|シザリガー|shizariger|가재장군|铁螯龙虾|鐵螯龍蝦
0343|baltoy|balbuto|puppance|baltoy|baltoy|ヤジロン|yajilon|오뚝군|天秤偶|天秤偶
0344|claydol|kaorine|lepumentas|claydol|claydol|ネンドール|nendoll|점토도리|念力土偶|念力土偶
0345|lileep|lilia|liliep|lileep|lileep|リリーラ|lilyla|릴링|触手百合|觸手百合
0346|cradily|vacilys|wielie|cradily|cradily|ユレイドル|yuradle|릴리요|摇篮百合|搖籃百合
0347|anorith|anorith|anorith|anorith|anorith|アノプス|anopth|아노딥스|太古羽虫|太古羽蟲
0348|armaldo|armaldo|armaldo|armaldo|armaldo|アーマルド|armaldo|아말도|太古盔甲|太古盔甲
0349|feebas|barpau|barschwa|feebas|feebas|ヒンバス|hinbass|빈티나|丑丑鱼|醜醜魚
0350|milotic|milobellus|milotic|milotic|milotic|ミロカロス|milokaross|밀로틱|美纳斯|美納斯
0351|castform|morphéo|formeo|castform|castform|ポワルン|powalen|캐스퐁|飘浮泡泡|飄浮泡泡
0352|kecleon|kecleon|kecleon|kecleon|kecleon|カクレオン|kakureon|켈리몬|变隐龙|變隱龍
0353|shuppet|polichombr|shuppet|shuppet|shuppet|カゲボウズ|kagebouzu|어둠대신|怨影娃娃|怨影娃娃
0354|banette|branette|banette|banette|banette|ジュペッタ|juppeta|다크펫|诅咒娃娃|詛咒娃娃
0355|duskull|skelénox|zwirrlicht|duskull|duskull|ヨマワル|yomawaru|해골몽|夜巡灵|夜巡靈
0356|dusclops|téraclope|zwirrklop|dusclops|dusclops|サマヨール|samayouru|미라몽|彷徨夜灵|彷徨夜靈
0357|tropius|tropius|tropius|tropius|tropius|トロピウス|tropius|트로피우스|热带龙|熱帶龍
0358|chimecho|éoko|palimpalim|chimecho|chimecho|チリーン|chirean|치렁|风铃铃|風鈴鈴
0359|absol|absol|absol|absol|absol|アブソル|absol|앱솔|阿勃梭鲁|阿勃梭魯
0360|wynaut|okéoké|isso|wynaut|wynaut|ソーナノ|sohnano|마자|小果然|小果然
0361|snorunt|stalgamin|schneppke|snorunt|snorunt|ユキワラシ|yukiwarashi|눈꼬마|雪童子|雪童子
0362|glalie|oniglali|firnontor|glalie|glalie|オニゴーリ|onigohri|얼음귀신|冰鬼护|冰鬼護
0363|spheal|obalie|seemops|spheal|spheal|タマザラシ|tamazarashi|대굴레오|海豹球|海豹球
0364|sealeo|phogleur|seejong|sealeo|sealeo|トドグラー|todoggler|씨레오|海魔狮|海魔獅
0365|walrein|kaimorse|walraisa|walrein|walrein|トドゼルガ|todoseruga|씨카이저|帝牙海狮|帝牙海獅
0366|clamperl|coquiperl|perlu|clamperl|clamperl|パールル|pearlulu|진주몽|珍珠贝|珍珠貝
0367|huntail|serpang|aalabyss|huntail|huntail|ハンテール|huntail|헌테일|猎斑鱼|獵斑魚
0368|gorebyss|rosabyss|saganabyss|gorebyss|gorebyss|サクラビス|sakurabyss|분홍장이|樱花鱼|櫻花魚
0369|relicanth|relicanth|relicanth|relicanth|relicanth|ジーランス|glanth|시라칸|古空棘鱼|古空棘魚
0370|luvdisc|lovdisc|liebiskus|luvdisc|luvdisc|ラブカス|lovecus|사랑동이|爱心鱼|愛心魚
0371|bagon|draby|kindwurm|bagon|bagon|タツベイ|tatsubay|아공이|宝贝龙|寶貝龍
0372|shelgon|drackhaus|draschel|shelgon|shelgon|コモルー|komoruu|쉘곤|甲壳龙|甲殼龍
0373|salamence|drattak|brutalanda|salamence|salamence|ボーマンダ|bohmander|보만다|暴飞龙|暴飛龍
0374|beldum|terhal|tanhel|beldum|beldum|ダンバル|dumbber|메탕|铁哑铃|鐵啞鈴
0375|metang|métang|metang|metang|metang|メタング|metang|메탕구|金属怪|金屬怪
0376|metagross|métalosse|metagross|metagross|metagross|メタグロス|metagross|메타그로스|巨金怪|巨金怪
0377|regirock|regirock|regirock|regirock|regirock|レジロック|regirock|레지락|雷吉洛克|雷吉洛克
0378|regice|regice|regice|regice|regice|レジアイス|regice|레지아이스|雷吉艾斯|雷吉艾斯
0379|registeel|registeel|registeel|registeel|registeel|レジスチル|registeel|레지스틸|雷吉斯奇鲁|雷吉斯奇魯
0380|latias|latias|latias|latias|latias|ラティアス|latias|라티아스|拉帝亚斯|拉帝亞斯
0381|latios|latios|latios|latios|latios|ラティオス|latios|라티오스|拉帝欧斯|拉帝歐斯
0382|kyogre|kyogre|kyogre|kyogre|kyogre|カイオーガ|kyogre|가이오가|盖欧卡|蓋歐卡
0383|groudon|groudon|groudon|groudon|groudon|グラードン|groudon|그란돈|固拉多|固拉多
0384|rayquaza|rayquaza|rayquaza|rayquaza|rayquaza|レックウザ|rayquaza|레쿠쟈|烈空坐|烈空坐
0385|jirachi|jirachi|jirachi|jirachi|jirachi|ジラーチ|jirachi|지라치|基拉祈|基拉祈
0386|deoxys|deoxys|deoxys|deoxys|deoxys|デオキシス|deoxys|테오키스|代欧奇希斯|代歐奇希斯
0387|turtwig|tortipouss|chelast|turtwig|turtwig|ナエトル|naetle|모부기|草苗龟|草苗龜
0388|grotle|boskara|chelcarain|grotle|grotle|ハヤシガメ|hayashigame|수풀부기|树林龟|樹林龜
0389|torterra|torterra|chelterrar|torterra|torterra|ドダイトス|dodaitose|토대부기|土台龟|土台龜
0390|chimchar|ouisticram|panflam|chimchar|chimchar|ヒコザル|hikozaru|불꽃숭이|小火焰猴|小火焰猴
0391|monferno|chimpenfeu|panpyro|monferno|monferno|モウカザル|moukazaru|파이숭이|猛火猴|猛火猴
0392|infernape|simiabraz|panferno|infernape|infernape|ゴウカザル|goukazaru|초염몽|烈焰猴|烈焰猴
0393|piplup|tiplouf|plinfa|piplup|piplup|ポッチャマ|pochama|팽도리|波加曼|波加曼
0394|prinplup|prinplouf|pliprin|prinplup|prinplup|ポッタイシ|pottaishi|팽태자|波皇子|波皇子
0395|empoleon|pingoléon|impoleon|empoleon|empoleon|エンペルト|emperte|엠페르트|帝王拿波|帝王拿波
0396|starly|étourmi|staralili|starly|starly|ムックル|mukkuru|찌르꼬|姆克儿|姆克兒
0397|staravia|étourvol|staravia|staravia|staravia|ムクバード|mukubird|찌르버드|姆克鸟|姆克鳥
0398|staraptor|étouraptor|staraptor|staraptor|staraptor|ムクホーク|mukuhawk|찌르호크|姆克鹰|姆克鷹
0399|bidoof|keunotor|bidiza|bidoof|bidoof|ビッパ|bippa|비버니|大牙狸|大牙狸
0400|bibarel|castorno|bidifas|bibarel|bibarel|ビーダル|beadaru|비버통|大尾狸|大尾狸
0401|kricketot|crikzik|zirpurze|kricketot|kricketot|コロボーシ|korobohshi|귀뚤뚜기|圆法师|圓法師
0402|kricketune|mélokrik|zirpeise|kricketune|kricketune|コロトック|korotock|귀뚤톡크|音箱蟀|音箱蟀
0403|shinx|lixy|sheinux|shinx|shinx|コリンク|kolink|꼬링크|小猫怪|小貓怪
0404|luxio|luxio|luxio|luxio|luxio|ルクシオ|luxio|럭시오|勒克猫|勒克貓
0405|luxray|luxray|luxtra|luxray|luxray|レントラー|rentorar|렌트라|伦琴猫|倫琴貓
0406|budew|rozbouton|knospi|budew|budew|スボミー|subomie|꼬몽울|含羞苞|含羞苞
0407|roserade|roserade|roserade|roserade|roserade|ロズレイド|roserade|로즈레이드|罗丝雷朵|羅絲雷朵
0408|cranidos|kranidos|koknodon|cranidos|cranidos|ズガイドス|zugaidos|두개도스|头盖龙|頭蓋龍
0409|rampardos|charkos|rameidon|rampardos|rampardos|ラムパルド|rampald|램펄드|战槌龙|戰槌龍
0410|shieldon|dinoclier|schilterus|shieldon|shieldon|タテトプス|tatetops|방패톱스|盾甲龙|盾甲龍
0411|bastiodon|bastiodon|bollterus|bastiodon|bastiodon|トリデプス|torideps|바리톱스|护城龙|護城龍
0412|burmy|cheniti|burmy|burmy|burmy|ミノムッチ|minomucchi|도롱충이|结草儿|結草兒
0413|wormadam|cheniselle|burmadame|wormadam|wormadam|ミノマダム|minomadam|도롱마담|结草贵妇|結草貴婦
0414|mothim|papilord|moterpel|mothim|mothim|ガーメイル|gamale|나메일|绅士蛾|紳士蛾
0415|combee|apitrini|wadribie|combee|combee|ミツハニー|mitsuhoney|세꿀버리|三蜜蜂|三蜜蜂
0416|vespiquen|apireine|honweisel|vespiquen|vespiquen|ビークイン|beequen|비퀸|蜂女王|蜂女王
0417|pachirisu|pachirisu|pachirisu|pachirisu|pachirisu|パチリス|pachirisu|파치리스|帕奇利兹|帕奇利茲
0418|buizel|mustébouée|bamelin|buizel|buizel|ブイゼル|buoysel|브이젤|泳圈鼬|泳圈鼬
0419|floatzel|mustéflott|bojelin|floatzel|floatzel|フローゼル|floazel|플로젤|浮潜鼬|浮潛鼬
0420|cherubi|ceribou|kikugi|cherubi|cherubi|チェリンボ|cherinbo|체리버|樱花宝|櫻花寶
0421|cherrim|ceriflor|kinoso|cherrim|cherrim|チェリム|cherrim|체리꼬|樱花儿|櫻花兒
0422|shellos|sancoki|schalellos|shellos|shellos|カラナクシ|karanakushi|깝질무|无壳海兔|無殼海兔
0423|gastrodon|tritosor|gastrodon|gastrodon|gastrodon|トリトドン|tritodon|트리토돈|海兔兽|海兔獸
0424|ambipom|capidextre|ambidiffel|ambipom|ambipom|エテボース|eteboth|겟핸보숭|双尾怪手|雙尾怪手
0425|drifloon|baudrive|driftlon|drifloon|drifloon|フワンテ|fuwante|흔들풍손|飘飘球|飄飄球
0426|drifblim|grodrive|drifzepeli|drifblim|drifblim|フワライド|fuwaride|둥실라이드|随风球|隨風球
0427|buneary|laporeille|haspiror|buneary|buneary|ミミロル|mimirol|이어롤|卷卷耳|捲捲耳
0428|lopunny|lockpin|schlapor|lopunny|lopunny|ミミロップ|mimilop|이어롭|长耳兔|長耳兔
0429|mismagius|magirêve|traunmagil|mismagius|mismagius|ムウマージ|mumargi|무우마직|梦妖魔|夢妖魔
0430|honchkrow|corboss|kramshef|honchkrow|honchkrow|ドンカラス|dongkarasu|돈크로우|乌鸦头头|烏鴉頭頭
0431|glameow|chaglam|charmian|glameow|glameow|ニャルマー|nyarmar|나옹마|魅力喵|魅力喵
0432|purugly|chaffreux|shnurgarst|purugly|purugly|ブニャット|bunyatto|몬냥이|东施喵|東施喵
0433|chingling|korillon|klingplim|chingling|chingling|リーシャン|lisyan|랑딸랑|铃铛响|鈴鐺響
0434|stunky|moufouette|skunkapuh|stunky|stunky|スカンプー|skunpuu|스컹뿡|臭鼬噗|臭鼬噗
0435|skuntank|moufflair|skuntank|skuntank|skuntank|スカタンク|skutank|스컹탱크|坦克臭鼬|坦克臭鼬
0436|bronzor|archéomire|bronzel|bronzor|bronzor|ドーミラー|dohmirror|동미러|铜镜怪|銅鏡怪
0437|bronzong|archéodong|bronzong|bronzong|bronzong|ドータクン|dohtakun|동탁군|青铜钟|青銅鐘
0438|bonsly|manzaï|mobai|bonsly|bonsly|ウソハチ|usohachi|꼬지지|盆才怪|盆才怪
0439|mime jr.|mime jr|pantimimi|mime jr.|mime jr.|マネネ|manene|흉내내|魔尼尼|魔尼尼
0440|happiny|ptiravi|wonneira|happiny|happiny|ピンプク|pinpuku|핑복|小福蛋|小福蛋
0441|chatot|pijako|plaudagei|chatot|chatot|ペラップ|perap|페라페|聒噪鸟|聒噪鳥
0442|spiritomb|spiritomb|kryppuk|spiritomb|spiritomb|ミカルゲ|mikaruge|화강돌|花岩怪|花岩怪
0443|gible|griknot|kaumalat|gible|gible|フカマル|fukamaru|딥상어동|圆陆鲨|圓陸鯊
0444|gabite|carmache|knarksel|gabite|gabite|ガバイト|gabite|한바이트|尖牙陆鲨|尖牙陸鯊
0445|garchomp|carchacrok|knakrack|garchomp|garchomp|ガブリアス|gaburias|한카리아스|烈咬陆鲨|烈咬陸鯊
0446|munchlax|goinfrex|mampfaxo|munchlax|munchlax|ゴンベ|gonbe|먹고자|小卡比兽|小卡比獸
0447|riolu|riolu|riolu|riolu|riolu|リオル|riolu|리오르|利欧路|利歐路
0448|lucario|lucario|lucario|lucario|lucario|ルカリオ|lucario|루카리오|路卡利欧|路卡利歐
0449|hippopotas|hippopotas|hippopotas|hippopotas|hippopotas|ヒポポタス|hippopotas|히포포타스|沙河马|沙河馬
0450|hippowdon|hippodocus|hippoterus|hippowdon|hippowdon|カバルドン|kabaldon|하마돈|河马兽|河馬獸
0451|skorupi|rapion|pionskora|skorupi|skorupi|スコルピ|scorupi|스콜피|钳尾蝎|鉗尾蠍
0452|drapion|drascore|piondragi|drapion|drapion|ドラピオン|dorapion|드래피온|龙王蝎|龍王蠍
0453|croagunk|cradopaud|glibunkel|croagunk|croagunk|グレッグル|gureggru|삐딱구리|不良蛙|不良蛙
0454|toxicroak|coatox|toxiquak|toxicroak|toxicroak|ドクロッグ|dokurog|독개굴|毒骷蛙|毒骷蛙
0455|carnivine|vortente|venuflibis|carnivine|carnivine|マスキッパ|muskippa|무스틈니|尖牙笼|尖牙籠
0456|finneon|écayon|finneon|finneon|finneon|ケイコウオ|keikouo|형광어|荧光鱼|螢光魚
0457|lumineon|luminéon|lumineon|lumineon|lumineon|ネオラント|neolant|네오라이트|霓虹鱼|霓虹魚
0458|mantyke|babimanta|mantirps|mantyke|mantyke|タマンタ|tamanta|타만타|小球飞鱼|小球飛魚
0459|snover|blizzi|shnebedeck|snover|snover|ユキカブリ|yukikaburi|눈쓰개|雪笠怪|雪笠怪
0460|abomasnow|blizzaroi|rexblisar|abomasnow|abomasnow|ユキノオー|yukinooh|눈설왕|暴雪王|暴雪王
0461|weavile|dimoret|snibunna|weavile|weavile|マニューラ|manyula|포푸니라|玛狃拉|瑪狃拉
0462|magnezone|magnézone|magnezone|magnezone|magnezone|ジバコイル|jibacoil|자포코일|自爆磁怪|自爆磁怪
0463|lickilicky|coudlangue|schlurplek|lickilicky|lickilicky|ベロベルト|berobelt|내룸벨트|大舌舔|大舌舔
0464|rhyperior|rhinastoc|rihornior|rhyperior|rhyperior|ドサイドン|dosidon|거대코뿌리|超甲狂犀|超甲狂犀
0465|tangrowth|bouldeneu|tangoloss|tangrowth|tangrowth|モジャンボ|mojumbo|덩쿠림보|巨蔓藤|巨蔓藤
0466|electivire|élekable|elevoltek|electivire|electivire|エレキブル|elekible|에레키블|电击魔兽|電擊魔獸
0467|magmortar|maganon|magbrant|magmortar|magmortar|ブーバーン|booburn|마그마번|鸭嘴炎兽|鴨嘴炎獸
0468|togekiss|togekiss|togekiss|togekiss|togekiss|トゲキッス|togekiss|토게키스|波克基斯|波克基斯
0469|yanmega|yanméga|yanmega|yanmega|yanmega|メガヤンマ|megayanma|메가자리|远古巨蜓|遠古巨蜓
0470|leafeon|phyllali|folipurba|leafeon|leafeon|リーフィア|leafia|리피아|叶伊布|葉伊布
0471|glaceon|givrali|glaziola|glaceon|glaceon|グレイシア|glacia|글레이시아|冰伊布|冰伊布
0472|gliscor|scorvol|skorgro|gliscor|gliscor|グライオン|glion|글라이온|天蝎王|天蠍王
0473|mamoswine|mammochon|mamutel|mamoswine|mamoswine|マンムー|mammoo|맘모꾸리|象牙猪|象牙豬
0474|porygon-z|porygon-z|porygon-z|porygon-z|porygon-z|ポリゴンＺ|porygon-z|폴리곤Z|多边兽乙型|多邊獸Ｚ
0475|gallade|gallame|galagladi|gallade|gallade|エルレイド|erureido|엘레이드|艾路雷朵|艾路雷朵
0476|probopass|tarinorme|voluminas|probopass|probopass|ダイノーズ|dainose|대코파스|大朝北鼻|大朝北鼻
0477|dusknoir|noctunoir|zwirrfinst|dusknoir|dusknoir|ヨノワール|yonoir|야느와르몽|黑夜魔灵|黑夜魔靈
0478|froslass|momartik|frosdedje|froslass|froslass|ユキメノコ|yukimenoko|눈여아|雪妖女|雪妖女
0479|rotom|motisma|rotom|rotom|rotom|ロトム|rotom|로토무|洛托姆|洛托姆
0480|uxie|créhelf|selfe|uxie|uxie|ユクシー|yuxie|유크시|由克希|由克希
0481|mesprit|créfollet|vesprit|mesprit|mesprit|エムリット|emrit|엠라이트|艾姆利多|艾姆利多
0482|azelf|créfadet|tobutz|azelf|azelf|アグノム|agnome|아그놈|亚克诺姆|亞克諾姆
0483|dialga|dialga|dialga|dialga|dialga|ディアルガ|dialga|디아루가|帝牙卢卡|帝牙盧卡
0484|palkia|palkia|palkia|palkia|palkia|パルキア|palkia|펄기아|帕路奇亚|帕路奇亞
0485|heatran|heatran|heatran|heatran|heatran|ヒードラン|heatran|히드런|席多蓝恩|席多藍恩
0486|regigigas|regigigas|regigigas|regigigas|regigigas|レジギガス|regigigas|레지기가스|雷吉奇卡斯|雷吉奇卡斯
0487|giratina|giratina|giratina|giratina|giratina|ギラティナ|giratina|기라티나|骑拉帝纳|騎拉帝納
0488|cresselia|cresselia|cresselia|cresselia|cresselia|クレセリア|cresselia|크레세리아|克雷色利亚|克雷色利亞
0489|phione|phione|phione|phione|phione|フィオネ|phione|피오네|霏欧纳|霏歐納
0490|manaphy|manaphy|manaphy|manaphy|manaphy|マナフィ|manaphy|마나피|玛纳霏|瑪納霏
0491|darkrai|darkrai|darkrai|darkrai|darkrai|ダークライ|darkrai|다크라이|达克莱伊|達克萊伊
0492|shaymin|shaymin|shaymin|shaymin|shaymin|シェイミ|shaymin|쉐이미|谢米|謝米
0493|arceus|arceus|arceus|arceus|arceus|アルセウス|arceus|아르세우스|阿尔宙斯|阿爾宙斯
0494|victini|victini|victini|victini|victini|ビクティニ|victini|비크티니|比克提尼|比克提尼
0495|snivy|vipélierre|serpifeu|snivy|snivy|ツタージャ|tsutarja|주리비얀|藤藤蛇|藤藤蛇
0496|servine|lianaja|efoserp|servine|servine|ジャノビー|janovy|샤비|青藤蛇|青藤蛇
0497|serperior|majaspic|serpiroyal|serperior|serperior|ジャローダ|jalorda|샤로다|君主蛇|君主蛇
0498|tepig|gruikui|floink|tepig|tepig|ポカブ|pokabu|뚜꾸리|暖暖猪|暖暖豬
0499|pignite|grotichon|ferkokel|pignite|pignite|チャオブー|chaoboo|차오꿀|炒炒猪|炒炒豬
0500|emboar|roitiflam|flambirex|emboar|emboar|エンブオー|enbuoh|염무왕|炎武王|炎武王
0501|oshawott|moustillon|ottaro|oshawott|oshawott|ミジュマル|mijumaru|수댕이|水水獭|水水獺
0502|dewott|mateloutre|zwottronin|dewott|dewott|フタチマル|futachimaru|쌍검자비|双刃丸|雙刃丸
0503|samurott|clamiral|admurai|samurott|samurott|ダイケンキ|daikenki|대검귀|大剑鬼|大劍鬼
0504|patrat|ratentif|nagelotz|patrat|patrat|ミネズミ|minezumi|보르쥐|探探鼠|探探鼠
0505|watchog|miradar|kukmarda|watchog|watchog|ミルホッグ|miruhog|보르그|步哨鼠|步哨鼠
0506|lillipup|ponchiot|yorkleff|lillipup|lillipup|ヨーテリー|yorterrie|요테리|小约克|小約克
0507|herdier|ponchien|terribark|herdier|herdier|ハーデリア|herderrie|하데리어|哈约克|哈約克
0508|stoutland|mastouffe|bissbark|stoutland|stoutland|ムーランド|mooland|바랜드|长毛狗|長毛狗
0509|purrloin|chacripan|felilou|purrloin|purrloin|チョロネコ|choroneko|쌔비냥|扒手猫|扒手貓
0510|liepard|léopardus|kleoparda|liepard|liepard|レパルダス|lepardas|레파르다스|酷豹|酷豹
0511|pansage|feuillajou|vegimak|pansage|pansage|ヤナップ|yanappu|야나프|花椰猴|花椰猴
0512|simisage|feuiloutan|vegichita|simisage|simisage|ヤナッキー|yanakkie|야나키|花椰猿|花椰猿
0513|pansear|flamajou|grillmak|pansear|pansear|バオップ|baoppu|바오프|爆香猴|爆香猴
0514|simisear|flamoutan|grillchita|simisear|simisear|バオッキー|baokkie|바오키|爆香猿|爆香猿
0515|panpour|flotajou|sodamak|panpour|panpour|ヒヤップ|hiyappu|앗차프|冷水猴|冷水猴
0516|simipour|flotoutan|sodachita|simipour|simipour|ヒヤッキー|hiyakkie|앗차키|冷水猿|冷水猿
0517|munna|munna|somniam|munna|munna|ムンナ|munna|몽나|食梦梦|食夢夢
0518|musharna|mushana|somnivora|musharna|musharna|ムシャーナ|musharna|몽얌나|梦梦蚀|夢夢蝕
0519|pidove|poichigeon|dusselgurr|pidove|pidove|マメパト|mamepato|콩둘기|豆豆鸽|豆豆鴿
0520|tranquill|colombeau|navitaub|tranquill|tranquill|ハトーボー|hatoboh|유토브|咕咕鸽|咕咕鴿
0521|unfezant|déflaisan|fasasnob|unfezant|unfezant|ケンホロウ|kenhallow|켄호로우|高傲雉鸡|高傲雉雞
0522|blitzle|zébribon|elezeba|blitzle|blitzle|シママ|shimama|줄뮤마|斑斑马|斑斑馬
0523|zebstrika|zéblitz|zebritz|zebstrika|zebstrika|ゼブライカ|zebraika|제브라이카|雷电斑马|雷電斑馬
0524|roggenrola|nodulithe|kiesling|roggenrola|roggenrola|ダンゴロ|dangoro|단굴|石丸子|石丸子
0525|boldore|géolithe|sedimantur|boldore|boldore|ガントル|gantle|암트르|地幔岩|地幔岩
0526|gigalith|gigalithe|brockoloss|gigalith|gigalith|ギガイアス|gigaiath|기가이어스|庞岩怪|龐岩怪
0527|woobat|chovsourir|fleknoil|woobat|woobat|コロモリ|koromori|또르박쥐|滚滚蝙蝠|滾滾蝙蝠
0528|swoobat|rhinolove|fletiamo|swoobat|swoobat|ココロモリ|kokoromori|맘박쥐|心蝙蝠|心蝙蝠
0529|drilbur|rototaupe|rotomurf|drilbur|drilbur|モグリュー|mogurew|두더류|螺钉地鼠|螺釘地鼠
0530|excadrill|minotaupe|stalobor|excadrill|excadrill|ドリュウズ|doryuzu|몰드류|龙头地鼠|龍頭地鼠
0531|audino|nanméouïe|ohrdoch|audino|audino|タブンネ|tabunne|다부니|差不多娃娃|差不多娃娃
0532|timburr|charpenti|praktibalk|timburr|timburr|ドッコラー|dokkorer|으랏차|搬运小匠|搬運小匠
0533|gurdurr|ouvrifier|strepoli|gurdurr|gurdurr|ドテッコツ|dotekkotsu|토쇠골|铁骨土人|鐵骨土人
0534|conkeldurr|bétochef|meistagrif|conkeldurr|conkeldurr|ローブシン|roubushin|노보청|修建老匠|修建老匠
0535|tympole|tritonde|schallquap|tympole|tympole|オタマロ|otamaro|동챙이|圆蝌蚪|圓蝌蚪
0536|palpitoad|batracné|mebrana|palpitoad|palpitoad|ガマガル|gamagaru|두까비|蓝蟾蜍|藍蟾蜍
0537|seismitoad|crapustule|branawarz|seismitoad|seismitoad|ガマゲロゲ|gamageroge|두빅굴|蟾蜍王|蟾蜍王
0538|throh|judokrak|jiutesto|throh|throh|ナゲキ|nageki|던지미|投摔鬼|投摔鬼
0539|sawk|karaclée|karadonis|sawk|sawk|ダゲキ|dageki|타격귀|打击鬼|打擊鬼
0540|sewaddle|larveyette|strawickl|sewaddle|sewaddle|クルミル|kurumiru|두르보|虫宝包|蟲寶包
0541|swadloon|couverdure|folikon|swadloon|swadloon|クルマユ|kurumayu|두르쿤|宝包茧|寶包繭
0542|leavanny|manternel|matrifol|leavanny|leavanny|ハハコモリ|hahakomori|모아머|保姆虫|保母蟲
0543|venipede|venipatte|toxiped|venipede|venipede|フシデ|fushide|마디네|百足蜈蚣|百足蜈蚣
0544|whirlipede|scobolide|rollum|whirlipede|whirlipede|ホイーガ|wheega|휠구|车轮球|車輪毬
0545|scolipede|brutapode|cerapendra|scolipede|scolipede|ペンドラー|pendror|펜드라|蜈蚣王|蜈蚣王
0546|cottonee|doudouvet|waumboll|cottonee|cottonee|モンメン|monmen|소미안|木棉球|木棉球
0547|whimsicott|farfaduvet|elfun|whimsicott|whimsicott|エルフーン|elfuun|엘풍|风妖精|風妖精
0548|petilil|chlorobule|lilminip|petilil|petilil|チュリネ|churine|치릴리|百合根娃娃|百合根娃娃
0549|lilligant|fragilady|dressella|lilligant|lilligant|ドレディア|dredear|드레디어|裙儿小姐|裙兒小姐
0550|basculin|bargantua|barschuft|basculin|basculin|バスラオ|bassrao|배쓰나이|野蛮鲈鱼|野蠻鱸魚
0551|sandile|mascaïman|ganovil|sandile|sandile|メグロコ|meguroco|깜눈크|黑眼鳄|黑眼鱷
0552|krokorok|escroco|rokkaiman|krokorok|krokorok|ワルビル|waruvile|악비르|混混鳄|混混鱷
0553|krookodile|crocorible|rabigator|krookodile|krookodile|ワルビアル|waruvial|악비아르|流氓鳄|流氓鱷
0554|darumaka|darumarond|flampion|darumaka|darumaka|ダルマッカ|darumakka|달막화|火红不倒翁|火紅不倒翁
0555|darmanitan|darumacho|flampivian|darmanitan|darmanitan|ヒヒダルマ|hihidaruma|불비달마|达摩狒狒|達摩狒狒
0556|maractus|maracachi|maracamba|maractus|maractus|マラカッチ|maracacchi|마라카치|沙铃仙人掌|沙鈴仙人掌
0557|dwebble|crabicoque|lithomith|dwebble|dwebble|イシズマイ|ishizumai|돌살이|石居蟹|石居蟹
0558|crustle|crabaraque|castellith|crustle|crustle|イワパレス|iwapalace|암팰리스|岩殿居蟹|岩殿居蟹
0559|scraggy|baggiguane|zurrokex|scraggy|scraggy|ズルッグ|zuruggu|곤율랭|滑滑小子|滑滑小子
0560|scrafty|baggaïd|irokex|scrafty|scrafty|ズルズキン|zuruzukin|곤율거니|头巾混混|頭巾混混
0561|sigilyph|cryptéro|symvolara|sigilyph|sigilyph|シンボラー|symboler|심보러|象征鸟|象徵鳥
0562|yamask|tutafeh|makabaja|yamask|yamask|デスマス|desumasu|데스마스|哭哭面具|哭哭面具
0563|cofagrigus|tutankafer|echnatoll|cofagrigus|cofagrigus|デスカーン|desukarn|데스니칸|迭失棺|死神棺
0564|tirtouga|carapagos|galapaflos|tirtouga|tirtouga|プロトーガ|protoga|프로토가|原盖海龟|原蓋海龜
0565|carracosta|mégapagos|karippas|carracosta|carracosta|アバゴーラ|abagoura|늑골라|肋骨海龟|肋骨海龜
0566|archen|arkéapti|flapteryx|archen|archen|アーケン|archen|아켄|始祖小鸟|始祖小鳥
0567|archeops|aéroptéryx|aeropteryx|archeops|archeops|アーケオス|archeos|아케오스|始祖大鸟|始祖大鳥
0568|trubbish|miamiasme|unratütox|trubbish|trubbish|ヤブクロン|yabukuron|깨봉이|破破袋|破破袋
0569|garbodor|miasmax|deponitox|garbodor|garbodor|ダストダス|dustdas|더스트나|灰尘山|灰塵山
0570|zorua|zorua|zorua|zorua|zorua|ゾロア|zorua|조로아|索罗亚|索羅亞
0571|zoroark|zoroark|zoroark|zoroark|zoroark|ゾロアーク|zoroark|조로아크|索罗亚克|索羅亞克
0572|minccino|chinchidou|picochilla|minccino|minccino|チラーミィ|chillarmy|치라미|泡沫栗鼠|泡沫栗鼠
0573|cinccino|pashmilla|chillabell|cinccino|cinccino|チラチーノ|chillaccino|치라치노|奇诺栗鼠|奇諾栗鼠
0574|gothita|scrutella|mollimorba|gothita|gothita|ゴチム|gothimu|고디탱|哥德宝宝|哥德寶寶
0575|gothorita|mesmérella|hypnomorba|gothorita|gothorita|ゴチミル|gothimiru|고디보미|哥德小童|哥德小童
0576|gothitelle|sidérella|morbitesse|gothitelle|gothitelle|ゴチルゼル|gothiruselle|고디모아젤|哥德小姐|哥德小姐
0577|solosis|nucléos|monozyto|solosis|solosis|ユニラン|uniran|유니란|单卵细胞球|單卵細胞球
0578|duosion|méios|mitodos|duosion|duosion|ダブラン|doublan|듀란|双卵细胞球|雙卵細胞球
0579|reuniclus|symbios|zytomega|reuniclus|reuniclus|ランクルス|lanculus|란쿨루스|人造细胞卵|人造細胞卵
0580|ducklett|couaneton|piccolente|ducklett|ducklett|コアルヒー|koaruhie|꼬지보리|鸭宝宝|鴨寶寶
0581|swanna|lakmécygne|swaroness|swanna|swanna|スワンナ|swanna|스완나|舞天鹅|舞天鵝
0582|vanillite|sorbébé|gelatini|vanillite|vanillite|バニプッチ|vanipeti|바닐프티|迷你冰|迷你冰
0583|vanillish|sorboul|gelatroppo|vanillish|vanillish|バニリッチ|vanirich|바닐리치|多多冰|多多冰
0584|vanilluxe|sorbouboul|gelatwino|vanilluxe|vanilluxe|バイバニラ|baivanilla|배바닐라|双倍多多冰|雙倍多多冰
0585|deerling|vivaldaim|sesokitz|deerling|deerling|シキジカ|shikijika|사철록|四季鹿|四季鹿
0586|sawsbuck|haydaim|kronjuwild|sawsbuck|sawsbuck|メブキジカ|mebukijika|바라철록|萌芽鹿|萌芽鹿
0587|emolga|emolga|emolga|emolga|emolga|エモンガ|emonga|에몽가|电飞鼠|電飛鼠
0588|karrablast|carabing|laukaps|karrablast|karrablast|カブルモ|kaburumo|딱정곤|盖盖虫|蓋蓋蟲
0589|escavalier|lançargot|cavalanzas|escavalier|escavalier|シュバルゴ|chevargo|슈바르고|骑士蜗牛|騎士蝸牛
0590|foongus|trompignon|tarnpignon|foongus|foongus|タマゲタケ|tamagetake|깜놀버슬|哎呀球菇|哎呀球菇
0591|amoonguss|gaulet|hutsassa|amoonguss|amoonguss|モロバレル|morobareru|뽀록나|败露球菇|敗露球菇
0592|frillish|viskuse|quabbel|frillish|frillish|プルリル|pururill|탱그릴|轻飘飘|輕飄飄
0593|jellicent|moyade|apoquallyp|jellicent|jellicent|ブルンゲル|burungel|탱탱겔|胖嘟嘟|胖嘟嘟
0594|alomomola|mamanbo|mamolida|alomomola|alomomola|ママンボウ|mamanbou|맘복치|保姆曼波|保母曼波
0595|joltik|statitik|wattzapf|joltik|joltik|バチュル|bachuru|파쪼옥|电电虫|電電蟲
0596|galvantula|mygavolt|voltula|galvantula|galvantula|デンチュラ|dentula|전툴라|电蜘蛛|電蜘蛛
0597|ferroseed|grindur|kastadur|ferroseed|ferroseed|テッシード|tesseed|철시드|种子铁球|種子鐵球
0598|ferrothorn|noacier|tentantel|ferrothorn|ferrothorn|ナットレイ|nutrey|너트령|坚果哑铃|堅果啞鈴
0599|klink|tic|klikk|klink|klink|ギアル|giaru|기어르|齿轮儿|齒輪兒
0600|klang|clic|kliklak|klang|klang|ギギアル|gigiaru|기기어르|齿轮组|齒輪組
0601|klinklang|cliticlic|klikdiklak|klinklang|klinklang|ギギギアル|gigigiaru|기기기어르|齿轮怪|齒輪怪
0602|tynamo|anchwatt|zapplardin|tynamo|tynamo|シビシラス|shibishirasu|저리어|麻麻小鱼|麻麻小魚
0603|eelektrik|lampéroie|zapplalek|eelektrik|eelektrik|シビビール|shibibeel|저리릴|麻麻鳗|麻麻鰻
0604|eelektross|ohmassacre|zapplarang|eelektross|eelektross|シビルドン|shibirudon|저리더프|麻麻鳗鱼王|麻麻鰻魚王
0605|elgyem|lewsor|pygraulon|elgyem|elgyem|リグレー|ligray|리그레|小灰怪|小灰怪
0606|beheeyem|neitram|megalon|beheeyem|beheeyem|オーベム|ohbem|벰크|大宇怪|大宇怪
0607|litwick|funécire|lichtel|litwick|litwick|ヒトモシ|hitomoshi|불켜미|烛光灵|燭光靈
0608|lampent|mélancolux|laternecto|lampent|lampent|ランプラー|lampler|램프라|灯火幽灵|燈火幽靈
0609|chandelure|lugulabre|skelabra|chandelure|chandelure|シャンデラ|chandela|샹델라|水晶灯火灵|水晶燈火靈
0610|axew|coupenotte|milza|axew|axew|キバゴ|kibago|터검니|牙牙|牙牙
0611|fraxure|incisache|sharfax|fraxure|fraxure|オノンド|onondo|액슨도|斧牙龙|斧牙龍
0612|haxorus|tranchodon|maxax|haxorus|haxorus|オノノクス|ononokus|액스라이즈|双斧战龙|雙斧戰龍
0613|cubchoo|polarhume|petznief|cubchoo|cubchoo|クマシュン|kumasyun|코고미|喷嚏熊|噴嚏熊
0614|beartic|polagriffe|siberio|beartic|beartic|ツンベアー|tunbear|툰베어|冻原熊|凍原熊
0615|cryogonal|hexagel|frigometri|cryogonal|cryogonal|フリージオ|freegeo|프리지오|几何雪花|幾何雪花
0616|shelmet|escargaume|schnuthelm|shelmet|shelmet|チョボマキ|chobomaki|쪼마리|小嘴蜗|小嘴蝸
0617|accelgor|limaspeed|hydragil|accelgor|accelgor|アギルダー|agilder|어지리더|敏捷虫|敏捷蟲
0618|stunfisk|limonde|flunschlik|stunfisk|stunfisk|マッギョ|maggyo|메더|泥巴鱼|泥巴魚
0619|mienfoo|kungfouine|lin-fu|mienfoo|mienfoo|コジョフー|kojofu|비조푸|功夫鼬|功夫鼬
0620|mienshao|shaofouine|wie-shu|mienshao|mienshao|コジョンド|kojondo|비조도|师父鼬|師父鼬
0621|druddigon|drakkarmin|shardrago|druddigon|druddigon|クリムガン|crimgan|크리만|赤面龙|赤面龍
0622|golett|gringolem|golbit|golett|golett|ゴビット|gobit|골비람|泥偶小人|泥偶小人
0623|golurk|golemastoc|golgantes|golurk|golurk|ゴルーグ|goloog|골루그|泥偶巨人|泥偶巨人
0624|pawniard|scalpion|gladiantri|pawniard|pawniard|コマタナ|komatana|자망칼|驹刀小兵|駒刀小兵
0625|bisharp|scalproie|caesurio|bisharp|bisharp|キリキザン|kirikizan|절각참|劈斩司令|劈斬司令
0626|bouffalant|frison|bisofank|bouffalant|bouffalant|バッフロン|buffron|버프론|爆炸头水牛|爆炸頭水牛
0627|rufflet|furaiglon|geronimatz|rufflet|rufflet|ワシボン|washibon|수리둥보|毛头小鹰|毛頭小鷹
0628|braviary|gueriaigle|washakwil|braviary|braviary|ウォーグル|warrgle|워글|勇士雄鹰|勇士雄鷹
0629|vullaby|vostourno|skallyk|vullaby|vullaby|バルチャイ|valchai|벌차이|秃鹰丫头|禿鷹丫頭
0630|mandibuzz|vaututrice|grypheldis|mandibuzz|mandibuzz|バルジーナ|vulgina|버랜지나|秃鹰娜|禿鷹娜
0631|heatmor|aflamanoir|furnifraß|heatmor|heatmor|クイタラン|kuitaran|앤티골|熔蚁兽|熔蟻獸
0632|durant|fermite|fermicula|durant|durant|アイアント|aiant|아이앤트|铁蚁|鐵蟻
0633|deino|solochi|kapuno|deino|deino|モノズ|monozu|모노두|单首龙|單首龍
0634|zweilous|diamat|duodino|zweilous|zweilous|ジヘッド|dihead|디헤드|双首暴龙|雙首暴龍
0635|hydreigon|trioxhydre|trikephalo|hydreigon|hydreigon|サザンドラ|sazandora|삼삼드래|三首恶龙|三首惡龍
0636|larvesta|pyronille|ignivor|larvesta|larvesta|メラルバ|merlarva|활화르바|燃烧虫|燃燒蟲
0637|volcarona|pyrax|ramoth|volcarona|volcarona|ウルガモス|ulgamoth|불카모스|火神蛾|火神蛾
0638|cobalion|cobaltium|kobalium|cobalion|cobalion|コバルオン|cobalon|코바르온|勾帕路翁|勾帕路翁
0639|terrakion|terrakium|terrakium|terrakion|terrakion|テラキオン|terrakion|테라키온|代拉基翁|代拉基翁
0640|virizion|viridium|viridium|virizion|virizion|ビリジオン|virizion|비리디온|毕力吉翁|畢力吉翁
0641|tornadus|boréas|boreos|tornadus|tornadus|トルネロス|tornelos|토네로스|龙卷云|龍捲雲
0642|thundurus|fulguris|voltolos|thundurus|thundurus|ボルトロス|voltolos|볼트로스|雷电云|雷電雲
0643|reshiram|reshiram|reshiram|reshiram|reshiram|レシラム|reshiram|레시라무|莱希拉姆|萊希拉姆
0644|zekrom|zekrom|zekrom|zekrom|zekrom|ゼクロム|zekrom|제크로무|捷克罗姆|捷克羅姆
0645|landorus|démétéros|demeteros|landorus|landorus|ランドロス|landlos|랜드로스|土地云|土地雲
0646|kyurem|kyurem|kyurem|kyurem|kyurem|キュレム|kyurem|큐레무|酋雷姆|酋雷姆
0647|keldeo|keldeo|keldeo|keldeo|keldeo|ケルディオ|keldeo|케르디오|凯路迪欧|凱路迪歐
0648|meloetta|meloetta|meloetta|meloetta|meloetta|メロエッタ|meloetta|메로엣타|美洛耶塔|美洛耶塔
0649|genesect|genesect|genesect|genesect|genesect|ゲノセクト|genesect|게노세크트|盖诺赛克特|蓋諾賽克特
0650|chespin|marisson|igamaro|chespin|chespin|ハリマロン|harimaron|도치마론|哈力栗|哈力栗
0651|quilladin|boguérisse|igastarnish|quilladin|quilladin|ハリボーグ|hariborg|도치보구|胖胖哈力|胖胖哈力
0652|chesnaught|blindépique|brigaron|chesnaught|chesnaught|ブリガロン|brigarron|브리가론|布里卡隆|布里卡隆
0653|fennekin|feunnec|fynx|fennekin|fennekin|フォッコ|fokko|푸호꼬|火狐狸|火狐狸
0654|braixen|roussil|rutena|braixen|braixen|テールナー|tairenar|테르나|长尾火狐|長尾火狐
0655|delphox|goupelin|fennexis|delphox|delphox|マフォクシー|mahoxy|마폭시|妖火红狐|妖火紅狐
0656|froakie|grenousse|froxy|froakie|froakie|ケロマツ|keromatsu|개구마르|呱呱泡蛙|呱呱泡蛙
0657|frogadier|croâporal|amphizel|frogadier|frogadier|ゲコガシラ|gekogashira|개굴반장|呱头蛙|呱頭蛙
0658|greninja|amphinobi|quajutsu|greninja|greninja|ゲッコウガ|gekkouga|개굴닌자|甲贺忍蛙|甲賀忍蛙
0659|bunnelby|sapereau|scoppel|bunnelby|bunnelby|ホルビー|horubee|파르빗|掘掘兔|掘掘兔
0660|diggersby|excavarenne|grebbit|diggersby|diggersby|ホルード|horudo|파르토|掘地兔|掘地兔
0661|fletchling|passerouge|dartiri|fletchling|fletchling|ヤヤコマ|yayakoma|화살꼬빈|小箭雀|小箭雀
0662|fletchinder|braisillon|dartignis|fletchinder|fletchinder|ヒノヤコマ|hinoyakoma|불화살빈|火箭雀|火箭雀
0663|talonflame|flambusard|fiaro|talonflame|talonflame|ファイアロー|fiarrow|파이어로|烈箭鹰|烈箭鷹
0664|scatterbug|lépidonille|purmel|scatterbug|scatterbug|コフキムシ|kofukimushi|분이벌레|粉蝶虫|粉蝶蟲
0665|spewpa|pérégrain|puponcho|spewpa|spewpa|コフーライ|kofuurai|분떠도리|粉蝶蛹|粉蝶蛹
0666|vivillon|prismillon|vivillon|vivillon|vivillon|ビビヨン|viviyon|비비용|彩粉蝶|彩粉蝶
0667|litleo|hélionceau|leufeo|litleo|litleo|シシコ|shishiko|레오꼬|小狮狮|小獅獅
0668|pyroar|némélios|pyroleo|pyroar|pyroar|カエンジシ|kaenjishi|화염레오|火炎狮|火炎獅
0669|flabébé|flabébé|flabébé|flabébé|flabébé|フラベベ|flabebe|플라베베|花蓓蓓|花蓓蓓
0670|floette|floette|floette|floette|floette|フラエッテ|floette|플라엣테|花叶蒂|花葉蒂
0671|florges|florges|florges|florges|florges|フラージェス|florges|플라제스|花洁夫人|花潔夫人
0672|skiddo|cabriolaine|mähikel|skiddo|skiddo|メェークル|meecle|메이클|坐骑小羊|坐騎小羊
0673|gogoat|chevroum|chevrumm|gogoat|gogoat|ゴーゴート|gogoat|고고트|坐骑山羊|坐騎山羊
0674|pancham|pandespiègle|pam-pam|pancham|pancham|ヤンチャム|yancham|판짱|顽皮熊猫|頑皮熊貓
0675|pangoro|pandarbare|pandagro|pangoro|pangoro|ゴロンダ|goronda|부란다|霸道熊猫|流氓熊貓
0676|furfrou|couafarel|coiffwaff|furfrou|furfrou|トリミアン|trimmien|트리미앙|多丽米亚|多麗米亞
0677|espurr|psystigri|psiau|espurr|espurr|ニャスパー|nyasper|냐스퍼|妙喵|妙喵
0678|meowstic|mistigrix|psiaugon|meowstic|meowstic|ニャオニクス|nyaonix|냐오닉스|超能妙喵|超能妙喵
0679|honedge|monorpale|gramokles|honedge|honedge|ヒトツキ|hitotsuki|단칼빙|独剑鞘|獨劍鞘
0680|doublade|dimoclès|duokles|doublade|doublade|ニダンギル|nidangill|쌍검킬|双剑鞘|雙劍鞘
0681|aegislash|exagide|durengard|aegislash|aegislash|ギルガルド|gillgard|킬가르도|坚盾剑怪|堅盾劍怪
0682|spritzee|fluvetin|parfi|spritzee|spritzee|シュシュプ|shushupu|슈쁘|粉香香|粉香香
0683|aromatisse|cocotine|parfinesse|aromatisse|aromatisse|フレフワン|frefuwan|프레프티르|芳香精|芳香精
0684|swirlix|sucroquin|flauschling|swirlix|swirlix|ペロッパフ|peroppafu|나룸퍼프|绵绵泡芙|綿綿泡芙
0685|slurpuff|cupcanaille|sabbaione|slurpuff|slurpuff|ペロリーム|peroream|나루림|胖甜妮|胖甜妮
0686|inkay|sepiatop|iscalar|inkay|inkay|マーイーカ|maaiika|오케이징|好啦鱿|好啦魷
0687|malamar|sepiatroce|calamanero|malamar|malamar|カラマネロ|calamanero|칼라마네로|乌贼王|烏賊王
0688|binacle|opermine|bithora|binacle|binacle|カメテテ|kametete|거북손손|龟脚脚|龜腳腳
0689|barbaracle|golgopathe|thanathora|barbaracle|barbaracle|ガメノデス|gamenodes|거북손데스|龟足巨铠|龜足巨鎧
0690|skrelp|venalgue|algitt|skrelp|skrelp|クズモー|kuzumo|수레기|垃垃藻|垃垃藻
0691|dragalge|kravarech|tandrak|dragalge|dragalge|ドラミドロ|dramidoro|드래캄|毒藻龙|毒藻龍
0692|clauncher|flingouste|scampisto|clauncher|clauncher|ウデッポウ|udeppou|완철포|铁臂枪虾|鐵臂槍蝦
0693|clawitzer|gamblast|wummer|clawitzer|clawitzer|ブロスター|bloster|블로스터|钢炮臂虾|鋼炮臂蝦
0694|helioptile|galvaran|eguana|helioptile|helioptile|エリキテル|erikiteru|목도리키텔|伞电蜥|傘電蜥
0695|heliolisk|iguolta|elezard|heliolisk|heliolisk|エレザード|elezard|일레도리자드|光电伞蜥|光電傘蜥
0696|tyrunt|ptyranidur|balgoras|tyrunt|tyrunt|チゴラス|chigoras|티고라스|宝宝暴龙|寶寶暴龍
0697|tyrantrum|rexillius|monargoras|tyrantrum|tyrantrum|ガチゴラス|gachigoras|견고라스|怪颚龙|怪顎龍
0698|amaura|amagara|amarino|amaura|amaura|アマルス|amarus|아마루스|冰雪龙|冰雪龍
0699|aurorus|dragmara|amagarga|aurorus|aurorus|アマルルガ|amaruruga|아마루르가|冰雪巨龙|冰雪巨龍
0700|sylveon|nymphali|feelinara|sylveon|sylveon|ニンフィア|nymphia|님피아|仙子伊布|仙子伊布
0701|hawlucha|brutalibré|resladero|hawlucha|hawlucha|ルチャブル|luchabull|루차불|摔角鹰人|摔角鷹人
0702|dedenne|dedenne|dedenne|dedenne|dedenne|デデンネ|dedenne|데덴네|咚咚鼠|咚咚鼠
0703|carbink|strassie|rocara|carbink|carbink|メレシー|melecie|멜리시|小碎钻|小碎鑽
0704|goomy|mucuscule|viscora|goomy|goomy|ヌメラ|numera|미끄메라|黏黏宝|黏黏寶
0705|sliggoo|colimucus|viscargot|sliggoo|sliggoo|ヌメイル|numeil|미끄네일|黏美儿|黏美兒
0706|goodra|muplodocus|viscogon|goodra|goodra|ヌメルゴン|numelgon|미끄래곤|黏美龙|黏美龍
0707|klefki|trousselin|clavion|klefki|klefki|クレッフィ|cleffy|클레피|钥圈儿|鑰圈兒
0708|phantump|brocélôme|paragoni|phantump|phantump|ボクレー|bokurei|나목령|小木灵|小木靈
0709|trevenant|desséliande|trombork|trevenant|trevenant|オーロット|ohrot|대로트|朽木妖|朽木妖
0710|pumpkaboo|pitrouille|irrbis|pumpkaboo|pumpkaboo|バケッチャ|bakeccha|호바귀|南瓜精|南瓜精
0711|gourgeist|banshitrouye|pumpdjinn|gourgeist|gourgeist|パンプジン|pumpjin|펌킨인|南瓜怪人|南瓜怪人
0712|bergmite|grelaçon|arktip|bergmite|bergmite|カチコール|kachikohru|꽁어름|冰宝|冰寶
0713|avalugg|séracrawl|arktilas|avalugg|avalugg|クレベース|crebase|크레베이스|冰岩怪|冰岩怪
0714|noibat|sonistrelle|ef-em|noibat|noibat|オンバット|onbat|음뱃|嗡蝠|嗡蝠
0715|noivern|bruyverne|uhafnir|noivern|noivern|オンバーン|onvern|음번|音波龙|音波龍
0716|xerneas|xerneas|xerneas|xerneas|xerneas|ゼルネアス|xerneas|제르네아스|哲尔尼亚斯|哲爾尼亞斯
0717|yveltal|yveltal|yveltal|yveltal|yveltal|イベルタル|yveltal|이벨타르|伊裴尔塔尔|伊裴爾塔爾
0718|zygarde|zygarde|zygarde|zygarde|zygarde|ジガルデ|zygarde|지가르데|基格尔德|基格爾德
0719|diancie|diancie|diancie|diancie|diancie|ディアンシー|diancie|디안시|蒂安希|蒂安希
0720|hoopa|hoopa|hoopa|hoopa|hoopa|フーパ|hoopa|후파|胡帕|胡帕
0721|volcanion|volcanion|volcanion|volcanion|volcanion|ボルケニオン|volcanion|볼케니온|波尔凯尼恩|波爾凱尼恩
0722|rowlet|brindibou|bauz|rowlet|rowlet|モクロー|mokuroh|나몰빼미|木木枭|木木梟
0723|dartrix|efflèche|arboretoss|dartrix|dartrix|フクスロー|fukuthrow|빼미스로우|投羽枭|投羽梟
0724|decidueye|archéduc|silvarro|decidueye|decidueye|ジュナイパー|junaiper|모크나이퍼|狙射树枭|狙射樹梟
0725|litten|flamiaou|flamiau|litten|litten|ニャビー|nyabby|냐오불|火斑喵|火斑喵
0726|torracat|matoufeu|miezunder|torracat|torracat|ニャヒート|nyaheat|냐오히트|炎热喵|炎熱喵
0727|incineroar|félinferno|fuegro|incineroar|incineroar|ガオガエン|gaogaen|어흥염|炽焰咆哮虎|熾焰咆哮虎
0728|popplio|otaquin|robball|popplio|popplio|アシマリ|ashimari|누리공|球球海狮|球球海獅
0729|brionne|otarlette|marikeck|brionne|brionne|オシャマリ|osyamari|키요공|花漾海狮|花漾海獅
0730|primarina|oratoria|primarene|primarina|primarina|アシレーヌ|ashirene|누리레느|西狮海壬|西獅海壬
0731|pikipek|picassaut|peppeck|pikipek|pikipek|ツツケラ|tsutsukera|콕코구리|小笃儿|小篤兒
0732|trumbeak|piclairon|trompeck|trumbeak|trumbeak|ケララッパ|kerarappa|크라파|喇叭啄鸟|喇叭啄鳥
0733|toucannon|bazoucan|tukanon|toucannon|toucannon|ドデカバシ|dodekabashi|왕큰부리|铳嘴大鸟|銃嘴大鳥
0734|yungoos|manglouton|mangunior|yungoos|yungoos|ヤングース|youngoose|영구스|猫鼬少|貓鼬少
0735|gumshoos|argouste|manguspektor|gumshoos|gumshoos|デカグース|dekagoose|형사구스|猫鼬探长|貓鼬探長
0736|grubbin|larvibule|mabula|grubbin|grubbin|アゴジムシ|agojimushi|턱지충이|强颚鸡母虫|強顎雞母蟲
0737|charjabug|chrysapile|akkup|charjabug|charjabug|デンヂムシ|dendimushi|전지충이|虫电宝|蟲電寶
0738|vikavolt|lucanon|donarion|vikavolt|vikavolt|クワガノン|kuwagannon|투구뿌논|锹农炮虫|鍬農炮蟲
0739|crabrawler|crabagarre|krabbox|crabrawler|crabrawler|マケンカニ|makenkani|오기지게|好胜蟹|好勝蟹
0740|crabominable|crabominable|krawell|crabominable|crabominable|ケケンカニ|kekenkani|모단단게|好胜毛蟹|好勝毛蟹
0741|oricorio|plumeline|choreogel|oricorio|oricorio|オドリドリ|odoridori|춤추새|花舞鸟|花舞鳥
0742|cutiefly|bombydou|wommel|cutiefly|cutiefly|アブリー|abuly|에블리|萌虻|萌虻
0743|ribombee|rubombelle|bandelby|ribombee|ribombee|アブリボン|aburibbon|에리본|蝶结萌虻|蝶結萌虻
0744|rockruff|rocabot|wuffels|rockruff|rockruff|イワンコ|iwanko|암멍이|岩狗狗|岩狗狗
0745|lycanroc|lougaroc|wolwerock|lycanroc|lycanroc|ルガルガン|lugarugan|루가루암|鬃岩狼人|鬃岩狼人
0746|wishiwashi|froussardine|lusardin|wishiwashi|wishiwashi|ヨワシ|yowashi|약어리|弱丁鱼|弱丁魚
0747|mareanie|vorastérie|garstella|mareanie|mareanie|ヒドイデ|hidoide|시마사리|好坏星|好壞星
0748|toxapex|prédastérie|aggrostella|toxapex|toxapex|ドヒドイデ|dohidoide|더시마사리|超坏星|超壞星
0749|mudbray|tiboudet|pampuli|mudbray|mudbray|ドロバンコ|dorobanko|머드나기|泥驴仔|泥驢仔
0750|mudsdale|bourrinos|pampross|mudsdale|mudsdale|バンバドロ|banbadoro|만마드|重泥挽马|重泥挽馬
0751|dewpider|araqua|araqua|dewpider|dewpider|シズクモ|shizukumo|물거미|滴蛛|滴蛛
0752|araquanid|tarenbulle|aranestro|araquanid|araquanid|オニシズクモ|onishizukumo|깨비물거미|滴蛛霸|滴蛛霸
0753|fomantis|mimantis|imantis|fomantis|fomantis|カリキリ|karikiri|짜랑랑|伪螳草|偽螳草
0754|lurantis|floramantis|mantidea|lurantis|lurantis|ラランテス|lalantes|라란티스|兰螳花|蘭螳花
0755|morelull|spododo|bubungus|morelull|morelull|ネマシュ|nemasyu|자마슈|睡睡菇|睡睡菇
0756|shiinotic|lampignon|lamellux|shiinotic|shiinotic|マシェード|mashade|마셰이드|灯罩夜菇|燈罩夜菇
0757|salandit|tritox|molunk|salandit|salandit|ヤトウモリ|yatoumori|야도뇽|夜盗火蜥|夜盜火蜥
0758|salazzle|malamandre|amfira|salazzle|salazzle|エンニュート|ennewt|염뉴트|焰后蜥|焰后蜥
0759|stufful|nounourson|velursi|stufful|stufful|ヌイコグマ|nuikoguma|포곰곰|童偶熊|童偶熊
0760|bewear|chelours|kosturso|bewear|bewear|キテルグマ|kiteruguma|이븐곰|穿着熊|穿著熊
0761|bounsweet|croquine|frubberl|bounsweet|bounsweet|アマカジ|amakaji|달콤아|甜竹竹|甜竹竹
0762|steenee|candine|frubaila|steenee|steenee|アママイコ|amamaiko|달무리나|甜舞妮|甜舞妮
0763|tsareena|sucreine|fruyal|tsareena|tsareena|アマージョ|amajo|달코퀸|甜冷美后|甜冷美后
0764|comfey|guérilande|curelei|comfey|comfey|キュワワー|cuwawa|큐아링|花疗环环|花療環環
0765|oranguru|gouroutan|kommandutan|oranguru|oranguru|ヤレユータン|yareyuutan|하랑우탄|智挥猩|智揮猩
0766|passimian|quartermac|quartermak|passimian|passimian|ナゲツケサル|nagetukesaru|내던숭이|投掷猴|投擲猴
0767|wimpod|sovkipou|reißlaus|wimpod|wimpod|コソクムシ|kosokumushi|꼬시레|胆小虫|膽小蟲
0768|golisopod|sarmuraï|tectass|golisopod|golisopod|グソクムシャ|gusokumusha|갑주무사|具甲武者|具甲武者
0769|sandygast|bacabouh|sankabuh|sandygast|sandygast|スナバァ|sunaba|모래꿍|沙丘娃|沙丘娃
0770|palossand|trépassable|colossand|palossand|palossand|シロデスナ|sirodethna|모래성이당|噬沙堡爷|噬沙堡爺
0771|pyukumuku|concombaffe|gufa|pyukumuku|pyukumuku|ナマコブシ|namakobushi|해무기|拳海参|拳海參
0772|type: null|type:0|typ:null|tipo zero|código cero|タイプ：ヌル|type: null|타입:널|属性：空|屬性：空
0773|silvally|silvallié|amigento|silvally|silvally|シルヴァディ|silvady|실버디|银伴战兽|銀伴戰獸
0774|minior|météno|meteno|minior|minior|メテノ|meteno|메테노|小陨星|小隕星
0775|komala|dodoala|koalelu|komala|komala|ネッコアラ|nekkoara|자말라|树枕尾熊|樹枕尾熊
0776|turtonator|boumata|tortunator|turtonator|turtonator|バクガメス|bakugames|폭거북스|爆焰龟兽|爆焰龜獸
0777|togedemaru|togedemaru|togedemaru|togedemaru|togedemaru|トゲデマル|togedemaru|토게데마루|托戈德玛尔|托戈德瑪爾
0778|mimikyu|mimiqui|mimigma|mimikyu|mimikyu|ミミッキュ|mimikkyu|따라큐|谜拟丘|謎擬Ｑ
0779|bruxish|denticrisse|knirfish|bruxish|bruxish|ハギギシリ|hagigishiri|치갈기|磨牙彩皮鱼|磨牙彩皮魚
0780|drampa|draïeul|sen-long|drampa|drampa|ジジーロン|jijilong|할비롱|老翁龙|老翁龍
0781|dhelmise|sinistrail|moruda|dhelmise|dhelmise|ダダリン|dadarin|타타륜|破破舵轮|破破舵輪
0782|jangmo-o|bébécaille|miniras|jangmo-o|jangmo-o|ジャラコ|jyarako|짜랑꼬|心鳞宝|心鱗寶
0783|hakamo-o|écaïd|mediras|hakamo-o|hakamo-o|ジャランゴ|jyarango|짜랑고우|鳞甲龙|鱗甲龍
0784|kommo-o|ékaïser|grandiras|kommo-o|kommo-o|ジャラランガ|jyararanga|짜랑고우거|杖尾鳞甲龙|杖尾鱗甲龍
0785|tapu koko|tokorico|kapu-riki|tapu koko|tapu koko|カプ・コケコ|kapu-kokeko|카푸꼬꼬꼭|卡璞・鸣鸣|卡璞・鳴鳴
0786|tapu lele|tokopiyon|kapu-fala|tapu lele|tapu lele|カプ・テテフ|kapu-tetefu|카푸나비나|卡璞・蝶蝶|卡璞・蝶蝶
0787|tapu bulu|tokotoro|kapu-toro|tapu bulu|tapu bulu|カプ・ブルル|kapu-bulul|카푸브루루|卡璞・哞哞|卡璞・哞哞
0788|tapu fini|tokopisco|kapu-kime|tapu fini|tapu fini|カプ・レヒレ|kapu-rehire|카푸느지느|卡璞・鳍鳍|卡璞・鰭鰭
0789|cosmog|cosmog|cosmog|cosmog|cosmog|コスモッグ|cosmog|코스모그|科斯莫古|科斯莫古
0790|cosmoem|cosmovum|cosmovum|cosmoem|cosmoem|コスモウム|cosmovum|코스모움|科斯莫姆|科斯莫姆
0791|solgaleo|solgaleo|solgaleo|solgaleo|solgaleo|ソルガレオ|solgaleo|솔가레오|索尔迦雷欧|索爾迦雷歐
0792|lunala|lunala|lunala|lunala|lunala|ルナアーラ|lunala|루나아라|露奈雅拉|露奈雅拉
0793|nihilego|zéroïd|anego|nihilego|nihilego|ウツロイド|uturoid|텅비드|虚吾伊德|虛吾伊德
0794|buzzwole|mouscoto|masskito|buzzwole|buzzwole|マッシブーン|massivoon|매시붕|爆肌蚊|爆肌蚊
0795|pheromosa|cancrelove|schabelle|pheromosa|pheromosa|フェローチェ|pheroache|페로코체|费洛美螂|費洛美螂
0796|xurkitree|câblifère|voltriant|xurkitree|xurkitree|デンジュモク|denjyumoku|전수목|电束木|電束木
0797|celesteela|bamboiselle|kaguron|celesteela|celesteela|テッカグヤ|tekkaguya|철화구야|铁火辉夜|鐵火輝夜
0798|kartana|katagami|katagami|kartana|kartana|カミツルギ|kamiturugi|종이신도|纸御剑|紙御劍
0799|guzzlord|engloutyran|schlingking|guzzlord|guzzlord|アクジキング|akuziking|악식킹|恶食大王|惡食大王
0800|necrozma|necrozma|necrozma|necrozma|necrozma|ネクロズマ|necrozma|네크로즈마|奈克洛兹玛|奈克洛茲瑪
0801|magearna|magearna|magearna|magearna|magearna|マギアナ|magearna|마기아나|玛机雅娜|瑪機雅娜
0802|marshadow|marshadow|marshadow|marshadow|marshadow|マーシャドー|marshadow|마샤도|玛夏多|瑪夏多
0803|poipole|vémini|venicro|poipole|poipole|ベベノム|bevenom|베베놈|毒贝比|毒貝比
0804|naganadel|mandrillon|agoyon|naganadel|naganadel|アーゴヨン|agoyon|아고용|四颚针龙|四顎針龍
0805|stakataka|ama-ama|muramura|stakataka|stakataka|ツンデツンデ|tundetunde|차곡차곡|垒磊石|壘磊石
0806|blacephalon|pierroteknik|kopplosio|blacephalon|blacephalon|ズガドーン|zugadoon|두파팡|砰头小丑|砰頭小丑
0807|zeraora|zeraora|zeraora|zeraora|zeraora|ゼラオラ|zeraora|제라오라|捷拉奥拉|捷拉奧拉
0808|meltan|meltan|meltan|meltan|meltan|メルタン|merutan|멜탄|美录坦|美錄坦
0809|melmetal|melmetal|melmetal|melmetal|melmetal|メルメタル|merumetaru|멜메탈|美录梅塔|美錄梅塔
0810|grookey|ouistempo|chimpep|grookey|grookey|サルノリ|saru nori|흥나숭|敲音猴|敲音猴
0811|thwackey|badabouin|chimstix|thwackey|thwackey|バチンキー|bachinkī|채키몽|啪咚猴|啪咚猴
0812|rillaboom|gorythmic|gortrom|rillaboom|rillaboom|ゴリランダー|gorirandā|고릴타|轰擂金刚猩|轟擂金剛猩
0813|scorbunny|flambino|hopplo|scorbunny|scorbunny|ヒバニー|hibanī|염버니|炎兔儿|炎兔兒
0814|raboot|lapyro|kickerlo|raboot|raboot|ラビフット|rabifutto|래비풋|腾蹴小将|騰蹴小將
0815|cinderace|pyrobut|liberlo|cinderace|cinderace|エースバーン|ēsu bān|에이스번|闪焰王牌|閃焰王牌
0816|sobble|larméléon|memmeon|sobble|sobble|メッソン|messon|울머기|泪眼蜥|淚眼蜥
0817|drizzile|arrozard|phlegleon|drizzile|drizzile|ジメレオン|jimereon|누겔레온|变涩蜥|變澀蜥
0818|inteleon|lézargus|intelleon|inteleon|inteleon|インテレオン|intereon|인텔리레온|千面避役|千面避役
0819|skwovet|rongourmand|raffel|skwovet|skwovet|ホシガリス|hoshigarisu|탐리스|贪心栗鼠|貪心栗鼠
0820|greedent|rongrigou|schlaraffel|greedent|greedent|ヨクバリス|yokubarisu|요씽리스|藏饱栗鼠|藏飽栗鼠
0821|rookidee|minisange|meikro|rookidee|rookidee|ココガラ|kokogara|파라꼬|稚山雀|稚山雀
0822|corvisquire|bleuseille|kranoviz|corvisquire|corvisquire|アオガラス|aogarasu|파크로우|蓝鸦|藍鴉
0823|corviknight|corvaillus|krarmor|corviknight|corviknight|アーマーガア|āmāgā|아머까오|钢铠鸦|鋼鎧鴉
0824|blipbug|larvadar|sensect|blipbug|blipbug|サッチムシ|sacchimushi|두루지벌레|索侦虫|索偵蟲
0825|dottler|coléodôme|keradar|dottler|dottler|レドームシ|redōmushi|레돔벌레|天罩虫|天罩蟲
0826|orbeetle|astronelle|maritellit|orbeetle|orbeetle|イオルブ|iorubu|이올브|以欧路普|以歐路普
0827|nickit|goupilou|kleptifux|nickit|nickit|クスネ|kusune|훔처우|狡小狐|偷兒狐
0828|thievul|roublenard|gaunux|thievul|thievul|フォクスライ|fokusurai|폭슬라이|猾大狐|狐大盜
0829|gossifleur|tournicoton|cottini|gossifleur|gossifleur|ヒメンカ|himenka|꼬모카|幼棉棉|幼棉棉
0830|eldegoss|blancoton|cottomi|eldegoss|eldegoss|ワタシラガ|watashiraga|백솜모카|白蓬蓬|白蓬蓬
0831|wooloo|moumouton|wolly|wooloo|wooloo|ウールー|ū rū|우르|毛辫羊|毛辮羊
0832|dubwool|moumouflon|zwollock|dubwool|dubwool|バイウールー|baiūrū|배우르|毛毛角羊|毛毛角羊
0833|chewtle|khélocrok|kamehaps|chewtle|chewtle|カムカメ|kamu kame|깨물부기|咬咬龟|咬咬龜
0834|drednaw|torgamord|kamalm|drednaw|drednaw|カジリガメ|kajirigame|갈가부기|暴噬龟|暴噬龜
0835|yamper|voltoutou|voldi|yamper|yamper|ワンパチ|wanpachi|멍파치|来电汪|來電汪
0836|boltund|fulgudog|bellektro|boltund|boltund|パルスワン|paru suwan|펄스멍|逐电犬|逐電犬
0837|rolycoly|charbi|klonkett|rolycoly|rolycoly|タンドン|tan don|탄동|小炭仔|小炭仔
0838|carkol|wagomine|wagong|carkol|carkol|トロッゴン|toroggon|탄차곤|大炭车|大炭車
0839|coalossal|monthracite|montecarbo|coalossal|coalossal|セキタンザン|sekitanzan|석탄산|巨炭山|巨炭山
0840|applin|verpom|knapfel|applin|applin|カジッチュ|kajicchu|과사삭벌레|啃果虫|啃果蟲
0841|flapple|pomdrapi|drapfel|flapple|flapple|アップリュー|appuryū|애프룡|苹裹龙|蘋裹龍
0842|appletun|dratatin|schlapfel|appletun|appletun|タルップル|taruppuru|단지래플|丰蜜龙|豐蜜龍
0843|silicobra|dunaja|salanga|silicobra|silicobra|スナヘビ|sunahebi|모래뱀|沙包蛇|沙包蛇
0844|sandaconda|dunaconda|sanaconda|sandaconda|sandaconda|サダイジャ|sadaija|사다이사|沙螺蟒|沙螺蟒
0845|cramorant|nigosier|urgl|cramorant|cramorant|ウッウ|ūu|윽우지|古月鸟|古月鳥
0846|arrokuda|embrochet|pikuda|arrokuda|arrokuda|サシカマス|sashi kamasu|찌로꼬치|刺梭鱼|刺梭魚
0847|barraskewda|hastacuda|barrakiefa|barraskewda|barraskewda|カマスジョー|kamasu jō|꼬치조|戽斗尖梭|戽斗尖梭
0848|toxel|toxizap|toxel|toxel|toxel|エレズン|erezun|일레즌|电音婴|毒電嬰
0849|toxtricity|salarsen|riffex|toxtricity|toxtricity|ストリンダー|sutorindā|스트린더|颤弦蝾螈|顫弦蠑螈
0850|sizzlipede|grillepattes|thermopod|sizzlipede|sizzlipede|ヤクデ|yaku de|태우지네|烧火蚣|燒火蚣
0851|centiskorch|scolocendre|infernopod|centiskorch|centiskorch|マルヤクデ|maruyakude|다태우지네|焚焰蚣|焚焰蚣
0852|clobbopus|poulpaf|klopptopus|clobbopus|clobbopus|タタッコ|tatakko|때때무노|拳拳蛸|拳拳蛸
0853|grapploct|krakos|kaocto|grapploct|grapploct|オトスパス|otosupasu|케오퍼스|八爪武师|八爪武師
0854|sinistea|théffroi|fatalitee|sinistea|sinistea|ヤバチャ|yabacha|데인차|来悲茶|來悲茶
0855|polteageist|polthégeist|mortipot|polteageist|polteageist|ポットデス|pottodesu|포트데스|怖思壶|怖思壺
0856|hatenna|bibichut|brimova|hatenna|hatenna|ミブリム|miburimu|몸지브림|迷布莉姆|迷布莉姆
0857|hattrem|chapotus|brimano|hattrem|hattrem|テブリム|teburimu|손지브림|提布莉姆|提布莉姆
0858|hatterene|sorcilence|silembrim|hatterene|hatterene|ブリムオン|burimuon|브리무음|布莉姆温|布莉姆溫
0859|impidimp|grimalin|bähmon|impidimp|impidimp|ベロバー|berobā|메롱꿍|捣蛋小妖|搗蛋小妖
0860|morgrem|fourbelin|pelzebub|morgrem|morgrem|ギモー|gimō|쏘겨모|诈唬魔|詐唬魔
0861|grimmsnarl|angoliath|olangaar|grimmsnarl|grimmsnarl|オーロンゲ|ō ronge|오롱털|长毛巨魔|長毛巨魔
0862|obstagoon|ixon|barrikadax|obstagoon|obstagoon|タチフサグマ|tachifusaguma|가로막구리|堵拦熊|堵攔熊
0863|perrserker|berserkatt|mauzinger|perrserker|perrserker|ニャイキング|nyaikingu|나이킹|喵头目|喵頭目
0864|cursola|corayôme|gorgasonn|cursola|cursola|サニゴーン|sanigōn|산호르곤|魔灵珊瑚|魔靈珊瑚
0865|sirfetch'd|palarticho|lauchzelot|sirfetch’d|sirfetch’d|ネギガナイト|negiganaito|창파나이트|葱游兵|蔥遊兵
0866|mr. rime|m. glaquette|pantifrost|mr. rime|mr. rime|バリコオル|barikōru|마임꽁꽁|踏冰人偶|踏冰人偶
0867|runerigus|tutétékri|oghnatoll|runerigus|runerigus|デスバーン|desubān|데스판|迭失板|死神板
0868|milcery|crèmy|hokumil|milcery|milcery|マホミル|mahomiru|마빌크|小仙奶|小仙奶
0869|alcremie|charmilly|pokusan|alcremie|alcremie|マホイップ|mahoippu|마휘핑|霜奶仙|霜奶仙
0870|falinks|hexadron|legios|falinks|falinks|タイレーツ|tairētsu|대여르|列阵兵|列陣兵
0871|pincurchin|wattapik|britzigel|pincurchin|pincurchin|バチンウニ|bachinuni|찌르성게|啪嚓海胆|啪嚓海膽
0872|snom|frissonille|snomnom|snom|snom|ユキハミ|yukihami|누니머기|雪吞虫|雪吞蟲
0873|frosmoth|beldeneige|mottineva|frosmoth|frosmoth|モスノウ|mosunō|모스노우|雪绒蛾|雪絨蛾
0874|stonjourner|dolman|humanolith|stonjourner|stonjourner|イシヘンジン|ishihenjin|돌헨진|巨石丁|巨石丁
0875|eiscue|bekaglaçon|kubuin|eiscue|eiscue|コオリッポ|kōrippo|빙큐보|冰砌鹅|冰砌鵝
0876|indeedee|wimessir|servol|indeedee|indeedee|イエッサン|iessan|에써르|爱管侍|愛管侍
0877|morpeko|morpeko|morpeko|morpeko|morpeko|モルペコ|morupeko|모르페코|莫鲁贝可|莫魯貝可
0878|cufant|charibari|kupfanti|cufant|cufant|ゾウドウ|zōdō|끼리동|铜象|銅象
0879|copperajah|pachyradjah|patinaraja|copperajah|copperajah|ダイオウドウ|daiōdō|대왕끼리동|大王铜象|大王銅象
0880|dracozolt|galvagon|lectragon|dracozolt|dracozolt|パッチラゴン|pacchiragon|파치래곤|雷鸟龙|雷鳥龍
0881|arctozolt|galvagla|lecryodon|arctozolt|arctozolt|パッチルドン|pacchirudon|파치르돈|雷鸟海兽|雷鳥海獸
0882|dracovish|hydragon|pescragon|dracovish|dracovish|ウオノラゴン|uonoragon|어래곤|鳃鱼龙|鰓魚龍
0883|arctovish|hydragla|pescryodon|arctovish|arctovish|ウオチルドン|uochirudon|어치르돈|鳃鱼海兽|鰓魚海獸
0884|duraludon|duralugon|duraludon|duraludon|duraludon|ジュラルドン|jurarudon|두랄루돈|铝钢龙|鋁鋼龍
0885|dreepy|fantyrm|grolldra|dreepy|dreepy|ドラメシヤ|dorameshiya|드라꼰|多龙梅西亚|多龍梅西亞
0886|drakloak|dispareptil|phandra|drakloak|drakloak|ドロンチ|doronchi|드래런치|多龙奇|多龍奇
0887|dragapult|lanssorien|katapuldra|dragapult|dragapult|ドラパルト|doraparuto|드래펄트|多龙巴鲁托|多龍巴魯托
0888|zacian|zacian|zacian|zacian|zacian|ザシアン|zashian|자시안|苍响|蒼響
0889|zamazenta|zamazenta|zamazenta|zamazenta|zamazenta|ザマゼンタ|zamazenta|자마젠타|藏玛然特|藏瑪然特
0890|eternatus|éthernatos|endynalos|eternatus|eternatus|ムゲンダイナ|mugendaina|무한다이노|无极汰那|無極汰那
0891|kubfu|wushours|dakuma|kubfu|kubfu|ダクマ|dakuma|치고마|熊徒弟|熊徒弟
0892|urshifu|shifours|wulaosu|urshifu|urshifu|ウーラオス|ū raosu|우라오스|武道熊师|武道熊師
0893|zarude|zarude|zarude|zarude|zarude|ザルード|zarūdo|자루도|萨戮德|薩戮德
0894|regieleki|regieleki|regieleki|regieleki|regieleki|レジエレキ|reji ereki|레지에레키|雷吉艾勒奇|雷吉艾勒奇
0895|regidrago|regidrago|regidrago|regidrago|regidrago|レジドラゴ|rejidorago|레지드래고|雷吉铎拉戈|雷吉鐸拉戈
0896|glastrier|blizzeval|polaross|glastrier|glastrier|ブリザポス|burizaposu|블리자포스|雪暴马|雪暴馬
0897|spectrier|spectreval|phantoross|spectrier|spectrier|レイスポス|reisuposu|레이스포스|灵幽马|靈幽馬
0898|calyrex|sylveroy|coronospa|calyrex|calyrex|バドレックス|badorekkusu|버드렉스|蕾冠王|蕾冠王
0899|wyrdeer|cerbyllin|damythir|wyrdeer|wyrdeer|アヤシシ||신비록|诡角鹿|詭角鹿
0900|kleavor|hachécateur|axantor|kleavor|kleavor|バサギリ||사마자르|劈斧螳螂|劈斧螳螂
0901|ursaluna|ursaking|ursaluna|ursaluna|ursaluna|ガチグマ||다투곰|月月熊|月月熊
0902|basculegion|paragruel|salmagnis|basculegion|basculegion|イダイトウ||대쓰여너|幽尾玄鱼|幽尾玄魚
0903|sneasler|farfurex|snieboss|sneasler|sneasler|オオニューラ||포푸니크|大狃拉|大狃拉
0904|overqwil|qwilpik|myriador|overqwil|overqwil|ハリーマン||장침바루|万针鱼|萬針魚
0905|enamorus|amovénus|cupidos|enamorus|enamorus|ラブトロス||러브로스|眷恋云|眷戀雲
0906|sprigatito|poussacha|felori|sprigatito|sprigatito|ニャオハ||나오하|新叶喵|新葉喵
0907|floragato|matourgeon|feliospa|floragato|floragato|ニャローテ||나로테|蒂蕾喵|蒂蕾喵
0908|meowscarada|miascarade|maskagato|meowscarada|meowscarada|マスカーニャ||마스카나|魔幻假面喵|魔幻假面喵
0909|fuecoco|chochodile|krokel|fuecoco|fuecoco|ホゲータ||뜨아거|呆火鳄|呆火鱷
0910|crocalor|crocogril|lokroko|crocalor|crocalor|アチゲータ||악뜨거|炙烫鳄|炙燙鱷
0911|skeledirge|flâmigator|skelokrok|skeledirge|skeledirge|ラウドボーン||라우드본|骨纹巨声鳄|骨紋巨聲鱷
0912|quaxly|coiffeton|kwaks|quaxly|quaxly|クワッス||꾸왁스|润水鸭|潤水鴨
0913|quaxwell|canarbello|fuentente|quaxwell|quaxwell|ウェルカモ||아꾸왁|涌跃鸭|湧躍鴨
0914|quaquaval|palmaval|bailonda|quaquaval|quaquaval|ウェーニバル||웨이니발|狂欢浪舞鸭|狂歡浪舞鴨
0915|lechonk|gourmelet|ferkuli|lechonk|lechonk|グルトン||맛보돈|爱吃豚|愛吃豚
0916|oinkologne|fragroin|fragrunz|oinkologne|oinkologne|パフュートン||퍼퓨돈|飘香豚|飄香豚
0917|tarountula|tissenboule|tarundel|tarountula|tarountula|タマンチュラ||타랜툴라|团珠蛛|團珠蛛
0918|spidops|filentrappe|spinsidias|spidops|spidops|ワナイダー||트래피더|操陷蛛|操陷蛛
0919|nymble|lilliterelle|micrick|nymble|nymble|マメバッタ||콩알뚜기|豆蟋蟀|豆蟋蟀
0920|lokix|gambex|lextremo|lokix|lokix|エクスレッグ||엑스레그|烈腿蝗|烈腿蝗
0921|pawmi|pohm|pamo|pawmi|pawmi|パモ||빠모|布拨|布撥
0922|pawmo|pohmotte|pamamo|pawmo|pawmo|パモット||빠모트|布土拨|布土撥
0923|pawmot|pohmarmotte|pamomamo|pawmot|pawmot|パーモット||빠르모트|巴布土拨|巴布土撥
0924|tandemaus|compagnol|zwieps|tandemaus|tandemaus|ワッカネズミ||두리쥐|一对鼠|一對鼠
0925|maushold|famignol|famieps|maushold|maushold|イッカネズミ||파밀리쥐|一家鼠|一家鼠
0926|fidough|pâtachiot|hefel|fidough|fidough|パピモッチ||쫀도기|狗仔包|狗仔包
0927|dachsbun|briochien|backel|dachsbun|dachsbun|バウッツェル||바우첼|麻花犬|麻花犬
0928|smoliv|olivini|olini|smoliv|smoliv|ミニーブ||미니브|迷你芙|迷你芙
0929|dolliv|olivado|olivinio|dolliv|dolliv|オリーニョ||올리뇨|奥利纽|奧利紐
0930|arboliva|arboliva|olithena|arboliva|arboliva|オリーヴァ||올리르바|奥利瓦|奧利瓦
0931|squawkabilly|tapatoès|krawalloro|squawkabilly|squawkabilly|イキリンコ||시비꼬|怒鹦哥|怒鸚哥
0932|nacli|selutin|geosali|nacli|nacli|コジオ||베베솔트|盐石宝|鹽石寶
0933|naclstack|amassel|sedisal|naclstack|naclstack|ジオヅム||스태솔트|盐石垒|鹽石壘
0934|garganacl|gigansel|saltigant|garganacl|garganacl|キョジオーン||콜로솔트|盐石巨灵|鹽石巨靈
0935|charcadet|charbambin|knarbon|charcadet|charcadet|カルボウ||카르본|炭小侍|炭小侍
0936|armarouge|carmadura|crimanzo|armarouge|armarouge|グレンアルマ||카디나르마|红莲铠骑|紅蓮鎧騎
0937|ceruledge|malvalame|azugladis|ceruledge|ceruledge|ソウブレイズ||파라블레이즈|苍炎刃鬼|蒼炎刃鬼
0938|tadbulb|têtampoule|blipp|tadbulb|tadbulb|ズピカ||빈나두|光蚪仔|光蚪仔
0939|bellibolt|ampibidou|wampitz|bellibolt|bellibolt|ハラバリー||찌리배리|电肚蛙|電肚蛙
0940|wattrel|zapétrel|voltrel|wattrel|wattrel|カイデン||찌리비|电海燕|電海燕
0941|kilowattrel|fulgulairo|voltrean|kilowattrel|kilowattrel|タイカイデン||찌리비크|大电海燕|大電海燕
0942|maschiff|grondogue|mobtiff|maschiff|maschiff|オラチフ||오라티프|偶叫獒|偶叫獒
0943|mabosstiff|dogrino|mastifioso|mabosstiff|mabosstiff|マフィティフ||마피티프|獒教父|獒教父
0944|shroodle|gribouraigne|sproxi|shroodle|shroodle|シルシュルー||땃쭈르|滋汁鼹|滋汁鼴
0945|grafaiai|tag-tag|affiti|grafaiai|grafaiai|タギングル||태깅구르|涂标客|塗標客
0946|bramblin|virovent|weherba|bramblin|bramblin|アノクサ||그푸리|纳噬草|納噬草
0947|brambleghast|virevorreur|horrerba|brambleghast|brambleghast|アノホラグサ||공푸리|怖纳噬草|怖納噬草
0948|toedscool|terracool|tentagra|toedscool|toedscool|ノノクラゲ||들눈해|原野水母|原野水母
0949|toedscruel|terracruel|tenterra|toedscruel|toedscruel|リククラゲ||육파리|陆地水母|陸地水母
0950|klawf|craparoi|klibbe|klawf|klawf|ガケガニ||절벼게|毛崖蟹|毛崖蟹
0951|capsakid|pimito|chilingel|capsakid|capsakid|カプサイジ||캡싸이|热辣娃|熱辣娃
0952|scovillain|scovilain|halupenjo|scovillain|scovillain|スコヴィラン||스코빌런|狠辣椒|狠辣椒
0953|rellor|léboulérou|relluk|rellor|rellor|シガロコ||구르데|虫滚泥|蟲滾泥
0954|rabsca|bérasca|skarabaks|rabsca|rabsca|ベラカス||베라카스|虫甲圣|蟲甲聖
0955|flittle|flotillon|flattutu|flittle|flittle|ヒラヒナ||하느라기|飘飘雏|飄飄雛
0956|espathra|cléopsytra|psiopatra|espathra|espathra|クエスパトラ||클레스퍼트라|超能艳鸵|超能豔鴕
0957|tinkatink|forgerette|forgita|tinkatink|tinkatink|カヌチャン||어리짱|小锻匠|小鍛匠
0958|tinkatuff|forgella|tafforgita|tinkatuff|tinkatuff|ナカヌチャン||벼리짱|巧锻匠|巧鍛匠
0959|tinkaton|forgelina|granforgita|tinkaton|tinkaton|デカヌチャン||두드리짱|巨锻匠|巨鍛匠
0960|wiglett|taupikeau|schligda|wiglett|wiglett|ウミディグダ||바다그다|海地鼠|海地鼠
0961|wugtrio|triopikeau|schligdri|wugtrio|wugtrio|ウミトリオ||바닥트리오|三海地鼠|三海地鼠
0962|bombirdier|lestombaile|adebom|bombirdier|bombirdier|オトシドリ||떨구새|下石鸟|下石鳥
0963|finizen|dofin|normifin|finizen|finizen|ナミイルカ||맨돌핀|波普海豚|波普海豚
0964|palafin|superdofin|delfinator|palafin|palafin|イルカマン||돌핀맨|海豚侠|海豚俠
0965|varoom|vrombi|knattox|varoom|varoom|ブロロン||부르롱|噗隆隆|噗隆隆
0966|revavroom|vrombotor|knattatox|revavroom|revavroom|ブロロローム||부르르룸|普隆隆姆|普隆隆姆
0967|cyclizar|motorizard|mopex|cyclizar|cyclizar|モトトカゲ||모토마|摩托蜥|摩托蜥
0968|orthworm|ferdeter|schlurm|orthworm|orthworm|ミミズズ||꿈트렁|拖拖蚓|拖拖蚓
0969|glimmet|germéclat|lumispross|glimmet|glimmet|キラーメ||초롱순|晶光芽|晶光芽
0970|glimmora|floréclat|lumiflora|glimmora|glimmora|キラフロル||킬라플로르|晶光花|晶光花
0971|greavard|toutombe|gruff|greavard|greavard|ボチ||망망이|墓仔狗|墓仔狗
0972|houndstone|tomberro|friedwuff|houndstone|houndstone|ハカドッグ||묘두기|墓扬犬|墓揚犬
0973|flamigo|flamenroule|flaminkno|flamigo|flamigo|カラミンゴ||꼬이밍고|缠红鹤|纏紅鶴
0974|cetoddle|piétacé|flaniwal|cetoddle|cetoddle|アルクジラ||터벅고래|走鲸|走鯨
0975|cetitan|balbalèze|kolowal|cetitan|cetitan|ハルクジラ||우락고래|浩大鲸|浩大鯨
0976|veluza|délestin|agiluza|veluza|veluza|ミガルーサ||가비루사|轻身鳕|輕身鱈
0977|dondozo|oyacata|heerashai|dondozo|dondozo|ヘイラッシャ||어써러셔|吃吼霸|吃吼霸
0978|tatsugiri|nigirigon|nigiragi|tatsugiri|tatsugiri|シャリタツ||싸리용|米立龙|米立龍
0979|annihilape|courrousinge|epitaff|annihilape|annihilape|コノヨザル||저승갓숭|弃世猴|棄世猴
0980|clodsire|terraiste|suelord|clodsire|clodsire|ドオー||토오|土王|土王
0981|farigiraf|farigiraf|farigiraf|farigiraf|farigiraf|リキキリン||키키링|奇麒麟|奇麒麟
0982|dudunsparce|deusolourdo|dummimisel|dudunsparce|dudunsparce|ノココッチ||노고고치|土龙节节|土龍節節
0983|kingambit|scalpereur|gladimperio|kingambit|kingambit|ドドゲザン||대도각참|仆刀将军|仆斬將軍
0984|great tusk|fort-ivoire|riesenzahn|grandizanne|colmilargo|イダイナキバ||위대한엄니|雄伟牙|雄偉牙
0985|scream tail|hurle-queue|brüllschweif|codaurlante|colagrito|サケブシッポ||우렁찬꼬리|吼叫尾|吼叫尾
0986|brute bonnet|fongus-furie|wutpilz|fungofurioso|furioseta|アラブルタケ||사나운버섯|猛恶菇|猛惡菇
0987|flutter mane|flotte-mèche|flatterhaar|crinealato|melenaleteo|ハバタクカミ||날개치는머리|振翼发|振翼髮
0988|slither wing|rampe-ailes|kriechflügel|alirasenti|reptalada|チヲハウハネ||땅을기는날개|爬地翅|爬地翅
0989|sandy shocks|pelage-sablé|sandfell|peldisabbia|pelarena|スナノケガワ||모래털가죽|沙铁皮|沙鐵皮
0990|iron treads|roue-de-fer|eisenrad|solcoferreo|ferrodada|テツノワダチ||무쇠바퀴|铁辙迹|鐵轍跡
0991|iron bundle|hotte-de-fer|eisenbündel|saccoferreo|ferrosaco|テツノツツミ||무쇠보따리|铁包袱|鐵包袱
0992|iron hands|paume-de-fer|eisenhand|manoferrea|ferropalmas|テツノカイナ||무쇠손|铁臂膀|鐵臂膀
0993|iron jugulis|têtes-de-fer|eisenhals|colloferreo|ferrocuello|テツノコウベ||무쇠머리|铁脖颈|鐵脖頸
0994|iron moth|mite-de-fer|eisenfalter|falenaferrea|ferropolilla|テツノドクガ||무쇠독나방|铁毒蛾|鐵毒蛾
0995|iron thorns|épine-de-fer|eisendorn|spineferree|ferropúas|テツノイバラ||무쇠가시|铁荆棘|鐵荊棘
0996|frigibax|frigodo|frospino|frigibax|frigibax|セビエ||드니차|凉脊龙|涼脊龍
0997|arctibax|cryodo|cryospino|arctibax|arctibax|セゴール||드니꽁|冻脊龙|凍脊龍
0998|baxcalibur|glaivodo|espinodon|baxcalibur|baxcalibur|セグレイブ||드닐레이브|戟脊龙|戟脊龍
0999|gimmighoul|mordudor|gierspenst|gimmighoul|gimmighoul|コレクレー||모으령|索财灵|索財靈
1000|gholdengo|gromago|monetigo|gholdengo|gholdengo|サーフゴー||타부자고|赛富豪|賽富豪
1001|wo-chien|chongjian|chongjian|wo-chien|wo-chien|チオンジェン||총지엔|古简蜗|古簡蝸
1002|chien-pao|baojian|baojian|chien-pao|chien-pao|パオジアン||파오젠|古剑豹|古劍豹
1003|ting-lu|dinglu|dinglu|ting-lu|ting-lu|ディンルー||딩루|古鼎鹿|古鼎鹿
1004|chi-yu|yuyu|yuyu|chi-yu|chi-yu|イーユイ||위유이|古玉鱼|古玉魚
1005|roaring moon|rugit-lune|donnersichel|lunaruggente|bramaluna|トドロクツキ||고동치는달|轰鸣月|轟鳴月
1006|iron valiant|garde-de-fer|eisenkrieger|eroeferreo|ferropaladín|テツノブジン||무쇠무인|铁武者|鐵武者
1007|koraidon|koraidon|koraidon|koraidon|koraidon|コライドン||코라이돈|故勒顿|故勒頓
1008|miraidon|miraidon|miraidon|miraidon|miraidon|ミライドン||미라이돈|密勒顿|密勒頓
1009|walking wake|serpente-eau|windewoge|acquecrespe|ondulagua|ウネルミナモ||굽이치는물결|波荡水|波盪水
1010|iron leaves|vert-de-fer|eisenblatt|fogliaferrea|ferroverdor|テツノイサハ||무쇠잎새|铁斑叶|鐵斑葉
1011|dipplin|pomdramour|sirapfel||||kamicchu|과미르||
1012|poltchageist|poltchageist|mortcha||||chadesu|차데스||
1013|sinistcha|théffroyable|fatalitcha||||yabasocha|그우린차||
1014|okidogi|félicanis|boninu||||iineinu|조타구||
1015|munkidori|fortusimia|benesaru||||mashimashira|이야후||
1016|fezandipiti|favianos|beatori||||kichigikisu|기로치||
1017|ogerpon|ogerpon|ogerpon||||ogerpon|오거폰||
1018|archaludon|pondralugon|briduradon||||briduras|브리두라스||
1019|hydrapple|pomdorochi|hydrapfel||||kamitsuorochi|과미드라||
1020|gouging fire|feu-perçant|keilflamme||||ugatsuhomura|꿰뚫는화염||
1021|raging bolt|ire-foudre|furienblitz||||takeruraiko|날뛰는우레||
1022|iron boulder|chef-de-fer|eisenfels||||tetsunoiwao|무쇠암석||
1023|iron crown|roc-de-fer|eisenhaupt||||tetsunokashira|무쇠감투||
1024|terapagos|terapagos|terapagos||||terapagos|테라파고스||
1025|pecharunt|pêchaminus|infamomo||||momowarou|복숭악동||
_pkmnlist_

#pkmnformlist#
0003|mega|Mega Venusaur|venusaur-mega
0006|mega-x|Mega Charizard X|charizard-mega-x
0006|mega-y|Mega Charizard Y|charizard-mega-y
0006|gmax|Gigantamax Charizard|charizard-gigantamax
0009|mega|Mega Blastoise|blastoise-mega
0009|gmax|Gigantamax Blastoise|blastoise-gigantamax
0003|gmax|Gigantamax Venusaur|venusaur-gigantamax
0012|gmax|Gigantamax Butterfree|butterfree-gigantamax
0015|mega|Mega Beedrill|beedrill-mega
0018|mega|Mega Pidgeot|pidgeot-mega
0019|alola|Alolan Rattata|rattata-alolan
0020|alola|Alolan Raticate|raticate-alolan
0025|gmax|Gigantamax Pikachu|pikachu-gigantamax
0026|alola|Alolan Raichu|raichu-alolan
0027|alola|Alolan Sandshrew|sandshrew-alolan
0028|alola|Alolan Sandslash|sandslash-alolan
0037|alola|Alolan Vulpix|vulpix-alolan
0038|alola|Alolan Ninetales|ninetales-alolan
0050|alola|Alolan Diglett|diglett-alolan
0051|alola|Alolan Dugtrio|dugtrio-alolan
0052|alola|Alolan Meowth|meowth-alolan
0052|galar|Galarian Meowth|meowth-galarian
0052|gmax|Gigantamax Meowth|meowth-gigantamax
0053|alola|Alolan Persian|persian-alolan
0058|hisui|Hisuian Growlithe|growlithe-hisuian
0059|hisui|Hisuian Arcanine|arcanine-hisuian
0065|mega|Mega Alakazam|alakazam-mega
0068|gmax|Gigantamax Machamp|machamp-gigantamax
0074|alola|Alolan Geodude|geodude-alolan
0075|alola|Alolan Graveler|graveler-alolan
0076|alola|Alolan Golem|golem-alolan
0077|galar|Galarian Ponyta|ponyta-galarian
0078|galar|Galarian Rapidash|rapidash-galarian
0079|galar|Galarian Slowpoke|slowpoke-galarian
0080|mega|Mega Slowbro|slowbro-mega
0080|galar|Galarian Slowbro|slowbro-galarian
0083|galar|Galarian Farfetch'd|farfetchd-galarian
0088|alola|Alolan Grimer|grimer-alolan
0089|alola|Alolan Muk|muk-alolan
0094|mega|Mega Gengar|gengar-mega
0094|gmax|Gigantamax Gengar|gengar-gigantamax
0099|gmax|Gigantamax Kingler|kingler-gigantamax
0100|hisui|Hisuian Voltorb|voltorb-hisuian
0101|hisui|Hisuian Electrode|electrode-hisuian
0103|alola|Alolan Exeggutor|exeggutor-alolan
0105|alola|Alolan Marowak|marowak-alolan
0110|galar|Galarian Weezing|weezing-galarian
0115|mega|Mega Kangaskhan|kangaskhan-mega
0122|galar|Galarian Mr. Mime|mr-mime-galarian
0127|mega|Mega Pinsir|pinsir-mega
0128|paldea-combat|Paldean Tauros (Combat)|tauros-paldean-combat-breed
0128|paldea-blaze|Paldean Tauros (Blaze)|tauros-paldean-blaze-breed
0128|paldea-aqua|Paldean Tauros (Aqua)|tauros-paldean-aqua-breed
0130|mega|Mega Gyarados|gyarados-mega
0131|gmax|Gigantamax Lapras|lapras-gigantamax
0133|gmax|Gigantamax Eevee|eevee-gigantamax
0142|mega|Mega Aerodactyl|aerodactyl-mega
0143|gmax|Gigantamax Snorlax|snorlax-gigantamax
0144|galar|Galarian Articuno|articuno-galarian
0145|galar|Galarian Zapdos|zapdos-galarian
0146|galar|Galarian Moltres|moltres-galarian
0150|mega-x|Mega Mewtwo X|mewtwo-mega-x
0150|mega-y|Mega Mewtwo Y|mewtwo-mega-y
0157|hisui|Hisuian Typhlosion|typhlosion-hisuian
0181|mega|Mega Ampharos|ampharos-mega
0194|paldea|Paldean Wooper|wooper-paldean
0199|galar|Galarian Slowking|slowking-galarian
0208|mega|Mega Steelix|steelix-mega
0211|hisui|Hisuian Qwilfish|qwilfish-hisuian
0212|mega|Mega Scizor|scizor-mega
0214|mega|Mega Heracross|heracross-mega
0215|hisui|Hisuian Sneasel|sneasel-hisuian
0222|galar|Galarian Corsola|corsola-galarian
0229|mega|Mega Houndoom|houndoom-mega
0248|mega|Mega Tyranitar|tyranitar-mega
0254|mega|Mega Sceptile|sceptile-mega
0257|mega|Mega Blaziken|blaziken-mega
0260|mega|Mega Swampert|swampert-mega
0263|galar|Galarian Zigzagoon|zigzagoon-galarian
0264|galar|Galarian Linoone|linoone-galarian
0282|mega|Mega Gardevoir|gardevoir-mega
0302|mega|Mega Sableye|sableye-mega
0303|mega|Mega Mawile|mawile-mega
0306|mega|Mega Aggron|aggron-mega
0308|mega|Mega Medicham|medicham-mega
0310|mega|Mega Manectric|manectric-mega
0319|mega|Mega Sharpedo|sharpedo-mega
0323|mega|Mega Camerupt|camerupt-mega
0334|mega|Mega Altaria|altaria-mega
0354|mega|Mega Banette|banette-mega
0359|mega|Mega Absol|absol-mega
0362|mega|Mega Glalie|glalie-mega
0373|mega|Mega Salamence|salamence-mega
0376|mega|Mega Metagross|metagross-mega
0380|mega|Mega Latias|latias-mega
0381|mega|Mega Latios|latios-mega
0382|primal|Primal Kyogre|kyogre-primal
0383|primal|Primal Groudon|groudon-primal
0384|mega|Mega Rayquaza|rayquaza-mega
0386|attack|Deoxys (Attack)|deoxys-attack
0386|defense|Deoxys (Defense)|deoxys-defense
0386|speed|Deoxys (Speed)|deoxys-speed
0413|sandy|Wormadam (Sandy)|wormadam-sandy
0413|trash|Wormadam (Trash)|wormadam-trash
0428|mega|Mega Lopunny|lopunny-mega
0445|mega|Mega Garchomp|garchomp-mega
0448|mega|Mega Lucario|lucario-mega
0460|mega|Mega Abomasnow|abomasnow-mega
0475|mega|Mega Gallade|gallade-mega
0479|heat|Rotom (Heat)|rotom-heat
0479|wash|Rotom (Wash)|rotom-wash
0479|frost|Rotom (Frost)|rotom-frost
0479|fan|Rotom (Fan)|rotom-fan
0479|mow|Rotom (Mow)|rotom-mow
0487|origin|Giratina (Origin)|giratina-origin
0492|sky|Shaymin (Sky)|shaymin-sky
0503|hisui|Hisuian Samurott|samurott-hisuian
0531|mega|Mega Audino|audino-mega
0549|hisui|Hisuian Lilligant|lilligant-hisuian
0550|blue|Basculin (Blue-Striped)|basculin-blue-striped
0550|white|Basculin (White-Striped)|basculin-white-striped
0554|galar|Galarian Darumaka|darumaka-galarian
0555|galar|Galarian Darmanitan|darmanitan-galarian
0555|zen|Darmanitan (Zen)|darmanitan-zen
0562|galar|Galarian Yamask|yamask-galarian
0569|gmax|Gigantamax Garbodor|garbodor-gigantamax
0570|hisui|Hisuian Zorua|zorua-hisuian
0571|hisui|Hisuian Zoroark|zoroark-hisuian
0618|galar|Galarian Stunfisk|stunfisk-galarian
0628|hisui|Hisuian Braviary|braviary-hisuian
0641|therian|Tornadus (Therian)|tornadus-therian
0642|therian|Thundurus (Therian)|thundurus-therian
0645|therian|Landorus (Therian)|landorus-therian
0646|black|Black Kyurem|kyurem-black
0646|white|White Kyurem|kyurem-white
0647|resolute|Keldeo (Resolute)|keldeo-resolute
0648|pirouette|Meloetta (Pirouette)|meloetta-pirouette
0681|blade|Aegislash (Blade)|aegislash-blade
0705|hisui|Hisuian Sliggoo|sliggoo-hisuian
0706|hisui|Hisuian Goodra|goodra-hisuian
0710|small|Pumpkaboo (Small)|pumpkaboo-small
0710|large|Pumpkaboo (Large)|pumpkaboo-large
0710|super|Pumpkaboo (Super)|pumpkaboo-super
0711|small|Gourgeist (Small)|gourgeist-small
0711|large|Gourgeist (Large)|gourgeist-large
0711|super|Gourgeist (Super)|gourgeist-super
0713|hisui|Hisuian Avalugg|avalugg-hisuian
0718|10|Zygarde (10%)|zygarde-10
0718|complete|Zygarde (Complete)|zygarde-complete
0719|mega|Mega Diancie|diancie-mega
0720|unbound|Hoopa Unbound|hoopa-unbound
0724|hisui|Hisuian Decidueye|decidueye-hisuian
0746|school|Wishiwashi (School)|wishiwashi-school
0800|dusk-mane|Dusk Mane Necrozma|necrozma-dusk-mane
0800|dawn-wings|Dawn Wings Necrozma|necrozma-dawn-wings
0800|ultra|Ultra Necrozma|necrozma-ultra
0809|gmax|Gigantamax Melmetal|melmetal-gigantamax
0812|gmax|Gigantamax Rillaboom|rillaboom-gigantamax
0815|gmax|Gigantamax Cinderace|cinderace-gigantamax
0818|gmax|Gigantamax Inteleon|inteleon-gigantamax
0823|gmax|Gigantamax Corviknight|corviknight-gigantamax
0826|gmax|Gigantamax Orbeetle|orbeetle-gigantamax
0834|gmax|Gigantamax Drednaw|drednaw-gigantamax
0839|gmax|Gigantamax Coalossal|coalossal-gigantamax
0841|gmax|Gigantamax Flapple|flapple-gigantamax
0842|gmax|Gigantamax Appletun|appletun-gigantamax
0844|gmax|Gigantamax Sandaconda|sandaconda-gigantamax
0849|gmax|Gigantamax Toxtricity|toxtricity-gigantamax
0851|gmax|Gigantamax Centiskorch|centiskorch-gigantamax
0858|gmax|Gigantamax Hatterene|hatterene-gigantamax
0861|gmax|Gigantamax Grimmsnarl|grimmsnarl-gigantamax
0869|gmax|Gigantamax Alcremie|alcremie-gigantamax
0879|gmax|Gigantamax Copperajah|copperajah-gigantamax
0884|gmax|Gigantamax Duraludon|duraludon-gigantamax
0888|crowned|Crowned Sword Zacian|zacian-crowned
0889|crowned|Crowned Shield Zamazenta|zamazenta-crowned
0890|eternamax|Eternamax Eternatus|eternatus-eternamax
0892|rapid|Urshifu (Rapid Strike)|urshifu-rapid-strike
0892|gmax|Gigantamax Urshifu|urshifu-single-strike-gigantamax
0892|gmax-rapid|Gigantamax Urshifu (Rapid)|urshifu-rapid-strike-gigantamax
0898|ice|Ice Rider Calyrex|calyrex-ice-rider
0898|shadow|Shadow Rider Calyrex|calyrex-shadow-rider
0905|therian|Enamorus (Therian)|enamorus-therian
1017|hearthflame|Hearthflame Mask Ogerpon|ogerpon-hearthflame
1017|wellspring|Wellspring Mask Ogerpon|ogerpon-wellspring
1017|cornerstone|Cornerstone Mask Ogerpon|ogerpon-cornerstone
1024|stellar|Stellar Terapagos|terapagos-stellar
_pkmnformlist_
MULTILINE-COMMENT

