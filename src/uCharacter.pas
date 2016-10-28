{/***************************************************************************
                          uCharacter.pas  -  description
                             -------------------
    begin                : Wed Jan 28 2014
    copyright            : (C) 2014 by Enrique Fuentes
    email                : deejaykike@gmail.com
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/
 }

//Unit for declaration of base character class.

unit uCharacter;

interface

uses
  uDepletablePoints,
  uArmour,
  uWeapon,
  uInventoryType,
  uDice,
  SysUtils,
  uStatus;

type

TCharacterType = (Fighter = 0, Paladin, Ranger, Mage, Cleric, Druid, Thief, Bard);
TRaceType = (Human = 0, Dwarf, Elf, HalfElf, Halfling, Gnome);

//Class base for character. All characters or monster need to derived of this class. Encapsulates all methods of character control.
TCharacter = class(TObject)
  protected
    //Name of character.
    fname: string;
    //To hit armor class 0.
    pTHACO: Integer;
    //Health points.
    pHP: TDepletablePoints;
    //Equipped weapon.
    pWeapon: TWeapon;
    //Equipped armor.
    pArmour: TArmour;
    //Character status.
    pStatus: TStatus;
    //Last attack points.
    pLastAttack: Integer;
    //Last roll.
    fLastRoll: Integer;
    //Last lost health points.
    fLastLostHP: Integer;
    //pBackpack: TInventoryList;
    //Method to know THAC0.
    function GetTHACO : Integer; virtual;
    //Is player alive?
    function Alive: Boolean;
    //Method to get HP.
    function GetHP: string;
  public
    //Get To hit armor class 0.
    property THACO: Integer read GetTHACO;
    //Get i am alive?.
    property AMAlive: Boolean read Alive;
    //Get Name.
    property Name: string read fname;
    //Get health points.
    property HP: string read GetHP;
    //Get last attack.
    property LastAttack: Integer read pLastAttack;
    //Get last roll.
    property LastRoll: Integer read fLastRoll;
    //Get last HP Lost.
    property LastLostHP: Integer read fLastRoll;
    //Constructor weapon & armour. Needs to be overrided.
    constructor Create(initialWeapon: TWeapon; initialArmour: TArmour; Name: string);
    //Destructor.
    destructor Destroy;
    //Attack to another character. If character is hit then do damage.
    function attackRoll(const Target: TCharacter): Boolean;
    //Do damage to another character.
    function doDamage(const Target: TCharacter): Integer; virtual;
    //Get Armor Class.
    function GetAC: Integer; overload; virtual;
    //Get Damage type Armor Class.
    function GetAC(const DamageType: Integer): Integer; overload; virtual;
    //Lose Heal Points.
    function LoseHP(const Amount: Integer): Integer;
    //Attack to another character. If character is hit then do damage
    function Attack(Target: TCharacter): Boolean;
    //Roll initative points.
    function RollInitiative: Integer;
    //Equip an Item.
    procedure Equip(Item: TInventoryItem);
end;

implementation

//THACO Tables.
const
  THACOTABLE: array [0..3, 0..19] of Integer = ((20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,2),
                                                (20,20,20,18,18,16,16,16,14,14,14,12,12,12,10,10,10,8,8,8),
                                                (20,20,19,19,18,18,17,17,16,16,15,15,14,14,13,13,12,12,11,11),
                                                (20,20,20,19,19,19,18,18,18,17,17,17,16,16,16,15,15,15,14,14));

constructor TCharacter.Create(initialWeapon: TWeapon; initialArmour: TArmour; Name: string);
begin
  inherited Create;
  fname:=Name;
  pStatus:=TStatus.Create(VALID);
  Randomize;
  pHP:=TDepletablePoints.Create(20);
  pTHACO:=20;
  pWeapon:=initialWeapon;
  pArmour:=initialArmour;
end;

destructor TCharacter.Destroy;
begin
  pWeapon:=nil;
  pArmour:=nil;
  inherited;
end;

function TCharacter.Attack(Target: TCharacter): Boolean;
begin
  if attackRoll(Target) then
  begin
    pLastAttack:=doDamage(Target);
    Result:=True;
  end;
end;

function TCharacter.attackRoll(const Target: TCharacter): Boolean;
var
  tohit, roll: Integer;
begin
  tohit:=GetTHACO - Target.GetAC(Integer(pWeapon.DT));
  roll:=TDice.Dice(1,20,0);
  fLastRoll:=roll;
  if roll = 20 then Result:=True
  else if roll = 1 then Result:=False
  else Result:=(roll > tohit);
end;

function TCharacter.doDamage(const Target: TCharacter): Integer;
var
  Damage: Integer;
begin
  Damage:=pWeapon.returnDamage;
  Target.LoseHP(Damage);
  Result:=Damage;
end;

function TCharacter.LoseHP(const Amount: Integer): Integer;
begin
  pHP.Decr(Amount);
  if not pHP.IsPositive then
  begin
    pStatus.clearFlag(TStatusTypes.VALID);
    pStatus.setFlag(TStatusTypes.UNCONSCIOUS);
  end;
  if pHP.Current <= -10 then
  begin
    pStatus.clearFlag(TStatusTypes.Valid);
    pStatus.setFlag(TStatusTypes.Dead);
  end;
  Result:=pHP.Current;
end;

function TCharacter.GetTHACO;
begin
  Result:=pTHACO + pWeapon.getPluses;
end;

function TCharacter.Alive: Boolean;
begin
  Result:=pStatus.checkFlah(TStatusTypes.VALID) or pStatus.checkFlah(TStatusTypes.UNCONSCIOUS);
end;

function TCharacter.GetAC(const DamageType: Integer): Integer;
begin
  Result:=pArmour.getAC(TDamageTypes(DamageType));
end;

function TCharacter.GetAC: Integer;
begin
  Result:=pArmour.getAC;
end;

function TCharacter.RollInitiative: Integer;
begin
  Result:=TDice.Dice(1,10,0) + pWeapon.Speed;
end;

procedure TCharacter.Equip(Item: TInventoryItem);
begin
  if Item.isEquippable then
  begin
     if Item is TArmour then pArmour:=Item as TArmour
     else if Item is TWeapon then pWeapon:=item as TWeapon;
  end;
end;

function TCharacter.GetHP: string;
begin
  Result:=inttostr(pHP.Current);

end;

end.
