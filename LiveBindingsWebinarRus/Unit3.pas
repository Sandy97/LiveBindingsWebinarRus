unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Bind.GenData, Data.Bind.GenData,
  Data.Bind.Controls, System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors,
  Data.Bind.EngExt, Vcl.Bind.DBEngExt, Data.Bind.Components, Vcl.ExtCtrls,
  Vcl.Buttons, Vcl.Bind.Navigator, Vcl.StdCtrls, Vcl.ComCtrls,
  Data.Bind.ObjectScope;

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

  TForm3 = class(TForm)
    PrototypeBindSource1: TPrototypeBindSource;
    ListView1: TListView;
    Edit1: TEdit;
    NavigatorPrototypeBindSource1: TBindNavigator;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    LinkControlToField1: TLinkControlToField;
    procedure PrototypeBindSource1CreateAdapter(Sender: TObject;
      var ABindSourceAdapter: TBindSourceAdapter);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

{ TRobj }
uses
 System.Generics.Collections;

procedure TRobj.SetName(const Value: string);
begin
  FName := Value;
end;

procedure TRobj.SetValue(const Value: Integer);
begin
  FValue := Value;
end;

procedure TForm3.PrototypeBindSource1CreateAdapter(Sender: TObject;
  var ABindSourceAdapter: TBindSourceAdapter);
var
  RobjList: TObjectList<TRobj>;
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

  ABindSourceAdapter:= TListBindSourceAdapter<TRobj>.Create(self,RobjList,True);
end;

end.
