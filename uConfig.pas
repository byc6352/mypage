unit uConfig;

interface
uses
  Vcl.Forms,System.SysUtils;
const
  APP_TITLE:string='��ҳ�޸ı��湤��';
  APP_VERSION:string='v2.01';
  WORK_DIR:string='mypage';
  LOG_NAME:string='authLog.txt';
  LOCAL_DIR:string='D:\works\delphi\xueyuan\pc';
  MODEL_FILE:string='csdnmodel.htm';
  FTP_HOST:string='182.16.38.162';
  FTP_PORT=21;
  FTP_USER:string='ai4330988';
  FTP_PWD:string='68370D33ACeb21';
  SITE_HOME:string='http://ai4330988.vip1.aihost7.top/xueyuan/pc/index.htm';
var
  workdir:string;//����Ŀ¼
  logfile,modelfile:string;// ���ݿ���Ŀ¼,���ݿ�
  isInit:boolean=false;
  procedure init();
implementation
procedure init();
var
    me:String;
begin
  isInit:=true;
  me:=application.ExeName;
  workdir:=extractfiledir(me)+'\'+WORK_DIR;
  if(not DirectoryExists(workdir))then ForceDirectories(workdir);
  logfile:=workdir+'\'+LOG_NAME;
  modelfile:=workdir+'\'+MODEL_FILE;
end;
begin
  init();
end.