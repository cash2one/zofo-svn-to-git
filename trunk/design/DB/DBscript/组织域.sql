/*==============================================================*/
/* DBMS name:      ORACLE Version 10gR2                         */
/* Created on:     2010-7-30 20:04:40                           */
/*==============================================================*/


alter table O_DEPT
   drop constraint FK_O_DEPT_OG_COMPAN_O_ORG;

alter table O_ROLE_AUTHORITY
   drop constraint FK_O_AUTHORITY_A_ROLE;

alter table O_ROLE_AUTHORITY
   drop constraint FK_O_ROLE_A_AUTHORITY;

alter table O_ROLE_AUTHORITY
   drop constraint FK_O_ROLE_A_OR_ROLE_A_O_ROLE;

alter table O_STAFF
   drop constraint FK_O_STAFF_OG_DEPT_P_O_DEPT;

alter table O_USER_ROLE
   drop constraint FK_O_USER_R_OG_ROLE_E_O_ROLE;

alter table O_USER_ROLE
   drop constraint FK_O_USER_R_OR_EMP_RO_O_STAFF;

drop table O_AUTHORITY cascade constraints;

drop table O_DEPT cascade constraints;

drop table O_ORG cascade constraints;

drop table O_ROLE cascade constraints;

drop table O_ROLE_AUTHORITY cascade constraints;

drop table O_STAFF cascade constraints;

drop table O_USER_ROLE cascade constraints;

drop sequence SEQ_O_ORG;

drop sequence SEQ_O_ROLE;

drop sequence SEQ_O_STAFF;

drop sequence SEQ_O_USER_ROLE;

create sequence SEQ_O_ORG
increment by 1
start with 1
 maxvalue 99999999
 minvalue 1
 cache 20;

create sequence SEQ_O_ROLE
increment by 1
start with 1
 maxvalue 99999999
 minvalue 1
 cache 20;

create sequence SEQ_O_STAFF
increment by 1
start with 1
 maxvalue 99999999
 minvalue 1
 cache 20;

create sequence SEQ_O_USER_ROLE
increment by 1
start with 1
 minvalue 1
nocycle
 cache 20
 maxvalue 99999999;

/*==============================================================*/
/* Table: O_AUTHORITY                                           */
/*==============================================================*/
create table O_AUTHORITY  (
   AUTHORITY_ID         NUMBER                          not null,
   AUTHORITY_NAME       VARCHAR2(50)                    not null,
   AUTHORITY_REMARK     VARCHAR2(256),
   LASTTIME_STAMP       DATE                           default SYSDATE,
   constraint PK_O_AUTHORITY primary key (AUTHORITY_ID)
)
tablespace TABS_ARCHIVE;

comment on column O_AUTHORITY.AUTHORITY_ID is
'PK，有序列SEQ_ROLE生成';

comment on column O_AUTHORITY.LASTTIME_STAMP is
'最后表结构修改时间戳';

/*==============================================================*/
/* Table: O_DEPT                                                */
/*==============================================================*/
create table O_DEPT  (
   DEPT_NO              VARCHAR2(16)                    not null,
   ORG_ID               NUMBER,
   ABBR                 VARCHAR2(256),
   NAME                 VARCHAR2(256),
   TYPE_CODE            VARCHAR2(8),
   P_DEPT_NO            VARCHAR2(16),
   DISP_SN              NUMBER(5),
   LASTTIME_STAMP       DATE                           default SYSDATE,
   constraint PK_O_DEPT primary key (DEPT_NO)
)
tablespace TABS_ARCHIVE;

comment on table O_DEPT is
'1) 部门为供电单位中的具体部门，科室、班组等。如：抄表班、营业厅。如果采用第三方组件，则本实体可以转换为视图，供其他数据域实体引用。本实体主要包括部门标识、部门名称、部门类型、上级部门标识等属性。
2) 通过部门管理，由录入产生记录。
';

comment on column O_DEPT.DEPT_NO is
'本实体记录的唯一标识，创建部门的唯一编码。';

comment on column O_DEPT.ABBR is
'部门名称的缩写。';

comment on column O_DEPT.NAME is
'部门的详细名称。';

comment on column O_DEPT.TYPE_CODE is
'部门的类型，可以提供给部门选择使用，方便部门过滤。属于枚举类属性，主要包括：01 抄表班、02 营业厅、03 核算班、04 电费班、05 计量班。';

comment on column O_DEPT.P_DEPT_NO is
'直接上级部门的部门编号。';

comment on column O_DEPT.DISP_SN is
'部门树形展现时的显示顺序号。';

/*==============================================================*/
/* Table: O_ORG                                                 */
/*==============================================================*/
create table O_ORG  (
   ORG_ID               NUMBER                          not null,
   ORG_NO               VARCHAR2(16)                    not null,
   ORG_NAME             VARCHAR2(256),
   P_ORG_NO             VARCHAR2(16),
   ORG_TYPE             VARCHAR2(8),
   SORT_NO              NUMBER(5),
   LASTTIME_STAMP       DATE                           default SYSDATE,
   constraint PK_O_ORG primary key (ORG_ID)
)
tablespace TABS_ARCHIVE;

comment on column O_ORG.ORG_NO is
'本实体记录的唯一标识， 创建供电单位的
唯一编码
';

comment on column O_ORG.ORG_NAME is
'供电单位详细的名称';

comment on column O_ORG.P_ORG_NO is
'直接上级供电单位编号';

comment on column O_ORG.ORG_TYPE is
'单位类别：国网公司、 省公司、地市公司、区县公司、分公司、 供电所等。01 国网公司、 02 省公司、 03 地市公司 、 04 区县公司、 05 分公司、 06 供电所。';

comment on column O_ORG.SORT_NO is
'在同级中的排列顺序的序号， 用自然数标
识，如， 1 、 2 、 3 。 
';

comment on column O_ORG.LASTTIME_STAMP is
'最后表结构修改时间戳';

/*==============================================================*/
/* Table: O_ROLE                                                */
/*==============================================================*/
create table O_ROLE  (
   ROLE_ID              NUMBER                          not null,
   ROLE_NAME            VARCHAR2(50)                    not null,
   ROLE_REMARK          VARCHAR2(256),
   ROLE_TYPE            VARCHAR2(5),
   CREATOR              VARCHAR2(20),
   CREATTIME            DATE,
   LASTTIME_STAMP       DATE                           default SYSDATE,
   constraint PK_O_ROLE primary key (ROLE_ID)
)
tablespace TABS_ARCHIVE;

comment on column O_ROLE.ROLE_ID is
'PK，有序列SEQ_ROLE生成';

comment on column O_ROLE.ROLE_TYPE is
'见编码ROLE_TYPE
1 - 岗位角色（主要对应应用功能） 
2 - 操作权限（如档案查询，档案维护） 
3 - 系统对象（所能操作系统对象）
';

comment on column O_ROLE.CREATOR is
'创建该角色的操作员编号（EMP_NO ）';

comment on column O_ROLE.LASTTIME_STAMP is
'最后表结构修改时间戳';

/*==============================================================*/
/* Table: O_ROLE_AUTHORITY                                      */
/*==============================================================*/
create table O_ROLE_AUTHORITY  (
   ROLE_ID              NUMBER,
   AUTHORITY_ID         NUMBER,
   constraint PK_O_ROLE_AUTHORITY primary key ()
)
tablespace TABS_ARCHIVE;

comment on table O_ROLE_AUTHORITY is
'角色权限关系';

comment on column O_ROLE_AUTHORITY.ROLE_ID is
'PK，有序列SEQ_ROLE生成';

comment on column O_ROLE_AUTHORITY.AUTHORITY_ID is
'PK，有序列SEQ_ROLE生成';

/*==============================================================*/
/* Table: O_STAFF                                               */
/*==============================================================*/
create table O_STAFF  (
   EMP_NO               NUMBER(16)                      not null,
   DEPT_NO              VARCHAR2(16),
   STAFF_NO             VARCHAR2(16),
   PASSWD               VARCHAR2(50),
   NAME                 VARCHAR2(64),
   GENDER               VARCHAR2(8),
   POS_NAME             VARCHAR2(256),
   POSITION             VARCHAR2(8),
   WORK_TYPE_CODE       VARCHAR2(8),
   MOBILE               VARCHAR2(32),
   REMARK               VARCHAR2(256),
   LASTTIME_STAMP       DATE                           default SYSDATE,
   ENABLE               INT,
   ACCOUNT_NON_EXPIRED  int,
   CREDENTIALS_NON_EXPIRED int,
   ACCOUNT_NON_LOCKED   int,
   constraint PK_O_STAFF primary key (EMP_NO)
)
tablespace TABS_ARCHIVE;

comment on table O_STAFF is
'操作员';

comment on column O_STAFF.EMP_NO is
'本实体记录的唯一标识';

comment on column O_STAFF.DEPT_NO is
'本实体记录的唯一标识， 创建部门的唯一编码';

comment on column O_STAFF.STAFF_NO is
'工号， 营销业务人员的服务工号';

comment on column O_STAFF.NAME is
'业务人员姓名 ';

comment on column O_STAFF.GENDER is
'性别。 01 男、 02 女';

comment on column O_STAFF.POS_NAME is
'所在职位名称';

comment on column O_STAFF.POSITION is
'人员所在岗位代码';

comment on column O_STAFF.WORK_TYPE_CODE is
'工作分工种类： 01 检定人员、 02 修校人员、 03 装表接电';

comment on column O_STAFF.MOBILE is
'人员联系手机号码';

comment on column O_STAFF.REMARK is
'人员的特殊说明 ';

comment on column O_STAFF.LASTTIME_STAMP is
'最后表结构修改时间戳';

/*==============================================================*/
/* Table: O_USER_ROLE                                           */
/*==============================================================*/
create table O_USER_ROLE  (
   EMP_NO               VARCHAR2(16),
   ROLE_ID              NUMBER,
   GRANTABLE            NUMBER,
   LASTTIME_STAMP       DATE                           default SYSDATE,
   constraint PK_O_USER_ROLE primary key ()
)
tablespace TABS_ARCHIVE;

comment on table O_USER_ROLE is
'维护操作员与角色的多对多的关系';

comment on column O_USER_ROLE.EMP_NO is
'本实体记录的唯一标识';

comment on column O_USER_ROLE.GRANTABLE is
'1 - 可以授予别人
0 - 不可以授予别人
默认1
';

comment on column O_USER_ROLE.LASTTIME_STAMP is
'最后表结构修改时间戳';

alter table O_DEPT
   add constraint FK_O_DEPT_OG_COMPAN_O_ORG foreign key (ORG_ID)
      references O_ORG (ORG_ID);

alter table O_ROLE_AUTHORITY
   add constraint FK_O_AUTHORITY_A_ROLE foreign key (AUTHORITY_ID)
      references O_AUTHORITY (AUTHORITY_ID);

alter table O_ROLE_AUTHORITY
   add constraint FK_O_ROLE_A_AUTHORITY foreign key (ROLE_ID)
      references O_ROLE (ROLE_ID);

alter table O_ROLE_AUTHORITY
   add constraint FK_O_ROLE_A_OR_ROLE_A_O_ROLE foreign key (ROLE_ID)
      references O_ROLE (ROLE_ID);

alter table O_STAFF
   add constraint FK_O_STAFF_OG_DEPT_P_O_DEPT foreign key (DEPT_NO)
      references O_DEPT (DEPT_NO);

alter table O_USER_ROLE
   add constraint FK_O_USER_R_OG_ROLE_E_O_ROLE foreign key (ROLE_ID)
      references O_ROLE (ROLE_ID);

alter table O_USER_ROLE
   add constraint FK_O_USER_R_OR_EMP_RO_O_STAFF foreign key (EMP_NO)
      references O_STAFF (EMP_NO);

