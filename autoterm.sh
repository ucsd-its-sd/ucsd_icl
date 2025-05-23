#!/bin/sh
TS=`date -I`

source ./config.sh

if [ "$TS" = "2025-03-17" ]; then
	ICLTERM=WI25
	ICLFINALS=1
elif [ "$TS" = "2025-03-31" ]; then
	ICLTERM=SP25
	ICLFINALS=0
elif [ "$TS" = "2025-06-07" ]; then
	ICLFINALS=1
elif [ "$TS" = "2025-06-30" ]; then
	ICLTERM=S125
	ICLFINALS=0
elif [ "$TS" = "2025-08-01" ]; then
	ICLFINALS=1
elif [ "$TS" = "2025-08-04" ]; then
	ICLTERM=S225
 	ICLFINALS=0
elif [ "$TS" = "2025-09-05" ]; then
	ICLFINALS=1
elif [ "$TS" = "2025-09-25" ]; then
	ICLTERM=FA25
 	ICLFINALS=0
elif [ "$TS" = "2025-12-06" ]; then
	ICLFINALS=1
elif [ "$TS" = "2026-01-05" ]; then
	ICLTERM=WI26
  	ICLFINALS=0
elif [ "$TS" = "2026-03-14" ]; then
	ICLFINALS=1
elif [ "$TS" = "2026-03-30" ]; then
	ICLTERM=SP26
  	ICLFINALS=0
elif [ "$TS" = "2026-06-06" ]; then
	ICLFINALS=1
elif [ "$TS" = "2026-06-29" ]; then
	ICLTERM=S126
  	ICLFINALS=0
elif [ "$TS" = "2026-07-31" ]; then
	ICLFINALS=1
elif [ "$TS" = "2026-08-03" ]; then
	ICLTERM=S226
  	ICLFINALS=0
elif [ "$TS" = "2026-09-04" ]; then
	ICLFINALS=1
elif [ "$TS" = "2026-09-24" ]; then
	ICLTERM=FA26
  	ICLFINALS=0
elif [ "$TS" = "2026-12-05" ]; then
	ICLFINALS=1
elif [ "$TS" = "2027-01-04" ]; then
	ICLTERM=WI27
  	ICLFINALS=0
elif [ "$TS" = "2027-03-13" ]; then
	ICLFINALS=1
elif [ "$TS" = "2027-03-29" ]; then
	ICLTERM=SP27
  	ICLFINALS=0
elif [ "$TS" = "2027-06-05" ]; then
	ICLFINALS=1
elif [ "$TS" = "2027-06-28" ]; then
	ICLTERM=S127
  	ICLFINALS=0
elif [ "$TS" = "2027-07-30" ]; then
	ICLFINALS=1
elif [ "$TS" = "2027-08-02" ]; then
	ICLTERM=S227
  	ICLFINALS=0
elif [ "$TS" = "2027-09-03" ]; then
	ICLFINALS=1
elif [ "$TS" = "2027-09-23" ]; then
	ICLTERM=FA27
  	ICLFINALS=0
elif [ "$TS" = "2027-12-04" ]; then
	ICLFINALS=1
elif [ "$TS" = "2028-01-10" ]; then
	ICLTERM=WI28
  	ICLFINALS=0
elif [ "$TS" = "2028-03-18" ]; then
	ICLFINALS=1
elif [ "$TS" = "2028-04-03" ]; then
	ICLTERM=SP28
  	ICLFINALS=0
elif [ "$TS" = "2028-06-10" ]; then
	ICLFINALS=1
elif [ "$TS" = "2028-07-03" ]; then
	ICLTERM=S128
  	ICLFINALS=0
elif [ "$TS" = "2028-08-04" ]; then
	ICLFINALS=1
elif [ "$TS" = "2028-08-07" ]; then
	ICLTERM=S228
  	ICLFINALS=0
elif [ "$TS" = "2028-09-08" ]; then
	ICLFINALS=1
elif [ "$TS" = "2028-09-28" ]; then
	ICLTERM=FA28
  	ICLFINALS=0
elif [ "$TS" = "2028-12-09" ]; then
	ICLFINALS=1
elif [ "$TS" = "2029-01-08" ]; then
	ICLTERM=WI29
  	ICLFINALS=0
elif [ "$TS" = "2029-03-17" ]; then
	ICLFINALS=1
elif [ "$TS" = "2029-04-02" ]; then
	ICLTERM=SP29
  	ICLFINALS=0
elif [ "$TS" = "2029-06-09" ]; then
	ICLFINALS=1
elif [ "$TS" = "2029-07-02" ]; then
	ICLTERM=S129
  	ICLFINALS=0
elif [ "$TS" = "2029-08-03" ]; then
	ICLFINALS=1
elif [ "$TS" = "2029-08-06" ]; then
	ICLTERM=S229
  	ICLFINALS=0
elif [ "$TS" = "2029-09-07" ]; then
	ICLFINALS=1
fi

echo echo "#!/bin/sh
# generated by \`autoterm.sh\`
export ICLTERM=$ICLTERM
export ICLFINALS=$ICLFINALS" > config.sh

git add config.sh
git commit -m "Run autoterm for $TS"
git push origin main
