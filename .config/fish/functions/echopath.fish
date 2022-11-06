function echopath -d "echo list of PATH"
  echo $PATH | sed 's/ /\n/g'
end
