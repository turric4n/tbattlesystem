program TBattleSystem;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  //Main library units
  uCharacter,
  uDice,
  uDepletablePoints,
  uRenormalizablePoints,
  uMoneyHolder,
  uStatus,
  uInventoryType,
  uArmour,
  uWeapon,
  uInventoryList,
  uItemLib,
  uPCharacter,
  uAttribs,
  strutils,
  //FPC Generic List unit (optional for the example)
  fgl;

const
  SOLDIER_COUNT = 4;

var
  x: Integer;
  //List of Characters
  charlist: TFPGObjectList<TPCharacter>;
  //List of Weapons
  weaponlist: TFPGObjectList<TWeapon>;
  //List of Armours
  armourlist: TFPGObjectList<TArmour>;
  //Temp Object references
  attacker: TPCharacter;
  defender: TPCharacter;
  //Item Database
  ItemLibrary: TItemLibrary;
  StartDate: TDateTime;
begin
  try
    //Runtime list construction
    weaponlist:=TFPGObjectList<TWeapon>.Create;
    armourlist:=TFPGObjectList<TArmour>.Create;
    charlist:=TFPGObjectList<TPCharacter>.Create(true);
    ItemLibrary:=TItemLibrary.Create;
    //Character creation
    for x := 0 to SOLDIER_COUNT - 1 do
    begin
      //Create human fighters only :) bare hand and without armor
      WriteLn('Invoking Soldier');
      charlist.Add(TPCharacter.Create(TRace.Human,TClasse.Fighter,TWeapon.Create,TArmour.Create, 5, 'Soldier ' + IntToStr(x)));
      WriteLn('Soldier invocked');
      WriteLn('Soldier Name : ' + charlist[x].Name);
      Writeln('THACO : ' + IntToStr(charlist[x].THACO));
      Writeln('AC : ' + IntToStr(charlist[x].GetAC));
      Writeln('Race : ' + charlist[x].RaceName);
      Writeln('Class : ' + charlist[x].ClassName);
      Writeln('HP : ' + charlist[x].HP);
      Writeln('Equiping soldier');
      //Forge and stack weapons and armors
      weaponlist.Add(TWeapon.Create(5,1,8,0,TDamageTypes.Slash,'Long Sword', 40));
      armourlist.Add(TArmour.Create(ItemLibrary.NewArmor(TArmorType.ChainMail)));
      //Assign weapon and armor to soldier
      charlist[x].Equip(weaponlist[x]);
      //charlist[x].Equip(armourlist[x]);
      Writeln('Soldier');
      Writeln('THACO : ' + IntToStr(charlist[x].THACO));
      Writeln('AC : ' + IntToStr(charlist[x].GetAC));
    end;
    Writeln('Press a key to begin the battle');
    ReadLn;
    StartDate:=Now;
    repeat
     begin
      Randomize;
      WriteLn('Players left ' + InttoStr(charlist.count));
      attacker:=charlist.Items[random(charlist.Count - 1)];
      repeat
        writeln(IntToStr(charlist.Count));
        defender:=charlist.Items[random(charlist.Count - 1)];
      until defender <> attacker;
        Writeln('Attacker ' + attacker.Name + ' is attacking to ' + defender.Name);
        if attacker.Attack(defender) then
        begin
          Writeln('HIT! - THACO ' + IntToStr(attacker.THACO) + ' - ' + ' Defender AC ' + IntToStr(defender.GetAC) + ' = ' +  IntToStr((attacker.THACO - defender.GetAC)) + '. ' + ' Attacker rolls ' + IntToStr(attacker.LastRoll));
          Writeln('Attacker ' + attacker.Name + ' does ' + IntToStr(attacker.LastAttack) + ' damage points.' );
          Writeln('Defender has ' + defender.HP + ' HP ' );
          if not defender.AMAlive then
          begin
            Writeln('Defender has died');
            charlist.Remove(defender);
          end;
        end
        else Writeln('Attacker fails to hit...  THACO ' + IntToStr(attacker.THACO) + ' - ' + ' Defender AC ' + IntToStr(defender.GetAC) + ' = ' +  IntToStr((attacker.THACO - defender.GetAC)) + '. ' + ' Attacker rolls ' + IntToStr(attacker.LastRoll));
    end;
    sleep(50);
    until charlist.Count <= 1 ;
    writeln(charlist.Last.Name + ' WIN');
    writeln('Time elapsed : ' +  DateTimeToStr(Now - StartDate));
    readln;
    { TODO -oUser -cConsole Main : Insert code here }
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
