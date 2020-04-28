object frmSearch: TfrmSearch
  Left = 0
  Top = 0
  Caption = 'Researcher'
  ClientHeight = 462
  ClientWidth = 292
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblName: TLabel
    Left = 110
    Top = 207
    Width = 47
    Height = 19
    Caption = 'Name'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblAge: TLabel
    Left = 110
    Top = 229
    Width = 32
    Height = 19
    Caption = 'Age'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblProfession: TLabel
    Left = 154
    Top = 283
    Width = 85
    Height = 19
    Caption = 'Profession'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbltitelName: TLabel
    Left = 5
    Top = 207
    Width = 98
    Height = 19
    Caption = 'Name         :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbltitelAge: TLabel
    Left = 5
    Top = 229
    Width = 98
    Height = 19
    Caption = 'Age            :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbltitelProfession: TLabel
    Left = 91
    Top = 283
    Width = 50
    Height = 19
    Caption = 'Prof. :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edtInput: TEdit
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 286
    Height = 21
    Align = alTop
    TabOrder = 0
    OnChange = edtInputChange
    OnKeyDown = edtInputKeyDown
    OnKeyPress = edtInputKeyPress
  end
  object lstboxResult: TListBox
    AlignWithMargins = True
    Left = 3
    Top = 30
    Width = 286
    Height = 171
    Align = alTop
    ItemHeight = 13
    TabOrder = 1
    OnClick = lstboxResultClick
    OnDrawItem = lstboxResultDrawItem
  end
  object MainMenu: TMainMenu
    Left = 5
    Top = 272
    object miS: TMenuItem
      Caption = '&File'
      ShortCut = 16454
      object N2: TMenuItem
        Caption = '&Exit'
        ShortCut = 16453
        OnClick = N2Click
      end
    end
    object miD: TMenuItem
      Caption = '&Display'
      object DAllName: TMenuItem
        Caption = 'All Name'
        OnClick = DAllNameClick
      end
    end
    object miF: TMenuItem
      Caption = '&Filter'
      object A2: TMenuItem
        Caption = 'Age'
        object FiOld: TMenuItem
          Caption = 'Oldest'
          OnClick = FiOldClick
        end
        object FiYoung: TMenuItem
          Caption = 'Youngest '
          OnClick = FiYoungClick
        end
      end
    end
    object miO: TMenuItem
      Caption = '&Option'
      object ONcs: TMenuItem
        Caption = 'No Case Sensitive'
        Checked = True
        RadioItem = True
        OnClick = ONcsClick
      end
      object Ocs: TMenuItem
        Caption = 'Case Sensitive'
        RadioItem = True
        OnClick = OcsClick
      end
    end
    object miA: TMenuItem
      Caption = '&About'
      ShortCut = 16449
      object I1: TMenuItem
        Caption = '&Information'
        ShortCut = 16457
        OnClick = I1Click
      end
    end
  end
end
