{ ============================================
  Software Name : 	CalculSum
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides                     }
{ CopyRight © 2019                             }
{ Email : WalWalWalides@gmail.com              }
{ GitHub :https://github.com/walwalwalides     }
{ ******************************************** }
unit uInterfaceObject;

interface

uses uCalculEvents;

type

  iCalcul = interface;
  iOperDisplay = interface;


  iOper = interface
    ['{DF845E6B-AEC8-4670-97E9-165A9831B298}']
    function Execute: string;
    function Display : iOperDisplay;
  end;

  iOperDisplay = interface
    ['{1B7B9644-935D-42AC-9FFA-4324029E0DDD}']
    function Result(Value: TEventDisplay): iOperDisplay;
    function EndDisplay : iOper;
  end;


  iCalculDisplay = interface
    ['{241BB46F-82DC-41C7-B3F3-09B37FC2BF39}']
    function Result(Value: TEventDisplay): iCalculDisplay;
    function EndDisplay: iCalcul;
  end;


  iCalcul = interface
    ['{41DC5E6A-44D3-4C98-AF75-C265AC72C083}']
    function Add(Value: String): iCalcul; overload;
    function Add(Value: Integer): iCalcul; overload;
    function Add(Value: Currency): iCalcul; overload;
    function Sum: iOper;
    function Display: iCalculDisplay;
  end;

implementation

end.
