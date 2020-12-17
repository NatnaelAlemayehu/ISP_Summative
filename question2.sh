#! /usr/bin/bash
ADRESS_BOOK="Adressbook.txt";


# the main function will hadnle the user input logic and display the main menu
function main() {  
  printf "Welcome to address book. \n"
  printf "Chose 1 of the 4 operations:\n"
  printf "A) Search a record\n"
  printf "B) Add a record\n"
  printf "C) Remove a record\n"
  printf "D) Edit a record\n"
  printf "0) Exit\n"

  # calling addressBook Function to create the record directory.
  createAddressBook

  read -p "Type in your choice A/B/C/D  " user_selection

  printf "$user_selection \n"
  if [ "$user_selection" == "A" ]
  then
    printf "Type in the any part of the person name you want to search with:\n"
    read -r search_item
    searchRecord $search_item
    main
  elif [ "$user_selection" == "B" ]
  then
      printf "Input full name of the person:\n"
      read -r name
      printf "Input cellphone number:\n"
      read -r phone_number
      printf "Input email address:\n"
      read -r email_address
      printf "Are you sure you want to save this record (Y/N)?"
      read -r choice
      #accpet user inputs and check the choice of the user to proceeed or not
      if [ "$choice" == "Y" ]
      then
        #passing the necessay arguments to the addEntry function so an entry is created.
        addEntry $name $phone_number $email_address
        main
      else
        main
      fi
  elif [ "$user_selection" == "C" ]
  then
      printf "\nInput the name or phone number or email address to delete:\n"      
      read -r input_value
      removeRecord $input_value
      main   
  elif [ "$user_selection" == "D" ]
  then
      printf "Type in the name or phone number or email address to modify \n"
      read -r input_value     
      editRecord $input_value
      main
  elif [[ $user_selection == "0" ]]; then
    exit
  else:
    printf "Invalid choice"
    main
  fi
}

function createAddressBook() { 
  # checking if file exist in the directory using '-e'
  if [ -e "$ADRESS_BOOK" ]
  then
    :
  else
  # creating the file if it doesn't exist
    touch $ADRESS_BOOK
    # inserting header data to file
    echo "ID    Name                  Number             Email Address" >> $ADRESS_BOOK  
  fi
}


function addEntry() {
    # get the count of the lines in the file by using wc - l command
    entry_id=$(cat $ADRESS_BOOK | wc -l)       
    printf "$entry_id.     $1                  $2             $3\n" >> $ADRESS_BOOK
}

function searchRecord(){
  #display the header items (columns) of the first row
  head -n 1 $ADRESS_BOOK
  #display the results if grep search 
  grep $1 $ADRESS_BOOK
  printf "\n"
}

function removeRecord(){  
  n=$(grep $1 $ADRESS_BOOK | wc -l)
  head -n 1 $ADRESS_BOOK
  grep $1 $ADRESS_BOOK
  printf "Type in ID number of record to delete:\n"
  read -r ID  
  #sed commnad deletes or modifies a record and here it is deleting the recrod line that has $ID as its ID value
  sed -i "/^$ID./d" $ADRESS_BOOK   
}

function editRecord(){
  grep $1 $ADRESS_BOOK
  printf "Type in ID number of record to edit :\n"
  read -r ID 
  printf "What do you want to replace the item with :\n"
  read -r replacement  
  increment="1"  
  new_count=$(( ID + increment))
  #sed command goes to line $new_count and replaces the argument passed to edit Record function and replaces it 
  # with $replacement  
  sed -i "$new_count s/$1/$replacement/" $ADRESS_BOOK  
}

main
