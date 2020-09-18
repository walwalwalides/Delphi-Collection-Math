{ ============================================
  Unit Name : 	uDynArrTools
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides }
{ CopyRight © 2020 }
{ Email : WalWalWalides@gmail.com }
{ GitHub :https://github.com/walwalwalides }
{ ******************************************** }
unit Test;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, System.generics.collections,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus;

type
  TfrmTest = class(TForm)
    btnSort2Array: TButton;
    btnIncArray: TButton;
    btnRotate: TButton;
    btnShortestSubArray: TButton;
    btnSum: TButton;
    btnAdd1: TButton;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    OpenFiles1: TMenuItem;
    N1: TMenuItem;
    A2: TMenuItem;
    miAbout: TMenuItem;
    miExit: TMenuItem;
    btnBlockArray: TButton;
    Button1: TButton;
    procedure btnSort2ArrayClick(Sender: TObject);
    procedure btnIncArrayClick(Sender: TObject);
    procedure btnRotateClick(Sender: TObject);
    procedure btnShortestSubArrayClick(Sender: TObject);
    procedure btnSumClick(Sender: TObject);
    procedure btnAdd1Click(Sender: TObject);
    procedure miAboutClick(Sender: TObject);
    procedure miExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnBlockArrayClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    procedure DisplayArrayOfInteger(var A: array of integer);
    procedure DisplayListOfInteger(var A: TList<integer>);
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmTest: TfrmTest;

implementation

{$R *.dfm}

uses uDynArrtools, System.math, uAbout;

// Migrate two increasing integer array
procedure TfrmTest.btnSort2ArrayClick(Sender: TObject);
var
  A: array of integer;
  B: array of integer;
  lenA, lenB: integer;
begin
  lenA := 10;
  lenB := 5;

  SetLength(A, lenA);
  SetLength(B, lenB);

  A[0] := 1;
  A[1] := 4;
  A[2] := 5;
  A[3] := 3;
  A[4] := 2;

  B[0] := 0;
  B[1] := 0;
  B[2] := 0;
  B[3] := 1;
  B[4] := 1;

  partSort(A, lenA, 0, lenB - 1);
  partSort(B, lenB, 0, lenB - 1);

  mergeSortedArray(A, lenB, B, lenB);

  DisplayArrayOfInteger(A);

end;

procedure TfrmTest.btnShortestSubArrayClick(Sender: TObject);
var
  A: array of integer;
  lenA: integer;
  k: integer;
begin
  // To do
  exit;
  lenA := 5;
  SetLength(A, lenA);
  A[0] := 1;
  A[1] := 2;
  A[2] := 2;
  A[3] := 3;
  A[4] := 1;

  k := findShortestSubArray(A);

  ShowMessage(k.ToString);
  // DisplayArrayOfInteger(A);

end;

// Sum of 3 element egal a 0
procedure TfrmTest.btnSumClick(Sender: TObject);
var
  I: integer;
  strResult: string;
  TestList: TList<integer>;
  ResultList: TList<integer>;
begin
  TestList := TList<integer>.create;

  // TestList.add(0);
  // TestList.add(0);
  TestList.add(3);
  TestList.add(-1);
  TestList.add(-1);
  TestList.add(-2);

  ResultList := ThreeSum(TestList);

  try
    DisplayListOfInteger(ResultList);

  finally
    ResultList.Free;
    TestList.Free;
  end;

  // Input: nums = [-1,0,1,2,-1,-4]
  // Output: [[-1,-1,2],[-1,0,1]]

end;

procedure TfrmTest.Button1Click(Sender: TObject);
var
  n, nbUnhappyF: integer;
  preferences: TMArray;
  pairs: TMArray;
begin
  //
  n := 4;
  SetLength(preferences, 4);

  SetLength(preferences[0], 3);
  SetLength(preferences[1], 3);
  SetLength(preferences[2], 3);
  SetLength(preferences[3], 3);

  preferences[0][0] := 1;
  preferences[0][1] := 3;
  preferences[0][2] := 2;

  preferences[1][0] := 2;
  preferences[1][1] := 3;
  preferences[1][2] := 0;

  preferences[2][0] := 1;
  preferences[2][1] := 3;
  preferences[2][2] := 0;

  preferences[3][0] := 0;
  preferences[3][1] := 2;
  preferences[3][2] := 1;


//    [[1, 3, 2], [2, 3, 0], [1, 3, 0], [0, 2, 1]], pairs = [[1, 3], [0, 2]]

  // { preferences := {{1, 2, 3},{3, 2, 0},{3, 1, 0},{1, 2, 0}};}

  SetLength(pairs, 2);

  // Set the length of the 3 sub-arrays to different sizes
  SetLength(pairs[0], 2);
  SetLength(pairs[1], 2);
  // SetLength(pairs[2], 2);

  pairs[0][0] := 1;
  pairs[0][1] := 3;
  pairs[1][0] := 0;
  pairs[1][1] := 2;

  nbUnhappyF := unhappyFriends(n, preferences, pairs);

  showmessage(nbUnhappyF.ToString);

end;

procedure TfrmTest.btnBlockArrayClick(Sender: TObject);

var
  I: integer;
  strResult: string;
  TestList1: TList<integer>;
  TestList2: TList<integer>;

  ResultList: TList<integer>;
begin
  TestList1 := TList<integer>.create;

  TestList1.add(3);
  TestList1.add(-1);
  TestList1.add(-7);
  TestList1.add(-2);

  TestList2 := TList<integer>.create;
  TestList2.add(1);
  TestList2.add(0);
  TestList2.add(1);
  TestList2.add(0);

  ResultList := NegativePrefix(TestList1, TestList2);

  try
    DisplayListOfInteger(ResultList);

  finally
    ResultList.Free;
    TestList1.Free;
    TestList2.Free;
  end;

end;

// increment one to the Tlist<integer>.
procedure TfrmTest.miAboutClick(Sender: TObject);
var
  f: TfrmAbout;
begin
  if Assigned(f) then
    Application.CreateForm(TfrmAbout, f);
  f.Position := poMainFormCenter;
  try
    f.ShowModal;
  finally
    FreeAndNil(f);
  end;
end;

procedure TfrmTest.btnAdd1Click(Sender: TObject);
var
  I: integer;
  strResult: string;
  TestList: TList<integer>;
begin
  TestList := TList<integer>.create;
  // 4,3,2,1    -> result should be : 4322
  // TestList.add(4);
  // TestList.add(3);
  // TestList.add(2);
  TestList.add(9);
  TestList.add(9);
  TestList := plusOne(TestList);

  try
    DisplayListOfInteger(TestList);

  finally
    TestList.Free;
  end;

end;

procedure TfrmTest.btnIncArrayClick(Sender: TObject);
var
  A: TXArray;
  lenA, lenB: integer;
  minLen: integer;
  I: integer;
  strResult: string;
begin
  lenA := 6;
  SetLength(A, lenA);
  A[0] := 10;
  A[1] := 10;
  A[2] := 40;
  A[3] := 30;
  A[4] := 60;
  A[5] := 60;
  minLen := findLengthOfShortestSubarray(A);

  for I := Low(A) to High(A) do
  Begin
    strResult := strResult + ' | ' + (A[I]).ToString;

  End;
  strResult := strResult + ' | ';

  ShowMessage(strResult);

end;

// Rotate Array
procedure TfrmTest.btnRotateClick(Sender: TObject);
var
  A: array of integer;
  lenA: integer;
begin
  lenA := 5;
  SetLength(A, lenA);
  A[0] := 10;
  A[1] := 20;
  A[2] := 30;
  A[3] := 40;
  A[4] := 50;

  rotateArray(A, 1);

  DisplayArrayOfInteger(A);
end;

{$REGION 'Display_Result'}

// Display List of integer
procedure TfrmTest.DisplayListOfInteger(var A: TList<integer>);
var
  strResult: string;
  I: integer;

Begin
  for I := 0 to A.Count - 1 do
  Begin
    strResult := strResult + ' | ' + (A[I]).ToString;

  End;
  strResult := strResult + ' | ';

  ShowMessage(strResult);

End;

procedure TfrmTest.FormCreate(Sender: TObject);
begin
  self.Color := clwhite;
  self.Caption := 'ArrayTools';
end;

procedure TfrmTest.miExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

// Display array of integer
procedure TfrmTest.DisplayArrayOfInteger(var A: array of integer);
var
  strResult: string;
  I: integer;

Begin
  for I := Low(A) to High(A) do
  Begin
    strResult := strResult + ' | ' + (A[I]).ToString;

  End;
  strResult := strResult + ' | ';

  ShowMessage(strResult);

End;

{$ENDREGION}

end.
