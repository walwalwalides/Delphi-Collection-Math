{ ============================================
  Unit Name : 	uDynArrTools
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides }
{ CopyRight © 2020 }
{ Email : WalWalWalides@gmail.com }
{ GitHub :https://github.com/walwalwalides }
{ ******************************************** }

unit uDynArrTools;

interface

uses
  classes, system.math, system.Generics.Collections,
  system.Generics.Defaults;

type
  TXArray = array of integer;
  TMArray = array of array of integer;
  // Array of integer
procedure mergeSortedArray(var A: array of integer; m: integer;
  var B: array of integer; n: integer);

procedure partSort(var arr: array of integer; n: integer; A, B: integer);
procedure rotateArray(var arr: array of integer; const n: integer);

function findLengthOfShortestSubarray(var arr: TXArray): integer;
function findShortestSubArray(var arr: array of integer): integer;

// TList<Integer>
function ThreeSum(var AList: TList<integer>): TList<integer>;
function plusOne(var AList: TList<integer>): TList<integer>;

function NegativePrefix(var AList: TList<integer>; var ABlock: TList<integer>;
  const Direction: integer = 0): TList<integer>;

//
function unhappyFriends(var n: integer; var preferences: TMArray;
  var pairs: TMArray): integer;

implementation

uses
  Vcl.Dialogs, system.SysUtils;

function lowerBound(var A: array of integer;
  low, high, element: integer): integer;
var
  middle: integer;
Begin
  while (low < high) Do
  begin
    middle := low + ((high - low) div 2);
    if (element > A[middle]) then
    begin
      low := middle + 1;
    end
    else
    begin
      high := middle;
    end;

  end;
  result := low;
end;

function upperBound(var A: array of integer;
  low, high, element: integer): integer;
var
  middle: integer;
Begin
  while (low < high) Do
  begin
    middle := low + ((high - low) div 2);
    if (A[middle] > element) then
    begin
      high := middle;
    end
    else
    begin
      low := middle + 1;
    end;

  end;
  result := low;
end;


// rotate a array of integer

procedure rotateArray(var arr: array of integer; const n: integer);
// number of time rotate
var
  newArr: array of integer;
  len: integer;
  i: integer;
Begin
  len := length(arr);
  SetLength(newArr, len);

  for i := Low(arr) to High(arr) do
  Begin
    newArr[(i + n) mod len] := arr[i];
  end;

  for i := 0 to len do
  Begin
    arr[i] := newArr[i]

  End;

end;






// return 0 : array sorted
// return >0 : number of shortest sub array (auto delete decrescent numbers )

{$REGION 'Find length of shortest Subarray'}

procedure DeleteX(var A: TXArray; const first, Index: integer);
var
  ALength: Cardinal;
  i, k: Cardinal;
  istart: integer;

begin
  istart := first;
  if istart > length(A) then
    istart := length(A) - 1;

  for k := istart downto (istart - Index) + 1 do
  Begin

    ALength := length(A);
    Assert(ALength > 0);
    Assert(k < ALength);
    for i := k + 1 to ALength - 1 do
      A[i - 1] := A[i];
    SetLength(A, ALength - 1);
  End;
end;

// Delete the shortest subarray & show a incremented array
function findLengthOfShortestSubarray(var arr: TXArray): integer;
var
  n, ans, last, first: integer;
  i: integer;
  j: integer;
  k: integer;
  arrtmp: array of integer;
Begin
  result := 0;
  n := length(arr);
  last := 0;
  while ((last + 1 < n) and (arr[last] <= arr[last + 1])) do
  Begin
    inc(last);
  end;
  first := n - 1;
  while ((first - 1 >= 0) and (arr[first - 1] <= arr[first])) do
  begin
    dec(first);
  end;

  if (last = n - 1) then
  Begin
    result := 0;
    exit;
  end;

  Assert(last < first);

  ans := n + 1;

  for i := 0 to last do
  Begin
    k := lowerBound(arr, first, n, arr[i]);
    ans := min(ans, k - i - 1);

  End;
  SetLength(arrtmp, ans);

  DeleteX(arr, (i + ans) - 1, ans);
  result := ans;

end;

{$ENDREGION}
// Sort array of integer from a to b

procedure partSort(var arr: array of integer; n: integer; A, B: integer);
var
  l, r: integer;
  j: integer;
  i: integer;
  tmpArr: array of integer;

Begin
  l := min(A, B);
  r := max(A, B);

  SetLength(tmpArr, r - l + 1);

  j := 0;

  for i := l to r do
  Begin
    tmpArr[j] := arr[i];
    inc(j);
  end;

  TArray.Sort<integer>(tmpArr, TComparer<integer>.Construct(
    function(const A, B: integer): integer
    begin
      result := TComparer<integer>.Default.Compare(A, B);

    end));
  j := 0;
  for i := l to r do
  begin
    arr[i] := tmpArr[j];
    inc(j);
  end;

end;

procedure mergeSortedArray(var A: array of integer; m: integer;
var B: array of integer; n: integer);
var
  i: integer;
Begin
  i := m + n;
  while ((m > 0) and (n > 0)) do
  begin

    if (A[m - 1] > B[n - 1]) then
    Begin

      A[i - 1] := A[m - 1];
      dec(m);
    end
    else
    Begin
      A[i - 1] := B[n - 1];
      dec(n);
    end;
    dec(i);
  end;

  while (n > 0) do
  Begin
    A[i - 1] := B[n - 1];
    dec(n);
    dec(i);
  end;

end;

function findShortestSubArray(var arr: array of integer): integer;
var
  DicRight, DicLeft, DicCount: TDictionary<integer, integer>;
  len: integer;
  x: integer;
  i: integer;
  val, degree: integer;
  ans: integer;
  val2: integer;
Begin
  len := length(arr);
  DicLeft := TDictionary<integer, integer>.Create;
  DicRight := TDictionary<integer, integer>.Create;
  DicCount := TDictionary<integer, integer>.Create;

  for i := 0 to len - 1 do

  Begin
    x := arr[i];
    if (DicLeft.ContainsKey(x) = false) then
      DicLeft.Add(x, i);
    DicRight.Add(x, i);
    DicLeft.TryGetValue(x, val2);
    DicCount.Add(x, val2 + 1);
  end;

  degree := DicCount.Count.MaxValue;
  ans := len;
  for x in DicCount.Keys do
  Begin
    if (DicCount.Items[x] = degree) then
      ans := min(ans, DicRight.Items[x] - DicLeft.Items[x] + 1);
  End;

  try
    result := ans;
  finally
    DicRight.Free;
    DicLeft.Free;
    DicCount.Free;
  end;

End;

// increment one to the integer.
function plusOne(var AList: TList<integer>): TList<integer>;
var
  i, i9: integer;
  ilast: integer;
Begin
  ilast := AList.Count - 1;
  i9 := -1;

  if (ilast >= 0) then
  Begin
    for i := ilast downto 0 do
    begin
      if (AList[i] = 9) then
      Begin
        AList[i] := 0;
        inc(i9);
      End
      else
      Begin
        AList[i] := AList[i] + 1;
        result := AList;

      end;

    end;
  End
  else
  Begin
    AList[0] := 1;
    result := AList;
  End;
  if (i9 = ilast) then
  Begin
    AList[0] := 1;
    AList.Add(0);
  end;

  result := AList;

end;

function ThreeSum(var AList: TList<integer>): TList<integer>;
const
  target = 0;
var
  BList: TList<integer>;
  i: integer;
  j: integer;
  k: integer;
  // l: integer;
  sum: integer;
Begin
  BList := TList<integer>.Create;
  AList.Sort;
  for i := 0 to AList.Count - 3 do
  Begin
    if ((i = 0) or (AList[i] <> AList[i - 1])) then // Skip duplicated.
    Begin
      k := AList.Count - 1;
      // l := i + 1;
      for j := i + 1 to k do
      Begin

        if ((j - 1 > i) and (AList[j] = AList[j - 1])) then // Skip duplicated
        Begin
          // inc(l);
          continue
        End
        else if ((k + 1 < AList.Count) and (AList[k] = AList[k + 1])) then
        // Skip duplicated.
        Begin
          dec(k)
        End
        else
        Begin
          sum := AList[i] + AList[j] + AList[k];
          if (sum > target) then // Should decrease sum
          Begin
            dec(k);
          end
          else if (sum < target) then // Should increase sum.
          Begin
            // inc(l);
            continue
          End
          else
          begin
            BList.Add(AList[i]);
            BList.Add(AList[j]);
            BList.Add(AList[k]);
            dec(k);
            // inc(l);
            continue
          end;

        end;

      End;

    End;

  End;
  result := BList;

End;

function NegativePrefix(var AList: TList<integer>; var ABlock: TList<integer>;
const Direction: integer = 0): TList<integer>;
var
  comparison: TComparison<integer>;
  x: integer;
  i: integer;
Begin
  if (AList.Count <> AList.Count) then
    exit;

  result := TList<integer>.Create;
  x := 0;
  for i := 0 to AList.Count - 1 do
  Begin
    if (ABlock[i] = 0) then
    Begin
      result.Add(AList[i]);
      inc(x);
    end;
  end;

  comparison := function(const Left, Right: integer): integer
    begin

      case Direction of
        - 1:
          result := Right - Left; // decrease
        0:
          result := Left - Right; // increase

      end;

    end;
  result.Sort(TComparer<integer>.Construct(comparison));

  if (x < AList.Count) then

    for i := 0 to AList.Count - 1 do
    Begin

      if (ABlock[i] = 1) then
      Begin
        result.Insert(i, AList[i]);

      end;

    end;

End;

function unhappyFriends(var n: integer; var preferences: TMArray;
var pairs: TMArray): integer;
var
  unhappy: integer;
  index_of_preference: TDictionary<integer, TDictionary<integer, integer>>;
  pairs_map, o_index, s: TDictionary<integer, integer>;
  no_of_pairs: integer;
  preferences_i: TList<integer>;
  i, u, v, k: integer;
  t, h, x, y: integer;
  condition_1: Boolean;
  condition_2: Boolean;
  A, B: integer;
Begin

  unhappy := 0;

  // create a map for each pair
  pairs_map := TDictionary<integer, integer>.Create;

  no_of_pairs := high(pairs);

  for i := 0 to no_of_pairs do
  Begin
    pairs_map.Add(pairs[i][0], pairs[i][1]);
    pairs_map.Add(pairs[i][1], pairs[i][0]);

  End;

  // for each friend create the map, whose value is again a map of friendNumber as key and the serial number in
  // preference list
  index_of_preference := TDictionary < integer, TDictionary < integer,
    integer >>.Create;

  for i := 0 to n - 1 do
  Begin
    // if (o_index <>nil)then
    // freeandnil(o_index);
      //destroy dictionary after create ....

    o_index := TDictionary<integer, integer>.Create;


    for t := 0 to n - 2 do
      o_index.Add(preferences[i][t], t);
    try
      index_of_preference.Add(i, o_index);
    finally
      // freeandnil(o_index)
    end;
  end;

  // check for each friend whether he is happy or unhapppy
  for i := 0 to n - 1 do
  Begin

    // now i is our x
    x := i;

    // now paired friend of x is our y
    y := pairs_map[x];

    // preferences_i is the preference list of ith friend

    // if not assigned(preferences_i)then
    // freeandnil(preferences_i);
    preferences_i := TList<integer>.Create;
    for h := 0 to n - 2 do
    begin
      preferences_i.Add(preferences[i][h]);
    end;

    // x prefers u over y
    condition_1 := true;

    // u prefers x over v
    condition_2 := true;

    // initially all friends are happy
    // check for each friend whether he is happy unhappy

    for k := 0 to n - 1 do
    Begin
      u := preferences_i[k];
      v := pairs_map[u];

      // if u is not equals to y that means u is prefered before y
      // so we need to check second condition
      if (u <> y) then
      begin
        // if (s <>nil)then
        // freeandnil(s);
        s := TDictionary<integer, integer>.Create;

        s := index_of_preference[u];
        A := s[x];
        B := s[v];

        if (A < B) then
        Begin
          condition_1 := false;
          condition_2 := false;
        End;

      end
      else
      begin
        // if u==y first condition is true
        break;
      end;

      if ((condition_1 = false) and (condition_2 = false)) then
      begin
        inc(unhappy);
        break;
      end;

    end;

  end;

  try
    freeandnil(index_of_preference);
    freeandnil(pairs_map);
    freeandnil(o_index);
    freeandnil(preferences_i);
    freeandnil(s);

  finally
    result := unhappy;
  end;

end;

end.
