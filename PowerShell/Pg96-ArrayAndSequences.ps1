# Collecting pipeline output as an array
$a = 1,2,3;
write-output $a.GetType().FullName
write-output ""

# Array indexing
write-output $a.length
write-output $a[0]
