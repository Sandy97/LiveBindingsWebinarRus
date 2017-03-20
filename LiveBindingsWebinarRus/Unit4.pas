unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Bind.GenData, Data.Bind.GenData,
  Data.Bind.Components, Data.Bind.ObjectScope, Vcl.ComCtrls, Vcl.StdCtrls, System.Generics.Collections,
  System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.EngExt,
  Vcl.Bind.DBEngExt;

type
  TRobj = class(TObject)
  private
    FName: string;
    FValue: Integer;
    procedure SetName(const Value: string);
    procedure SetValue(const Value: Integer);
  published
    property Name: string read FName write SetName;
    Property Value: Integer read FValue write SetValue;
  end;

  TForm4 = class(TForm)
    PrototypeBindSource1: TPrototypeBindSource;
    Edit1: TEdit;
    ListView1: TListView;
    procedure FormCreate(Sender: TObject);
    procedure PrototypeBindSource1CreateAdapter(Sender: TObject;
      var ABindSourceAdapter: TBindSourceAdapter);
  private
    { Private declarations }
    RobjList: TObjectList<TRobj>;
  public
    { Public declarations }
    constructor Create(Aowner:TComponent); override;
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}


procedure TRobj.SetName(const Value: string);
begin
  FName := Value;
end;

procedure TRobj.SetValue(const Value: Integer);
begin
  FValue := Value;
end;

constructor TForm4.Create(Aowner: TComponent);
var
  ro: TRobj;
begin
  RobjList:= TObjectList<TRobj>.Create(True);

  ro:=TRobj.Create;
  ro.Name := 'Abc';
  ro.Value:= 123456;
  RobjList.Add(ro);

  ro:=TRobj.Create;
  ro.Name := 'Smith';
  ro.Value:= 98765;
  RobjList.Add(ro);

  inherited;
end;

procedure TForm4.FormCreate(Sender: TObject);
var
  LinkListControlToField1: TLinkListControlToField;
  LinkControlToField1: TLinkControlToField;
begin
  LinkListControlToField1 := TLinkListControlToField.Create(self);
  with LinkListControlToField1 do
  begin
    DataSource := PrototypeBindSource1;
    FieldName := 'Name';
    Control := ListView1;
  end;
  LinkControlToField1 := TLinkControlToField.Create(self);
  with LinkControlToField1 do
  begin
    DataSource := PrototypeBindSource1;
    FieldName := 'Value';
    Control := Edit1;
    Track := True;
  end;
  PrototypeBindSource1.Active:=False;
  PrototypeBindSource1.Active:=True;
end;

procedure TForm4.PrototypeBindSource1CreateAdapter(Sender: TObject;
 var ABindSourceAdapter: TBindSourceAdapter);
begin
  ABindSourceAdapter:= TListBindSourceAdapter<TRobj>.Create(self,RobjList,True);
end;

end.
