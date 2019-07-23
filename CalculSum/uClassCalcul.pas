{ ============================================
  Software Name : 	CalculSum
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides                     }
{ CopyRight © 2019                             }
{ Email : WalWalWalides@gmail.com              }
{ GitHub :https://github.com/walwalwalides     }
{ ******************************************** }
unit uClassCalcul;

interface

uses uInterfaceObject, uClassSum, System.Classes,
  System.Generics.Collections, uCalculEvents;

type

  TCalcul = class(TInterfacedObject, iCalcul, iCalculDisplay)
  private
  FEventDisplay : TEventDisplay;
  FList : TList<Double>;
  public
    constructor Create;
    destructor Destroy; override;
    Class function New: iCalcul;
    function Add(Value: String): iCalcul; overload;
    function Add(Value: Integer): iCalcul; overload;
    function Add(Value: Currency): iCalcul; overload;
    function Sum: iOper;
    function Display : iCalculDisplay;
    function Result(Value: TEventDisplay): iCalculDisplay;
    function EndDisplay: iCalcul;
  end;

implementation

uses
  System.SysUtils, uClassMethodsUtils;

{ TCalculadora }

function TCalcul.Add(Value: String): iCalcul;
begin
Result:= Self;
FList.Add(Value.ToNumerico);
end;

function TCalcul.Add(Value: Integer): iCalcul;
begin
Result:= Self;
FList.Add(Value.ToDouble)
end;

function TCalcul.Add(Value: Currency): iCalcul;
begin
Result:= Self;
FList.Add(Value);
end;

constructor TCalcul.Create;
begin
  FList:= TList<Double>.Create;
end;

destructor TCalcul.Destroy;
begin
  FList.Free;
  inherited;
end;

function TCalcul.Display: iCalculDisplay;
begin
Result:= Self;
end;



function TCalcul.EndDisplay: iCalcul;
begin
Result:= Self;
end;


class function TCalcul.New: iCalcul;
begin
  Result := Self.Create;
end;

function TCalcul.Result(Value: TEventDisplay): iCalculDisplay;
begin
  Result:= Self;
  FEventDisplay:= Value;
end;

function TCalcul.Sum: iOper;
begin
  Result := TSum.New(FList).Display.Result(FEventDisplay).EndDisplay;
end;


end.
