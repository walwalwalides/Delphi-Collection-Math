{ ============================================
  Software Name : 	CalculSum
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides                     }
{ CopyRight © 2019                             }
{ Email : WalWalWalides@gmail.com              }
{ GitHub :https://github.com/walwalwalides     }
{ ******************************************** }
unit uClassOper;

interface

uses
  uInterfaceObject, System.Generics.Collections, uCalculEvents;

type

  TOper = class(TInterfacedObject, iOper, iOperDisplay)
  protected
    FList: TList<Double>;
    FEventDisplay: TEventDisplay;
    procedure DisplayValue(Value: String);
  public
    function Execute: string; virtual;
    function Display: iOperDisplay;
    function Result(Value: TEventDisplay): iOperDisplay;
    function EndDisplay: iOper;
  end;

implementation

{ TOper }

function TOper.Display: iOperDisplay;
begin
  Result := Self;
end;

procedure TOper.DisplayValue(Value: String);
begin
  if Assigned(FEventDisplay) then
    FEventDisplay(Value);

end;

function TOper.EndDisplay: iOper;
begin
  Result := Self;
end;

function TOper.Execute: string;
begin
  FList.Clear;
end;

function TOper.Result(Value: TEventDisplay): iOperDisplay;
begin
  Result := Self;
  FEventDisplay := Value;
end;

end.
