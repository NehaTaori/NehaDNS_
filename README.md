# DNS-resolver

### A CLI Ruby program which does domain name resolution and prints the lookup chain, until it resolves to an IPv4 address.

_[learn more about DNS & zone files ](http://www.marinamele.com/2014/06/understand-the-dns-zone-and-the-canonical-name-cname.html)_

> ![demo](https://user-images.githubusercontent.com/56788911/119274349-12ce6b00-bc2d-11eb-9522-65dd178f54e8.png)

### Sample Input zone file

`RECORD TYPE`, `SOURCE`, `DESTINATION`  
A, ruby-lang.org, 221.186.184.75  
A, google.com, 172.217.163.46

CNAME, www.ruby-lang.org, ruby-lang.org  
CNAME, mail.google.com, google.com  
CNAME, gmail.com, mail.google.com

### Output

`$ ruby lookup.rb google.com`  
google.com => 172.217.163.46

`$ ruby lookup.rb gmail.com`  
gmail.com => mail.google.com => google.com => 172.217.163.46

`$ ruby lookup.rb gmil.com`  
gmil.com => Error: record not found for gmil.com
