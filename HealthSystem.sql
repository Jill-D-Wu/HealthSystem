USE [HealthSystem]
GO
/****** Object:  Table [dbo].[Diagnose]    Script Date: 7/19/2020 10:47:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Diagnose](
	[DiagnoseID] [int] IDENTITY(1,1) NOT NULL,
	[DiagnoseName] [nvarchar](500) NULL,
 CONSTRAINT [PK_Diagnose] PRIMARY KEY CLUSTERED 
(
	[DiagnoseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Appointment]    Script Date: 7/19/2020 10:47:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Appointment](
	[AppointmentID] [int] IDENTITY(1,1) NOT NULL,
	[AppointmentName] [nvarchar](50) NULL,
	[AppointmentDatetime] [datetime] NULL,
	[PatientID] [int] NULL,
	[HospitalID] [int] NULL,
 CONSTRAINT [PK_Appointment] PRIMARY KEY CLUSTERED 
(
	[AppointmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Treatment]    Script Date: 7/19/2020 10:47:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Treatment](
	[TreatmentID] [int] IDENTITY(1,1) NOT NULL,
	[TreatmentName] [nvarchar](50) NULL,
 CONSTRAINT [PK_Treatment] PRIMARY KEY CLUSTERED 
(
	[TreatmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DiagnoseTreatment]    Script Date: 7/19/2020 10:47:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiagnoseTreatment](
	[DiagnoseID] [int] NOT NULL,
	[TreatmentID] [int] NOT NULL,
 CONSTRAINT [PK_DiagnoseTreatment] PRIMARY KEY CLUSTERED 
(
	[DiagnoseID] ASC,
	[TreatmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppointmentDiagnose]    Script Date: 7/19/2020 10:47:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppointmentDiagnose](
	[AppointmentID] [int] NOT NULL,
	[DiagnoseID] [int] NOT NULL,
 CONSTRAINT [PK_AppointmentDiagnose] PRIMARY KEY CLUSTERED 
(
	[AppointmentID] ASC,
	[DiagnoseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppointmentTreatment]    Script Date: 7/19/2020 10:47:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppointmentTreatment](
	[AppointmentID] [int] NOT NULL,
	[TreatmentID] [int] NOT NULL,
 CONSTRAINT [PK_PatientTreatment] PRIMARY KEY CLUSTERED 
(
	[AppointmentID] ASC,
	[TreatmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[CheckTreatment]    Script Date: 7/19/2020 10:47:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[CheckTreatment]
AS
--select AppointmentName, DiagnoseName, TreatmentName, d.DiagnoseID, t.TreatmentID, a.AppointmentID from Appointment a 
--inner join AppointmentDiagnose ad on a.AppointmentID=ad.AppointmentID 
--inner join Diagnose d on d.DiagnoseID=ad.DiagnoseID 
--inner join DiagnoseTreatment dt on d.DiagnoseID=dt.DiagnoseID 
--inner join Treatment t on dt.TreatmentID=t.TreatmentID

--select AppointmentName, DiagnoseName, TreatmentName, d.DiagnoseID, t.TreatmentID, a.AppointmentID from Appointment a 
--inner join AppointmentTreatment apt on a.AppointmentID = apt.AppointmentID
--inner join Treatment t on apt.TreatmentID=t.TreatmentID
--inner join DiagnoseTreatment dt on dt.TreatmentID=t.TreatmentID
--inner join Diagnose d on d.DiagnoseID=dt.DiagnoseID 

select cast(t1.AppointmentID as varchar(3))+cast(t1.DiagnoseID as varchar(3))+cast(t1.TreatmentID as varchar(3)) as ID,
t1.AppointmentName, t1.DiagnoseName, t1.TreatmentName, 'Ok' as Comment from
(select AppointmentName, DiagnoseName, TreatmentName, d.DiagnoseID, t.TreatmentID, a.AppointmentID from Appointment a 
inner join AppointmentDiagnose ad on a.AppointmentID=ad.AppointmentID 
inner join Diagnose d on d.DiagnoseID=ad.DiagnoseID 
inner join DiagnoseTreatment dt on d.DiagnoseID=dt.DiagnoseID 
inner join Treatment t on dt.TreatmentID=t.TreatmentID) t1 inner join
(select AppointmentName, DiagnoseName, TreatmentName, d.DiagnoseID, t.TreatmentID, a.AppointmentID from Appointment a 
inner join AppointmentTreatment apt on a.AppointmentID = apt.AppointmentID
inner join Treatment t on apt.TreatmentID=t.TreatmentID
inner join DiagnoseTreatment dt on dt.TreatmentID=t.TreatmentID
inner join Diagnose d on d.DiagnoseID=dt.DiagnoseID ) t2 on t1.AppointmentID=t2.AppointmentID 
and t1.DiagnoseID=t2.DiagnoseID and t1.TreatmentID=t2.TreatmentID
union
select  cast(t1.AppointmentID as varchar(3))+cast(t1.DiagnoseID as varchar(3))+cast(t1.TreatmentID as varchar(3)) as ID,
t1.AppointmentName, t1.DiagnoseName, '???' as TreatmentName, 'Need Treatment' as Comment from
(select AppointmentName, DiagnoseName, TreatmentName, d.DiagnoseID, t.TreatmentID, a.AppointmentID from Appointment a 
inner join AppointmentDiagnose ad on a.AppointmentID=ad.AppointmentID 
inner join Diagnose d on d.DiagnoseID=ad.DiagnoseID 
inner join DiagnoseTreatment dt on d.DiagnoseID=dt.DiagnoseID 
inner join Treatment t on dt.TreatmentID=t.TreatmentID) t1 where not t1.DiagnoseID in 
(select d.DiagnoseID from Appointment a 
inner join AppointmentTreatment apt on a.AppointmentID = apt.AppointmentID
inner join Treatment t on apt.TreatmentID=t.TreatmentID
inner join DiagnoseTreatment dt on dt.TreatmentID=t.TreatmentID
inner join Diagnose d on d.DiagnoseID=dt.DiagnoseID where a.AppointmentID=t1.AppointmentID) 
union
select  cast(t2.AppointmentID as varchar(3))+cast(t2.DiagnoseID as varchar(3))+cast(t2.TreatmentID as varchar(3)) as ID,
t2.AppointmentName, '???' as DiagnoseName, t2.TreatmentName, 'Not Suitable' as Comment from
(select AppointmentName, DiagnoseName, TreatmentName, d.DiagnoseID, t.TreatmentID, a.AppointmentID from Appointment a 
inner join AppointmentTreatment apt on a.AppointmentID = apt.AppointmentID
inner join Treatment t on apt.TreatmentID=t.TreatmentID
inner join DiagnoseTreatment dt on dt.TreatmentID=t.TreatmentID
inner join Diagnose d on d.DiagnoseID=dt.DiagnoseID ) t2 where not t2.TreatmentID in
(select  t.TreatmentID from Appointment a 
inner join AppointmentDiagnose ad on a.AppointmentID=ad.AppointmentID 
inner join Diagnose d on d.DiagnoseID=ad.DiagnoseID 
inner join DiagnoseTreatment dt on d.DiagnoseID=dt.DiagnoseID 
inner join Treatment t on dt.TreatmentID=t.TreatmentID where a.AppointmentID=t2.AppointmentID)




GO
/****** Object:  Table [dbo].[Allocation]    Script Date: 7/19/2020 10:47:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Allocation](
	[AllocationID] [int] IDENTITY(1,1) NOT NULL,
	[AllocationName] [varchar](100) NULL,
 CONSTRAINT [PK_Allocation] PRIMARY KEY CLUSTERED 
(
	[AllocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppointmentDoctor]    Script Date: 7/19/2020 10:47:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppointmentDoctor](
	[AppointmentID] [int] NOT NULL,
	[DoctorID] [int] NOT NULL,
 CONSTRAINT [PK_AppointmentDoctor] PRIMARY KEY CLUSTERED 
(
	[AppointmentID] ASC,
	[DoctorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[City]    Script Date: 7/19/2020 10:47:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[City](
	[CityID] [int] IDENTITY(1,1) NOT NULL,
	[CityName] [varchar](150) NULL,
	[CountryID] [int] NULL,
 CONSTRAINT [PK_City] PRIMARY KEY CLUSTERED 
(
	[CityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Country]    Script Date: 7/19/2020 10:47:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Country](
	[CountryID] [int] IDENTITY(1,1) NOT NULL,
	[CountryName] [varchar](50) NULL,
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Doctor]    Script Date: 7/19/2020 10:47:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doctor](
	[DoctorID] [int] IDENTITY(1,1) NOT NULL,
	[DoctorName] [nvarchar](50) NULL,
 CONSTRAINT [PK_Doctor] PRIMARY KEY CLUSTERED 
(
	[DoctorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FunderType]    Script Date: 7/19/2020 10:47:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FunderType](
	[FunderTypeID] [int] IDENTITY(1,1) NOT NULL,
	[FunderTypeName] [varchar](50) NULL,
 CONSTRAINT [PK_FunderType] PRIMARY KEY CLUSTERED 
(
	[FunderTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Gender]    Script Date: 7/19/2020 10:47:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Gender](
	[GenderID] [int] IDENTITY(1,1) NOT NULL,
	[GenderIName] [varchar](10) NULL,
 CONSTRAINT [PK_Gender] PRIMARY KEY CLUSTERED 
(
	[GenderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Hospital]    Script Date: 7/19/2020 10:47:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Hospital](
	[HospitalID] [int] IDENTITY(1,1) NOT NULL,
	[HospitalName] [nvarchar](50) NULL,
	[Address] [nvarchar](50) NULL,
 CONSTRAINT [PK_Hospital] PRIMARY KEY CLUSTERED 
(
	[HospitalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HospitalDoctor]    Script Date: 7/19/2020 10:47:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HospitalDoctor](
	[HospitalID] [int] NOT NULL,
	[DoctorID] [int] NOT NULL,
 CONSTRAINT [PK_HospitalDoctor] PRIMARY KEY CLUSTERED 
(
	[HospitalID] ASC,
	[DoctorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InterventionModel]    Script Date: 7/19/2020 10:47:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InterventionModel](
	[InterventionModelID] [int] IDENTITY(1,1) NOT NULL,
	[InterventionModelName] [varchar](100) NULL,
 CONSTRAINT [PK_InterventionModel] PRIMARY KEY CLUSTERED 
(
	[InterventionModelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InterventionType]    Script Date: 7/19/2020 10:47:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InterventionType](
	[InterventionTypeID] [int] IDENTITY(1,1) NOT NULL,
	[InterventionTypeName] [varchar](50) NULL,
 CONSTRAINT [PK_InterventionType] PRIMARY KEY CLUSTERED 
(
	[InterventionTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Masking]    Script Date: 7/19/2020 10:47:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Masking](
	[MaskingID] [int] IDENTITY(1,1) NOT NULL,
	[MaskingName] [varchar](100) NULL,
 CONSTRAINT [PK_Masking] PRIMARY KEY CLUSTERED 
(
	[MaskingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ObservationalModel]    Script Date: 7/19/2020 10:47:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ObservationalModel](
	[ObservationalModelID] [int] IDENTITY(1,1) NOT NULL,
	[ObservationalModelName] [varchar](100) NULL,
 CONSTRAINT [PK_ObservationalModel] PRIMARY KEY CLUSTERED 
(
	[ObservationalModelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Patient]    Script Date: 7/19/2020 10:47:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Patient](
	[PatientID] [int] IDENTITY(1,1) NOT NULL,
	[PatientName] [nvarchar](50) NULL,
 CONSTRAINT [PK_Patient] PRIMARY KEY CLUSTERED 
(
	[PatientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Phase]    Script Date: 7/19/2020 10:47:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Phase](
	[PhaseID] [int] IDENTITY(1,1) NOT NULL,
	[PhaseName] [varchar](50) NULL,
 CONSTRAINT [PK_Phase] PRIMARY KEY CLUSTERED 
(
	[PhaseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PrimaryPurpose]    Script Date: 7/19/2020 10:47:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PrimaryPurpose](
	[PrimaryPurposeID] [int] IDENTITY(1,1) NOT NULL,
	[PrimaryPurposeName] [varchar](100) NULL,
 CONSTRAINT [PK_PrimaryPurpose] PRIMARY KEY CLUSTERED 
(
	[PrimaryPurposeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sponsor]    Script Date: 7/19/2020 10:47:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sponsor](
	[SponsorID] [int] IDENTITY(1,1) NOT NULL,
	[SponsorName] [varchar](200) NULL,
 CONSTRAINT [PK_Sponsor] PRIMARY KEY CLUSTERED 
(
	[SponsorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Statu]    Script Date: 7/19/2020 10:47:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Statu](
	[StatusID] [int] IDENTITY(1,1) NOT NULL,
	[StatusName] [varchar](50) NULL,
 CONSTRAINT [PK_Statu] PRIMARY KEY CLUSTERED 
(
	[StatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Study]    Script Date: 7/19/2020 10:47:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Study](
	[NCTNumber] [char](11) NOT NULL,
	[StudieName] [varchar](500) NULL,
	[Acronym] [varchar](50) NULL,
	[StatusID] [int] NULL,
	[HasResult] [bit] NULL,
	[OutcomeMeasure] [varchar](max) NULL,
	[GenderID] [int] NULL,
	[AgeStarting] [float] NULL,
	[AgeEnding] [float] NULL,
	[PhaseID] [int] NULL,
	[Enrollment] [int] NULL,
	[FunderTypeID] [int] NULL,
	[StudyTypeID] [int] NULL,
	[AllocationID] [int] NULL,
	[InterventionModelID] [int] NULL,
	[MaskingID] [int] NULL,
	[PrimaryPurposeID] [int] NULL,
	[ObservationalModelID] [int] NULL,
	[TimePerspectiveID] [int] NULL,
	[OtherID] [varchar](150) NULL,
	[StartDate] [date] NULL,
	[PrimaryCompletionDate] [date] NULL,
	[CompletionDate] [date] NULL,
	[FirstPosted] [date] NULL,
	[ResultsFirstPosted] [date] NULL,
	[LastUpdatePosted] [date] NULL,
 CONSTRAINT [PK_Study] PRIMARY KEY CLUSTERED 
(
	[NCTNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudyCity]    Script Date: 7/19/2020 10:47:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudyCity](
	[NCTNumber] [char](11) NOT NULL,
	[CityID] [int] NOT NULL,
 CONSTRAINT [PK_StudyCity] PRIMARY KEY CLUSTERED 
(
	[NCTNumber] ASC,
	[CityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudyCountry]    Script Date: 7/19/2020 10:47:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudyCountry](
	[NCTNumber] [char](11) NOT NULL,
	[CountryID] [int] NOT NULL,
 CONSTRAINT [PK_StudyCountry] PRIMARY KEY CLUSTERED 
(
	[NCTNumber] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudyDesign]    Script Date: 7/19/2020 10:47:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudyDesign](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NCTNumber] [char](11) NOT NULL,
	[StudyDesign] [varchar](500) NULL,
	[DesignType] [varchar](50) NULL,
	[DesignName] [varchar](500) NULL,
 CONSTRAINT [PK_StudyDesign] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudyDiagnose]    Script Date: 7/19/2020 10:47:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudyDiagnose](
	[NCTNumber] [char](11) NOT NULL,
	[DiagnoseID] [int] NOT NULL,
 CONSTRAINT [PK_StudyDiagnose] PRIMARY KEY CLUSTERED 
(
	[NCTNumber] ASC,
	[DiagnoseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudyIntervention]    Script Date: 7/19/2020 10:47:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudyIntervention](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[NCTNumber] [char](11) NOT NULL,
	[Intervention] [varchar](600) NULL,
	[InterventionTypeID] [int] NULL,
 CONSTRAINT [PK_StudyIntervention] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudyInterventionType]    Script Date: 7/19/2020 10:47:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudyInterventionType](
	[NCTNumber] [char](11) NOT NULL,
	[InterventionTypeID] [int] NOT NULL,
 CONSTRAINT [PK_StudyInterventionType] PRIMARY KEY CLUSTERED 
(
	[NCTNumber] ASC,
	[InterventionTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudyLocation]    Script Date: 7/19/2020 10:47:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudyLocation](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NCTNumber] [char](11) NOT NULL,
	[Location] [varchar](500) NULL,
	[Country] [varchar](50) NULL,
	[City] [varchar](100) NULL,
	[tmp] [varchar](400) NULL,
	[CountryID] [int] NULL,
	[CityID] [int] NULL,
 CONSTRAINT [PK_StudyLocation] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudySponsor]    Script Date: 7/19/2020 10:47:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudySponsor](
	[NCTNumber] [char](11) NOT NULL,
	[SponsorID] [int] NOT NULL,
 CONSTRAINT [PK_StudySponsor_1] PRIMARY KEY CLUSTERED 
(
	[NCTNumber] ASC,
	[SponsorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudyType]    Script Date: 7/19/2020 10:47:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudyType](
	[StudyTypeID] [int] IDENTITY(1,1) NOT NULL,
	[StudyTypeName] [varchar](100) NULL,
 CONSTRAINT [PK_StudyType] PRIMARY KEY CLUSTERED 
(
	[StudyTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TimePerspective]    Script Date: 7/19/2020 10:47:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TimePerspective](
	[TimePerspectiveID] [int] IDENTITY(1,1) NOT NULL,
	[TimePerspectiveName] [varchar](100) NULL,
 CONSTRAINT [PK_TimePerspective] PRIMARY KEY CLUSTERED 
(
	[TimePerspectiveID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Appointment]  WITH CHECK ADD  CONSTRAINT [FK_Appointment_Hospital] FOREIGN KEY([HospitalID])
REFERENCES [dbo].[Hospital] ([HospitalID])
GO
ALTER TABLE [dbo].[Appointment] CHECK CONSTRAINT [FK_Appointment_Hospital]
GO
ALTER TABLE [dbo].[Appointment]  WITH CHECK ADD  CONSTRAINT [FK_Appointment_Patient] FOREIGN KEY([PatientID])
REFERENCES [dbo].[Patient] ([PatientID])
GO
ALTER TABLE [dbo].[Appointment] CHECK CONSTRAINT [FK_Appointment_Patient]
GO
ALTER TABLE [dbo].[AppointmentDiagnose]  WITH CHECK ADD  CONSTRAINT [FK_AppointmentDiagnose_Appointment] FOREIGN KEY([AppointmentID])
REFERENCES [dbo].[Appointment] ([AppointmentID])
GO
ALTER TABLE [dbo].[AppointmentDiagnose] CHECK CONSTRAINT [FK_AppointmentDiagnose_Appointment]
GO
ALTER TABLE [dbo].[AppointmentDiagnose]  WITH CHECK ADD  CONSTRAINT [FK_AppointmentDiagnose_Diagnose] FOREIGN KEY([DiagnoseID])
REFERENCES [dbo].[Diagnose] ([DiagnoseID])
GO
ALTER TABLE [dbo].[AppointmentDiagnose] CHECK CONSTRAINT [FK_AppointmentDiagnose_Diagnose]
GO
ALTER TABLE [dbo].[AppointmentDoctor]  WITH CHECK ADD  CONSTRAINT [FK_AppointmentDoctor_Appointment] FOREIGN KEY([AppointmentID])
REFERENCES [dbo].[Appointment] ([AppointmentID])
GO
ALTER TABLE [dbo].[AppointmentDoctor] CHECK CONSTRAINT [FK_AppointmentDoctor_Appointment]
GO
ALTER TABLE [dbo].[AppointmentDoctor]  WITH CHECK ADD  CONSTRAINT [FK_AppointmentDoctor_Doctor] FOREIGN KEY([DoctorID])
REFERENCES [dbo].[Doctor] ([DoctorID])
GO
ALTER TABLE [dbo].[AppointmentDoctor] CHECK CONSTRAINT [FK_AppointmentDoctor_Doctor]
GO
ALTER TABLE [dbo].[AppointmentTreatment]  WITH CHECK ADD  CONSTRAINT [FK_PatientTreatment_Patient] FOREIGN KEY([AppointmentID])
REFERENCES [dbo].[Appointment] ([AppointmentID])
GO
ALTER TABLE [dbo].[AppointmentTreatment] CHECK CONSTRAINT [FK_PatientTreatment_Patient]
GO
ALTER TABLE [dbo].[AppointmentTreatment]  WITH CHECK ADD  CONSTRAINT [FK_PatientTreatment_Treatment] FOREIGN KEY([TreatmentID])
REFERENCES [dbo].[Treatment] ([TreatmentID])
GO
ALTER TABLE [dbo].[AppointmentTreatment] CHECK CONSTRAINT [FK_PatientTreatment_Treatment]
GO
ALTER TABLE [dbo].[City]  WITH CHECK ADD  CONSTRAINT [FK_City_Country] FOREIGN KEY([CountryID])
REFERENCES [dbo].[Country] ([CountryID])
GO
ALTER TABLE [dbo].[City] CHECK CONSTRAINT [FK_City_Country]
GO
ALTER TABLE [dbo].[DiagnoseTreatment]  WITH CHECK ADD  CONSTRAINT [FK_DiagnoseTreatment_Diagnose] FOREIGN KEY([DiagnoseID])
REFERENCES [dbo].[Diagnose] ([DiagnoseID])
GO
ALTER TABLE [dbo].[DiagnoseTreatment] CHECK CONSTRAINT [FK_DiagnoseTreatment_Diagnose]
GO
ALTER TABLE [dbo].[DiagnoseTreatment]  WITH CHECK ADD  CONSTRAINT [FK_DiagnoseTreatment_Treatment] FOREIGN KEY([TreatmentID])
REFERENCES [dbo].[Treatment] ([TreatmentID])
GO
ALTER TABLE [dbo].[DiagnoseTreatment] CHECK CONSTRAINT [FK_DiagnoseTreatment_Treatment]
GO
ALTER TABLE [dbo].[HospitalDoctor]  WITH CHECK ADD  CONSTRAINT [FK_HospitalDoctor_Doctor] FOREIGN KEY([DoctorID])
REFERENCES [dbo].[Doctor] ([DoctorID])
GO
ALTER TABLE [dbo].[HospitalDoctor] CHECK CONSTRAINT [FK_HospitalDoctor_Doctor]
GO
ALTER TABLE [dbo].[HospitalDoctor]  WITH CHECK ADD  CONSTRAINT [FK_HospitalDoctor_Hospital] FOREIGN KEY([HospitalID])
REFERENCES [dbo].[Hospital] ([HospitalID])
GO
ALTER TABLE [dbo].[HospitalDoctor] CHECK CONSTRAINT [FK_HospitalDoctor_Hospital]
GO
ALTER TABLE [dbo].[Study]  WITH CHECK ADD  CONSTRAINT [FK_Study_Allocation] FOREIGN KEY([AllocationID])
REFERENCES [dbo].[Allocation] ([AllocationID])
GO
ALTER TABLE [dbo].[Study] CHECK CONSTRAINT [FK_Study_Allocation]
GO
ALTER TABLE [dbo].[Study]  WITH CHECK ADD  CONSTRAINT [FK_Study_FunderType] FOREIGN KEY([FunderTypeID])
REFERENCES [dbo].[FunderType] ([FunderTypeID])
GO
ALTER TABLE [dbo].[Study] CHECK CONSTRAINT [FK_Study_FunderType]
GO
ALTER TABLE [dbo].[Study]  WITH CHECK ADD  CONSTRAINT [FK_Study_Gender] FOREIGN KEY([GenderID])
REFERENCES [dbo].[Gender] ([GenderID])
GO
ALTER TABLE [dbo].[Study] CHECK CONSTRAINT [FK_Study_Gender]
GO
ALTER TABLE [dbo].[Study]  WITH CHECK ADD  CONSTRAINT [FK_Study_InterventionModel] FOREIGN KEY([InterventionModelID])
REFERENCES [dbo].[InterventionModel] ([InterventionModelID])
GO
ALTER TABLE [dbo].[Study] CHECK CONSTRAINT [FK_Study_InterventionModel]
GO
ALTER TABLE [dbo].[Study]  WITH CHECK ADD  CONSTRAINT [FK_Study_Masking] FOREIGN KEY([MaskingID])
REFERENCES [dbo].[Masking] ([MaskingID])
GO
ALTER TABLE [dbo].[Study] CHECK CONSTRAINT [FK_Study_Masking]
GO
ALTER TABLE [dbo].[Study]  WITH CHECK ADD  CONSTRAINT [FK_Study_ObservationalModel] FOREIGN KEY([ObservationalModelID])
REFERENCES [dbo].[ObservationalModel] ([ObservationalModelID])
GO
ALTER TABLE [dbo].[Study] CHECK CONSTRAINT [FK_Study_ObservationalModel]
GO
ALTER TABLE [dbo].[Study]  WITH CHECK ADD  CONSTRAINT [FK_Study_Phase] FOREIGN KEY([PhaseID])
REFERENCES [dbo].[Phase] ([PhaseID])
GO
ALTER TABLE [dbo].[Study] CHECK CONSTRAINT [FK_Study_Phase]
GO
ALTER TABLE [dbo].[Study]  WITH CHECK ADD  CONSTRAINT [FK_Study_PrimaryPurpose] FOREIGN KEY([PrimaryPurposeID])
REFERENCES [dbo].[PrimaryPurpose] ([PrimaryPurposeID])
GO
ALTER TABLE [dbo].[Study] CHECK CONSTRAINT [FK_Study_PrimaryPurpose]
GO
ALTER TABLE [dbo].[Study]  WITH CHECK ADD  CONSTRAINT [FK_Study_Statu] FOREIGN KEY([StatusID])
REFERENCES [dbo].[Statu] ([StatusID])
GO
ALTER TABLE [dbo].[Study] CHECK CONSTRAINT [FK_Study_Statu]
GO
ALTER TABLE [dbo].[Study]  WITH CHECK ADD  CONSTRAINT [FK_Study_StudyType] FOREIGN KEY([StudyTypeID])
REFERENCES [dbo].[StudyType] ([StudyTypeID])
GO
ALTER TABLE [dbo].[Study] CHECK CONSTRAINT [FK_Study_StudyType]
GO
ALTER TABLE [dbo].[Study]  WITH CHECK ADD  CONSTRAINT [FK_Study_TimePerspective] FOREIGN KEY([TimePerspectiveID])
REFERENCES [dbo].[TimePerspective] ([TimePerspectiveID])
GO
ALTER TABLE [dbo].[Study] CHECK CONSTRAINT [FK_Study_TimePerspective]
GO
ALTER TABLE [dbo].[StudyCity]  WITH CHECK ADD  CONSTRAINT [FK_StudyCity_City] FOREIGN KEY([CityID])
REFERENCES [dbo].[City] ([CityID])
GO
ALTER TABLE [dbo].[StudyCity] CHECK CONSTRAINT [FK_StudyCity_City]
GO
ALTER TABLE [dbo].[StudyCity]  WITH CHECK ADD  CONSTRAINT [FK_StudyCity_Study] FOREIGN KEY([NCTNumber])
REFERENCES [dbo].[Study] ([NCTNumber])
GO
ALTER TABLE [dbo].[StudyCity] CHECK CONSTRAINT [FK_StudyCity_Study]
GO
ALTER TABLE [dbo].[StudyCountry]  WITH CHECK ADD  CONSTRAINT [FK_StudyCountry_Country] FOREIGN KEY([CountryID])
REFERENCES [dbo].[Country] ([CountryID])
GO
ALTER TABLE [dbo].[StudyCountry] CHECK CONSTRAINT [FK_StudyCountry_Country]
GO
ALTER TABLE [dbo].[StudyCountry]  WITH CHECK ADD  CONSTRAINT [FK_StudyCountry_Study] FOREIGN KEY([NCTNumber])
REFERENCES [dbo].[Study] ([NCTNumber])
GO
ALTER TABLE [dbo].[StudyCountry] CHECK CONSTRAINT [FK_StudyCountry_Study]
GO
ALTER TABLE [dbo].[StudyDiagnose]  WITH CHECK ADD  CONSTRAINT [FK_StudyDiagnose_Diagnose] FOREIGN KEY([DiagnoseID])
REFERENCES [dbo].[Diagnose] ([DiagnoseID])
GO
ALTER TABLE [dbo].[StudyDiagnose] CHECK CONSTRAINT [FK_StudyDiagnose_Diagnose]
GO
ALTER TABLE [dbo].[StudyDiagnose]  WITH CHECK ADD  CONSTRAINT [FK_StudyDiagnose_Study] FOREIGN KEY([NCTNumber])
REFERENCES [dbo].[Study] ([NCTNumber])
GO
ALTER TABLE [dbo].[StudyDiagnose] CHECK CONSTRAINT [FK_StudyDiagnose_Study]
GO
ALTER TABLE [dbo].[StudyIntervention]  WITH CHECK ADD  CONSTRAINT [FK_StudyIntervention_InterventionType] FOREIGN KEY([InterventionTypeID])
REFERENCES [dbo].[InterventionType] ([InterventionTypeID])
GO
ALTER TABLE [dbo].[StudyIntervention] CHECK CONSTRAINT [FK_StudyIntervention_InterventionType]
GO
ALTER TABLE [dbo].[StudyIntervention]  WITH CHECK ADD  CONSTRAINT [FK_StudyIntervention_Study] FOREIGN KEY([NCTNumber])
REFERENCES [dbo].[Study] ([NCTNumber])
GO
ALTER TABLE [dbo].[StudyIntervention] CHECK CONSTRAINT [FK_StudyIntervention_Study]
GO
ALTER TABLE [dbo].[StudyInterventionType]  WITH CHECK ADD  CONSTRAINT [FK_StudyInterventionType_InterventionType] FOREIGN KEY([InterventionTypeID])
REFERENCES [dbo].[InterventionType] ([InterventionTypeID])
GO
ALTER TABLE [dbo].[StudyInterventionType] CHECK CONSTRAINT [FK_StudyInterventionType_InterventionType]
GO
ALTER TABLE [dbo].[StudyInterventionType]  WITH CHECK ADD  CONSTRAINT [FK_StudyInterventionType_Study] FOREIGN KEY([NCTNumber])
REFERENCES [dbo].[Study] ([NCTNumber])
GO
ALTER TABLE [dbo].[StudyInterventionType] CHECK CONSTRAINT [FK_StudyInterventionType_Study]
GO
ALTER TABLE [dbo].[StudySponsor]  WITH CHECK ADD  CONSTRAINT [FK_StudySponsor_Sponsor] FOREIGN KEY([SponsorID])
REFERENCES [dbo].[Sponsor] ([SponsorID])
GO
ALTER TABLE [dbo].[StudySponsor] CHECK CONSTRAINT [FK_StudySponsor_Sponsor]
GO
ALTER TABLE [dbo].[StudySponsor]  WITH CHECK ADD  CONSTRAINT [FK_StudySponsor_Study] FOREIGN KEY([NCTNumber])
REFERENCES [dbo].[Study] ([NCTNumber])
GO
ALTER TABLE [dbo].[StudySponsor] CHECK CONSTRAINT [FK_StudySponsor_Study]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[9] 2[32] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Appointment"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 157
               Right = 246
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AppointmentTreatment"
            Begin Extent = 
               Top = 121
               Left = 284
               Bottom = 237
               Right = 455
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DiagnoseTreatment"
            Begin Extent = 
               Top = 6
               Left = 493
               Bottom = 118
               Right = 663
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Treatment"
            Begin Extent = 
               Top = 195
               Left = 534
               Bottom = 291
               Right = 709
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AppointmentDiagnose"
            Begin Extent = 
               Top = 6
               Left = 284
               Bottom = 102
               Right = 455
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CheckTreatment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CheckTreatment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CheckTreatment'
GO
