unit uFoo;

interface

uses System.Generics.Collections;

type
  TFoo = class;
  TFoo2 = class;
  TFee = class;
  TFud = class;
  TFooList = TObjectList<TFoo>;
  TFudList = TObjectList<TFud>;

  TFoo = class
  strict private
    FName: string;
    FValue: Integer;
    FFoo2: TFoo2;
    FFee: TFee;
    FFudList: TFudList;
  public
    constructor Create(aName: string; aValue : Integer);
    destructor Destroy; override;
    property Name : string read FName write FName;
    property Value : Integer read FValue write FValue;
    property Foo2 : TFoo2 read FFoo2;
    property Fee : TFee read FFee;
    property FudList : TFudList read FFudList;
  end;

  TFoo2 = class
  private
    FFoo2Value: string;
  public
    property Foo2Value: string read FFoo2Value write FFoo2Value;
  end;

  TFee = class
  private
    FFeeValue: string;
  public
    property FeeValue: string read FFeeValue write FFeeValue;
  end;

  TFud = class
  strict private
    FName: string;
    FValue: Integer;
    FFudFoo: TFoo2;
  public
    constructor Create(aName: string; aValue : Integer);
    destructor Destroy; override;
    property Name : string read FName write FName;
    property Value : Integer read FValue write FValue;
    property FudFoo : TFoo2 read FFudFoo;
  end;



implementation

{ TFoo }

constructor TFoo.Create(aName: string; aValue: Integer);

  procedure AddFud(aName: string; aValue : Integer);
  var
    aFud: TFud;
  begin
    aFud := TFud.Create(aName,aValue);
    FFudList.Add(aFud);
  end;

begin
  inherited Create;
  Name := aName;
  Value := aValue;
  FFoo2 := TFoo2.Create;
  FFoo2.Foo2Value := aName+'''s Foo2';

  FFee := TFee.Create;
  FFee.FeeValue := aName+'''s Fee';

  FFudList := TFudList.Create(True);
  AddFud(aName+' Item 1',1);
  AddFud(aName+' Item 2',2);
  AddFud(aName+' Item 3',3);
  AddFud(aName+' Item 4',4);
end;


destructor TFoo.Destroy;
begin
  FFoo2.Free;
  FFee.Free;
  FFudList.Free;
  inherited;
end;

{ TFud }

constructor TFud.Create(aName: string; aValue: Integer);
begin
  inherited Create;
  Name := aName;
  Value := aValue;

  FFudFoo := TFoo2.Create;
  FFudFoo.FFoo2Value := 'FooFud for '+aName;
end;


destructor TFud.Destroy;
begin
  FFudFoo.Free;
  inherited;
end;

end.
