#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"
echo -e "\n~~~~~ MY SALON ~~~~~\n"
MAIN_MENU(){
  if [[ $1 ]]
  then
  echo -e "\n$1"
  fi
  echo -e "\n Hello, How may I help you today ?"
  echo -e "\n1) Haircut and Styling \n2) Hairdye and Highlights \n3) Tanning \n4) Manicures and Pedicures \n5) Facials"
  read SERVICE_ID_SELECTED
  case $SERVICE_ID_SELECTED in
  1) BOOK_SERVICE "1" ;;
  2) BOOK_SERVICE "2" ;;
  3) BOOK_SERVICE "3" ;;
  4) BOOK_SERVICE "4" ;;
  5) BOOK_SERVICE "5" ;;
  *) MAIN_MENU "Please enter a available service" ;;
  esac
}
BOOK_SERVICE(){
  SERVICE_ID_SELECTED=$(echo $1)
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
  echo -e "\nWhat's your phone no:"
  read CUSTOMER_PHONE
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE';")
  if [[ -z $CUSTOMER_NAME ]]
  then
  #insert customer's name
  echo -e "\nWhat's your name?"
  read CUSTOMER_NAME
  INSERT_NAME=$($PSQL "INSERT INTO customers(phone,name) VALUES('$CUSTOMER_PHONE','$CUSTOMER_NAME')")
  fi
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE';")
  echo -e "\nAt what time , would you like your haircut and styling ,$CUSTOMER_NAME"
  read SERVICE_TIME
  INSERT_APP=$($PSQL "INSERT INTO appointments(customer_id,service_id,time) VALUES($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME');")
  echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."

}
MAIN_MENU