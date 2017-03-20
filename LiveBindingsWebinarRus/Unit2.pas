unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.Bind.GenData, System.Rtti,
  System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.EngExt,
  Vcl.Bind.DBEngExt, Data.Bind.Components, Data.Bind.ObjectScope, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Bind.GenData, uVLBDetailAdvHelper, uFoo, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TForm2 = class(TForm)
    ListView1: TListView;
    pbsFooObjects: TPrototypeBindSource;
    Edit1: TEdit;
    Edit2: TEdit;
    pbsFooFoo2Object: TPrototypeBindSource;
    Edit3: TEdit;
    pbsFooFeeObject: TPrototypeBindSource;
    ListView2: TListView;
    pbsFudObjects: TPrototypeBindSource;
    Edit4: TEdit;
    Edit5: TEdit;
    pbsFudFoo: TPrototypeBindSource;
    FDMemTable1: TFDMemTable;
    FDMemTable1Name: TStringField;
    FDMemTable1Colour: TStringField;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    procedure pbsFooObjectsCreateAdapter(Sender: TObject;
      var ABindSourceAdapter: TBindSourceAdapter);
    procedure FormCreate(Sender: TObject);
    procedure pbsFooFoo2ObjectCreateAdapter(Sender: TObject;
      var ABindSourceAdapter: TBindSourceAdapter);
    procedure pbsFooFeeObjectCreateAdapter(Sender: TObject;
      var ABindSourceAdapter: TBindSourceAdapter);
    procedure pbsFudObjectsCreateAdapter(Sender: TObject;
      var ABindSourceAdapter: TBindSourceAdapter);
    procedure pbsFudFooCreateAdapter(Sender: TObject;
      var ABindSourceAdapter: TBindSourceAdapter);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FooList: TFooList;
    Sync : TVLBSyncMasterList<Tfoo>;
  public
    { Public declarations }
    constructor Create(AOwner : TComponent); override;
  end;



var
  Form2: TForm2;

implementation

{$R *.dfm}

constructor TForm2.Create(AOwner: TComponent);
var
  aFoo: TFoo;
  DetailsArray : TVLBSyncDetailLinkArray;
  SubDetail : TVLBSyncDetailLinkArray;

  procedure AddDataSetRecord(aName, aColour : string);
  begin
    FDMemTable1.Append;
    FDMemTable1Name.AsString := aName;
    FDMemTable1Colour.AsString := aColour;
    FDMemTable1.Post;
  end;
begin
  /// Sample Data
  FooList := TFooList.Create(True);

  aFoo := TFoo.Create('Bob',100);
  FooList.Add(aFoo);

  aFoo := TFoo.Create('Frank',200);
  FooList.Add(aFoo);

  aFoo := TFoo.Create('George',300);
  FooList.Add(aFoo);

  SetLength(DetailsArray,4);

  DetailsArray[0] := TVLBSyncDetailObjectLink<Tfoo, Tfoo2>.Create(FooList[0],
    function(aCurrentMaster : TFoo) : TFoo2
    begin
      if aCurrentMaster = nil then
        Result := nil
      else
        Result := aCurrentMaster.Foo2;
    end, []);

  DetailsArray[1] := TVLBSyncDetailObjectLink<Tfoo, Tfee>.Create(FooList[0],
    function(aCurrentMaster : TFoo) : TFee
    begin
      if aCurrentMaster = nil then
        Result := nil
      else
        Result := aCurrentMaster.Fee;
    end, []);

    // Now for a list in an object that is kept in sync
    SetLength(SubDetail,1);
    SubDetail[0] := TVLBSyncDetailObjectLink<TFud, TFoo2>.Create(FooList[0].FudList[0],
      function(aCurrentMaster : TFud) : TFoo2
      begin
        if aCurrentMaster = nil then
          Result := nil
        else
          Result := aCurrentMaster.FudFoo;
      end, []);

  DetailsArray[2] := TVLBSyncDetailListLink<Tfoo, Tfud>.Create(FooList[0],
    function(aCurrentMaster : TFoo) : TFudList
    begin
      if aCurrentMaster = nil then
        Result := nil
      else
        Result := aCurrentMaster.FudList;
    end, SubDetail);

  DetailsArray[3] := TVLBSyncDetailObjectLink<Tfoo, TDataSet>.Create(FooList[0],
    function(aCurrentMaster : TFoo) : TDataSet
    begin
      if not Assigned(FDMemTable1) then
        Exit(nil);
      if aCurrentMaster = nil then begin
        Result := nil;
        DBGrid1.Visible := False;
      end else begin
        Result := FDMemTable1;
        FDMemTable1.Filter := 'NAME='+aCurrentMaster.Name.QuotedString;
        FDMemTable1.Filtered := True;
        DBGrid1.Visible := True;
      end;
    end, []);


  Sync := TVLBSyncMasterList<Tfoo>.Create(FooList, DetailsArray);

  inherited;

  AddDataSetRecord('Bob','Green');
  AddDataSetRecord('Bob','Orange');
  AddDataSetRecord('George','Red');
  AddDataSetRecord('George','Blue');
  AddDataSetRecord('Frank','Yellow');
end;

procedure TForm2.FormCreate(Sender: TObject);
var
  ListLink: TLinkListControlToField;
  LinkControl: TLinkControlToField;
begin
  pbsFooObjects.Active := False;
  {$REGION 'LiveBinding Creation'}
  ListLink := TLinkListControlToField.Create(Self);
  ListLink.DataSource := pbsFooObjects;
  ListLink.FieldName := 'Name';
  ListLink.Control := ListView1;

  LinkControl := TLinkControlToField.Create(Self);
  LinkControl.DataSource := pbsFooObjects;
  LinkControl.FieldName := 'Value';
  LinkControl.Control := Edit1;
  LinkControl.Track := True;

  LinkControl := TLinkControlToField.Create(Self);
  LinkControl.DataSource := pbsFooFoo2Object;
  LinkControl.FieldName := 'Foo2Value';
  LinkControl.Control := Edit2;
  LinkControl.Track := True;

  LinkControl := TLinkControlToField.Create(Self);
  LinkControl.DataSource := pbsFooFeeObject;
  LinkControl.FieldName := 'FeeValue';
  LinkControl.Control := Edit3;
  LinkControl.Track := True;

  ListLink := TLinkListControlToField.Create(Self);
  ListLink.DataSource := pbsFudObjects;
  ListLink.FieldName := 'Name';
  ListLink.Control := ListView2;

  LinkControl := TLinkControlToField.Create(Self);
  LinkControl.DataSource := pbsFudObjects;
  LinkControl.FieldName := 'Value';
  LinkControl.Control := Edit4;
  LinkControl.Track := True;

  LinkControl := TLinkControlToField.Create(Self);
  LinkControl.DataSource := pbsFudFoo;
  LinkControl.FieldName := 'Foo2Value';
  LinkControl.Control := Edit5;
  LinkControl.Track := True;
  {$ENDREGION}


  pbsFooObjects.Active := True;
end;

procedure TForm2.FormDestroy(Sender: TObject);
begin
  Sync.Free;
  FooList.Free;
end;

procedure TForm2.pbsFooObjectsCreateAdapter(Sender: TObject;
  var ABindSourceAdapter: TBindSourceAdapter);
begin
  ABindSourceAdapter := Sync.MasterBindSource;
end;

procedure TForm2.pbsFudFooCreateAdapter(Sender: TObject;
  var ABindSourceAdapter: TBindSourceAdapter);
begin
  ABindSourceAdapter := Sync.DetailsArray[2].DetailsArray[0].DetailBindSource;
end;

procedure TForm2.pbsFudObjectsCreateAdapter(Sender: TObject;
  var ABindSourceAdapter: TBindSourceAdapter);
begin
  ABindSourceAdapter := Sync.DetailsArray[2].DetailBindSource;
end;

procedure TForm2.pbsFooFeeObjectCreateAdapter(Sender: TObject;
  var ABindSourceAdapter: TBindSourceAdapter);
begin
  ABindSourceAdapter := Sync.DetailsArray[1].DetailBindSource;
end;

procedure TForm2.pbsFooFoo2ObjectCreateAdapter(Sender: TObject;
  var ABindSourceAdapter: TBindSourceAdapter);
begin
  ABindSourceAdapter := Sync.DetailsArray[0].DetailBindSource;
end;

end.
