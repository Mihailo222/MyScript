#arrays and arraylists

#arrays
$myArray=@()
$myArray.GetType()

$array2=@("server1","server2","server3")
$array2.Length
$array2.Count
$array2[1]
$array2[3]
#add and remove element from the array
$array2+="server4" 
$array2=$array2 -ne "server3"

#arraylist
$arrayList=[System.Collections.ArrayList]@()
$myList = New-Object -TypeName System.Collections.ArrayList
$myList.GetType()
$myList.IsFixedSize

$myList.Add("item1")
$myList.RemoveAt(0)
$myList.AddRange(@("e1","e2"))
$myList



#hash tables
$myHashTable=@{ #with keys and values
    key1=100
    apple=2.4
    key3=$true
}
#redosled elemenata u hash tabeli stalnose menja 

$myHashTable.GetType()
$myHashTable.Keys
$myHashTable.Values

$myHashTable.ContainsKey('key1')
$myHashTable.ContainsValue(2.4)

$myHashTable.Add('key5','New item')
$myHashTable['key6']='New key added 6th time.'



#custom objects

$employee1 = New-Object -TypeName PSCustomObject 
$employee1.GetType()

Add-Member -InputObject $Employee1 -MemberType NoteProperty -Name 'EmployeeID' -Value '1001' 
Add-Member -InputObject $employee1 -MemberType NoteProperty -Name 'FirstName' -Value 'Annah'
Add-Member -InputObject $employee1 -MemberType NoteProperty -Name 'Surname' -Value 'Melton'

$employee1 | Get-Member #get fields

#cast hash table into an object: keys->properties, values->values
$employee2 = [PSCustomObject]@{
    EmployeeID = '1001'
    FirstName = 'Penny'
    LastName = 'Milton'
}

$employee2

#pipeline

Get-Service -Name Spooler
