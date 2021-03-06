# Define a Hashtable
$foo = @{
    a = 1
    b = 2
    c = 3
    };

# Brows type infomation and detail.
write-output "$foo";
write-output $foo;
write-output ""

# From Pg95:
#   Now assign $foo to $bar and verify that it matches $foo as we expect.
$bar = $foo
write-output "$bar"
write-output $bar
write-output ""

# compare property
write-output $bar.a;
write-output $foo.a;
write-output "$($foo.a.equals($bar.a))"; # use object.equals()
write-output ""

# compare property after change
$bar.a = "Hi, there"
write-output $bar.a;
write-output $foo.a;
write-output "$($foo.a.equals($bar.a))"; # use object.equals()
write-output ""
