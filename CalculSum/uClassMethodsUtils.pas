{ ============================================
  Software Name : 	CalculSum
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides                     }
{ CopyRight © 2019                             }
{ Email : WalWalWalides@gmail.com              }
{ GitHub :https://github.com/walwalwalides     }
{ ******************************************** }
unit uClassMethodsUtils;

interface

uses
   Vcl.Controls;
 type

 TCaptionHelper = record  Helper for TCaption
  function ToNumerico : Double;
 end;

 TStrHelper = record Helper for String
 function ToNumerico : double;
 end;
implementation

uses
  System.SysUtils;

{ TCaptionHelper }

function TCaptionHelper.ToNumerico: Double;
begin
Result:= StrToFloat(Self);
end;

{ TStrHelper }

function TStrHelper.ToNumerico: double;
begin
Result:= StrtoFloat(Self);
end;

end.
