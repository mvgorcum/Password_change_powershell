$passwordarray = foreach($i in 1..25) {'t3mpp4ss'+$i}
$secretoldpass = Read-Host -assecurestring -Prompt 'Input your password'
$oldpass = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($secretoldpass))
$NTURI = 'WinNT://'+$env:UserDomain+'/'+$env:UserName+',user'
([adsi]$NTURI).ChangePassword($oldpass,$passwordarray[0])
if ($?) {
               echo "your password is now:"
               echo $passwordarray[0]
               for ($i=1;$i -lt $passwordarray.length;$i++) {
                              ([adsi]$NTURI).ChangePassword($passwordarray[$i-1],$passwordarray[$i])
                              if ($?) {
                                            echo "your password is now:"
                                            echo $passwordarray[$i]
                              }
                              else {
                                            echo "something went wrong, your current password is printed above, please rerun the script with that password, and manually change it afterwards"
                                            break
                              }
               }
               ([adsi]$NTURI).ChangePassword($passwordarray[-1],$oldpass)
               if ($?) {
                                            echo "Your password has now been changed 24 times, and is set back to the original password"
                              }
                              else {
                                            echo "Something went wrong while trying to set the old password back, policy may have changed. Your current password is printed above, feel free to try setting any password now."
                              }
}
else {echo "wrong username and/or password, try again"}