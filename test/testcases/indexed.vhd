architecture x of myEntity is
begin 
  a <= mySignal (0);
  b <= mySignal (1,2);
  c <= mySignal (to_integer(unsigned(x)));
end;
