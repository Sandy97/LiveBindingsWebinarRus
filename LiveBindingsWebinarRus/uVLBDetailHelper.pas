unit uVLBDetailHelper;

interface

uses Data.Bind.ObjectScope, System.Generics.Collections, Classes;

type
  // Need to swap this to get the details using Generics
  TVLBGetDetail<TM,TD: class> = reference to function(aCurrentMaster : TM) : TD;
  TVLBGetDetailList<TM,TD: class> = reference to function(aCurrentMaster : TM) : TList<TD>;

  TVLBSyncMasterListDetailList<TM,TD: class> = class
  strict private
    FMasterAdapter: TListBindSourceAdapter<TM>;
    FDetailAdapter: TListBindSourceAdapter<TD>;
    FGetDetail: TVLBGetDetailList<TM,TD>;
    procedure OnAfterScroll(Adapter: TBindSourceAdapter);
    procedure OnBeforeScroll(Adapter: TBindSourceAdapter);
  public
    constructor Create(aMaster : TList<TM>; aGetDetail : TVLBGetDetailList<TM,TD>);
    property MasterBindSource : TListBindSourceAdapter<TM> read FMasterAdapter;
    property DetailBindSource : TListBindSourceAdapter<TD> read FDetailAdapter;
  end;

  TVLBSyncMasterListDetailObject<TM,TD: class> = class
  strict private
    FMasterAdapter: TListBindSourceAdapter<TM>;
    FDetailAdapter: TObjectBindSourceAdapter<TD>;
    FGetDetail: TVLBGetDetail<TM,TD>;
    procedure OnAfterScroll(Adapter: TBindSourceAdapter);
    procedure OnBeforeScroll(Adapter: TBindSourceAdapter);
  public
    constructor Create(aMaster : TList<TM>; aGetDetail : TVLBGetDetail<TM,TD>);
    property MasterBindSource : TListBindSourceAdapter<TM> read FMasterAdapter;
    property DetailBindSource : TObjectBindSourceAdapter<TD> read FDetailAdapter;
  end;

implementation

{ TVLBSyncMasterListDetailList<TM, TD> }

constructor TVLBSyncMasterListDetailList<TM, TD>.Create(aMaster : TList<TM>; aGetDetail : TVLBGetDetailList<TM,TD>);
var
  NewDetail: TList<TD>;
begin
  Assert(Assigned(aGetDetail));
  inherited Create;
  FGetDetail := aGetDetail;

  FMasterAdapter := TListBindSourceAdapter<TM>.Create(nil,aMaster,False);
  TListBindSourceAdapter<TM>(FMasterAdapter).AfterScroll := OnAfterScroll;
  TListBindSourceAdapter<TM>(FMasterAdapter).BeforeScroll := OnBeforeScroll;

  NewDetail := FGetDetail(TM(FMasterAdapter.Current));
  FDetailAdapter := TListBindSourceAdapter<TD>.Create(nil,NewDetail,False);

  OnAfterScroll(FMasterAdapter);
end;

procedure TVLBSyncMasterListDetailList<TM, TD>.OnAfterScroll(
  Adapter: TBindSourceAdapter);
var
  NewDetail : TList<TD>;
begin
  if (FDetailAdapter <> nil) and (FMasterAdapter <> nil) then
  begin
    if FMasterAdapter.Current is TM then begin
      // List details of current master
      NewDetail := FGetDetail(TM(FMasterAdapter.Current));
      FDetailAdapter.SetList(NewDetail, False)  // False because instances are owned by master
    end else
      // Empty list
      FDetailAdapter.SetList(TList<TD>.Create, False);

    // CODE REVIEW.... What is the best way to handle nil?
    if FDetailAdapter.Current <> nil then
      // Activate because SetList deactivates.
      FDetailAdapter.Active := True;
  end;
end;

procedure TVLBSyncMasterListDetailList<TM, TD>.OnBeforeScroll(
  Adapter: TBindSourceAdapter);
begin
  if (FDetailAdapter <> nil) and (FMasterAdapter <> nil) then
    if FDetailAdapter.State in seEditModes then
      FDetailAdapter.Post;
end;

{ TVLBSyncMasterListDetailObject<TM, TD> }

constructor TVLBSyncMasterListDetailObject<TM, TD>.Create(aMaster : TList<TM>; aGetDetail : TVLBGetDetail<TM,TD>);
var
  NewDetail: TD;
begin
  inherited Create;
  FGetDetail := aGetDetail;

  FMasterAdapter := TListBindSourceAdapter<TM>.Create(nil,aMaster,False);
  TListBindSourceAdapter<TM>(FMasterAdapter).AfterScroll := OnAfterScroll;
  TListBindSourceAdapter<TM>(FMasterAdapter).BeforeScroll := OnBeforeScroll;

  NewDetail := FGetDetail(TM(FMasterAdapter.Current));
  FDetailAdapter := TObjectBindSourceAdapter<TD>.Create(nil,NewDetail,False);

  OnAfterScroll(FMasterAdapter);
end;

procedure TVLBSyncMasterListDetailObject<TM, TD>.OnAfterScroll(
  Adapter: TBindSourceAdapter);
var
  NewDetail : TD;
begin
  if (FDetailAdapter <> nil) and (FMasterAdapter <> nil) then
  begin
    if FMasterAdapter.Current is TM then begin
      // List details of current master
      NewDetail := FGetDetail(TM(FMasterAdapter.Current));
      FDetailAdapter.SetDataObject(NewDetail, False)  // False because instances are owned by master
    end else
      // Empty list
      FDetailAdapter.SetDataObject(nil, False);

    // CODE REVIEW.... What is the best way to handle nil?
    if FDetailAdapter.Current <> nil then
      FDetailAdapter.Active := True;
  end;
end;

procedure TVLBSyncMasterListDetailObject<TM, TD>.OnBeforeScroll(
  Adapter: TBindSourceAdapter);
begin
  if (FDetailAdapter <> nil) and (FMasterAdapter <> nil) then
    if FDetailAdapter.State in seEditModes then
      FDetailAdapter.Post;
end;

end.
