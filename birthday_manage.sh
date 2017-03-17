#!/bin/ksh

amenu () {

clear
echo `date`
echo
echo "                  * Birthday management utility *      "
echo "                 ----------------------------------    "
echo 
echo
echo "    1. Add a friend to the list "
echo "    2. Remove a friend from the list "
echo "    3. Edit a friend "
echo "    4. Total number of friend in the list "
echo "    5. List of all entries "
echo "    6. Show all friends born in a particular year"
echo "    7. Show all friends born in a particular month "
echo "    8. Show all friends with in a particular first name"
echo "    9. Show all friends with in a particular family name "
echo "    10. Exit "

echo Select by pressing a number and then ENTER ;
echo 
echo "  	Your Choice->"

} 

PressEnter () {
echo Press Enter
read x
}


AddFriend () {
clear
echo please enter the data as the following 
echo
echo
echo " firstName FamilyNme    Email   birthdate(ex: December 4, 1991) "
read input
echo "$input" >> birthdaylist.txt
PressEnter
}

RemoveFreind () {
var=1

if [ -e birthdaylist.txt ]
then 
clear 
echo
echo "                  * Remove a Friend From The List*      "
echo "                 -----------------------------------    "
echo 
echo
sed = birthdaylist.txt | sed 's/ /  -  /3'|sed 's/ /  -  /2'|sed 'N;s/\n/. /'
input1=$(grep -c . birthdaylist.txt)
input2=$(($input1+ $var))
echo  $input2". Return to previous menu "
echo Select by pressing a number and then ENTER ;
echo 
echo "  	Your Choice->"

read choice
if test $choice -lt $input2 
then 
sed  "${choice} d"  birthdaylist.txt >k.txt | mv k.txt birthdaylist.txt 
fi
elif test $choice -eq $input2 
then 
PressEnter

else 
clear
echo "you type a invalid number please try again"
echo 
echo
RemoveFreind
fi


PressEnter
}

EditFriend () {
var=1
filename=birthdaylist.txt
if [ -e birthdaylist.txt ]
then 
clear 
echo
echo "                    *Edit a Friend From The List*      "
echo "                 -----------------------------------    "
echo 
echo
sed = birthdaylist.txt | sed 's/ /  -  /3'|sed 's/ /  -  /2'|sed 'N;s/\n/. /'
input1=$(grep -c . birthdaylist.txt)
input2=$(($input1+ $var))
echo  $input2". Return to previous menu "
echo Select by pressing a number and then ENTER ;
echo 
echo "  	Your Choice->"

read choice
if test $choice -lt $input2 
then 
clear
echo
echo " the chosen line to edit has the following data "
echo
sed -n "${choice} p" birthdaylist.txt

echo
echo
echo "start enter the data as the form in the upper form "
echo
echo
read line
echo  "$line" >> birthdaylist.txt
sed  "${choice} d"  birthdaylist.txt >k.txt | mv k.txt birthdaylist.txt
fi

elif test $choice -eq $input2 
then 
PressEnter

else 
clear
echo "you type a invalid number please try again"
EditFriend
echo 
echo

fi


PressEnter
}

Total () {
clear 
echo
echo
echo "the total number of entry in the system is "
echo 
total=$(grep -c . birthdaylist.txt)
echo " ----------->" $total

PressEnter
}

ListEntry () {
clear
echo 
echo "------------------------the list of Entry-----------------------"
echo 
echo
sed = birthdaylist.txt | sed 's/ /  -  /3'|sed 's/ /  -  /2'|sed 'N;s/\n/. /'

PressEnter
}

FrnzParYear () {
clear
if [ ! -f birthdaylist.txt ]
then 
echo
echo "file bithdaylist.txt not exist try when u fix the problem "
PressEnter
fi

echo 
echo 
echo "---------------------find friends born in spescific years-----------------------"
echo "********************************************************************************"
echo "please enter the year -> "
echo
read year

cut -f6 -d ' ' birthdaylist.txt|grep -n "$year" |cut -f1 -d: > temp1.txt

while read line 
 do 
 sed  -n "${line} p" birthdaylist.txt  
 done < temp1.txt


PressEnter
}

FrnzParmonth () {
clear
if [ ! -f birthdaylist.txt ]
then 
echo
echo "file bithdaylist.txt not exist try when u fix the problem "
PressEnter
fi

echo 
echo 
echo "---------------------find friends born in spescific month-----------------------"
echo "********************************************************************************"
echo "please enter the month in this Form (Apr,Feb,......) -> "
echo
read month
cut -f4 -d ' ' birthdaylist.txt > temp1.txt  # take the month string from the date of birth 
cut -c 1-3 < temp1.txt >temp2.txt #this command take the month from file temp1 take the first three letters and store it in temp2
grep -n $month temp2.txt |cut -f1 -d: > temp1.txt #take the number of line that match the condition 


while read line 
 do 
 sed  -n "${line} p" birthdaylist.txt  
 done < temp1.txt

PressEnter
}
FrnzFirstName () {

clear
if [ ! -f birthdaylist.txt ]
then 
echo
echo "file bithdaylist.txt not exist try when u fix the problem "
PressEnter
fi

echo 
echo 
echo "---------------------find friends with the same first name----------------------"
echo "********************************************************************************"
echo "please enter the first name "
echo 
read name
name=$(echo "$name"|tr [a-z] [A-Z] )

cut -f1 -d ' ' birthdaylist.txt > temp1.txt | tr [a-z] [A-Z] < temp1.txt > temp2.txt #cut and convert to upper case 
grep -n $name temp2.txt |cut -f1 -d: > temp1.txt

while read line 
 do 
 sed  -n "${line} p" birthdaylist.txt  
 done < temp1.txt

PressEnter
}



FrnzFamilyName () {

clear
if [ ! -f birthdaylist.txt ]
then 
echo
echo "file bithdaylist.txt not exist try when u fix the problem "
PressEnter
fi

echo 
echo 
echo "---------------------find friends with the same family name---------------------"
echo "********************************************************************************"
echo "please enter the first name "
echo 
read family
family=$(echo "$family"|tr [a-z] [A-Z] )

cut -f2 -d ' ' birthdaylist.txt > temp1.txt | tr [a-z] [A-Z] < temp1.txt > temp2.txt #cut and convert to upper case 
grep -n $family temp2.txt |cut -f1 -d: > temp1.txt

while read line 
 do 
 sed  -n "${line} p" birthdaylist.txt  
 done < temp1.txt

PressEnter
}
Directoryfunctions () {
PressEnter
}


while true
do

amenu

read answer

case $answer in
1) AddFriend ;;
2) RemoveFreind ;;
3) EditFriend ;;
4) Total ;;
5) ListEntry ;;
6) FrnzParYear ;;
7) FrnzParmonth ;;
8) FrnzFirstName ;;
9) FrnzFamilyName ;;


10) break ;;
esac

done
clear
