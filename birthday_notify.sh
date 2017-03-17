#!/bin/bash
#project by Mohammad Kabajah & Maha Najee 
#All Rights Reserved

while true

do


tillm=$(date -v +1w +"%B") #month after 2 week
tilld=$(date -v +1w +"%d") #day after 2 week

nowm=$(date +"%B") #the month 
nowd=$(date +"%d") #the day
year=$(date +"%Y") #the year 
FileName='birthdaylist.txt'
if [ -e birthdays.txt ] 
then
rm birthdays.txt
fi
touch birthdays.txt
echo `date` >> birthdays.txt
echo >>  birthdays.txt
echo " *************the last update to my friends birtday************ " >> birthdays.txt
if [ -e emails.txt ]
then
rm emails.txt 
fi
touch emails.txt
while read LINE
do
m=$(echo $LINE| cut -f4 -d ' ' )
d=$(echo $LINE|cut -f5 -d ' '| tr -d ',')
name=$(echo $LINE|cut -f1 -d' ' )
family=$(echo $LINE | cut -f2 -d' ')
yob=$(echo $LINE|cut -f6 -d ' ')
email=$(echo $LINE|cut -f3 -d ' ')

if [ $m == $tillm  ] 
then
if [ $d -le $tilld ] #1
then
dif=$(($d-$nowd))
yrdif=$(($year-$yob))
if [ $dif -ge 0 ]
then 
echo " "$dif" remaining to "$name $family"'s birthday he will be " $yrdif "years old :)" >> birthdays.txt |sed 'N;s/\n/. /'
while read LINE
do 
email1=$(echo $LINE|cut -f3 -d ' ')
if [ $email != $email1 ]
then
echo " "$dif" day  remaining to "$name $family"'s birthday he will be " $yrdif "years old :)"| mail -s "happy birthday" "$email"
fi
done < birthdaylist.txt
fi 

echo $name $family $email >> emails.txt
fi #1
if [ $d -eq $nowd ] #2
then
echo "Happy Birthday to "$name $family "today is his/ her birthday " >> birthdays.txt |sed 'N;s/\n/. /'
echo "Happy Birthday to you "$name $family " wish u all the best " | mail -s "happy birthday" "$email"
fi #2
fi

done < $FileName
if [ ! -s birthdays.txt ]
then
echo "Nothing to Remind" > birthdays.txt
fi

sed = birthdays.txt |sed 'N;s/\n/. /' > b1.txt
mv b1.txt birthdays.txt

while true 
do 
hour=$(date +"%H")
min=$(date +"%M")
if test $hour -eq 00 -a $min = 00
then 
break;
else 
    sleep 60
fi
done 


done

