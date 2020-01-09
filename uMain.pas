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
    ts0: TTabSheet;
    ts1: TTabSheet;
    ts2: TTabSheet;
    ts3: TTabSheet;
    Web1: TWebBrowser;
    Web2: TWebBrowser;
    Memo1: TMemo;
    Memo2: TMemo;
    edtUrl: TEdit;
    ts4: TTabSheet;
    Memo3: TMemo;
    btnCopyContent: TButton;
    btnMerge: TButton;
    ts5: TTabSheet;
    Memo4: TMemo;
    btnMerge2: TButton;
    ts6: TTabSheet;
    Web3: TWebBrowser;
    btnSaveas: TButton;
    Save1: TSaveDialog;
    tsLocalContent: TTabSheet;
    Memo5: TMemo;
    web4: TWebBrowser;
    btnSave: TButton;
    ts8: TTabSheet;
    Panel2: TPanel;
    Drive1: TDriveComboBox;
    Dir1: TDirectoryListBox;
    Panel3: TPanel;
    File1: TFileListBox;
    tsList: TTabSheet;
    tsListCode: TTabSheet;
    WebList: TWebBrowser;
    memoList: TMemo;
    edtFile: TEdit;
    btnClose: TButton;
    GroupBox1: TGroupBox;
    edtTitle: TEdit;
    tsWebsite: TTabSheet;
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
    procedure btnLoadClick(Sender: TObject);
    procedure Web1DocumentComplete(ASender: TObject; const pDisp: IDispatch;
      const URL: OleVariant);
    procedure Web1NavigateComplete2(ASender: TObject; const pDisp: IDispatch;
      const URL: OleVariant);
    procedure Web2DocumentComplete(ASender: TObject; const pDisp: IDispatch;
      const URL: OleVariant);
    procedure btnCopyContentClick(Sender: TObject);
    procedure btnMergeClick(Sender: TObject);
    procedure btnMerge2Click(Sender: TObject);
    procedure btnSaveasClick(Sender: TObject);
    procedure Web3DocumentComplete(ASender: TObject; const pDisp: IDispatch;
      const URL: OleVariant);
    procedure btnSaveClick(Sender: TObject);
    procedure web4DocumentComplete(ASender: TObject; const pDisp: IDispatch;
      const URL: OleVariant);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Web1BeforeNavigate2(ASender: TObject; const pDisp: IDispatch;
      const URL, Flags, TargetFrameName, PostData, Headers: OleVariant;
      var Cancel: WordBool);
    procedure btnCloseClick(Sender: TObject);
    procedure edtFileChange(Sender: TObject);
    procedure WebListDocumentComplete(ASender: TObject; const pDisp: IDispatch;
      const URL: OleVariant);
    procedure WebListNavigateComplete2(ASender: TObject; const pDisp: IDispatch;
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
  public
    { Public declarations }
  end;

var
  fMain: TfMain;

  mProtocol,mSite,mTitle,mCharset,mPage,mWorkDir,mModelPage:string;
function getPageCode(doc:IHTMLDocument2):string;//返回页面源代码
function getPageContent(doc:IHTMLDocument2;tag:string):string;//返回页面源代码
function DownloadToFile(Source, Dest: string): Boolean;
procedure SaveAsPage(doc:IHTMLDocument2;localPageName:string);//页面另存为
procedure SaveSinglePage(doc:IHTMLDocument2;localPageName:string);//仅仅保存一个页面
procedure  WB_LoadHTML(WebBrowser:  TWebBrowser;  HTMLCode:  string);//将 HTML 代码直接加入到 TWebbrowser 组件中去
procedure  WBLoadHTML(WebBrowser:  TWebBrowser;  HTMLCode:  tstrings);
implementation

{$R *.dfm}
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
begin   //连接
  idftp.changedir(dir);                          //改变目录
  idftp.List(nil);                               //获取当前目录的信息
  for i:=0 to idftp.DirectoryListing.Count-1 do
  begin
    t := idftp.DirectoryListing.Items[i];        //得到一个文件相关信息
    fileName := t.FileName;                      //获取文件名
    if t.ItemType = ditFile then                 //如果是文件，则直接下载
    begin
      idftp.Delete(filename);
    end
    else if (t.ItemType = ditdirectory) then     //如果是文件夹，则往下循环下载文件夹的内容
    begin
      foldName :=t.FileName;
      doDelDir(idftp,foldName);    //递归调用，往下一层一层的循环下载子文件夹数据
      //idFTP.ChangeDirUp();                   //返回上级目录
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
  if result=false then showmessage('ftp已经断开连接！');
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
begin   //连接
  if not DirectoryExists(LocalPath+dir) then     //如果本地目录不存在则创建文件夹
  begin
    ForceDirectories(LocalPath+dir);             //创建一个全路径的文件夹
  end;
  idftp.changedir(dir);                          //改变目录
  idftp.List(nil);                               //获取当前目录的信息

  idftp.TransferType := ftBinary;                //指定为二进制文件   或文本文件ftASCII
  for i:=0 to idftp.DirectoryListing.Count-1 do
  begin
    t := idftp.DirectoryListing.Items[i];        //得到一个文件相关信息
    fileName := t.FileName;                      //获取文件名
    if t.ItemType = ditFile then                 //如果是文件，则直接下载
    begin
      idftp.Get(fileName,LocalPath + dir+'\' + fileName,True); //下载到本地，并为覆盖
    end
    else if (t.ItemType = ditdirectory) then     //如果是文件夹，则往下循环下载文件夹的内容
    begin
      foldName :=t.FileName;
      doDownloadDir(idftp,dir+'\'+foldName,LocalPath);    //递归调用，往下一层一层的循环下载子文件夹数据
      idFTP.ChangeDirUp();                   //返回上级目录
      idFTP.List(nil);
    end;
  end;
end;


function tfmain.GetFileIconIndex(FileName: string; Large: Boolean): Integer;
{ 获取图标的序号函数 }
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
  dir:=inputbox('创建目录','请输入目录名?','');
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
//从内存中加载页面（比加载htm文件速度快）uses ActiveX;
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

function getPageContent(doc:IHTMLDocument2;tag:string):string;//返回页面源代码
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
function getPageCode(doc:IHTMLDocument2):string;//返回页面源代码
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
  ftp1.Connect;

finally

end;
end;

procedure TfMain.btnCopyContentClick(Sender: TObject);
var
  doc:IHTMLDocument2;
begin
  doc:=web1.Document as IHTMLDocument2; //得到接口；
  memo3.Lines.Text:=getpagecontent(doc,'article_content');
  bar1.Panels[0].Text:='加载完毕！';
  page1.ActivePageIndex:=6;
end;

procedure TfMain.btnDisconnectClick(Sender: TObject);
begin
  ftp1.Disconnect;
end;

procedure TfMain.btnLoadClick(Sender: TObject);
begin
  page1.ActivePageIndex:=2;
  web1.Navigate(edturl.Text);
  bar1.Panels[0].Text:='正在加载页面...';
  web2.Navigate(mModelPage);
  //web2.Navigate(memo2.Lines.Text);
end;

procedure TfMain.btnMerge2Click(Sender: TObject);
var
  title:string;
begin
  memo4.Lines:=memo2.Lines;
  memo4.Lines.Insert(12,memo3.Text);
  mTitle:=edtTitle.Text;
  title:='<title>'+mTitle+'</title>';
  memo4.Lines.Text:=StringReplace(memo4.Lines.Text,'<title></title>',title,[rfReplaceAll]);
  //mergefilename:=mWorkDir+'\tmp.htm';
  //memo4.Lines.SaveToFile(mergefilename,tEncoding.UTF8);
  bar1.Panels[0].Text:='正在加载合成页面...';
  page1.ActivePageIndex:=8;
  //web3.Navigate(mergefilename);
  wbloadhtml(web3,memo4.Lines);

end;

procedure TfMain.btnMergeClick(Sender: TObject);
var
  doc1,doc2:IHTMLDocument2;
begin
  doc1:=web1.Document as IHTMLDocument2; //得到接口；
  memo1.Lines.Text:=getpagecontent(doc1,'article_content');
  doc2:=web2.Document as IHTMLDocument2; //得到接口；
  doc2.body.innerHTML:=memo1.Lines.Text;
  //doc2.body.innerHTML:='aa';

  //memo4.Lines.Text:=doc2.all.toString;
  memo4.Lines.Text:=getpagecode(doc2);
end;

procedure TfMain.btnParentDirClick(Sender: TObject);
begin
  N5Click(sender);
end;

procedure TfMain.btnSaveasClick(Sender: TObject);
const
  LI_FLAG='<li><a href=""></a></li>';
var
  filename,fileList,lastLine,lastnum,newnum,newfilename:string; //fileList:list文件名;lastline:最后的li项；lastnum:最大li编号；newnum:新文件编号；newfilename:新文件名；
  doc3:IHTMLDocument2;
  ss:tstrings;
  i:integer;
begin
  fileList:=uFuncs.findfile(dir1.Directory,'*list.htm');
  if(fileList='')then
  begin
    showmessage('无法保存在该目录：'+dir1.Directory);
    exit;
  end;
  ss:=tstringlist.Create;
  ss.LoadFromFile(fileList,TEncoding.UTF8);
  for i := 0 to ss.Count-1 do
  begin
    if trim(ss[i])=LI_FLAG then
    begin
      lastLine:=trim(ss[i-1]);
      lastnum:=getNumberFromString(lastLine,'"','"',filename);
      if(lastnum='')then
      begin
        showmessage('没有取得项目编号：'+lastLine);
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

  if not Assigned(web3.Document) then Exit;
  if(save1.Execute())then begin
    filename:=save1.FileName;
    save1.InitialDir:=extractfiledir(filename);
    doc3:=web3.Document as IHTMLDocument2;
    SaveAsPage(doc3,filename);
    fmain.memo5.Lines.Text:=fmain.web3.OleObject.Document.all.tags('HTML').Item(0).outerHTML;
    memo5.Lines.SaveToFile(filename,tEncoding.UTF8);
    page1.ActivePageIndex:=10;
    web4.Navigate(filename);
    mPage:=filename;
    lastLine:='<li><a href="'+newfilename+'">'+mtitle+'</a></li>';
    ss.Insert(i,lastLine);
    ss.SaveToFile(fileList,tEncoding.UTF8);
    if(ftp1.Connected)then
    begin
      ftp1.Put(filename);
      ftp1.Delete(extractfilename(fileList));
      ftp1.Put(fileList);
      ftpListfile('');
    end;
  end;
  if assigned(ss) then ss.Free;

end;

procedure TfMain.btnSaveClick(Sender: TObject);
begin
  page1.ActivePageIndex:=10;
  bar1.Panels[0].Text:='正在加载本地页面...！';
  memo5.Lines.SaveToFile(mPage,tEncoding.UTF8);
  web4.Navigate(mPage);
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
    webList.Navigate(fullfilename);
    bar1.Panels[0].Text:='正在加载本地页面...'+fullfilename;
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
  web2.Navigate(mModelPage);
  fmain.caption:=APP_TITLE+APP_VERSION;
  initLocalDir();
  initHostdir();
  website.Navigate(uConfig.SITE_HOME);
end;

procedure TfMain.FTP1AfterClientLogin(Sender: TObject);
begin
  memoftp.Lines.Add('登陆成功！');
  ftpListfile('web');
end;

procedure TfMain.FTP1Connected(Sender: TObject);
var
  ss:tstrings;
begin
  memoftp.Lines.Add('连接成功！');
  //ftp1.Login;
  //FTP1.List(edtFtpDir.Text);
end;

procedure TfMain.FTP1Disconnected(Sender: TObject);
begin
  memoftp.Lines.Add('断开连接！');
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
  if(AWorkMode=wmRead)then workmsg:='正在读取数据...';
  if(AWorkMode=wmWrite)then workmsg:='正在上传数据...';
  workmsg:=workmsg+inttostr(AWorkCount)+'/'+inttostr(mFtpWorkCount);
  bar1.Panels[1].Text:=workmsg;
end;

procedure TfMain.FTP1WorkBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);
var
  workmsg:string;
begin
  if(AWorkMode=wmRead)then workmsg:='准备读取数据...';
  if(AWorkMode=wmWrite)then workmsg:='准备上传数据...';
  mFtpWorkCount:=AWorkCountMax;
  bar1.Panels[1].Text:=workmsg;
  memoftp.Lines.Add(workmsg);
end;

procedure TfMain.FTP1WorkEnd(ASender: TObject; AWorkMode: TWorkMode);
var
  workmsg:string;
begin
  if(AWorkMode=wmRead)then workmsg:='读取数据结束！';
  if(AWorkMode=wmWrite)then workmsg:='上传数据结束！';
  bar1.Panels[1].Text:=workmsg;
  memoftp.Lines.Add(workmsg);
end;

procedure TfMain.Web1BeforeNavigate2(ASender: TObject; const pDisp: IDispatch;
  const URL, Flags, TargetFrameName, PostData, Headers: OleVariant;
  var Cancel: WordBool);
begin
  bar1.Panels[0].Text:='正在加载页面...';
end;

procedure TfMain.Web1DocumentComplete(ASender: TObject; const pDisp: IDispatch;
  const URL: OleVariant);
var
  doc:IHTMLDocument2;
begin
  if(Web1.ReadyState<>READYSTATE_COMPLETE)then exit;
  doc:=web1.Document as IHTMLDocument2; //得到接口；
  memo1.Lines.Text:=getpagecode(doc);
  mProtocol:=doc.protocol;
  mTitle:=doc.title;
  edtTitle.Text:=mTitle;
  mSite:=doc.domain;
  mCharset:=doc.charset;
  if(mProtocol='HyperText Transfer Protocol with Privacy')then mProtocol:='https://' else mProtocol:='http://';
  fmain.caption:=APP_TITLE+APP_VERSION+'('+mTitle+')';
  bar1.Panels[0].Text:='远程页面加载完毕！';
  //page1.ActivePageIndex:=1;
end;

procedure TfMain.Web1NavigateComplete2(ASender: TObject; const pDisp: IDispatch;
  const URL: OleVariant);
begin
  web1.Silent := True;
end;

procedure TfMain.Web2DocumentComplete(ASender: TObject; const pDisp: IDispatch;
  const URL: OleVariant);
var
  doc:IHTMLDocument2;
begin
  doc:=web2.Document as IHTMLDocument2; //得到接口；
  memo2.Lines.Text:=getpagecode(doc);
  bar1.Panels[0].Text:='模板页面加载完毕！';

end;
procedure TfMain.Web3DocumentComplete(ASender: TObject; const pDisp: IDispatch;
  const URL: OleVariant);
var
  doc:IHTMLDocument2;
begin
  doc:=web3.Document as IHTMLDocument2; //得到接口；
  doc.title:=mTitle;
  memo4.Lines.Text:=getpageContent(doc,'html');
  bar1.Panels[0].Text:='合成页面加载完毕！';
end;

procedure TfMain.web4DocumentComplete(ASender: TObject; const pDisp: IDispatch;
  const URL: OleVariant);
begin
   bar1.Panels[0].Text:='本地页面加载完毕！';
end;

procedure TfMain.WebListDocumentComplete(ASender: TObject;
  const pDisp: IDispatch; const URL: OleVariant);
var
  doc:IHTMLDocument2;
begin
  doc:=webList.Document as IHTMLDocument2;
  memoList.Lines.Text:=getpagecode(doc);
  fmain.Caption:=uConfig.APP_TITLE+uConfig.APP_VERSION+'('+doc.title+')';
  bar1.Panels[0].Text:='本地页面加载完毕！';
end;

procedure TfMain.WebListNavigateComplete2(ASender: TObject;
  const pDisp: IDispatch; const URL: OleVariant);
begin
  webList.Silent := True;
end;

procedure TfMain.websiteDocumentComplete(ASender: TObject;
  const pDisp: IDispatch; const URL: OleVariant);
var
  doc:IHTMLDocument2;
begin
  doc:=webList.Document as IHTMLDocument2;
  bar1.Panels[0].Text:='网站页面加载完毕！';

end;

procedure TfMain.websiteNavigateComplete2(ASender: TObject;
  const pDisp: IDispatch; const URL: OleVariant);
begin
  webSite.Silent := True;
end;

//------------------------------------------页面另存为区------------------------------------------
procedure SaveAsPage(doc:IHTMLDocument2;localPageName:string);//页面另存为
Var
  all:IHTMLElementCollection;
  sheets:IHTMLstyleSheetsCollection;
  len,I,p:integer;
  item:OleVariant;
  url,newUrl,filename,localfilename,localPageDir,localImageDir,filetag,fileext,num:string;
  ss:tstrings;
begin
  //网页中的图片文件：
  localPageDir:=extractfiledir(localPageName);
  localfilename:=extractfilename(localPageName);
  filetag:=leftstr(localfilename,length(localfilename)-4);
  localImageDir:=localPageDir+'\images';
  if(not System.SysUtils.directoryexists(localImageDir))then System.SysUtils.forcedirectories(localImageDir);
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
    newUrl:='images/'+filename;
    item.src:=newUrl;
  end;
  //ss:=tstringlist.Create;
  //ss.Text:=doc.body.outerHTML;
  //ss.SaveToFile(localpagename,TEncoding.UTF8);
  //ss.Free;
  //SaveSinglePage(doc,localpagename);
  //fmain.memo4.Lines:=getPagecode(doc);
end;
procedure SaveSinglePage(doc:IHTMLDocument2;localPageName:string);//仅仅保存一个页面
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
//------------------------------------------公共函数区----------------------------------------------
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
