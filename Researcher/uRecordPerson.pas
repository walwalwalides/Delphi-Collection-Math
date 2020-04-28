{ ============================================
  Software Name : 	Researcher
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides                     }
{ CopyRight © 2020                             }
{ Email : WalWalWalides@gmail.com              }
{ GitHub :https://github.com/walwalwalides     }
{ ******************************************** }
unit uRecordPerson;

interface
 uses
  System.Classes, System.SysUtils, System.RTLConsts,
  System.Generics.Defaults, System.Generics.Collections,uArrayhelper;

type
  TArrayRecord<T> = record
  strict private
  type
    TEnumerator = class
    private
      FValue: ^TArrayRecord<T>;
      FIndex: integer;
      function GetCurrent: T;
    public
      constructor Create(var AValue: TArrayRecord<T>);
      function MoveNext: boolean;
      property Current: T read GetCurrent;
    end;
  public
    function GetEnumerator(): TEnumerator;
  private
    function GetCount: integer;
    procedure SetCount(const Value: integer);
    function GetItemAt(Index: integer): T;
    procedure SetItemAt(Index: integer; Value: T);
  public
    Items: TArray<T>;
    property Count: integer read GetCount write SetCount;
    property ItemAt[Index: integer]: T read GetItemAt write SetItemAt; default;

    constructor Create(ACapacity: integer); overload;
    constructor Create(const AValues: array of T); overload;
    procedure Clear;
    procedure SetItems(const Values: array of T);
    function Add(const Value: T): integer;
    procedure Delete(Index: integer);
    procedure Insert(Index: integer; Value: T);
    function Remove(const AItem: T): boolean;
    function AddIfNotContians(const AItem: T): boolean;

    procedure AddRange(const ValuesToInsert: array of T); overload;
    procedure AddRange(const ValuesToInsert: TArrayRecord<T>); overload;

    procedure InsertRange(Index: integer;
      const ValuesToInsert: array of T); overload;
    procedure InsertRange(Index: integer;
      const ValuesToInsert: TArrayRecord<T>); overload;

    function IndexOf(Item: T): integer; overload;
    function IndexOf(Item: T; const Comparer: IComparer<T>): integer; overload;

    function IndexOfMax: integer; overload;
    function IndexOfMax(const Comparer: IComparer<T>): integer; overload;
    function IndexOfMin: integer; overload;
    function IndexOfMin(const Comparer: IComparer<T>): integer; overload;

    function Contains(Item: T): boolean; overload;
    function Contains(Item: T; const Comparer: IComparer<T>): boolean; overload;

    function Compare(const ValuesToCompare: array of T): boolean; overload;
    function Compare(const ValuesToCompare: array of T;
      const Comparer: IComparer<T>): boolean; overload;
    function Compare(const ValuesToCompare: TArrayRecord<T>): boolean; overload;
    function Compare(const ValuesToCompare: TArrayRecord<T>;
      const Comparer: IComparer<T>): boolean; overload;

    procedure ForEach(const Callback: TArrayForEachCallback<T>);
    function Find(const Callback: TArrayFindCallback<T>;
      const StartIndex: integer = 0): integer; overload;
    function Map(const Callback: TArrayMapCallback<T>): TArrayRecord<T>;
    function Convert<TTo>(const Callback: TArrayConvert<T, TTo>)
      : TArrayRecord<TTo>;

    procedure Sort; overload;
    procedure Sort(const AComparer: IComparer<T>); overload;
    procedure Sort(const AComparer: IComparer<T>;
      AIndex, ACount: integer); overload;
    function BinarySearch(const AItem: T; out AFoundIndex: integer;
      const AComparer: IComparer<T>; AIndex, ACount: integer): boolean;
      overload;
    function BinarySearch(const AItem: T; out AFoundIndex: integer;
      const AComparer: IComparer<T>): boolean; overload;
    function BinarySearch(const AItem: T; out AFoundIndex: integer)
      : boolean; overload;

    procedure Unique;
    function CopyArray(FromIndex: integer; Count: integer = -1)
      : TArrayRecord<T>;

    class operator Equal(const L, R: TArrayRecord<T>): boolean;
    class operator NotEqual(const L, R: TArrayRecord<T>): boolean;
  end;

implementation


{ TArrayRecord<T>.TEnumerator }

constructor TArrayRecord<T>.TEnumerator.Create(var AValue: TArrayRecord<T>);
begin
  FValue := @AValue;
  FIndex := -1;
end;

function TArrayRecord<T>.TEnumerator.GetCurrent: T;
begin
  Result := FValue^.Items[FIndex];
end;

function TArrayRecord<T>.TEnumerator.MoveNext: boolean;
begin
  Result := FIndex < High(FValue^.Items);
  Inc(FIndex);
end;

{ TArrayRecord<T> }

constructor TArrayRecord<T>.Create(ACapacity: integer);
begin
  SetLength(Items, ACapacity);
end;

constructor TArrayRecord<T>.Create(const AValues: array of T);
begin
  SetLength(Items, 0);
  AddRange(AValues);
end;

procedure TArrayRecord<T>.Clear;
begin
  SetLength(Items, 0);
end;

class operator TArrayRecord<T>.Equal(const L, R: TArrayRecord<T>): boolean;
begin
  Result := L.Compare(R);
end;

class operator TArrayRecord<T>.NotEqual(const L, R: TArrayRecord<T>): boolean;
begin
  Result := not L.Compare(R);
end;

function TArrayRecord<T>.GetCount: integer;
begin
  Result := Length(Items);
end;

function TArrayRecord<T>.GetEnumerator: TEnumerator;
begin
  Result := TEnumerator.Create(Self);
end;

procedure TArrayRecord<T>.SetCount(const Value: integer);
begin
  SetLength(Items, Value);
end;

procedure TArrayRecord<T>.SetItemAt(Index: integer; Value: T);
begin
  Items[Index] := Value;
end;

procedure TArrayRecord<T>.SetItems(const Values: array of T);
begin
  SetLength(Items, 0);
  AddRange(Values);
end;

function TArrayRecord<T>.GetItemAt(Index: integer): T;
begin
  Result := Items[Index];
end;

procedure TArrayRecord<T>.AddRange(const ValuesToInsert: array of T);
begin
  TArray.AddRange<T>(Items, ValuesToInsert);
end;

procedure TArrayRecord<T>.AddRange(const ValuesToInsert: TArrayRecord<T>);
begin
  TArray.AddRange<T>(Items, ValuesToInsert.Items);
end;

function TArrayRecord<T>.BinarySearch(const AItem: T; out AFoundIndex: integer;
  const AComparer: IComparer<T>; AIndex, ACount: integer): boolean;
begin
  Result := TArray.BinarySearch<T>(Items, AItem, AFoundIndex, AComparer,
    AIndex, ACount);
end;

function TArrayRecord<T>.BinarySearch(const AItem: T; out AFoundIndex: integer;
  const AComparer: IComparer<T>): boolean;
begin
  Result := TArray.BinarySearch<T>(Items, AItem, AFoundIndex, AComparer);
end;

function TArrayRecord<T>.BinarySearch(const AItem: T;
  out AFoundIndex: integer): boolean;
begin
  Result := TArray.BinarySearch<T>(Items, AItem, AFoundIndex);
end;

procedure TArrayRecord<T>.Delete(Index: integer);
begin
  TArray.Delete<T>(Items, Index);
end;

function TArrayRecord<T>.Remove(const AItem: T): boolean;
var
  I: integer;
begin
  I := IndexOf(AItem);
  if I < 0 then
    Result := FALSE
  else
  begin
    Delete(I);
    Result := TRUE;
  end;
end;

function TArrayRecord<T>.AddIfNotContians(const AItem: T): boolean;
begin
  Result := not Contains(AItem);
  if not Result then
    Add(AItem);
end;

function TArrayRecord<T>.Find(const Callback: TArrayFindCallback<T>;
  const StartIndex: integer): integer;
begin
  Result := TArray.Find<T>(Items, Callback, StartIndex);
end;

procedure TArrayRecord<T>.ForEach(const Callback: TArrayForEachCallback<T>);
begin
  TArray.ForEach<T>(Items, Callback);
end;

function TArrayRecord<T>.Compare(const ValuesToCompare
  : TArrayRecord<T>): boolean;
begin
  Result := TArray.Compare<T>(Items, ValuesToCompare.Items);
end;

function TArrayRecord<T>.Compare(const ValuesToCompare: TArrayRecord<T>;
  const Comparer: IComparer<T>): boolean;
begin
  Result := TArray.Compare<T>(Items, ValuesToCompare.Items, Comparer);
end;



function TArrayRecord<T>.Compare(const ValuesToCompare: array of T): boolean;
begin
  Result := TArray.Compare<T>(Items, ValuesToCompare);
end;

function TArrayRecord<T>.Compare(const ValuesToCompare: array of T;
  const Comparer: IComparer<T>): boolean;
begin
  Result := TArray.Compare<T>(Items, ValuesToCompare, Comparer);
end;

function TArrayRecord<T>.Contains(Item: T;
  const Comparer: IComparer<T>): boolean;
begin
  Result := TArray.Contains<T>(Items, Item, Comparer);
end;

function TArrayRecord<T>.Contains(Item: T): boolean;
begin
  Result := TArray.Contains<T>(Items, Item);
end;

function TArrayRecord<T>.IndexOf(Item: T; const Comparer: IComparer<T>)
  : integer;
begin
  Result := TArray.IndexOf<T>(Items, Item, Comparer);
end;

function TArrayRecord<T>.IndexOfMax: integer;
begin
  Result := TArray.IndexOfMax<T>(Items);
end;

function TArrayRecord<T>.IndexOfMax(const Comparer: IComparer<T>): integer;
begin
  Result := TArray.IndexOfMax<T>(Items, Comparer);
end;

function TArrayRecord<T>.IndexOfMin: integer;
begin
  Result := TArray.IndexOfMin<T>(Items);
end;

function TArrayRecord<T>.IndexOfMin(const Comparer: IComparer<T>): integer;
begin
  Result := TArray.IndexOfMin<T>(Items, Comparer);
end;

function TArrayRecord<T>.IndexOf(Item: T): integer;
begin
  Result := TArray.IndexOf<T>(Items, Item);
end;

procedure TArrayRecord<T>.Insert(Index: integer; Value: T);
begin
  TArray.Insert<T>(Items, Index, Value);
end;

procedure TArrayRecord<T>.InsertRange(Index: integer;
  const ValuesToInsert: TArrayRecord<T>);
begin
  TArray.InsertRange<T>(Items, Index, ValuesToInsert.Items);
end;

procedure TArrayRecord<T>.InsertRange(Index: integer;
  const ValuesToInsert: array of T);
begin
  TArray.InsertRange<T>(Items, Index, ValuesToInsert);
end;

function TArrayRecord<T>.Map(const Callback: TArrayMapCallback<T>)
  : TArrayRecord<T>;
begin
  Result.Items := TArray.Map<T>(Items, Callback);
end;

function TArrayRecord<T>.Convert<TTo>(const Callback: TArrayConvert<T, TTo>)
  : TArrayRecord<TTo>;
var
  I: integer;
begin
  Result.Clear;
  for I := Low(Items) to High(Items) do
    Result.Add(Callback(Items[I]));
end;

function TArrayRecord<T>.CopyArray(FromIndex: integer; Count: integer)
  : TArrayRecord<T>;
var
  I: integer;
begin
  Result.Clear;
  if Count < 0 then
    Count := Length(Items);
  if Length(Items) < (FromIndex + Count) then
    Count := Length(Items) - FromIndex;
  if Count > 0 then
  begin
    SetLength(Result.Items, Count);
    for I := 0 to Count - 1 do
      Result.Items[I] := Items[I + FromIndex];
  end;
end;

procedure TArrayRecord<T>.Sort;
begin
  TArray.Sort<T>(Items);
end;

procedure TArrayRecord<T>.Sort(const AComparer: IComparer<T>);
begin
  TArray.Sort<T>(Items, AComparer);
end;

procedure TArrayRecord<T>.Sort(const AComparer: IComparer<T>;
  AIndex, ACount: integer);
begin
  TArray.Sort<T>(Items, AComparer, AIndex, ACount);
end;

function TArrayRecord<T>.Add(const Value: T): integer;
begin
  Result := TArray.Add<T>(Items, Value);
end;

procedure TArrayRecord<T>.Unique;
var
  Hash: TDictionary<T, integer>;
  I: integer;
begin
  Hash := TDictionary<T, integer>.Create(Length(Items));
  try
    for I := Low(Items) to High(Items) do
      Hash.AddOrSetValue(Items[I], 0);
    Items := Hash.Keys.ToArray;
  finally
    Hash.Free;
  end;
end;


end.
