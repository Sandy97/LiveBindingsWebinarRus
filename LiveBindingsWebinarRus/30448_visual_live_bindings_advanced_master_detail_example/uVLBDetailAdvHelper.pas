unit uVLBDetailAdvHelper;

interface

uses
  Data.Bind.ObjectScope, System.Generics.Collections, Classes;

type
  // methods used to get the latest version of the object.
  TfuncVLBGetDetail<TM,TD: class> = reference to function(aCurrentMaster : TM) : TD;
  TfuncVLBGetDetailList<TM,TD: class> = reference to function(aCurrentMaster : TM) : TObjectList<TD>;

  TVLBSyncDetailBase = class;
  TVLBSyncDetailLinkArray = Array of TVLBSyncDetailBase;

  // Foundation class for all detail objects
  TVLBSyncDetailBase = class
  private
    FDetailArray: TVLBSyncDetailLinkArray;
    function GetDetailBindSource: TBindSourceAdapter; virtual; abstract;
    procedure OnAfterScroll(Adapter: TBindSourceAdapter); virtual; abstract;
    procedure OnBeforeScroll(Adapter: TBindSourceAdapter); virtual; abstract;
    procedure SetDetailArray(const Value: TVLBSyncDetailLinkArray);
  public
    property DetailBindSource : TBindSourceAdapter read GetDetailBindSource;
    property DetailsArray : TVLBSyncDetailLinkArray read FDetailArray write SetDetailArray;
    destructor Destroy; override;
  end;

  // Base Class for all detail classes working with Generics
  TVLBSyncGenericDetailBase<TM, TD : class> = class(TVLBSyncDetailBase)
  private
  end;

  // Link for an Object
  TVLBSyncDetailObjectLink<TM, TD : class> = class(TVLBSyncGenericDetailBase<TM, TD>)
  strict private
    FGetDetail: TfuncVLBGetDetail<TM,TD>;
    FDetailAdapter: TObjectBindSourceAdapter<TD>;
    function GetDetailBindSource: TBindSourceAdapter; override;
    procedure OnAfterScroll(Adapter: TBindSourceAdapter);  override;
    procedure OnBeforeScroll(Adapter: TBindSourceAdapter); override;
  public
    constructor Create(aMaster: TM; aGetDetail: TfuncVLBGetDetail<TM, TD>; aDetailArray : TVLBSyncDetailLinkArray);
    destructor Destroy; override;
  end;

  // Link for an Object List
  TVLBSyncDetailListLink<TM, TD : class> = class(TVLBSyncGenericDetailBase<TM, TD>)
  strict private
    FGetDetail: TfuncVLBGetDetailList<TM,TD>;
    FDetailListAdapter: TListBindSourceAdapter<TD>;
    function GetDetailBindSource: TBindSourceAdapter; override;

    procedure OnUIAfterScroll(Adapter: TBindSourceAdapter);
    procedure OnUIBeforeScroll(Adapter: TBindSourceAdapter);

    procedure OnAfterScroll(Adapter: TBindSourceAdapter);  override;
    procedure OnBeforeScroll(Adapter: TBindSourceAdapter); override;
  public
    constructor Create(aMaster: TM; aGetDetail: TfuncVLBGetDetailList<TM, TD>; aDetailArray : TVLBSyncDetailLinkArray);
    destructor Destroy; override;
  end;

  // Master class that has the top level list.
  TVLBSyncMasterList<TM : class> = class
  strict private
    FMasterAdapter: TListBindSourceAdapter<TM>;
    FDetailArray: TVLBSyncDetailLinkArray;
    procedure OnAfterScroll(Adapter: TBindSourceAdapter);
    procedure OnBeforeScroll(Adapter: TBindSourceAdapter);
    procedure SetDetailsArray(const Value: TVLBSyncDetailLinkArray);
  public
    constructor Create(aMaster : TList<TM>; aDetailArray : TVLBSyncDetailLinkArray);
    destructor Destroy; override;
    property MasterBindSource : TListBindSourceAdapter<TM> read FMasterAdapter;
    property DetailsArray : TVLBSyncDetailLinkArray read FDetailArray write SetDetailsArray;
  end;

implementation

uses Dialogs;

{ TVLBSyncMasterList<TM> }

constructor TVLBSyncMasterList<TM>.Create(aMaster: TList<TM>;
  aDetailArray: TVLBSyncDetailLinkArray);
begin
  FDetailArray := aDetailArray;

  FMasterAdapter := TListBindSourceAdapter<TM>.Create(nil,aMaster,False);
  TListBindSourceAdapter<TM>(FMasterAdapter).AfterScroll := OnAfterScroll;
  TListBindSourceAdapter<TM>(FMasterAdapter).BeforeScroll := OnBeforeScroll;

  //OnAfterScroll(FMasterAdapter);
end;

destructor TVLBSyncMasterList<TM>.Destroy;
var
  Detail : TVLBSyncDetailBase;
begin
  for Detail in DetailsArray do begin
    if Detail <> nil then
      Detail.Free;
  end;

  inherited;
end;

procedure TVLBSyncMasterList<TM>.OnAfterScroll(Adapter: TBindSourceAdapter);
var
  Detail : TVLBSyncDetailBase;
begin
  if (FMasterAdapter <> nil) then begin
    for Detail in DetailsArray do
      Detail.OnAfterScroll(Adapter);
  end;
end;

procedure TVLBSyncMasterList<TM>.OnBeforeScroll(Adapter: TBindSourceAdapter);
var
  Detail : TVLBSyncDetailBase;
begin
  if (FMasterAdapter <> nil) then begin
    for Detail in DetailsArray do
      Detail.OnBeforeScroll(Adapter);
  end;
end;

procedure TVLBSyncMasterList<TM>.SetDetailsArray(
  const Value: TVLBSyncDetailLinkArray);
var
  detail: TVLBSyncDetailBase;
begin
  // Assert no nulls.
  for detail in Value do
    Assert(Assigned(detail),'Detail Array Value cannot be null');

  FDetailArray := Value;
end;

{ TVLBSyncDetailLink<TM, TD> }

constructor TVLBSyncDetailObjectLink<TM, TD>.Create(aMaster: TM; aGetDetail: TfuncVLBGetDetail<TM, TD>; aDetailArray : TVLBSyncDetailLinkArray);
var
  NewDetail: TD;
begin
  inherited Create;
  FGetDetail := aGetDetail;
  DetailsArray := aDetailArray;

  NewDetail := FGetDetail(aMaster);
  FDetailAdapter := TObjectBindSourceAdapter<TD>.Create(nil,NewDetail,False);
end;

destructor TVLBSyncDetailObjectLink<TM, TD>.Destroy;
begin
  FDetailAdapter.Free;
  inherited;
end;

function TVLBSyncDetailObjectLink<TM, TD>.GetDetailBindSource: TBindSourceAdapter;
begin
  Result := FDetailAdapter;
end;

procedure TVLBSyncDetailObjectLink<TM, TD>.OnAfterScroll(Adapter: TBindSourceAdapter);
var
  NewDetail : TD;
  Detail : TVLBSyncDetailBase;
begin

  if (FDetailAdapter <> nil) and (Adapter <> nil) and (Adapter.Current <> nil) then
  begin
    if Adapter.Current is TM then begin
      // List details of current master
      NewDetail := FGetDetail(TM(Adapter.Current));
      FDetailAdapter.SetDataObject(NewDetail, False)  // False because instances are owned by master
    end else begin
      // Empty list
      FDetailAdapter.SetDataObject(nil, False);
    end;

    // CODE REVIEW.... What is the best way to handle nil?
    if FDetailAdapter.Current <> nil then
      FDetailAdapter.Active := True;

    for Detail in DetailsArray do
      Detail.OnAfterScroll(DetailBindSource);
  end;

end;

procedure TVLBSyncDetailObjectLink<TM, TD>.OnBeforeScroll(
  Adapter: TBindSourceAdapter);
var
  Detail : TVLBSyncDetailBase;
begin
  if (FDetailAdapter <> nil) and (Adapter <> nil) then begin
    if FDetailAdapter.State in seEditModes then
      FDetailAdapter.Post;

    for Detail in DetailsArray do
      Detail.OnBeforeScroll(DetailBindSource);
  end;
end;

{ TVLBSyncDetailListLink<TM, TD> }

constructor TVLBSyncDetailListLink<TM, TD>.Create(aMaster: TM;
  aGetDetail: TfuncVLBGetDetailList<TM, TD>;
  aDetailArray: TVLBSyncDetailLinkArray);
var
  NewDetail: TList<TD>;
begin
  inherited Create;
  FGetDetail := aGetDetail;
  DetailsArray := aDetailArray;

  NewDetail := FGetDetail(aMaster);
  FDetailListAdapter := TListBindSourceAdapter<TD>.Create(nil,NewDetail,False);
  FDetailListAdapter.AfterScroll := OnUIAfterScroll;
  FDetailListAdapter.BeforeScroll := OnUIBeforeScroll;
end;

destructor TVLBSyncDetailListLink<TM, TD>.Destroy;
begin
  FDetailListAdapter.Free;
  inherited;
end;

function TVLBSyncDetailListLink<TM, TD>.GetDetailBindSource: TBindSourceAdapter;
begin
  Result := FDetailListAdapter;
end;

procedure TVLBSyncDetailListLink<TM, TD>.OnAfterScroll(
  Adapter: TBindSourceAdapter);
var
  NewDetail : TList<TD>;
  Detail : TVLBSyncDetailBase;
begin
  if (FDetailListAdapter <> nil) and (Adapter <> nil) then
  begin
    if Adapter.Current is TM then begin
      // List details of current master
      NewDetail := FGetDetail(Adapter.Current);
      FDetailListAdapter.SetList(NewDetail, False)  // False because instances are owned by master
    end else begin
      // Empty list
      FDetailListAdapter.SetList(nil, False);
    end;

    // CODE REVIEW.... What is the best way to handle nil?
    if FDetailListAdapter.Current <> nil then
      FDetailListAdapter.Active := True;

    for Detail in DetailsArray do begin
      Detail.OnAfterScroll(FDetailListAdapter);
    end;
  end;
end;

procedure TVLBSyncDetailListLink<TM, TD>.OnBeforeScroll(
  Adapter: TBindSourceAdapter);
var
  Detail : TVLBSyncDetailBase;
begin
  if (FDetailListAdapter <> nil) and (Adapter <> nil) then begin
    if FDetailListAdapter.State in seEditModes then
      FDetailListAdapter.Post;

    for Detail in DetailsArray do
      Detail.OnBeforeScroll(FDetailListAdapter);
  end;
end;

procedure TVLBSyncDetailListLink<TM, TD>.OnUIAfterScroll(
  Adapter: TBindSourceAdapter);
var
  Detail : TVLBSyncDetailBase;
begin
  for Detail in DetailsArray do
    Detail.OnAfterScroll(FDetailListAdapter);
end;

procedure TVLBSyncDetailListLink<TM, TD>.OnUIBeforeScroll(
  Adapter: TBindSourceAdapter);
var
  Detail : TVLBSyncDetailBase;
begin
  for Detail in DetailsArray do
    Detail.OnBeforeScroll(FDetailListAdapter);
end;

{ TVLBSyncDetailBase }

destructor TVLBSyncDetailBase.Destroy;
var
  Detail : TVLBSyncDetailBase;
begin
  for Detail in DetailsArray do begin
    if Detail <> nil then
      Detail.Free;
  end;

  inherited;
end;

procedure TVLBSyncDetailBase.SetDetailArray(
  const Value: TVLBSyncDetailLinkArray);
var
  detail: TVLBSyncDetailBase;
begin
  // Assert no nulls.
  for detail in Value do
    Assert(Assigned(detail),'Detail Array Value cannot be null');

  FDetailArray := Value;
end;

end.
