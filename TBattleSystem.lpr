program TBattleSystem;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  uCharacter in 'uCharacter.pas',
  uDice in 'uDice.pas',
  uDepletablePoints in 'uDepletablePoints.pas',
  uRenormalizablePoints in 'uRenormalizablePoints.pas',
  uMoneyHolder in 'uMoneyHolder.pas',
  uStatus in 'uStatus.pas',
  uInventoryType in 'uInventoryType.pas',
  uArmour in 'uArmour.pas',
  uWeapon in 'uWeapon.pas',
  uInventoryList in 'uInventoryList.pas',
  uItemLib in 'uItemLib.pas',
  uPCharacter in 'uPCharacter.pas',
  uAttribs in 'uAttribs.pas',
  strutils,
  fgl;

var
  x: Integer;
  a: TFPGObjectList<TPCharacter>;
  d: TPCharacter;
  b: array[0..99999] of TWeapon;
  c: array[0..99999] of TArmour;
  i: Integer;
  attacker: TPCharacter;
  defender: TPCharacter;
  ItemLibrary: TItemLibrary;
  StartDate: TDateTime;
begin
  try
    ItemLibrary:=TItemLibrary.Create;
    for x := 0 to 5 do
    begin
      b[x]:=TWeapon.Create(5,1,8,0,TDamageTypes.Slash,'Long Sword', 40);
    end;
    for x := 0 to 5 do
    begin
      c[x]:=ItemLibrary.NewArmor(TArmorType.Leather);
    end;
    a:=TFPGObjectList<TPCharacter>.Create(true);
    for x := 0 to 5 do
    begin
      a.Add(TPCharacter.Create(TRace(x),TClasse(x),b[x],c[x],10,'Player ' + IntToStr(x)));
      Writeln('THACO : ' + IntToStr(a[x].THACO));
      Writeln('AC : ' + IntToStr(a[x].GetAC));
      Writeln('Race : ' + a[x].RaceName);
      Writeln('Class : ' + a[x].ClassName);
      Writeln('HP : ' + a[x].HP);
      //Writeln('STR : ' + a[x].);
    end;
    StartDate:=Now;
    repeat
     begin
      Randomize;
      WriteLn('Players left ' + InttoStr(a.count));
      attacker:=a.Items[random(a.Count - 1)];
      defender:=a.Items[random(a.Count - 1)];
      if attacker <> defender then
      begin
        Writeln('Attacker ' + attacker.Name + ' is attacking to ' + defender.Name);
        if attacker.Attack(defender) then
        begin
          Writeln('HIT! - THACO ' + IntToStr(attacker.THACO) + ' - ' + ' Defender AC ' + IntToStr(defender.GetAC) + ' = ' +  IntToStr((attacker.THACO - defender.GetAC)) + '. ' + ' Attacker rolls ' + IntToStr(attacker.LastRoll));
          Writeln('Attacker ' + attacker.Name + ' does ' + IntToStr(attacker.LastAttack) + ' damage points.' );
          Writeln('Defender has ' + defender.HP + ' HP ' );
          if not defender.AMAlive then
          begin
            Writeln('Defender has died');
            a.Remove(defender);
          end;
        end
        else Writeln('Attacker fails to hit...  THACO ' + IntToStr(attacker.THACO) + ' - ' + ' Defender AC ' + IntToStr(defender.GetAC) + ' = ' +  IntToStr((attacker.THACO - defender.GetAC)) + '. ' + ' Attacker rolls ' + IntToStr(attacker.LastRoll));
      end;
    end;
    until a.Count <= 1 ;
    writeln(a.Last.Name + ' WIN');
    writeln('Time elapsed : ' +  DateTimeToStr(Now - StartDate));
    readln;
    { TODO -oUser -cConsole Main : Insert code here }
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
