architecture x of myEntity is
begin 
  a <= mySignal (7 downto 0);
  b <= mySignal (1 to 2);
  c <= mySignal (x'range);
end;
