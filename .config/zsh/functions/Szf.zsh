if [[ -e $ZDOTDIR/functions.sh ]] && [[ -e $ZDOTDIR/functions ]]
then
  Szf ()
  {
    SOURCE_RCFILE $ZDOTDIR/functions.sh
    for f in $ZDOTDIR/functions/*
    do
      SOURCE_RCFILE $f
    done
  }
fi