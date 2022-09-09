Received: from mx08-00440002.pphosted.com (mx08-00440002.pphosted.com [185.183.31.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42274A02
	for <iwd@lists.linux.dev>; Fri,  9 Sep 2022 14:00:36 +0000 (UTC)
Received: from pps.filterd (m0267190.ppops.net [127.0.0.1])
	by mx08-00440002.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 289Dr5iv001364;
	Fri, 9 Sep 2022 10:00:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landisgyr.com; h=from : to :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pselector2;
 bh=Gg+Kb+O2t04pZz5oFY1Tq1tNS2g50+pTkaY0leIsM4g=;
 b=KVeR1+5WFRhsb2BIyB1RNiIJnj8Um663qSWWurYt7RbEHwZiloglTHcQRZJtMk/pSEwQ
 vtEhaS068tUBpTg5IlxtDgEDiy6LePxdgqGJ/xXwlKS8detExU/xWud/vqIFzYt/vVTJ
 TFS2g6fscyWGtJAWXqW9EFFE8AFVi29ieKGMK3h+9FRtl5wIGGtiETfXuU+JbgyZm57j
 lK6cQqNyc6bijS4A2dCyBVMxq3MJ9ItD7/7CtabS+jIWXqXBoa7ep+BrAEDk/gq049No
 5MROPLYC4kD083bxIigeY0WEkuKwPO4PxVFNZVSA4CH2OjPxkxJEIRSmCik2yG0kWOn1 rw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landisgyr.com; h=from : to :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pselector1;
 bh=Gg+Kb+O2t04pZz5oFY1Tq1tNS2g50+pTkaY0leIsM4g=;
 b=dagxASpwX6Wgwi+o6PHiZG+WMRvcHxUzIiShw3EMl8ch8SGT9H6zw0FioF4ZSiDjj3v8
 WLTpRqOrggsrc9nmZjGgP7FvcEqxFVWQKfkJN7a5cIMsFd1wNQkER5Ig7OkYI8JtmrOA
 V7qETF0DElk0pp8YnrLrJx/xyq3+sVASGgloNAy9NYcR18ZaM8D5t4yCihaTozAjljFg
 Mz3qi42eWbfZiOoIqp4dZF9dHb/5hth3Hu7rR1Dbgw8dSRjIEk6o47nmHtmnd5uYIDv4
 diaw9kFWLU43Q151IrSoMIF4Oh/x+4xB8bDJAZykLXb2P9jhAxXURzDFtkNh2Q1xiYrF eg== 
Received: from eur05-am6-obe.outbound.protection.outlook.com (mail-am6eur05lp2104.outbound.protection.outlook.com [104.47.18.104])
	by mx08-00440002.pphosted.com (PPS) with ESMTPS id 3jc1kvnx5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Sep 2022 10:00:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gU29Q7FIS24bz7XK+gSb6iBsFMBOGqbw+2T6F5xiOOZAXcQzqJR1YbseMIF6PIvyqlCI8MAa1iYlW3VuFI0+deXRkhM3zW+/cPE0ss3JjMe3z8eNn1ThGSDji9UWTAaIBYIz7Wb12aeDrVntSTjHsMUXjwAFDpdZVQ0aDzmuhfRX+mJK/mPSJr9D/md0lLttUl5eoh6swQQCkFCvQlkmgARow2/fev4WA0T6B80PZ0T4FOTa4fuGUC6c0SCo8FGOsBeCxN0Fi4rIfOnCTYZSJrXBFzwI7oeIvIqqMqJtYy6SUFQrKgh4FAKfv//1z2t4sY1FRlsktBFeYwf5cvVcGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gg+Kb+O2t04pZz5oFY1Tq1tNS2g50+pTkaY0leIsM4g=;
 b=n7TdsSpLfVQHuSgtcS1Sw/ame0PA2KIEd21a3dv80tOvV8/+yx5rHue7Gf7gfZOPA9eicDpfcJj+/ZFbkRGi7z+5aaiy/ZW5dhjZt80Lj7v3KhpRdQ6dyBCLaiPRy1W/oqlX0ci9fX9J1mqJYMzfaPix8gqPTPYj+HRpJYDmhAzgHAdY92oYvjSLdaQKJ4LtyJTHEv3r63qMA5+tv4JJo0CP8C9sHVr40IsgMKJwjRx8JJ+pMoceGkjq1aYZjCkt0B+RVkfvvYvoenlWcVP5C8B0yqBRrd5kAV0Vf8dvPNFWqWUsXWlM/gaQJeQVaAQnLPgG7FJXHQ0/+gtdl9zqqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=landisgyr.com; dmarc=pass action=none
 header.from=landisgyr.com; dkim=pass header.d=landisgyr.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landisgyr.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gg+Kb+O2t04pZz5oFY1Tq1tNS2g50+pTkaY0leIsM4g=;
 b=cTTdxsmnOZJU2tyZQOyYqok/BK8K2i501HD0S9mhTgGSxiOQ9fTZMxbEP+HttVTw5B0fLiZgMc9OhBxE7laTKNHL68aYxf3LFD3oa2+BIXrAmEKoxICH05Dhbx7RhjmiNE0ubdOrrqJcPhkqCDvy/w+6uYNeJFVX1l5BOwP2HIM=
Received: from AS8PR01MB7493.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:25b::13) by DBAPR01MB6968.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:17e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Fri, 9 Sep
 2022 14:00:32 +0000
Received: from AS8PR01MB7493.eurprd01.prod.exchangelabs.com
 ([fe80::b6cc:1d10:ae57:ac82]) by AS8PR01MB7493.eurprd01.prod.exchangelabs.com
 ([fe80::b6cc:1d10:ae57:ac82%7]) with mapi id 15.20.5612.020; Fri, 9 Sep 2022
 14:00:31 +0000
From: "Johnson, Bryce" <Bryce.Johnson@landisgyr.com>
To: James Prestwood <prestwoj@gmail.com>,
        "iwd@lists.linux.dev"
	<iwd@lists.linux.dev>
Subject: RE: Could not start RRM scan error - repeated
Thread-Topic: Could not start RRM scan error - repeated
Thread-Index: 
 AdjDpwit4JRLBkttQ3+PMFfEEbU4+AAAciQAAAQyY1AAASObgAAAXKTAAADJDwAAJB5OwA==
Date: Fri, 9 Sep 2022 14:00:31 +0000
Message-ID: 
 <AS8PR01MB7493562D3EADD882AC92C4C8F4439@AS8PR01MB7493.eurprd01.prod.exchangelabs.com>
References: 
 <AS8PR01MB7493D4E15D3465B3B0491B22F4409@AS8PR01MB7493.eurprd01.prod.exchangelabs.com>
	 <0913644cbda1bd56a556a3733fd2acbf9ab433f6.camel@gmail.com>
	 <AS8PR01MB7493EE14AFA1C016A6FFA60DF4409@AS8PR01MB7493.eurprd01.prod.exchangelabs.com>
	 <57215da9fd5a65e4b804bd2f4602f2660065c85f.camel@gmail.com>
	 <AS8PR01MB7493394E25D4B40A14772CA8F4409@AS8PR01MB7493.eurprd01.prod.exchangelabs.com>
 <9226b42441f9abb14db1a91733b7b55fa1c44e4e.camel@gmail.com>
In-Reply-To: <9226b42441f9abb14db1a91733b7b55fa1c44e4e.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_ActionId=5d7a414c-0ddc-46f0-966d-7fdec0ef6fa2;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_ContentBits=0;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_Enabled=true;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_Method=Standard;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_Name=724d29b2-602f-4b77-ba15-b7b42511c7c5;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_SetDate=2022-09-09T13:51:12Z;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_SiteId=ee2cd48b-958f-4be4-9852-b8f104c001b9;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR01MB7493:EE_|DBAPR01MB6968:EE_
x-ms-office365-filtering-correlation-id: 99e299ac-cbf1-40d3-1c16-08da926ba8ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 sVBVLfdNhtZWqIjl+Tvl4QrD9kiJjPk5DWMqIAqEnA/Bga+8DQPUCYPJzhpsnrCV27EEEl/VPNR8Xu1EiDH2aDlYT7BApfXsNFUnkmFybon0QV2bbUDlaXqP8kFVNnQwcTjUjIeJxvw6vRAZ8nvCl2zdFUS7W3NUFHGiWntKNtFsUDmvzpb8q91hdDOL90jwMlwMhwGbTVo+2cesP2CQYA6WCTdO1Uqn5s9eYi+2+CHFUkdUaGTBq6Po6HNvq7VE7DfAH9u/bHionEjZOdTPKMKr19G9QQIsxpyBSXSsnwH/RIeZfps1H9CVvbs6zuc/6+yUQzEmzrwXwaU3+O1v2fSOClX3TC54V3Rqz0wup281NK8H0dZiNOdqF1SvcXsy1oiVxJv4MVnBzBIK3qS4LxyrCRNtJs/AlsLRRXq22D8/Z7ZH2o1kyTz1vf4ePGx+8VrDZXueSn+BwaBVEorF2h2Gh4WL2PFE2IYQJOB5kNi+Urkmu4xFLl7yWEuHOshmdgjm48+SPtmqYcL5e/zejLtVrccZbyo8m/pB8VW+L2t8RKyxkAcdqY6/wrz4wPB52B3ZmVwv1OYh2s7RXqt6KIW5wnP8Tr1j+Sxmg0Tl0aFc2oqEDhOgVlP756TJnG9W8/Z+L+vhhIQ5OnwizDJu1Ga3yV5+SMJfmce7gRPri4/rQ8vvcXBds13rc1bdyJyuXK2IsNJOb9eJZ4kQNg5I2W25a4GZF8TfsyCnqHr7zaiJaLji4NCV6Jc9bFUNSP7mKEv8FGA1zNPB0T9rzkWNVw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR01MB7493.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(396003)(376002)(346002)(39850400004)(122000001)(38100700002)(76116006)(64756008)(66946007)(8676002)(66446008)(66476007)(66556008)(86362001)(33656002)(38070700005)(66574015)(26005)(41300700001)(83380400001)(186003)(6506007)(9686003)(7696005)(71200400001)(478600001)(55016003)(316002)(110136005)(2906002)(5660300002)(8936002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?M3ZBUDg4QjZTNHU0L0xFai9vWUNQZks1dWcwNytPU1hyOENQd0dHWk8wb2JO?=
 =?utf-8?B?Rzh3NjNLSTlZUVdPbnhtdjZaeWlsZFdvUHdTNFp1ck5SUVFzQjlKRjJXbUlt?=
 =?utf-8?B?Tlk1YXlIRFVLbEMwbUdVc3Q2RGhRUFVyRllQcFN2QzBrQmZYeDdocmVTSFpz?=
 =?utf-8?B?Y3QyYXllblpPVkZJNG53dWdrUTJRUld6eTRLaDNKUVI3aW02UDBlTHQ3SmR4?=
 =?utf-8?B?eVVrMndMT1g2TDM2bStvMVJvd3BMSFhnOEY3dTJTRHhVaWlZRjVmQXMzaTdt?=
 =?utf-8?B?QUpBWmtaeU1JNUQ3RGo2WGJpYzdoKzRKa0k4YmZERmRCME5iRE1EcWVtMTh5?=
 =?utf-8?B?MllXaDZRaE1HZVVyUXJrNWNFNWlBeDJqaVdPRmpmUjJ0ZXdyT1BtVll1Yks0?=
 =?utf-8?B?ckh6TlIrNkRMcDJEdkYrMFJReURqeUhUU092K3ZpcXppeEt5UkVBQlNSZmp2?=
 =?utf-8?B?RnhnZllsTFk3VlFtRTRUSHJiOTBYdEhDRFYzTlJhSkF4eVNzaXNzNGFZVWVF?=
 =?utf-8?B?dW5VdUxnZ083MlFvZk9zNGk0K2ZwYm5Ya2tzUzJuWDB0S1NodStrUUdrM2JI?=
 =?utf-8?B?SllIdkpJcEF6QWF1RHVDTVFZKy9YSkVXdmRUNmRXa3BFMVZZNHdpYlc3VFdG?=
 =?utf-8?B?K05QcDVqTnh4YWs4RkhlRElPdUdIZjFFQjVVbzNqN0tzWlIxRFVMZ2FGMDR3?=
 =?utf-8?B?NVF3RjVhMmhqbXE1VG9kenFac2dnWnNhYXc2azNENWJiNC9oT1NxUXd4Y0hT?=
 =?utf-8?B?V1huSlpVZzcwd09DSWxhQ0hZNWJUdEVNR3ZpTHVNWG5kdThHd3dEai9KekMx?=
 =?utf-8?B?Z1ZLckNKL0l2UVdDZWdsTkVxOGw3ZXJZeko5VEM4U0JjMHdNNUtnU0JuZFA2?=
 =?utf-8?B?dUR0V25nemNLODE2eWt3OU9GQUFlRzJTKzdYa2s5alNKQ3JWVHFwTm9oeHVP?=
 =?utf-8?B?WWk2OHZ0SGRHcnpudy81cmN2VkdKQkVTYzQ0K0xsb0R5eHdkNVdsRlc1ZVc3?=
 =?utf-8?B?WXhtZlJ1NFphOU1IcUhYMFRneXZhZk1JT0pwZjhxbzdMSTFOK2gvd1dCaEtQ?=
 =?utf-8?B?aVhFVnVaYmtWeW9IWkl5d1d0cE9uMEFDd1pSQkxabi90N2lKYWczVDN3RktN?=
 =?utf-8?B?ekFGMlZiR0dZZm1wWWtQL0w4SDRoSlg4QjhGZlhFb29qSTBHU2FUTUhXalRL?=
 =?utf-8?B?WXl4SXhTdEdwcjNGV3kxRG5QbjR5NndOcXVzZENLSjN2bThwbTV2dlBBYWQ5?=
 =?utf-8?B?T200ek5aQ0JHakZYU3g4V1NTc0pDOC9xRzZrZFJIb3JYZzRyNTVSd0VHdURN?=
 =?utf-8?B?WE1vZW5BQlI3eFRJN2FhbG1EaFNKMDFIVHFvby9Ia3JseUt5SytSeVEzKy9K?=
 =?utf-8?B?WXpzTnAwYklrT3NpM3M4bHRyWW9FNi9vV3dQYWpGc21JR25jcWpVaElVbXdD?=
 =?utf-8?B?dC9aQnZVTHd0TERKdStUUmp1VE1FSkNFSmVSb2hiRnJQcElWQUtWQUFYUlht?=
 =?utf-8?B?Y3p5eXlCdElCb3dQOGFvRVdqVHc4LzFodW0vT1FZYUtZYUs5SnRQVWd5RGhC?=
 =?utf-8?B?Y0ZnV0I5TzNtWDdqdVJhbUhZVUdKN3BlOFVJZUd1Tmw3Y1NmS28weFdRVEpH?=
 =?utf-8?B?Uk8rTHF3ZWRWc1A4ay9YOVBvSzcreWU1bVJkamM0MlUveE5TWXdwWW1aSmN6?=
 =?utf-8?B?ak1zck5QaTJ4dnZYckQ4WFdBN0xKYUs4RVNqM00rY0ZBY1h4SDQ0VFh5bFE3?=
 =?utf-8?B?SHFieS80S3NHK2tFYWNMN0ZDS1VTT2d3S2JmNW41ZzRnYzlZaStNQjRXQUlB?=
 =?utf-8?B?bVd1SlV0L3p2blczMk1WZEpkR3lidGlYeVBIMFVURWFuUUVEbkUxaTNFMWdP?=
 =?utf-8?B?NE04V0VDcndsM3Urczl0VVV0WnZ4akpISDR5TExoV3dNUkYxSnBiaVJsM0Uw?=
 =?utf-8?B?NFJteHpObDNyN0xvb3pTZ2dDRU5qUTJjY2ZldTlTUXlLcmNsUTA3clhmQ0tV?=
 =?utf-8?B?bWFTLysvc2xtaFRFeFpYTzMxdzY1ZzlYU2pmWXRMS0EvbGt3MkxUdFpqRUw0?=
 =?utf-8?B?T1BlLzMzNmFTa2tDM3dMOC8yNU1VZzNLZGx2TFVpcWo4SlRXRmUrVkJKenA5?=
 =?utf-8?Q?ZfwspmYpxlFC6c9CKbqQ09f92?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: landisgyr.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR01MB7493.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e299ac-cbf1-40d3-1c16-08da926ba8ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2022 14:00:31.8792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ee2cd48b-958f-4be4-9852-b8f104c001b9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ilwM9bnPh7uzWeK1+8gNKMZk1Pa0Euj62M29LhnLgdgsFfRiZb7xZBTRq3ZcZc4zQobUDJWP8Qm1IiC4R5rOxdAEQ6JPVRJyVP4SQtJijzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR01MB6968
X-Proofpoint-ORIG-GUID: JoAR5xdfI-ywtMAH89tPTqwNiNjRidwH
X-Proofpoint-GUID: JoAR5xdfI-ywtMAH89tPTqwNiNjRidwH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_08,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 mlxlogscore=898 malwarescore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209090049

PiBCdXQgdGhlIHJvdXRlciBoYXMgdGhlIHNhbWUgU1NJRCBmb3IgYm90aCAyLjRHSHogYmFuZCBh
bmQgNUdoei4NCj4gPiBSb3V0ZXIgaXMgcHJvYmFibHkgd2FudHMgbWUgdG8gY2hlY2sgaWYgdGhl
IDVHSHogY29ubmVjdGlvbiB3b3VsZCBiZQ0KPiA+IGJldHRlciB0byBtb3ZlIG92ZXIgdGhlcmUg
aWYgc28/DQo+DQo+IEhhcmQgdG8gc2F5IHdoeS4gVGhlIEFQIGlzIGp1c3QgYXNraW5nICJIZXks
IGNhbiB5b3Ugc2NhbiBvbiB0aGlzDQo+IGNoYW5uZWw/Ii4NCj4NCg0KTm90IHRoYXQgaXMgbWF0
dGVycyBzaW5jZSB5b3UgYWxyZWFkeSBnb3QgYSBwYXRjaCAodGhhbmtzIGZvciB0aGF0ISkuICBC
dXQgdHJpZWQgdG8gdHVybiBvZmYgInNtYXJ0IGNvbm5lY3QiIG9uIG15IHJvdXRlciAoVFAtbGlu
ayBhcmNoZXIgQTcgNS4wKSB3aGljaCBtYWtlcyB0aGUgc3NpZHMgZm9yIDIuNCBhbmQgNUdIeiBz
aGFyZSB0aGUgc2FtZSBuYW1lLiAgVHVybmVkIHRoYXQgb2ZmIGFuZCBjaGFuZ2VkIHRoZSBzc2lk
cyB0byBkaWZmZXJlbnQgbmFtZXMgYW5kIEkgZG9uJ3Qgc2VlIHRoZSBSUk0gc2NhbiBlcnJvciBt
ZXNzYWdlcy4NCg0KUCBQTEVBU0UgQ09OU0lERVIgT1VSIEVOVklST05NRU5UIEJFRk9SRSBQUklO
VElORyBUSElTIEVNQUlMLg0KDQpUaGlzIGUtbWFpbCAoaW5jbHVkaW5nIGFueSBhdHRhY2htZW50
cykgaXMgY29uZmlkZW50aWFsIGFuZCBtYXkgYmUgbGVnYWxseSBwcml2aWxlZ2VkLiBJZiB5b3Ug
YXJlIG5vdCBhbiBpbnRlbmRlZCByZWNpcGllbnQgb3IgYW4gYXV0aG9yaXplZCByZXByZXNlbnRh
dGl2ZSBvZiBhbiBpbnRlbmRlZCByZWNpcGllbnQsIHlvdSBhcmUgcHJvaGliaXRlZCBmcm9tIHVz
aW5nLCBjb3B5aW5nIG9yIGRpc3RyaWJ1dGluZyB0aGUgaW5mb3JtYXRpb24gaW4gdGhpcyBlLW1h
aWwgb3IgaXRzIGF0dGFjaG1lbnRzLiBJZiB5b3UgaGF2ZSByZWNlaXZlZCB0aGlzIGUtbWFpbCBp
biBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGJ5IHJldHVybiBl
LW1haWwgYW5kIGRlbGV0ZSBhbGwgY29waWVzIG9mIHRoaXMgbWVzc2FnZSBhbmQgYW55IGF0dGFj
aG1lbnRzLiBUaGFuayB5b3UuDQo=
