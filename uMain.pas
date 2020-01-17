unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.OleCtrls, SHDocVw,ActiveX,MSHTML,urlmon,
  strutils,uConfig,uLog,uFuncs,
  Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.FileCtrl, Vcl.Menus, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase,
  IdFTPList,shellapi, IdFTP, IdGlobal, IdFTPCommon,  IdAllFTPListParsers,
  System.ImageList, Vcl.ImgList; //

type
  TfMain = class(TForm)
    Page1: TPageControl;
    Panel1: TPanel;
    btnLoad: TButton;
    Bar1: TStatusBar;
    tsRemote: TTabSheet;
    ts1: TTabSheet;
    WebRemote: TWebBrowser;
    WebModel: TWebBrowser;
    edtUrl: TEdit;
    tsArticle: TTabSheet;
    memoArticle: TMemo;
    btnCopyContent: TButton;
    btnMerge: TButton;
    btnMerge2: TButton;
    tsMerge: TTabSheet;
    WebMerge: TWebBrowser;
    btnSaveas: TButton;
    Save1: TSaveDialog;
    webNew: TWebBrowser;
    tsNew: TTabSheet;
    Panel2: TPanel;
    Drive1: TDriveComboBox;
    Dir1: TDirectoryListBox;
    Panel3: TPanel;
    File1: TFileListBox;
    tsLocal: TTabSheet;
    WebLocal: TWebBrowser;
    edtFile: TEdit;
    btnClose: TButton;
    GroupBox1: TGroupBox;
    edtTitle: TEdit;
    tsFtpsite: TTabSheet;
    Panel4: TPanel;
    edtAddr: TEdit;
    edtPort: TEdit;
    Label2: TLabel;
    edtUser: TEdit;
    Label3: TLabel;
    edtPwd: TEdit;
    Label4: TLabel;
    btnConnect: TButton;
    ListFtpFile: TListView;
    memoftp: TMemo;
    PopFile: TPopupMenu;
    PopDownFile: TMenuItem;
    PopDelFile: TMenuItem;
    Panel5: TPanel;
    edtFtpDir: TEdit;
    btnParentDir: TButton;
    Label1: TLabel;
    FTP1: TIdFTP;
    btnDisconnect: TButton;
    IMLFolders: TImageList;
    N1: TMenuItem;
    btnCancel: TButton;
    btnUpfile: TButton;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    tssite: TTabSheet;
    website: TWebBrowser;
    Splitter1: TSplitter;
    Panel6: TPanel;
    memoLocal: TMemo;
    edtLocalFile: TEdit;
    btnLocalBrush: TButton;
    btnLocalSave: TButton;
    Panel7: TPanel;
    edtRemote: TEdit;
    btnRemoteBrush: TButton;
    btnRemoteSave: TButton;
    MemoRemote: TMemo;
    Splitter2: TSplitter;
    Panel8: TPanel;
    edtModel: TEdit;
    btnModelBrush: TButton;
    Button2: TButton;
    memoModel: TMemo;
    MemoMerge: TMemo;
    Splitter3: TSplitter;
    Splitter4: TSplitter;
    Panel9: TPanel;
    edtnew: TEdit;
    btnNew: TButton;
    Button3: TButton;
    memoNew: TMemo;
    procedure btnLoadClick(Sender: TObject);
    procedure WebRemoteDocumentComplete(ASender: TObject; const pDisp: IDispatch;
      const URL: OleVariant);
    procedure WebRemoteNavigateComplete2(ASender: TObject; const pDisp: IDispatch;
      const URL: OleVariant);
    procedure WebModelDocumentComplete(ASender: TObject; const pDisp: IDispatch;
      const URL: OleVariant);
    procedure btnCopyContentClick(Sender: TObject);
    procedure btnMergeClick(Sender: TObject);
    procedure btnMerge2Click(Sender: TObject);
    procedure btnSaveasClick(Sender: TObject);
    procedure WebMergeDocumentComplete(ASender: TObject; const pDisp: IDispatch;
      const URL: OleVariant);
    procedure webNewDocumentComplete(ASender: TObject; const pDisp: IDispatch;
      const URL: OleVariant);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure WebRemoteBeforeNavigate2(ASender: TObject; const pDisp: IDispatch;
      const URL, Flags, TargetFrameName, PostData, Headers: OleVariant;
      var Cancel: WordBool);
    procedure btnCloseClick(Sender: TObject);
    procedure edtFileChange(Sender: TObject);
    procedure WebLocalDocumentComplete(ASender: TObject; const pDisp: IDispatch;
      const URL: OleVariant);
    procedure WebLocalNavigateComplete2(ASender: TObject; const pDisp: IDispatch;
      const URL: OleVariant);
    procedure FTP1AfterClientLogin(Sender: TObject);
    procedure FTP1Connected(Sender: TObject);
    procedure FTP1Disconnected(Sender: TObject);
    procedure FTP1Status(ASender: TObject; const AStatus: TIdStatus;
      const AStatusText: string);
    procedure btnParentDirClick(Sender: TObject);
    procedure btnConnectClick(Sender: TObject);
    procedure btnDisconnectClick(Sender: TObject);
    procedure FTP1Work(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure FTP1WorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
    procedure FTP1WorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    procedure ListFtpFileDblClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure PopDelFileClick(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure PopDownFileClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure websiteDocumentComplete(ASender: TObject;
      const pDisp: IDispatch; const URL: OleVariant);
    procedure websiteNavigateComplete2(ASender: TObject;
      const pDisp: IDispatch; const URL: OleVariant);
    procedure btnLocalSaveClick(Sender: TObject);
    procedure btnLocalBrushClick(Sender: TObject);
    procedure btnRemoteBrushClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure btnUpfileClick(Sender: TObject);
    procedure FTP1BannerBeforeLogin(ASender: TObject; const AMsg: string);
  private
    { Private declarations }
    mLocalHomeDir:string;
    mFtpWorkCount:Int64;
    procedure AppException(Sender: TObject; E: Exception);
    procedure initLocaldir();
    procedure initHostdir();
    procedure ftpListfile(subdir:string);
    function GetFileIconIndex(FileName: string; Large: Boolean): Integer;

    procedure doDownloadDir(idftp:TIdFTP;dir,LocalPath:string);
    procedure doUploadDir(idftp:TIdFTP;LocalPath,FileExt:string);
    function ftpConnected():boolean;
    procedure doDelDir(idftp:TIdFTP;dir:string);
    procedure uploadfile(ftp:TIdFTP;LocalFile:string);
    procedure FtpConnect();
  public
    { Public declarations }
  end;

var
  fMain: TfMain;

  mProtocol,mSite,mTitle,mCharset,mPage,mWorkDir,mModelPage:string;
function getPageCode(doc:IHTMLDocument2):string;//����ҳ��Դ����
function getPageContent(doc:IHTMLDocument2;tag:string):string;//����ҳ��Դ����
function DownloadToFile(Source, Dest: string): Boolean;
function SaveAsPage(doc:IHTMLDocument2;localPageName:string):string;//ҳ�����Ϊ
procedure SaveSinglePage(doc:IHTMLDocument2;localPageName:string);//��������һ��ҳ��
procedure  WB_LoadHTML(WebBrowser:  TWebBrowser;  HTMLCode:  string);//�� HTML ����ֱ�Ӽ��뵽 TWebbrowser �����ȥ
procedure  WBLoadHTML(WebBrowser:  TWebBrowser;  HTMLCode:  tstrings);
implementation

{$R *.dfm}
procedure TfMain.FtpConnect();
procedure connectproc();stdcall;
begin
  fmain.ftp1.Connect;
end;
var
  threadId:Cardinal;
begin
  createthread(nil,0,@connectproc,nil,0,threadId);
end;
procedure TfMain.uploadfile(ftp:TIdFTP;LocalFile:string);
begin
  if ftp.Connected=false then exit;
  ftp.Put(LocalFile);
end;
procedure TfMain.doDelDir(idftp:TIdFTP;dir:string);
var
  t : TIdFTPListItem;
  i : integer;
  fileName,foldName : String;
begin   //����
  idftp.changedir(dir);                          //�ı�Ŀ¼
  idftp.List(nil);                               //��ȡ��ǰĿ¼����Ϣ
  for i:=0 to idftp.DirectoryListing.Count-1 do
  begin
    t := idftp.DirectoryListing.Items[i];        //�õ�һ���ļ������Ϣ
    fileName := t.FileName;                      //��ȡ�ļ���
    if t.ItemType = ditFile then                 //������ļ�����ֱ������
    begin
      idftp.Delete(filename);
    end
    else if (t.ItemType = ditdirectory) then     //������ļ��У�������ѭ�������ļ��е�����
    begin
      foldName :=t.FileName;
      doDelDir(idftp,foldName);    //�ݹ���ã�����һ��һ���ѭ���������ļ�������
      //idFTP.ChangeDirUp();                   //�����ϼ�Ŀ¼
      //idFTP.RemoveDir(foldName);
      idFTP.List(nil);
    end;
  end;
  idFTP.ChangeDirUp();
  idFTP.RemoveDir(dir);
end;


function TfMain.ftpConnected():boolean;
begin
  result:=ftp1.Connected;
  if result=false then showmessage('ftp�Ѿ��Ͽ����ӣ�');
end;
procedure TfMain.doUploadDir(idftp:TIdFTP;LocalPath,FileExt:string);
var
  sch:TSearchrec;
  subdir:string;
begin
  subdir:=extractfilename(LocalPath);
  if rightStr(trim(subdir), 1) = '\' then subdir:=leftstr(trim(subdir),length(subdir)-1);

if rightStr(trim(LocalPath), 1) <> '\' then
    LocalPath := trim(LocalPath) + '\'
else
    LocalPath := trim(LocalPath);

if not DirectoryExists(LocalPath) then
begin
    exit;
end;
  idftp.MakeDir(subdir);
  idftp.ChangeDir(subdir);
if FindFirst(LocalPath + '*', faAnyfile, sch) = 0 then
begin
    repeat
       Application.ProcessMessages;
       if ((sch.Name = '.') or (sch.Name = '..')) then Continue;
       if DirectoryExists(LocalPath+sch.Name) then
       begin
         doUploadDir(idftp,LocalPath+sch.Name,FileExt);
         idftp.ChangeDirUp;
       end
       else
       begin
         if (UpperCase(extractfileext(LocalPath+sch.Name)) = UpperCase(FileExt)) or (FileExt='.*') then
         begin
           IdFTP.TransferType := ftBinary;
           IdFTP.Put(LocalPath+sch.Name, sch.Name);
         end;
       end;
    until FindNext(sch) <> 0;
    System.SysUtils.FindClose(sch);
end;

end;
procedure TfMain.doDownloadDir(idftp:TIdFTP;dir,LocalPath:string);
var
  t : TIdFTPListItem;
  i : integer;
  fileName,foldName : String;
begin   //����
  if not DirectoryExists(LocalPath+dir) then     //�������Ŀ¼�������򴴽��ļ���
  begin
    ForceDirectories(LocalPath+dir);             //����һ��ȫ·�����ļ���
  end;
  idftp.changedir(dir);                          //�ı�Ŀ¼
  idftp.List(nil);                               //��ȡ��ǰĿ¼����Ϣ

  idftp.TransferType := ftBinary;                //ָ��Ϊ�������ļ�   ���ı��ļ�ftASCII
  for i:=0 to idftp.DirectoryListing.Count-1 do
  begin
    t := idftp.DirectoryListing.Items[i];        //�õ�һ���ļ������Ϣ
    fileName := t.FileName;                      //��ȡ�ļ���
    if t.ItemType = ditFile then                 //������ļ�����ֱ������
    begin
      idftp.Get(fileName,LocalPath + dir+'\' + fileName,True); //���ص����أ���Ϊ����
    end
    else if (t.ItemType = ditdirectory) then     //������ļ��У�������ѭ�������ļ��е�����
    begin
      foldName :=t.FileName;
      doDownloadDir(idftp,dir+'\'+foldName,LocalPath);    //�ݹ���ã�����һ��һ���ѭ���������ļ�������
      idFTP.ChangeDirUp();                   //�����ϼ�Ŀ¼
      idFTP.List(nil);
    end;
  end;
end;


function tfmain.GetFileIconIndex(FileName: string; Large: Boolean): Integer;
{ ��ȡͼ�����ź��� }
var
  Ext: string;
  Flags: Integer;
  FileInfo:TSHFileInfoA ;
  tmpstr:string;
begin
  Ext := FileName;
  Flags := SHGFI_SYSICONINDEX or SHGFI_TYPENAME or SHGFI_USEFILEATTRIBUTES;
  if Large then
    Flags := Flags or SHGFI_LARGEICON
  else
    Flags := Flags or SHGFI_SMALLICON;
  SHGetFileInfoA(PansiChar(Ext), 0, FileInfo, SizeOf(FileInfo), Flags);
  Result := FileInfo.iIcon;
  tmpstr:=FileInfo.szDisplayName;
  tmpstr:=FileInfo.szTypeName;
  //FileInfo.
  //self.Caption:=FileInfo.szTypeName;
end;
procedure TfMain.ftpListfile(subdir:string);
var
  i:integer;
  itemFtp:TIdFTPListItem;
  item:tListitem;
begin
  ListFtpFile.Clear;
  if subdir<>'' then ftp1.ChangeDir(subdir);
  FTP1.List();
  edtFtpDir.Text:=ftp1.RetrieveCurrentDir;
  for i:=0 to FTP1.DirectoryListing.Count-1 do
  begin
    itemFtp:=FTP1.DirectoryListing.Items[i];
    if itemFtp.ItemType = ditDirectory then
    begin
      item:=ListFtpFile.Items.Add;
      item.Caption:=itemFtp.FileName;
      item.ImageIndex:=7;
      //if itemFtp.ItemType = ditFile then item.ImageIndex:=8;
      //if itemFtp.ItemType = ditDirectory then item.ImageIndex:=7;
      //item.ImageIndex:=getFileiconIndex(item.Caption,false);
      item.SubItems.Add(inttostr(itemFtp.Size));
      item.SubItems.Add(datetimetostr(itemFtp.ModifiedDate)); //,TFormatSettings.
    end;
  end;
  for i:=0 to FTP1.DirectoryListing.Count-1 do
  begin
    itemFtp:=FTP1.DirectoryListing.Items[i];
    if itemFtp.ItemType = ditFile then
    begin
      item:=ListFtpFile.Items.Add;
      item.Caption:=itemFtp.FileName;
      item.ImageIndex:=8;
      item.SubItems.Add(inttostr(itemFtp.Size));
      item.SubItems.Add(datetimetostr(itemFtp.ModifiedDate)); //,TFormatSettings.
    end;
  end;
end;
procedure TfMain.initLocaldir();
var
  drive:char;
  pagedir:string;
begin
  mLocalHomeDir:=uConfig.LOCAL_DIR;
  drive:=mLocalHomeDir[1];
  drive1.Drive:=drive;

  dir1.Directory:=mLocalHomeDir;
end;
procedure TfMain.ListFtpFileDblClick(Sender: TObject);
var
  item:tListItem;
begin
  item:=ListFtpfile.Selected;
  if item.ImageIndex=7 then
  begin
    ftpListfile(item.Caption);
  end;
end;

procedure TfMain.N1Click(Sender: TObject);
var
  dir:string;
begin
  if not ftpConnected() then exit;
  dir:=inputbox('����Ŀ¼','������Ŀ¼��?','');
  if dir='' then exit;
try
  ftp1.MakeDir(dir);
  ftpListFile('');
finally

end;
end;

procedure TfMain.N2Click(Sender: TObject);
var
  curdir:string;
begin
  if not ftpConnected() then exit;
  doUploadDir(ftp1,dir1.Directory,'.*');
  curdir:=ftp1.RetrieveCurrentDir;
  ftpListfile(curdir);
end;

procedure TfMain.N3Click(Sender: TObject);
var
  dir:string;
  item:tListItem;
begin
  if not ftpConnected() then exit;
  item:=listftpfile.Selected;
  if item.ImageIndex<>7 then exit;
  doDownLoadDir(ftp1,item.Caption,dir1.Directory);
end;

procedure TfMain.N4Click(Sender: TObject);
var
  item:tListItem;
begin
  if not ftpConnected() then exit;
  item:=listftpfile.Selected;
  if item.ImageIndex<>7 then exit;
  //ftp1.RemoveDir(item.Caption);
  doDelDir(ftp1,item.Caption);
  ftpListFile('');
end;

procedure TfMain.N5Click(Sender: TObject);
var
  item:tListItem;
  filename,dir,Localfile:string;
begin
  if not ftpConnected() then exit;
  filename:=edtfile.Text;
  if(filename='*.*')then exit;
  localfile:=dir1.Directory+'\'+filename;
try
  ftp1.Put(LocalFile,filename,true);
  ftpListFile('');
finally

end;
end;

procedure TfMain.PopDelFileClick(Sender: TObject);
var
  item:tListItem;
begin
  if not ftpConnected() then exit;
  item:=listftpfile.Selected;
  if item.ImageIndex<>8 then exit;
try
  ftp1.Delete(item.Caption);
  ftpListFile('');
finally

end;
end;

procedure TfMain.PopDownFileClick(Sender: TObject);
var
  item:tListItem;
  filename,dir,Localfile:string;
begin
  if not ftpConnected() then exit;
  item:=listftpfile.Selected;
  if item.ImageIndex<>8 then exit;
  filename:=item.Caption;
  localfile:=dir+'\'+filename;
try
  ftp1.get(filename,LocalFile,true,true);
  ftpListFile('');
finally

end;
end;

procedure TfMain.initHostdir();
var
  drive:char;
  pagedir:string;
begin
  edtAddr.Text:=uConfig.FTP_HOST;
  edtPort.Text:=inttostr(uConfig.FTP_PORT);
  edtUser.Text:=uConfig.FTP_USER;
  edtPwd.text:=uConfig.FTP_PWD;


end;
procedure TfMain.AppException(Sender: TObject; E: Exception);
begin

  Log(e.Message);
end;
//���ڴ��м���ҳ�棨�ȼ���htm�ļ��ٶȿ죩uses ActiveX;
procedure  WBLoadHTML(WebBrowser:  TWebBrowser;  HTMLCode:  tstrings);
var
   ms:  TMemoryStream;
begin
   if  not Assigned(WebBrowser.Document)  then
      WebBrowser.Navigate('about:blank');
   if  Assigned(WebBrowser.Document)  then
   begin
       try
           ms  :=  TMemoryStream.Create;
           try
               HTMLCode.SaveToStream(ms,tEncoding.UTF8);
               ms.Seek(0,  0);
               (WebBrowser.Document  as  IPersistStreamInit).Load(TStreamAdapter.Create(ms));
               finally
               ms.Free;
           end;
       finally
       end;
   end;
end;

function getPageContent(doc:IHTMLDocument2;tag:string):string;//����ҳ��Դ����
var
  content:ihtmlelement;
begin
try
  content:=(doc.all.item(tag,0) as ihtmlelement);
  content.style.removeAttribute('HEIGHT',0);
  result:=content.outerHTML;
finally

end;
end;
function getPageCode(doc:IHTMLDocument2):string;//����ҳ��Դ����
var
  ms: TMemoryStream;
  ss:tstrings;
begin
 ms := TMemoryStream.Create;
 ss:=tstringlist.Create;
try
 (doc as IPersistStreamInit).Save(TStreamAdapter.Create(ms), True);
 ms.Position := 0;
 ss.LoadFromStream(ms,TEncoding.UTF8);
 result:=ss.Text;
finally
 ms.Free;
 ss.Free;
end;

end;

procedure TfMain.btnCancelClick(Sender: TObject);
begin
  if not ftpConnected() then exit;
  FTP1.Abort;
end;

procedure TfMain.btnCloseClick(Sender: TObject);
begin
  close;
end;

procedure TfMain.btnConnectClick(Sender: TObject);
begin
  if ftp1.Connected then
  begin
    try
      ftp1.Abort;
      ftp1.Quit;
   finally

   end
  end;
try
  ftp1.Host:=edtAddr.Text;
  ftp1.Port:=strtoint(edtPort.Text);
  ftp1.Username:=edtUser.Text;
  ftp1.Password:=edtPwd.Text;
  ftp1.TransferType := ftASCII;
  FTP1.passive :=true;
  //ftp1.Connect;
  FtpConnect();
finally

end;
end;

procedure TfMain.btnCopyContentClick(Sender: TObject);
var
  doc:IHTMLDocument2;
begin
  doc:=WebRemote.Document as IHTMLDocument2; //�õ��ӿڣ�
  memoArticle.Lines.Text:=getpagecontent(doc,'article_content');
  bar1.Panels[0].Text:='������ϣ�';
  page1.ActivePage:=tsArticle;
end;

procedure TfMain.btnDisconnectClick(Sender: TObject);
begin
  ftp1.Disconnect;
end;

procedure TfMain.btnLoadClick(Sender: TObject);
begin
  page1.ActivePage:=tsRemote;
  WebRemote.Navigate(edturl.Text);
  bar1.Panels[0].Text:='���ڼ���ҳ��...';
  WebModel.Navigate(mModelPage);
  edtRemote.Text:=edturl.Text;
  edtModel.Text:=mModelPage;
  //web2.Navigate(memo2.Lines.Text);
end;

procedure TfMain.btnLocalBrushClick(Sender: TObject);
begin
  webLocal.Navigate(edtLocalFile.Text);
end;

procedure TfMain.btnLocalSaveClick(Sender: TObject);
begin
  memoLocal.Lines.SaveToFile(edtLocalFile.Text,TEncoding.UTF8);
  webLocal.Navigate(edtLocalFile.Text);
end;

procedure TfMain.btnMerge2Click(Sender: TObject);
var
  title:string;
begin
  MemoMerge.Lines:=memoModel.Lines;
  MemoMerge.Lines.Insert(12,memoArticle.Text);
  mTitle:=edtTitle.Text;
  title:='<title>'+mTitle+'</title>';
  MemoMerge.Lines.Text:=StringReplace(MemoMerge.Lines.Text,'<title></title>',title,[rfReplaceAll]);
  //mergefilename:=mWorkDir+'\tmp.htm';
  //memo4.Lines.SaveToFile(mergefilename,tEncoding.UTF8);
  bar1.Panels[0].Text:='���ڼ��غϳ�ҳ��...';
  page1.ActivePage:=tsMerge;
  //web3.Navigate(mergefilename);
  wbloadhtml(WebMerge,MemoMerge.Lines);

end;

procedure TfMain.btnMergeClick(Sender: TObject);
var
  doc1,doc2:IHTMLDocument2;
begin
  doc1:=WebRemote.Document as IHTMLDocument2; //�õ��ӿڣ�
  memoRemote.Lines.Text:=getpagecontent(doc1,'article_content');
  doc2:=WebModel.Document as IHTMLDocument2; //�õ��ӿڣ�
  doc2.body.innerHTML:=memoRemote.Lines.Text;
  //doc2.body.innerHTML:='aa';

  //memo4.Lines.Text:=doc2.all.toString;
  memoMerge.Lines.Text:=getpagecode(doc2);
end;

procedure TfMain.btnParentDirClick(Sender: TObject);
begin
  if not ftpConnected() then exit;
try
  ftp1.ChangeDirUp;
  ftpListFile('');
finally

end;
end;

procedure TfMain.btnRemoteBrushClick(Sender: TObject);
begin
  webRemote.Navigate(edtRemote.Text);
end;

procedure TfMain.btnSaveasClick(Sender: TObject);
const
  LI_FLAG='<li><a href=""></a></li>';
var
  filename,fileList,lastLine,lastnum,newnum,newfilename:string; //fileList:list�ļ���;lastline:����li�lastnum:���li��ţ�newnum:���ļ���ţ�newfilename:���ļ�����
  doc3:IHTMLDocument2;
  ss,imglist:tstrings;
  i:integer;
begin
  fileList:=uFuncs.findfile(dir1.Directory,'*list.htm');
  if(fileList='')then
  begin
    showmessage('�޷������ڸ�Ŀ¼��'+dir1.Directory);
    exit;
  end;
  ss:=tstringlist.Create;
  imglist:=tstringlist.Create;
  ss.LoadFromFile(fileList,TEncoding.UTF8);
  for i := 0 to ss.Count-1 do
  begin
    if trim(ss[i])=LI_FLAG then
    begin
      lastLine:=trim(ss[i-1]);
      lastnum:=getNumberFromString(lastLine,'"','"',filename);
      if(lastnum='')then
      begin
        showmessage('û��ȡ����Ŀ��ţ�'+lastLine);
        exit;
      end;
      newnum:=inttostr(strtoint(lastnum)+1);
      newnum := rightstr('000' + newnum, 3);
      newfilename:=StringReplace(filename,lastnum,newnum,[rfReplaceAll]);
      break;
    end;

  end;
  save1.InitialDir:=dir1.Directory;
  save1.FileName:=dir1.Directory+'\'+newfilename;
  //DownloadToFile('https://stackedit.io/style.css','C:\tmp\2\style.css');

  if not Assigned(WebMerge.Document) then Exit;
  if(save1.Execute())then begin
    filename:=save1.FileName;
    save1.InitialDir:=extractfiledir(filename);
    doc3:=WebMerge.Document as IHTMLDocument2;
    imglist.Text:=SaveAsPage(doc3,filename);
    fmain.memoNew.Lines.Text:=fmain.WebMerge.OleObject.Document.all.tags('HTML').Item(0).outerHTML;
    memoNew.Lines.SaveToFile(filename,tEncoding.UTF8);
    page1.ActivePage:=tsnew;
    webNew.Navigate(filename);
    mPage:=filename;
    lastLine:='<li><a href="'+newfilename+'">'+mtitle+'</a></li>';
    ss.Insert(i,lastLine);
    ss.SaveToFile(fileList,tEncoding.UTF8);
    edtnew.Text:=filename;
    //�ϴ���վ��
    if(ftp1.Connected)then
    begin
      ftp1.Put(filename);
      ftp1.Delete(extractfilename(fileList));
      ftp1.Put(fileList);
      if imglist.Count>0 then
      begin
        ftp1.ChangeDir('images');
        for I := 0 to imglist.Count-1 do
        begin
          if(fileexists(imglist[i]))then
             ftp1.Put(imglist[i]);
        end;
        ftp1.ChangeDirUp;
      end;
      ftpListfile('');
      file1.Update;
    end;
  end;
  if assigned(ss) then ss.Free;

end;

procedure TfMain.btnUpfileClick(Sender: TObject);
begin
  N5Click(sender);
end;

procedure TfMain.Button3Click(Sender: TObject);
begin
  page1.ActivePage:=tsNew;
  bar1.Panels[0].Text:='���ڼ��ر���ҳ��...��';
  memoNew.Lines.SaveToFile(edtNew.Text,tEncoding.UTF8);
  webNew.Navigate(edtNew.Text);
end;

procedure TfMain.edtFileChange(Sender: TObject);
var
  filename,fileext,filedir,fullfilename:string;
begin
  filename:=edtFile.Text;
  fileext:=extractfileext(filename);
  if(pos('.htm',fileext)>0)then
  begin
    filedir:=dir1.Directory;
    fullfilename:=filedir+'\'+filename;
    webLocal.Navigate(fullfilename);
    edtLocalFile.text:=fullfilename;
    page1.ActivePage:=tsLocal;
    bar1.Panels[0].Text:='���ڼ��ر���ҳ��...'+fullfilename;
  end;
end;

procedure TfMain.FormCreate(Sender: TObject);
begin
  Application.OnException := AppException;
  //Set8087CW(Longword($133f));
  IEEmulator(11001);
end;

procedure TfMain.FormShow(Sender: TObject);
begin
  mWorkDir:=uConfig.workdir;
  mModelPage:=uConfig.modelfile;
  WebModel.Navigate(mModelPage);
  fmain.caption:=APP_TITLE+APP_VERSION;
  initLocalDir();
  initHostdir();
  website.Navigate(uConfig.SITE_HOME);
end;

procedure TfMain.FTP1AfterClientLogin(Sender: TObject);
begin
  memoftp.Lines.Add('��½�ɹ���');
  bar1.Panels[1].Text:='��½�ɹ���';
  ftpListfile('web');
end;

procedure TfMain.FTP1BannerBeforeLogin(ASender: TObject; const AMsg: string);
begin
  memoftp.Lines.Add(aMsg);
  bar1.Panels[1].Text:='��ʼ��½��';
end;

procedure TfMain.FTP1Connected(Sender: TObject);
var
  ss:tstrings;
begin
  memoftp.Lines.Add('���ӳɹ���');
  bar1.Panels[1].Text:='���ӳɹ�';
  //ftp1.Login;
  //FTP1.List(edtFtpDir.Text);
end;

procedure TfMain.FTP1Disconnected(Sender: TObject);
begin
  memoftp.Lines.Add('�Ͽ����ӣ�');
  bar1.Panels[1].Text:='�Ͽ����ӣ�';
end;

procedure TfMain.FTP1Status(ASender: TObject; const AStatus: TIdStatus;
  const AStatusText: string);
begin
  memoftp.Lines.Add(AStatusText);
end;

procedure TfMain.FTP1Work(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
var
  workmsg:string;
begin
  if(AWorkMode=wmRead)then workmsg:='���ڶ�ȡ����...';
  if(AWorkMode=wmWrite)then workmsg:='�����ϴ�����...';
  workmsg:=workmsg+inttostr(AWorkCount)+'/'+inttostr(mFtpWorkCount);
  bar1.Panels[1].Text:=workmsg;
end;

procedure TfMain.FTP1WorkBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);
var
  workmsg:string;
begin
  if(AWorkMode=wmRead)then workmsg:='׼����ȡ����...';
  if(AWorkMode=wmWrite)then workmsg:='׼���ϴ�����...';
  mFtpWorkCount:=AWorkCountMax;
  bar1.Panels[1].Text:=workmsg;
  memoftp.Lines.Add(workmsg);
end;

procedure TfMain.FTP1WorkEnd(ASender: TObject; AWorkMode: TWorkMode);
var
  workmsg:string;
begin
  if(AWorkMode=wmRead)then workmsg:='��ȡ���ݽ�����';
  if(AWorkMode=wmWrite)then workmsg:='�ϴ����ݽ�����';
  bar1.Panels[1].Text:=workmsg;
  memoftp.Lines.Add(workmsg);
end;

procedure TfMain.WebRemoteBeforeNavigate2(ASender: TObject; const pDisp: IDispatch;
  const URL, Flags, TargetFrameName, PostData, Headers: OleVariant;
  var Cancel: WordBool);
begin
  bar1.Panels[0].Text:='���ڼ���ҳ��...';
end;

procedure TfMain.WebRemoteDocumentComplete(ASender: TObject; const pDisp: IDispatch;
  const URL: OleVariant);
var
  doc:IHTMLDocument2;
begin
  if(WebRemote.ReadyState<>READYSTATE_COMPLETE)then exit;
  doc:=WebRemote.Document as IHTMLDocument2; //�õ��ӿڣ�
  memoRemote.Lines.Text:=getpagecode(doc);
  mProtocol:=doc.protocol;
  mTitle:=doc.title;
  edtTitle.Text:=mTitle;
  mSite:=doc.domain;
  mCharset:=doc.charset;
  if(mProtocol='HyperText Transfer Protocol with Privacy')then mProtocol:='https://' else mProtocol:='http://';
  fmain.caption:=APP_TITLE+APP_VERSION+'('+mTitle+')';
  bar1.Panels[0].Text:='Զ��ҳ�������ϣ�';
  //page1.ActivePageIndex:=1;
end;

procedure TfMain.WebRemoteNavigateComplete2(ASender: TObject; const pDisp: IDispatch;
  const URL: OleVariant);
begin
  WebRemote.Silent := True;
end;

procedure TfMain.WebModelDocumentComplete(ASender: TObject; const pDisp: IDispatch;
  const URL: OleVariant);
var
  doc:IHTMLDocument2;
begin
  doc:=WebModel.Document as IHTMLDocument2; //�õ��ӿڣ�
  memoModel.Lines.Text:=getpagecode(doc);
  bar1.Panels[0].Text:='ģ��ҳ�������ϣ�';

end;
procedure TfMain.WebMergeDocumentComplete(ASender: TObject; const pDisp: IDispatch;
  const URL: OleVariant);
var
  doc:IHTMLDocument2;
begin
  doc:=WebMerge.Document as IHTMLDocument2; //�õ��ӿڣ�
  doc.title:=mTitle;
  memoMerge.Lines.Text:=getpageContent(doc,'html');
  bar1.Panels[0].Text:='�ϳ�ҳ�������ϣ�';
end;

procedure TfMain.webNewDocumentComplete(ASender: TObject; const pDisp: IDispatch;
  const URL: OleVariant);
begin
   bar1.Panels[0].Text:='����ҳ�������ϣ�';
end;

procedure TfMain.WebLocalDocumentComplete(ASender: TObject;
  const pDisp: IDispatch; const URL: OleVariant);
var
  doc:IHTMLDocument2;
begin
  doc:=webLocal.Document as IHTMLDocument2;
  memoLocal.Lines.Text:=getpagecode(doc);
  fmain.Caption:=uConfig.APP_TITLE+uConfig.APP_VERSION+'('+doc.title+')';
  edturl.Text:=doc.url;
  bar1.Panels[0].Text:='����ҳ�������ϣ�';
end;

procedure TfMain.WebLocalNavigateComplete2(ASender: TObject;
  const pDisp: IDispatch; const URL: OleVariant);
begin
  webLocal.Silent := True;
end;

procedure TfMain.websiteDocumentComplete(ASender: TObject;
  const pDisp: IDispatch; const URL: OleVariant);
var
  doc:IHTMLDocument2;
begin
  doc:=website.Document as IHTMLDocument2;
  bar1.Panels[0].Text:='��վҳ�������ϣ�';

end;

procedure TfMain.websiteNavigateComplete2(ASender: TObject;
  const pDisp: IDispatch; const URL: OleVariant);
begin
  webSite.Silent := True;
end;

//------------------------------------------ҳ�����Ϊ��------------------------------------------
{-------------------------------------------------------------------------------
������:    SaveAsPage ��Զ��docҳ�汣��Ϊ����ҳ�棬ͬʱ�޸�ҳ�������ͼƬ���ӵ�ַ������Զ��ͼƬ�����أ����ر���ͼƬ��ַ�б�
����:      doc:IHTMLDocument2;localPageName:string  1.Զ��ҳ�棻2.�����ļ�����
����ֵ:    result:string  ���ر���ͼƬ�б��ַ��

-------------------------------------------------------------------------------}
function SaveAsPage(doc:IHTMLDocument2;localPageName:string):string;//ҳ�����Ϊ
Var
  all:IHTMLElementCollection;
  sheets:IHTMLstyleSheetsCollection;
  len,I,p:integer;
  item:OleVariant;
  url,newUrl,filename,localfilename,localPageDir,localImageDir,filetag,fileext,num:string;
  ss:tstrings;
begin
  //��ҳ�е�ͼƬ�ļ���
  localPageDir:=extractfiledir(localPageName);
  localfilename:=extractfilename(localPageName);
  filetag:=leftstr(localfilename,length(localfilename)-4);
  localImageDir:=localPageDir+'\images';
  if(not System.SysUtils.directoryexists(localImageDir))then System.SysUtils.forcedirectories(localImageDir);
  ss:=tstringlist.Create;
  all:=doc.images;
  len:=all.length;
  for I:=0 to len-1 do begin
    item:=all.item(I,varempty);
    url:=item.src;
    url:=trim(url);
    if(length(url)=0)then continue;
    if(pos('/',url)=1)then url:=mProtocol+mSite+url;
    //replacestr(url,'file://',mProtocol);
    if(leftstr(url,7)='file://')then url:=replacestr(url,'file://',mProtocol);
    num:=inttostr(i+1);
    if(length(num)=1)then num:='0'+num;
    if(url[length(url)-3]='.')then fileext:=rightstr(url,4) else fileext:='.jpg';
    filename:=filetag+num+fileext;
    localfilename:=localImageDir+'\'+filename;
    DownloadToFile(url,localfilename);
    ss.Add(localfilename);
    newUrl:='images/'+filename;
    item.src:=newUrl;
  end;
  result:=ss.Text;
  ss.Free;
  //ss:=tstringlist.Create;
  //ss.Text:=doc.body.outerHTML;
  //ss.SaveToFile(localpagename,TEncoding.UTF8);
  //ss.Free;
  //SaveSinglePage(doc,localpagename);
  //fmain.memo4.Lines:=getPagecode(doc);
end;
procedure SaveSinglePage(doc:IHTMLDocument2;localPageName:string);//��������һ��ҳ��
var
  ms: TMemoryStream;
  ss:tstrings;
begin
 ms := TMemoryStream.Create;
 ss:=tstringlist.Create;
 (doc as IPersistStreamInit).Save(TStreamAdapter.Create(ms), True);
 ms.Position := 0;
 ss.LoadFromStream(ms,TEncoding.UTF8);
 ss.SaveToFile(localPageName,TEncoding.UTF8);
 ms.Free;
 ss.Free;
end;
//------------------------------------------����������----------------------------------------------
//uses urlmon;
function DownloadToFile(Source, Dest: string): Boolean;
begin
  try
    Result := UrlDownloadToFile(nil, PChar(source), PChar(Dest), 0, nil) = 0;
  except
    Result := False;
  end;
end;
procedure  WB_LoadHTML(WebBrowser:  TWebBrowser;  HTMLCode:  string);

var

   sl:  TStringList;

   ms:  TMemoryStream;

begin

   WebBrowser.Navigate('about:blank');

   if  Assigned(WebBrowser.Document)  then

   begin

       sl  :=  TStringList.Create;

       try

           ms  :=  TMemoryStream.Create;

           try

               sl.Text  :=  HTMLCode;

               sl.SaveToStream(ms);

               ms.Seek(0,  0);

               (WebBrowser.Document  as  IPersistStreamInit).Load(TStreamAdapter.Create(ms));

              finally

               ms.Free;

           end;

       finally

           sl.Free;

       end;

   end;

end;
procedure init();
var
  filename:string;
begin
  filename:=application.ExeName;
  mWorkDir:=extractfiledir(filename);
  mModelPage:=mWorkDir+'\csdnmodel.htm';
end;
initialization
  OleInitialize(nil);
  //init();
finalization
  OleUninitialize;
end.


{








procedure TfMain.ftpListfileFirst();
var
  i:integer;
  item:tListitem;
  ss:tstrings;
begin
try
  ss:=tstringlist.Create;
  FTP1.TransferType := ftASCII;
  FTP1.List(ss);
  ListFtpFile.Clear;
  for I := 0 to ss.Count-1 do
  begin
    item:=ListFtpFile.Items.Add;
    item.Caption:=ss[i];
  end;

finally
  ss.Free;
end;
end;
}
