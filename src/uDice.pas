{/***************************************************************************
                          uDice.pas  -  description
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

//Unit for Dice Operations.
unit uDice;

interface

uses
  SysUtils;

type
//Dice operations class. With static methods for basic random operations.
TDice = class(TObject)
  private
    //Quantity of dices.
    pQuantity: Integer;
    //Quantity of sides.
    pSides: Integer;
    //Modifier to roll.
    pModifier: Integer;
    //Get num of dices.
    function getNumDice: Integer;
    //Set num of dices.
    procedure setNumDice(newNum: Integer);
    //Get sides.
    function getSides: Integer;
    //Set sides.
    procedure setSides(newSides: Integer);
    //Get modification to roll.
    function getMod: Integer;
    //Set modification to roll.
    procedure setMod(newMod: Integer);
  public
    //Create Basic dice.
    constructor Create; overload;
    //Create custom dices with modifications.
    constructor Create(number,polygonNo: Integer; bonus: Integer); overload;
    //Create custom dice.
    constructor Create(polyNo: Integer); overload;
    //Num of dices.
    property NumDice: Integer read getNumDice write setNumDice;
    //Num of sides.
    property Sides: Integer read getSides write setSides;
    //Modifier.
    property Modifier: Integer read getMod write setMod;
    //Method to roll dices. Returns integer.
    function Roll: LongInt;
    //Randomizer with a range.
    class function Rand(num: Integer): Integer; static;
    //Return a random number of dices with a modificator.
    class function Dice(n,sides: Integer; modifier: Integer): Integer;
    //Return percentile.
    class function Percentile: Integer;
    //Return a random number of 6 sides dices.
    class function xd6(x: Integer): Integer;
    //Randomizer.
    class procedure Randomize;
end;


implementation

constructor TDice.Create;
begin
  inherited;
  pQuantity:=0;
  pSides:=0;
  pModifier:=0;
end;

constructor TDice.Create(number: Integer; polygonNo: Integer; bonus: Integer);
begin
  pQuantity:=number;
  pSides:=polygonNo;
  pModifier:=bonus;
end;

constructor TDice.Create(polyNo: Integer);
begin
  pQuantity:=1;
  pSides:=polyNo;
  pModifier:=0;
end;

function TDice.getNumDice: Integer;
begin
  Result:=pQuantity;
end;

procedure TDice.setNumDice(newNum: Integer);
begin
  pQuantity:=newNum;
end;

function TDice.getSides: Integer;
begin
  Result:=pSides;
end;

procedure TDice.setSides(newSides: Integer);
begin
  pSides:=newSides;
end;

function TDice.getMod: Integer;
begin
  Result:=pModifier;
end;

procedure TDice.setMod(newMod: Integer);
begin
  pModifier:=newMod;
end;

function TDice.Roll: Integer;
begin
  Result:=TDice.Dice(pQuantity, pSides, pModifier);
end;

class function TDice.Rand(num: Integer): Integer;
begin
  Randomize;
  Result:=Random(num);
end;

class function TDice.Dice(n,sides: Integer; modifier: Integer): Integer;
var
  I: Integer;
begin
  Result:=modifier;
  for I := 1 to n do
  begin
    Inc(Result,TDice.Rand(sides) + 1);
  end;
end;

class function TDice.Percentile: Integer;
begin
  Result:=TDice.Dice(1,100,0);

end;

class function TDice.xd6(x: Integer): Integer;
begin
  Result:=TDice.Dice(x,6,0);
end;

class procedure TDice.Randomize;
begin
  Random(Round(Now));
end;

end.
