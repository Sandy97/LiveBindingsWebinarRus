object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 559
  ClientWidth = 1082
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object ListView1: TListView
    Left = 8
    Top = 24
    Width = 401
    Height = 288
    Columns = <>
    TabOrder = 0
    ViewStyle = vsList
  end
  object Edit1: TEdit
    Left = 464
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 1
    Text = '4290283019'
  end
  object Edit2: TEdit
    Left = 464
    Top = 112
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'Edit2'
  end
  object Edit3: TEdit
    Left = 464
    Top = 176
    Width = 121
    Height = 21
    TabOrder = 3
    Text = 'Edit3'
  end
  object ListView2: TListView
    Left = 639
    Top = 24
    Width = 154
    Height = 288
    Columns = <>
    TabOrder = 4
    ViewStyle = vsList
  end
  object Edit4: TEdit
    Left = 824
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 5
    Text = 'Edit4'
  end
  object Edit5: TEdit
    Left = 824
    Top = 112
    Width = 241
    Height = 21
    TabOrder = 6
    Text = 'Edit5'
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 368
    Width = 401
    Height = 177
    DataSource = DataSource1
    TabOrder = 7
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object pbsFooObjects: TPrototypeBindSource
    AutoActivate = True
    AutoPost = False
    FieldDefs = <
      item
        Name = 'Value'
        FieldType = ftUInteger
        Generator = 'AlphaColors'
        ReadOnly = False
      end
      item
        Name = 'Name'
        Generator = 'BitmapNames'
        ReadOnly = False
      end>
    ScopeMappings = <>
    OnCreateAdapter = pbsFooObjectsCreateAdapter
    Left = 424
    Top = 40
  end
  object pbsFooFoo2Object: TPrototypeBindSource
    AutoActivate = True
    AutoPost = False
    FieldDefs = <
      item
        Name = 'Foo2Value'
        Generator = 'ColorsNames'
        ReadOnly = True
      end>
    ScopeMappings = <>
    OnCreateAdapter = pbsFooFoo2ObjectCreateAdapter
    Left = 416
    Top = 104
  end
  object pbsFooFeeObject: TPrototypeBindSource
    AutoActivate = True
    AutoPost = False
    FieldDefs = <
      item
        Name = 'FeeValue'
        Generator = 'ColorsNames'
        ReadOnly = True
      end>
    ScopeMappings = <>
    OnCreateAdapter = pbsFooFeeObjectCreateAdapter
    Left = 416
    Top = 168
  end
  object pbsFudObjects: TPrototypeBindSource
    AutoActivate = True
    AutoPost = False
    FieldDefs = <
      item
        Name = 'Value'
        FieldType = ftUInteger
        Generator = 'AlphaColors'
        ReadOnly = False
      end
      item
        Name = 'Name'
        Generator = 'BitmapNames'
        ReadOnly = False
      end>
    ScopeMappings = <>
    OnCreateAdapter = pbsFudObjectsCreateAdapter
    Left = 720
    Top = 64
  end
  object pbsFudFoo: TPrototypeBindSource
    AutoActivate = True
    AutoPost = False
    FieldDefs = <
      item
        Name = 'Foo2Value'
        Generator = 'ColorsNames'
        ReadOnly = True
      end>
    ScopeMappings = <>
    OnCreateAdapter = pbsFudFooCreateAdapter
    Left = 728
    Top = 120
  end
  object FDMemTable1: TFDMemTable
    Active = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 464
    Top = 360
    object FDMemTable1Name: TStringField
      DisplayWidth = 15
      FieldName = 'Name'
      Size = 10
    end
    object FDMemTable1Colour: TStringField
      DisplayWidth = 24
      FieldName = 'Colour'
    end
  end
  object DataSource1: TDataSource
    DataSet = FDMemTable1
    Left = 464
    Top = 416
  end
end
