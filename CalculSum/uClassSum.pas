{ ============================================
  Software Name : 	CalculSum
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides                     }
{ CopyRight © 2019                             }
{ Email : WalWalWalides@gmail.com              }
{ GitHub :https://github.com/walwalwalides     }
{ ******************************************** }
unit uClassSum;

interface

uses uInterfaceObject, System.SysUtils, uClassOper,
  System.Generics.Collections;

type

  TSum = class sealed(TOper)
  public
    constructor Create(var Value: TList<Double>);
    class function New(var Value: TList<Double>): iOper;
    destructor Destroy; override;
    function Execute: string; override;
  end;

implementation

{ TSum }

uses uClassMethodsUtils;

constructor TSum.Create(var Value: TList<Double>);
begin
  FList := Value;
end;

destructor TSum.Destroy;
begin

  inherited;
end;

function TSum.Execute: string;
var
  I: Integer;
begin
  begin
    Result := FList[0].ToString;
    for I := 1 to FList.Count - 1 do
      Result := (Result.ToNumeric + FList[I]).ToString;
    DisplayValue(Result);
  end;
  inherited;
end;

class function TSum.New(var Value: TList<Double>): iOper;
begin
  Result := Self.Create(Value);
end;

end.
