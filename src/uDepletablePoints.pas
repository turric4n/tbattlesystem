{/***************************************************************************
                          uDepletablePoints.pas  -  description
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

unit uDepletablePoints;

{/**Keeps track of a variable value with a maximum possible value. Archetypical example is
  hit points.
  */}

interface

type

TDepletablePoints = class(TObject)
  private
    pCurrent, pMaximum: Integer;
    procedure SetCurrent(const val: Integer);
    function GetCurrent: Integer;
    procedure SetMax(const val: Integer);
    function GetMax: Integer;
    procedure MakeValid;
  public
    constructor Create(const Val: Integer = 0); overload;
    constructor Create(const curr,max: Integer); overload;
    function Change(const delta: Integer): Integer;
    property Current: Integer read GetCurrent write SetCurrent;
    property Max: Integer read GetMax write SetMax;
    function ChangeMax(const delta: Integer): Integer;
    procedure Become(const ref: TDepletablePoints);
    function IsPositive: Boolean;
    procedure Incr(const value: Integer); overload;
    procedure Decr(const value: Integer); overload;
    procedure Incr; overload;
    procedure Decr; overload;
    function LessOrEqual(const value: Integer): Boolean; overload;
    function LessOrEqual(DepletablePoints: TDepletablePoints): Boolean; overload;
    function LessThan(const value: Integer): Boolean; overload;
    function LessThan(DepletablePoints: TDepletablePoints): Boolean; overload;
    function Equal(const value: Integer): Boolean; overload;
    function Equal(DepletablePoints: TDepletablePoints): Boolean; overload;
    function notEqual(const value: Integer): Boolean; overload;
    function notEqual(DepletablePoints: TDepletablePoints): Boolean; overload;
    function GreaterOrEqual(const value: Integer): Boolean; overload;
    function GreaterOrEqual(DepletablePoints: TDepletablePoints): Boolean; overload;
end;


implementation

constructor TDepletablePoints.Create(const Val: Integer = 0);
begin
  pCurrent:=val;
  pMaximum:=val;
end;

constructor TDepletablePoints.Create(const curr,max: Integer);
begin
  pCurrent:=curr;
  pMaximum:=max;
  MakeValid;
end;

function TDepletablePoints.Change(const delta: Integer): Integer;
begin
  Inc(pCurrent,delta);
  MakeValid;
  Result:=pCurrent;
end;

function TDepletablePoints.ChangeMax(const delta: Integer): Integer;
begin
  Inc(pMaximum,delta);
  MakeValid;
  Result:=pMaximum;
end;

procedure TDepletablePoints.SetCurrent(const val: Integer);
begin
  pCurrent:=val;
  MakeValid;
end;

procedure TDepletablePoints.SetMax(const val: Integer);
begin
  pMaximum:=val;
  MakeValid;
end;

function TDepletablePoints.GetCurrent: Integer;
begin
  Result:=pCurrent;
end;

function TDepletablePoints.GetMax: Integer;
begin
  Result:=pMaximum;
end;

procedure TDepletablePoints.Become(const ref: TDepletablePoints);
begin
  pCurrent:=ref.pCurrent;
  pMaximum:=ref.pMaximum;
end;

function TDepletablePoints.LessOrEqual(const value: Integer): Boolean;
begin
  Result:=pCurrent <= value;
end;

function TDepletablePoints.LessOrEqual(DepletablePoints: TDepletablePoints): Boolean;
begin
  Result:=pCurrent <= DepletablePoints.pCurrent;
end;

function TDepletablePoints.LessThan(const value: Integer): Boolean;
begin
  Result:=pCurrent < value;
end;

function TDepletablePoints.LessThan(DepletablePoints: TDepletablePoints): Boolean;
begin
  Result:=pCurrent < DepletablePoints.pCurrent;
end;

function TDepletablePoints.Equal(const value: Integer): Boolean;
begin
  Result:=pCurrent = value;
end;

function TDepletablePoints.Equal(DepletablePoints: TDepletablePoints): Boolean;
begin
  Result:=pCurrent = DepletablePoints.pCurrent;
end;

function TDepletablePoints.notEqual(const value: Integer): Boolean;
begin
  Result:=pCurrent <> value;
end;

function TDepletablePoints.notEqual(DepletablePoints: TDepletablePoints): Boolean;
begin
  Result:=pCurrent <> DepletablePoints.pCurrent;
end;

function TDepletablePoints.GreaterOrEqual(const value: Integer): Boolean;
begin
  Result:=pCurrent >= value;
end;

function TDepletablePoints.GreaterOrEqual(DepletablePoints: TDepletablePoints): Boolean;
begin
  Result:=pCurrent >= DepletablePoints.pCurrent;
end;

function TDepletablePoints.IsPositive: Boolean;
begin
  Result:=pCurrent > 0;
end;

procedure TDepletablePoints.Incr(const value: Integer);
begin
  Inc(pCurrent,value);
end;

procedure TDepletablePoints.Decr(const value: Integer);
begin
  Dec(pCurrent,value);
end;

procedure TDepletablePoints.Incr;
begin
  Inc(pCurrent);
  MakeValid;
end;

procedure TDepletablePoints.Decr;
begin
  Dec(pCurrent);
  MakeValid;
end;

procedure TDepletablePoints.MakeValid;
begin
  if pCurrent > pMaximum then pCurrent:=pMaximum;
end;

end.
