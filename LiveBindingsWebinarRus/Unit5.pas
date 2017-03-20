unit Unit5;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  System.Generics.Collections, Vcl.Bind.GenData, Data.Bind.GenData,
  Data.Bind.Components, Data.Bind.ObjectScope, Vcl.StdCtrls, Vcl.ComCtrls,
  uVLBDetailHelper, System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors,
  Data.Bind.EngExt, Vcl.Bind.DBEngExt, Data.Bind.Controls, Vcl.ExtCtrls,
  Vcl.Buttons, Vcl.Bind.Navigator;

type
  TFoo2 = class
  private
    F2V: string;
  public
    property Foo2Value: string read F2V write F2V;
  end;

  TFoo = class
  private
    FName: string;
    FV: Integer;
    FFoo2: TFoo2;
  public
    constructor Create(aName: string; aValue: Integer);
    property Name: string read FName write FName;
    property Value: Integer read FV write FV;
    property Foo2: TFoo2 read FFoo2;
  end;

  TFooList = TObjectList<TFoo>;

  TForm5 = class(TForm)
    ListView1: TListView;
    Edit1: TEdit;
    Edit2: TEdit;
    pbsFooObjectDS: TPrototypeBindSource;
    pbsFooFoo2ObjectDS: TPrototypeBindSource;
    Button1: TButton;
    Edit3: TEdit;
    NavigatorpbsFooObjectDS: TBindNavigator;
    procedure pbsFooObjectDSCreateAdapter(Sender: TObject;
      var ABindSourceAdapter: TBindSourceAdapter);
    procedure FormCreate(Sender: TObject);
    procedure pbsFooFoo2ObjectDSCreateAdapter(Sender: TObject;
      var ABindSourceAdapter: TBindSourceAdapter);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    FooList: TFooList;
    Sync: TVLBSyncMasterListDetailObject<TFoo, TFoo2>;
  public
    { Public declarations }
    constructor Create(Aowner: TComponent); override;
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}
{ TFoo }

constructor TFoo.Create(aName: string; aValue: Integer);
begin
  inherited Create;
  Name := aName;
  Value := aValue;
  FFoo2 := TFoo2.Create;
  FFoo2.Foo2Value := aName + '''s Foo2';
end;

{ TForm5 }

procedure TForm5.Button1Click(Sender: TObject);
begin
  pbsFooObjectDS.Active:=False;
  FooList.Add(TFoo.Create(Edit3.Text, 77770077)); //(aFoo)
  pbsFooObjectDS.Active:=True;
end;

constructor TForm5.Create(Aowner: TComponent);
var
  aFoo: TFoo;
begin
  FooList := TFooList.Create(True);
  aFoo := TFoo.Create('ABC', 2756);
  FooList.Add(aFoo);
  aFoo := TFoo.Create('DEF', 3579);
  FooList.Add(aFoo);
  aFoo := TFoo.Create('GHIJ', 9087);
  FooList.Add(aFoo);

  Sync := TVLBSyncMasterListDetailObject<TFoo, TFoo2>.Create(FooList,
    function(aCurrentMaster: TFoo): TFoo2
    begin
      if aCurrentMaster = nil then
        Result := nil
      else
        Result := aCurrentMaster.Foo2;
    end);

  inherited;

end;

procedure TForm5.FormCreate(Sender: TObject);
var
  LinkListControlToField1: TLinkListControlToField;
  //просто указатель на текущий линк. ”ничтожаетс€ формой
  LinkControlToField1: TLinkControlToField;
begin
  LinkListControlToField1 := TLinkListControlToField.Create(self);
  with LinkListControlToField1 do
  begin
    DataSource := pbsFooObjectDS;
    FieldName := 'Name';
    Control := ListView1;
  end;
  LinkControlToField1 := TLinkControlToField.Create(self);
  with LinkControlToField1 do
  begin
    DataSource := pbsFooObjectDS;
    FieldName := 'Value';
    Control := Edit1;
    Track := True;
  end;
  LinkControlToField1 := TLinkControlToField.Create(self);
  with LinkControlToField1 do
  begin
    DataSource := pbsFooFoo2ObjectDS;
    FieldName := 'Foo2Value';
    Control := Edit2;
    Track := True;
  end;

  pbsFooObjectDS.Active := False;
  pbsFooObjectDS.Active := True;

end;

procedure TForm5.pbsFooObjectDSCreateAdapter(Sender: TObject;
var ABindSourceAdapter: TBindSourceAdapter);
begin
  //вместо этого пользуемс€ набором из sync
  //ABindSourceAdapter := TListBindSourceAdapter<TFoo>.Create(self, FooList, True);
  ABindSourceAdapter := Sync.MasterBindSource;
end;

procedure TForm5.pbsFooFoo2ObjectDSCreateAdapter(Sender: TObject;
  var ABindSourceAdapter: TBindSourceAdapter);
begin
  //вместо этого пользуемс€ набором из sync
  //ABindSourceAdapter := TListBindSourceAdapter<TFoo2>.Create(self, FooList, True);
  ABindSourceAdapter := Sync.DetailBindSource;
end;

end.
