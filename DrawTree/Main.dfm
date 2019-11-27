object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'DrawTree'
  ClientHeight = 443
  ClientWidth = 780
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox1: TPaintBox
    Left = 8
    Top = 8
    Width = 490
    Height = 430
  end
  object GrpBoxInsert: TGroupBox
    Left = 504
    Top = 8
    Width = 268
    Height = 177
    Caption = 'Add New Item'
    TabOrder = 0
    object Bevel1: TBevel
      Left = 3
      Top = 85
      Width = 262
      Height = 50
    end
    object edtNumber: TEdit
      Left = 58
      Top = 28
      Width = 153
      Height = 21
      TabOrder = 0
      Text = 'edtNumber'
    end
    object btnInsert: TButton
      Left = 85
      Top = 55
      Width = 100
      Height = 25
      Caption = 'Insert'
      TabOrder = 1
      OnClick = btnInsertClick
    end
    object btnDraw: TButton
      Left = 85
      Top = 141
      Width = 100
      Height = 25
      Caption = 'Draw'
      TabOrder = 2
      OnClick = btnDrawClick
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 424
    Width = 780
    Height = 19
    Panels = <
      item
        Text = 'Nr'#176' of Element : '
        Width = 100
      end
      item
        Width = 50
      end
      item
        Text = 'Max Element'
        Width = 100
      end
      item
        Text = '10'
        Width = 50
      end>
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    Left = 688
    Top = 208
  end
  object MainMenu1: TMainMenu
    Left = 568
    Top = 296
    object File1: TMenuItem
      Caption = 'File'
      object OpenFiles1: TMenuItem
        Action = actOpenFile
      end
      object OpenFolders1: TMenuItem
        Action = actOpenFolder
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Action = actExit
      end
    end
    object Edit1: TMenuItem
      Caption = 'Edit'
      object CopytoClipboard1: TMenuItem
        Action = actCopyToClipboard
      end
    end
    object View1: TMenuItem
      Caption = 'View'
      object Refresh1: TMenuItem
        Action = actRefresh
      end
    end
    object A1: TMenuItem
      Caption = 'Action'
      object C1: TMenuItem
        Action = actClear
      end
      object miSum: TMenuItem
        Action = actSum
        Enabled = False
      end
    end
    object Option1: TMenuItem
      Caption = 'Option'
      object actOption1: TMenuItem
        Action = actSettings
      end
    end
    object A2: TMenuItem
      Caption = 'About'
      object actAbout1: TMenuItem
        Action = actAbout
      end
    end
  end
  object ActionList1: TActionList
    Left = 673
    Top = 304
    object actClear: TAction
      Category = 'Action'
      Caption = 'Clear'
      ShortCut = 16451
    end
    object actSum: TAction
      Category = 'Action'
      Caption = 'Sum'
      ShortCut = 16467
    end
    object actOpenFile: TAction
      Category = 'File'
      Caption = 'Open File(s)...'
    end
    object actShowInExplorer: TAction
      Caption = 'Show in Explorer'
    end
    object actOpenFolder: TAction
      Category = 'File'
      Caption = 'Open Folder(s)...'
    end
    object actExit: TAction
      Category = 'File'
      Caption = 'Exit'
      OnExecute = actExitExecute
    end
    object actCopyToClipboard: TAction
      Category = 'Edit'
      Caption = 'Copy to Clipboard'
      ShortCut = 16451
    end
    object actRefresh: TAction
      Category = 'View'
      Caption = 'Refresh'
      ShortCut = 116
    end
    object actSettings: TAction
      Category = 'Option'
      Caption = 'Settings'
      ShortCut = 16467
    end
    object actAbout: TAction
      Category = 'About'
      Caption = 'Info'
      ShortCut = 16457
      OnExecute = actAboutExecute
    end
  end
end
