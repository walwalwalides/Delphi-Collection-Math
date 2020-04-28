{ ============================================
  Software Name : 	Researcher
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides }
{ CopyRight © 2020 }
{ Email : WalWalWalides@gmail.com }
{ GitHub :https://github.com/walwalwalides }
{ ******************************************** }

unit uArrayhelper;

// Create Helper Class for TArray
interface

uses
  System.Classes, System.SysUtils, System.RTLConsts,
  System.Generics.Defaults, System.Generics.Collections;

type

  TArrayForEachCallback<T> = reference to procedure(var Value: T;
    Index: integer);

  TArrayMapCallback<T> = reference to function(var Value: T;
    Index: integer): boolean;

  TArrayConvert<T, TTo> = reference to function(const Value: T): TTo;

  TArrayFindCallback<T> = reference to function(const Value: T): boolean;

  TArrayHelper = class helper for TArray
    class function Add<T>(var Values: TArray<T>; Item: T): integer; static;

    class procedure Delete<T>(var Values: TArray<T>; Index: integer); static;

    class procedure Insert<T>(var Values: TArray<T>; Index: integer;
      Value: T); static;

    class procedure AddRange<T>(var Values: TArray<T>;
      const ValuesToInsert: array of T); static;

    class procedure InsertRange<T>(var Values: TArray<T>; Index: integer;
      const ValuesToInsert: array of T); static;

    class function IndexOf<T>(var Values: TArray<T>; Item: T): integer;
      overload; static;

    class function IndexOf<T>(var Values: TArray<T>; Item: T;
      const Comparer: IComparer<T>): integer; overload; static;

    class function IndexOfMax<T>(var Values: TArray<T>): integer;
      overload; static;

    class function IndexOfMax<T>(var Values: TArray<T>;
      const Comparer: IComparer<T>): integer; overload; static;

    class function IndexOfMin<T>(var Values: TArray<T>): integer;
      overload; static;

    class function IndexOfMin<T>(var Values: TArray<T>;
      const Comparer: IComparer<T>): integer; overload; static;

    class function Contains<T>(var Values: TArray<T>; Item: T): boolean;
      overload; static;

    class function Contains<T>(var Values: TArray<T>; Item: T;
      const Comparer: IComparer<T>): boolean; overload; static;

    class function Compare<T>(const Values, ValuesToCompare: array of T)
      : boolean; overload; static;

    class function Compare<T>(const Values, ValuesToCompare: array of T;
      const Comparer: IComparer<T>): boolean; overload; static;

    class procedure ForEach<T>(var Values: TArray<T>;
      const Callback: TArrayForEachCallback<T>); static;

    class function Find<T>(const Values: TArray<T>;
      const Callback: TArrayFindCallback<T>; const StartIndex: integer = 0)
      : integer; overload; static;

    class function Map<T>(const Values: TArray<T>;
      const Callback: TArrayMapCallback<T>): TArray<T>; static;
  end;

implementation

{ TArrayHelper }

class function TArrayHelper.Add<T>(var Values: TArray<T>; Item: T): integer;
begin
  Result := Length(Values);
  SetLength(Values, Result + 1);
  Values[Result] := Item;
end;

class procedure TArrayHelper.Delete<T>(var Values: TArray<T>; Index: integer);
var
  I: integer;
begin
  if (Index < Low(Values)) or (Index > High(Values)) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  for I := Index + 1 to High(Values) do
    Values[I - 1] := Values[I];
  SetLength(Values, Length(Values) - 1);
end;

class procedure TArrayHelper.Insert<T>(var Values: TArray<T>; Index: integer;
  Value: T);
var
  I, H: integer;
begin
  if (Index < Low(Values)) or (Index > Length(Values)) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  H := High(Values);
  SetLength(Values, Length(Values) + 1);
  for I := H downto Index do
    Values[I + 1] := Values[I];
  Values[Index] := Value;
end;

class procedure TArrayHelper.InsertRange<T>(var Values: TArray<T>;
  Index: integer; const ValuesToInsert: array of T);
var
  I, L, H: integer;
begin
  L := Length(ValuesToInsert);
  if L = 0 then
    EXIT;
  if (Index < Low(Values)) or (Index > Length(Values)) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  H := High(Values);
  SetLength(Values, Length(Values) + L);
  for I := H downto Index do
    Values[I + L] := Values[I];
  for I := Low(ValuesToInsert) to High(ValuesToInsert) do
    Values[Index + I] := ValuesToInsert[I];
end;

class procedure TArrayHelper.AddRange<T>(var Values: TArray<T>;
  const ValuesToInsert: array of T);
var
  I, Index: integer;
begin
  Index := Length(Values);
  SetLength(Values, Length(Values) + Length(ValuesToInsert));
  for I := Low(ValuesToInsert) to High(ValuesToInsert) do
    Values[Index + I] := ValuesToInsert[I];
end;

class function TArrayHelper.IndexOf<T>(var Values: TArray<T>; Item: T;
  const Comparer: IComparer<T>): integer;
begin
  for Result := Low(Values) to High(Values) do
    if Comparer.Compare(Values[Result], Item) = 0 then
      EXIT;
  Result := -1;
end;

class function TArrayHelper.IndexOf<T>(var Values: TArray<T>; Item: T): integer;
begin
  Result := IndexOf<T>(Values, Item, TComparer<T>.Default);
end;

class function TArrayHelper.IndexOfMax<T>(var Values: TArray<T>): integer;
begin
  Result := IndexOfMax<T>(Values, TComparer<T>.Default);
end;

class function TArrayHelper.IndexOfMax<T>(var Values: TArray<T>;
  const Comparer: IComparer<T>): integer;
var
  I: integer;
begin
  if Length(Values) = 0 then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  Result := 0;
  for I := 1 to High(Values) do
    if Comparer.Compare(Values[I], Values[Result]) > 0 then
      Result := I;
end;

class function TArrayHelper.IndexOfMin<T>(var Values: TArray<T>): integer;
begin
  Result := IndexOfMin<T>(Values, TComparer<T>.Default);
end;

class function TArrayHelper.IndexOfMin<T>(var Values: TArray<T>;
  const Comparer: IComparer<T>): integer;
var
  I: integer;
begin
  if Length(Values) = 0 then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  Result := 0;
  for I := 1 to High(Values) do
    if Comparer.Compare(Values[I], Values[Result]) < 0 then
      Result := I;
end;

class function TArrayHelper.Contains<T>(var Values: TArray<T>; Item: T;
  const Comparer: IComparer<T>): boolean;
begin
  Result := IndexOf<T>(Values, Item, Comparer) <> -1;
end;

class function TArrayHelper.Contains<T>(var Values: TArray<T>; Item: T)
  : boolean;
begin
  Result := Contains<T>(Values, Item, TComparer<T>.Default);
end;

class function TArrayHelper.Compare<T>(const Values, ValuesToCompare
  : array of T; const Comparer: IComparer<T>): boolean;
var
  I: integer;
begin
  if Length(Values) <> Length(ValuesToCompare) then
    EXIT(FALSE);
  for I := Low(Values) to High(Values) do
    if Comparer.Compare(Values[I], ValuesToCompare[I]) <> 0 then
      EXIT(FALSE);
  Result := TRUE;
end;

class function TArrayHelper.Compare<T>(const Values, ValuesToCompare
  : array of T): boolean;
begin
  Result := Compare<T>(Values, ValuesToCompare, TComparer<T>.Default);
end;

class procedure TArrayHelper.ForEach<T>(var Values: TArray<T>;
  const Callback: TArrayForEachCallback<T>);
var
  I: integer;
begin
  for I := Low(Values) to High(Values) do
    Callback(Values[I], I);
end;

class function TArrayHelper.Find<T>(const Values: TArray<T>;
  const Callback: TArrayFindCallback<T>; const StartIndex: integer): integer;
begin
  if (Length(Values) = 0) or (StartIndex < 0) or (StartIndex > High(Values))
  then
    EXIT(-1);
  for Result := StartIndex to High(Values) do
    if Callback(Values[Result]) then
      EXIT;
  Result := -1;
end;

class function TArrayHelper.Map<T>(const Values: TArray<T>;
  const Callback: TArrayMapCallback<T>): TArray<T>;
var
  Item: T;
  I: integer;
begin
  Result := NIL;
  for I := Low(Values) to High(Values) do
  begin
    Item := Values[I];
    if Callback(Item, I) then
      Add<T>(Result, Item);
  end;
end;

end.
