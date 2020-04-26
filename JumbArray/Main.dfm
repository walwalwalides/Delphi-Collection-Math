object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'JumbArray'
  ClientHeight = 407
  ClientWidth = 539
  Color = clWhite
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
  object lblresult: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 31
    Width = 533
    Height = 13
    Align = alTop
    Caption = 'lblresult'
    ExplicitTop = 107
    ExplicitWidth = 37
  end
  object lblArrayInput: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 533
    Height = 13
    Align = alTop
    Caption = 'lblArrayInput'
    ExplicitWidth = 63
  end
  object lblTitelInput: TLabel
    Left = 128
    Top = 9
    Width = 34
    Height = 13
    Caption = 'Input:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblOutput: TLabel
    Left = 128
    Top = 41
    Width = 42
    Height = 13
    Caption = 'Output:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object bvlSperate: TBevel
    AlignWithMargins = True
    Left = 3
    Top = 19
    Width = 533
    Height = 6
    Align = alTop
    ExplicitTop = 95
    ExplicitWidth = 629
  end
  object Bevel1: TBevel
    AlignWithMargins = True
    Left = 3
    Top = 47
    Width = 533
    Height = 6
    Align = alTop
    ExplicitLeft = -2
    ExplicitTop = 251
    ExplicitWidth = 629
  end
  object btnCalcule: TButton
    Left = 232
    Top = 350
    Width = 75
    Height = 25
    Caption = 'Calcule'
    TabOrder = 0
    OnClick = btnCalculeClick
  end
  object MainMenu: TMainMenu
    Left = 21
    Top = 336
    object N1: TMenuItem
      Caption = '&File'
      ShortCut = 16454
      object N2: TMenuItem
        Caption = '&Exit'
        ShortCut = 16453
        OnClick = N2Click
      end
    end
    object A1: TMenuItem
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
