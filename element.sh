#Periodic Table Database Script

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
MAIN_MENU(){
  NUMBER_SEARCH_RESULT=$($PSQL "SELECT * FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE atomic_number='$1'" 2>/dev/null)
  SYMBOL_SEARCH_RESULT=$($PSQL "SELECT * FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE symbol = '$1'" 2>/dev/null)
  NAME_SEARCH_RESULT=$($PSQL "SELECT * FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE name = '$1'" 2>/dev/null)
  
  if [[ -z $NUMBER_SEARCH_RESULT ]]
  then
    if [[ -z $SYMBOL_SEARCH_RESULT ]]
    then
      if [[ -z $NAME_SEARCH_RESULT ]]
      then
        echo I could not find that element in the database.
      else
        echo $NAME_SEARCH_RESULT | while IFS='|' read TYPE_ID  ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE
        do
          echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
        done
      fi
    else
      echo $SYMBOL_SEARCH_RESULT | while IFS='|' read TYPE_ID  ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE
      do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      done
    fi
  else
    echo $NUMBER_SEARCH_RESULT | while IFS='|' read TYPE_ID  ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE
    do
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    done
  fi
}

if [[ $1 ]]
then 
  MAIN_MENU $1
else
  echo Please provide an element as an argument.
fi