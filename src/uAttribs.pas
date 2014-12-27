unit uAttribs;

interface

uses
  uRenormalizablePoints;

type
  TCharismaAttrib = class(TRenormalizablePoints)
    public
      constructor Create(Value: Integer);
      function chaNoHench: Integer;
      function chaLoyBase: Integer;
      function chaReacAdj: Integer;
  end;

  TConstitutionAttrib = class(TRenormalizablePoints)
    public
      constructor Create(Value: Integer);
      function conHPAdj: Integer;
      function conSysShock: Integer;
      function conResSurv: Integer;
      function conPoiSaveMod: Integer;
  end;

  TDexterityAttrib = class(TRenormalizablePoints)
    public
      constructor Create(Value: Integer);
      function dexACMod: Integer;
      function dexMissileMod: Integer;
  end;

  TIntelligenceAttrib = class(TRenormalizablePoints)
    public
      constructor Create(Value: Integer);
      function intNoLang: Integer;
      function intSpLev: Integer;
      function intSpCha: Integer;
      function intMaxSp: Integer;
  end;

  TStrengthAttrib = class(TRenormalizablePoints)
    public
      constructor Create(Value: Integer);
      function getHitAdj: Integer;
      function getDamAdj: Integer;
      function getWeight: Integer;
  end;

  TWisdomAttrib = class(TRenormalizablePoints)
    public
      constructor Create(Value: Integer);
      function wisMagDefAdj: Integer;
      function wisBonusSpells: Integer;
      function wisSpFail: Integer;
  end;

implementation

constructor TCharismaAttrib.Create(Value: Integer);
begin
  inherited Create(value);
end;

function TCharismaAttrib.chaNoHench: Integer;
const
  noHench: array [0..25] of integer  = (0, 0, 1, 1, 1, 2, 2, 3, 3, 4, 4, 4,
			   5, 5, 6, 7, 8, 10, 15, 20, 25, 30, 35,
			   40, 45, 50);
begin
  Result:=noHench[Current];
end;

function TCharismaAttrib.chaLoyBase: Integer;
const
  loyBase: array [0..25] of integer = (-8, -8, -7, -6, -5, -4, -3, -2, -1, 0, 0, 0, 0,
			   0, 1, 3, 4, 6, 8, 10, 12, 14, 16, 18, 20,
			   20);
begin
  Result:=loyBase[current];
end;

function TCharismaAttrib.chaReacAdj: Integer;
const
  reacAdj: array [0..25] of Integer = (-7, -7, -6, -5, -4, -3, -2, -1, 0, 0, 0, 0,
			   0, 1, 2, 3, 5, 6, 7, 8, 9,
			   10, 11, 12, 13, 14);
begin
  Result:=reacAdj[current];
end;

constructor TConstitutionAttrib.Create(Value: Integer);
begin
  inherited Create(value);
end;

function TConstitutionAttrib.conHPAdj: Integer;
const
  HPAdj: array [0..19] of Integer = (0, -3, -2, -2, -1, -1, -1,
		   0, 0, 0, 0, 0, 0, 0, 0,
		   1, 2, 2, 2, 2);
begin
  Result:=HPAdj[Current];
end;

function TConstitutionAttrib.conSysShock: Integer;
var
  temp: Integer;
begin
  temp:=20;
  if Current <= 16 then Inc(temp, current * 5)
  else
    if Current = 17 then temp:=97
    else if current <= 24 then temp:=99
      else temp:=100;
  Result:=temp;
end;

function TConstitutionAttrib.conResSurv: Integer;
var
  temp: Integer;
begin
  temp:=25;
  if Current <= 25 then Inc(temp, current * 5)
  else if current >= 18 then temp:=100
    else temp:=90 + (Current - 13) * 2;
  Result:=temp;
end;

function TConstitutionAttrib.conPoiSaveMod: Integer;
begin
  if (Current >= 3) or (Current <= 18) then Result:=0
	else if (current <= 1) then Result:= -2
	else if (current = 2) then Result:= -1
	else if ((current = 19) or (current = 20)) then Result:= 1
	else if ((current = 21) or (current = 22)) then Result:= 2
	else if ((current = 23) or (current = 23)) then Result:= 3
	else if (current >= 24) then Result:= 4
  else Result:=0;
end;

constructor TDexterityAttrib.Create(Value: Integer);
begin
  inherited Create(value);
end;

function TDexterityAttrib.dexACMod: Integer;
const
  ACMod: array [0..19] of integer = (5, 5, 5, 4, 3, 2, 1, 0, 0,
			   0, 0, 0, 0, 0, 0, -1, -2,
			   -3, -4, -4);
begin
  Result:=ACMod[Current];
end;

function TDexterityAttrib.dexMissileMod: Integer;
const
  MissileMod: array [0..26] of Integer = (-6, -6, -4, -3, -2, -1, 0,
				     0, 0, 0, 0, 0, 0, 0, 0, 0,
				     0, 1, 2, 2, 3, 3, 4, 4, 4,
				     5, 5);
begin
  Result:=MissileMod[current];
end;

constructor TIntelligenceAttrib.Create(Value: Integer);
begin
  inherited Create(Value);
end;

function TIntelligenceAttrib.intNoLang: Integer;
const
  noLang: array [0..25] of Integer = (0, 0, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2,
			  3, 3, 4, 4, 5, 6, 7, 8, 9, 10, 11,
			  12, 15, 20);
begin
  Result:=noLang[current];
end;

function TIntelligenceAttrib.intSpLev: Integer;
const
  spLev: array [0..25] of Integer = (0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 5, 5, 6,
			 6, 7, 7, 8, 8, 9, 9, 9, 9, 9, 9, 9,
			 9);
begin
  Result:=spLev[current];
end;

function TIntelligenceAttrib.intSpCha: Integer;
const
  spCha: array [0..25] of Integer = (0, 0, 0, 0, 0, 0, 0, 0, 0, 35, 40, 45,
			 50, 55, 60, 65, 70, 75, 85, 95, 96,
			 97, 98, 99, 100, 100);
begin
  Result:=spCha[current];
end;

function TIntelligenceAttrib.intMaxSp: Integer;
const
  maxSP: array [0..25] of Integer = (0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 7, 7, 7,
			 9, 9, 11, 11, 14, 18, 999, 999, 999,
			 999, 999, 999, 99);
begin
  Result:=maxSp[current];
end;

constructor TStrengthAttrib.Create(Value: Integer);
begin
  inherited Create(Value);
end;

function TStrengthAttrib.getHitAdj: Integer;
const
  HitAdj: array [0..18] of Integer = (-3, -3, -3, -3, -2, -2, -1, -1,
			    0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1);
begin
  Result:=HitAdj[Current];
end;

function TStrengthAttrib.getDamAdj: Integer;
const
  DamAdj: array [0..18] of Integer = (-1, -1, -1, -1, -1, -1, -1, -1,
			   0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2);
begin
  Result:=DamAdj[current];
end;

function TStrengthAttrib.getWeight: Integer;
var
  temp: Integer;
begin
  temp:=200;
  case Current of
    1: temp:=1;
    2: temp:=1;
    3: temp:=5;
    4: temp:=10;
    5: temp:=10;
    6: temp:=20;
    7: temp:=20;
    8: temp:=35;
    9: temp:=35;
    10: temp:=40;
    11: temp:=40;
    12: temp:=45;
    13: temp:=45;
    14: temp:=55;
    15: temp:=55;
    16: temp:=70;
    17: temp:=85;
    18: temp:=110;
    19: temp:=485;
    20: temp:=535;
  end;
end;

constructor TWisdomAttrib.Create(Value: Integer);
begin
  inherited Create(Value);
end;

function TWisdomAttrib.wisMagDefAdj: Integer;
const
  magDefAdj: array [0..25] of Integer = (-6, -6, -4, -3, -2, -1, -1, -1, 0, 0, 0, 0,
			     0, 0, 0, 1, 2, 3, 4, 4, 4, 4, 4,
			     4, 4, 4);
begin
  Result:=magDefAdj[current];
end;

function TWisdomAttrib.wisBonusSpells: Integer;
const
  bonusSpells: array [0..25] of Integer = (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			       1, 1, 2, 2, 3, 4, 13, 24, 35, 45, 16, 56,
			       67);
begin
  Result:=bonusSpells[Current];
end;

function TWisdomAttrib.wisSpFail: Integer;
const
  spFail: array [0..25] of Integer = (80, 80, 60, 50, 45, 40, 35, 30, 25, 20, 15, 10,
			  5, 0, 0, 0, 0, 0, 0, 0, 0,
			  0, 0, 0, 0, 0);
begin
  Result:=spFail[Current];
end;

end.
