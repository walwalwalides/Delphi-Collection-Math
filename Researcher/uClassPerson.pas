{ ============================================
  Software Name : 	Researcher
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides                     }
{ CopyRight © 2020                             }
{ Email : WalWalWalides@gmail.com              }
{ GitHub :https://github.com/walwalwalides     }
{ ******************************************** }
unit uClassPerson;

interface

uses
  system.classes, system.generics.defaults, system.generics.collections,system.sysutils;

type
  TPersonRecord = record
    Name: string;
    Age: integer;
    Profession: string;
    constructor Create(AName: string; AAge: integer; AProfession: String);

    // Comparer function
    class function NameComparer: IComparer<TPersonRecord>; static;
    class function AgeComparer: IComparer<TPersonRecord>; static;
    Class function ProfessionComparer: IComparer<TPersonRecord>; static;

    // Convert function
    class function ConvertToNames(const Value: TPersonRecord): string; static;
    class function ConvertToAges(const Value: TPersonRecord): integer; static;
    class function ConvertToProfession(const Value: TPersonRecord)
      : string; static;

  end;

implementation

constructor TPersonRecord.Create(AName: string; AAge: integer;
  AProfession: String);
begin
  Name := AName;
  Age := AAge;
  Profession := AProfession;
end;

class function TPersonRecord.ConvertToNames(const Value: TPersonRecord): string;
begin
  Result := Value.Name;
end;

class function TPersonRecord.ConvertToProfession(const Value
  : TPersonRecord): string;
begin
  Result := Value.Profession;
end;


class function TPersonRecord.ConvertToAges(const Value: TPersonRecord): integer;
begin
  Result := Value.Age;
end;

class function TPersonRecord.AgeComparer: IComparer<TPersonRecord>;
begin
  Result := TComparer<TPersonRecord>.Construct(
    function(const Left, Right: TPersonRecord): integer
    begin
      Result := TComparer<integer>.Default.Compare(Left.Age, Right.Age);
    end);
end;

class function TPersonRecord.NameComparer: IComparer<TPersonRecord>;
begin
  Result := TComparer<TPersonRecord>.Construct(
    function(const Left, Right: TPersonRecord): integer
    begin
      Result := TComparer<string>.Default.Compare(Left.Name, Right.Name);
    end);
end;

class function TPersonRecord.ProfessionComparer: IComparer<TPersonRecord>;
begin
  Result := TComparer<TPersonRecord>.Construct(
    function(const Left, Right: TPersonRecord): integer
    Begin
      Result := TComparer<string>.Default.Compare(Left.Profession,
        Right.Profession);
    End);
end;

end.
