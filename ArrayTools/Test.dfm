object frmTest: TfrmTest
  Left = 0
  Top = 0
  Caption = 'Test'
  ClientHeight = 546
  ClientWidth = 563
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  DesignSize = (
    563
    546)
  PixelsPerInch = 96
  TextHeight = 13
  object btnSort2Array: TButton
    Left = 8
    Top = 513
    Width = 86
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Sort2Array'
    TabOrder = 0
    OnClick = btnSort2ArrayClick
  end
  object btnIncArray: TButton
    Left = 192
    Top = 513
    Width = 86
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'IncArray'
    TabOrder = 1
    OnClick = btnIncArrayClick
  end
  object btnRotate: TButton
    Left = 100
    Top = 513
    Width = 86
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'RotateArray'
    TabOrder = 2
    OnClick = btnRotateClick
  end
  object btnShortestSubArray: TButton
    Left = 284
    Top = 513
    Width = 86
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'ShortSubArray'
    TabOrder = 3
    OnClick = btnShortestSubArrayClick
  end
  object btnSum: TButton
    Left = 376
    Top = 513
    Width = 86
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Sum'
    TabOrder = 4
    OnClick = btnSumClick
  end
  object btnAdd1: TButton
    Left = 468
    Top = 513
    Width = 86
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Add One'
    TabOrder = 5
    OnClick = btnAdd1Click
  end
  object btnBlockArray: TButton
    Left = 8
    Top = 482
    Width = 86
    Height = 25
    Caption = 'BlockArray'
    TabOrder = 6
    OnClick = btnBlockArrayClick
  end
  object Button1: TButton
    Left = 100
    Top = 482
    Width = 86
    Height = 25
    Caption = 'Button1'
    TabOrder = 7
    OnClick = Button1Click
  end
  object MainMenu1: TMainMenu
    Left = 344
    Top = 176
    object File1: TMenuItem
      Caption = 'File'
      object OpenFiles1: TMenuItem
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object miExit: TMenuItem
        Caption = 'Exit'
        ShortCut = 16453
        OnClick = miExitClick
      end
    end
    object A2: TMenuItem
      Caption = 'About'
      object miAbout: TMenuItem
        Caption = 'About'
        ShortCut = 16449
        OnClick = miAboutClick
      end
    end
  end
end
