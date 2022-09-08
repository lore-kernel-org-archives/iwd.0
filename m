Received: from mx08-00440002.pphosted.com (mx08-00440002.pphosted.com [185.183.31.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1E75CA6
	for <iwd@lists.linux.dev>; Thu,  8 Sep 2022 20:25:43 +0000 (UTC)
Received: from pps.filterd (m0267191.ppops.net [127.0.0.1])
	by mx08-00440002.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288KF9cN032137;
	Thu, 8 Sep 2022 16:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landisgyr.com; h=from : to :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pselector2;
 bh=1QBdFYNyl77axIoT5PCkaxWnYBHVqst4AxpNGKFlQJo=;
 b=jF9bC1bfJ0RJhGo6sq8RdMx9KwgVtR7f64S1k/Py9pBeN/37/kvo4IAUqM4KJvByrjPu
 LJkvrHrQl52SKfIAzzWP8uXfR1f6VoHQ17IjIBfbANSbB3w7KzkA7XEQnrpWDpZvD4jb
 AKNpYZmc1jfGB2PzwbGMLuIKmfl9X8ot5wQ+uWIOYfpa4wpd9HaITl8M3l55AF0izKWo
 b86EohVl769tt6A6LPtK19Dy484NbPx9BQjtv8wll9nrFnTuzgsdkG7eetKEFSGGwIz4
 L3tpew1tZRz96hbgT7M61YzqnjvDY/ozGzTuXdkRIxy8SFwrrTq23nsYu3TuIHCA6mIy 6A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landisgyr.com; h=from : to :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pselector1;
 bh=1QBdFYNyl77axIoT5PCkaxWnYBHVqst4AxpNGKFlQJo=;
 b=aco9gQ/U/dTYAWiRxa5hpG50UZVQJOu/xZFGGCZXlP2D09Ry3gZfFa7MINIjymI4ctSP
 ugqvbDr9lVcr1drhEdsf+vWYhl4weV9IfK6zc7IUezum7TSckmgEJZdIF3uT6yjTHnX1
 HByKGbjYGEErKznt8nT38SRiUuHLnf2sXYzWRS4dJymFZzfVQlgkTRB6PXWQKzHk5fsO
 2fc01ORAV2pq3FENjiwMl5Mj6Md1OIJkHB2+Txt9aTUs72rdiW2+e2IWnVpfRCXuRcrx
 R2svMnhUbYmIRWkiOBYINFF3LBlTFE51VZfyv9N+msbYkSTdrEscWWSnoxP6ovsuLxop 1w== 
Received: from eur01-he1-obe.outbound.protection.outlook.com (mail-he1eur01lp2054.outbound.protection.outlook.com [104.47.0.54])
	by mx08-00440002.pphosted.com (PPS) with ESMTPS id 3jbym6d8a1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Sep 2022 16:25:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5YosQVYGRQlr55kQ8BClO4XdhtfFEa9EFTPisPKK4hBKo2huOgCrZ9CZ8/V/1Ms2g/ZpVGtjOsH38+SmoXuO7MqR1IBt7zw4jj6+HxI8kTuzMBwNgRfdItzX4Xj2jU8+UAmuk89mJRkJBFeKBsTnLq3lt9+SteOsaUSPj0D71/mIx/wvkgdf2ty6gfsELQks7gzGesCXbRdgXbPDx+V85noyCQzWVJjvY5gYGO/RIYaXOq2VmFudN9AqDA3cCr728WCBpGBxFyTpQtJL75bvcpCV3ab3LjW8/2URvKaRW9ZGppEbGl58r7HCzPFyeVy2J6v6cp01cZg0Q1AFc1WrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QBdFYNyl77axIoT5PCkaxWnYBHVqst4AxpNGKFlQJo=;
 b=Xd9uG8+u0hCERgIydFzjZkH3gJA/bGfnKoPSfXnKAbh9XOOZAKnyogj+BnJLOACiYI8bxU23PlqQlBXbPwjlvX5hpIvozg/Z0qO0mWsVo7a/Ctk8xXul6pUut0Aw1qzOex9ZDs/Uxn6sTjOWJBd/a1GBfmBOlTyAHjM4TDfIjSkMzIxa0+jgjliL4to+16JhboIGhUBUL6iRV5lG7MtdZeDpJGEoU5lZARakOuOW1VMx5yOBBdmG1DcdwrQ1n/5xLS+Kp7PmfZFS2KzHw98KsXb0wTDmFOEaC1MNyyDdzbn/XAA+V6XcRTW5torvzIZf3rHCy4CANehBjQcBSyDqsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=landisgyr.com; dmarc=pass action=none
 header.from=landisgyr.com; dkim=pass header.d=landisgyr.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landisgyr.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QBdFYNyl77axIoT5PCkaxWnYBHVqst4AxpNGKFlQJo=;
 b=cTI61VYGoZJMs93RvXB8JGkdcXuzsCR+qPkMeXF/CgNyAKyIS+Sgf5l9ySwtwa655bHPI5CD55YUrgE2vM0HUZ1K4IsZwmEEtFwsumHZYwPEzAOcKt040ZkGPV8IT5rO+Wh4jzF/oQsbxloa9GBqC/u1ETekJqmnRzWlBiliIlo=
Received: from AS8PR01MB7493.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:25b::13) by DB9PR01MB7452.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:213::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Thu, 8 Sep
 2022 20:25:31 +0000
Received: from AS8PR01MB7493.eurprd01.prod.exchangelabs.com
 ([fe80::b6cc:1d10:ae57:ac82]) by AS8PR01MB7493.eurprd01.prod.exchangelabs.com
 ([fe80::b6cc:1d10:ae57:ac82%7]) with mapi id 15.20.5612.018; Thu, 8 Sep 2022
 20:25:30 +0000
From: "Johnson, Bryce" <Bryce.Johnson@landisgyr.com>
To: James Prestwood <prestwoj@gmail.com>,
        "iwd@lists.linux.dev"
	<iwd@lists.linux.dev>
Subject: RE: Could not start RRM scan error - repeated
Thread-Topic: Could not start RRM scan error - repeated
Thread-Index: AdjDpwit4JRLBkttQ3+PMFfEEbU4+AAAciQAAAQyY1AAASObgAAAXKTA
Date: Thu, 8 Sep 2022 20:25:30 +0000
Message-ID: 
 <AS8PR01MB7493394E25D4B40A14772CA8F4409@AS8PR01MB7493.eurprd01.prod.exchangelabs.com>
References: 
 <AS8PR01MB7493D4E15D3465B3B0491B22F4409@AS8PR01MB7493.eurprd01.prod.exchangelabs.com>
	 <0913644cbda1bd56a556a3733fd2acbf9ab433f6.camel@gmail.com>
	 <AS8PR01MB7493EE14AFA1C016A6FFA60DF4409@AS8PR01MB7493.eurprd01.prod.exchangelabs.com>
 <57215da9fd5a65e4b804bd2f4602f2660065c85f.camel@gmail.com>
In-Reply-To: <57215da9fd5a65e4b804bd2f4602f2660065c85f.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_ActionId=56e7ab15-f5f4-4566-8a9a-b03ea27484bb;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_ContentBits=0;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_Enabled=true;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_Method=Standard;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_Name=724d29b2-602f-4b77-ba15-b7b42511c7c5;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_SetDate=2022-09-08T20:14:32Z;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_SiteId=ee2cd48b-958f-4be4-9852-b8f104c001b9;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR01MB7493:EE_|DB9PR01MB7452:EE_
x-ms-office365-filtering-correlation-id: 8d45bc85-7538-4f24-52c0-08da91d84691
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 I9QSA1D9uympSpb+/Xo/dCPK3rFAF/0iadkhZIqDM2Ie+9JsWyW5skSnygzdZNKmnPgQS/O/oHR1yXtApWfFJX+73N3giEotMt/R+pbDRRx0wMzHN0b1GckitFJrqxp0dTAWYCUECvXyRUCjHTAyjLDPWP5VrbgZLblHn1sbltji8RkHH6JL8LPYdfa5NDm4Zu518XMbGI3/fJHl9s43kVRokY0Yf1emSMuMe0Xub/ROnFK/PboXYrVf1APr7aIii1sA7uGSTQYQKuSY3vyXNIFZuVqMfsxa6Fe0zoRwE2jtwv7OreKZtkE0s5TXD0a5HTOCqhpwVPZQBUFB1BiiQB8OLMnX8qHB+UWl+T431Ba0yC9pNaO/lqTm1E5li7ThvZIaMJY0urP4/lwNvfdgAsogmYcmCN29LPBWeaeE+LfaOZ5dQZ0E5QF/QWH5MfSJpDEjm20qoAFUD9tWB5Liq/KfEuS4/fjaEaDPYWRkztvBphHLqaAAAUMloA9CRYo6k9R9HFxVwIwFFkdRywxoCbQI16Akh3yt7b/hXAV9288coyqa6Bo1hVfP+qctQfC+s1Bjbi//aJC8jRz4qMcMIvIC/eneUKDJEXfHDfUDTiOWzhJYzNNMJUFD7LLzk4uPGOvjaAPDqTZBuw3rtuuJamItGIatgeS0pm/x+W4ZZ3UnHkv5yZJjbP4g9j6jKATPvTWgiJ67DA5bvEM8iBmu99rFgt/h6R3ZBpcg8UGk5J27czUc/sbMXT/rROmQ9DJ5jx3a00eeJgGpkBfFyuH0kA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR01MB7493.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(41300700001)(110136005)(55016003)(86362001)(38070700005)(71200400001)(478600001)(316002)(83380400001)(66574015)(9686003)(26005)(38100700002)(6506007)(7696005)(186003)(122000001)(66446008)(5660300002)(66556008)(66476007)(76116006)(64756008)(33656002)(8676002)(8936002)(66946007)(2906002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RUowZ2tGVWVXOVRCZWRyRml6dldNZFhpZldGY3pLU1RZOS9rM3FOMjJ6bFBP?=
 =?utf-8?B?SHBSQzIralNkcUZHd2czMHEyaDc1NmtWdGxyR2lpVEE4Nnh1VWVIU3FZQ2xF?=
 =?utf-8?B?YzlXNUxvTmNBVm15VlNCZUVnQVhncWlTamJiSWlvNktaZ3M0dGV3YXRCTml5?=
 =?utf-8?B?MGtIaWhXakpZeVRpTjZYUytkRTVDYUpxaGphNTZTUzdsUWljaEpTSWp0K1NE?=
 =?utf-8?B?R0xrNm05Ym5VTUlDWGdwbTlJakJ6QXpITFUvWDBOQUMvRTRVRTNOTjhsNDJR?=
 =?utf-8?B?K1VyWTM3bGIxU1BjME5XcWFCNnBVTG1xWG1CZjhOVUZ1Y2JyRmJxcEovTm40?=
 =?utf-8?B?Q1lEZ3NJUVpWRkY1RUpFY1lIaWliZUJ0WGg2djQyK1hicHFycmFVZ01lN05J?=
 =?utf-8?B?OVNmY25NdUlsM2tGTFlsek82WDhjazRXTGliekxub1M2cy9Vdm1pV0ZzWk1F?=
 =?utf-8?B?Q2JQd2YyQ1pIZTNSS0lmc0kzdW1PblN4Q0daN2VyeG5rc0R2MWw0SHVWZTdU?=
 =?utf-8?B?V1JlTTV6SWNRWW9ieTIxNzQ5VElDcDBvdDlQUGFmMGJ6d0xKdXVGelVPZHlP?=
 =?utf-8?B?Q2tPZXJqSmIwRVdLQkpLOG85d3JMNjN6TUt1c1M4SWVSbHUzZ1JhRFV3RTVa?=
 =?utf-8?B?MmRTZGNDWDVEaE5EdHlEYzMzWlBiSVY0dXZ6ZzRGem9Kc3ExMXRidUx6T1Rz?=
 =?utf-8?B?ZUdCVE1lOXA4bjBxQ3paRXhXTnlEcnFudHNVa2VYRlRhNHJsNWFDRWFZL0Vx?=
 =?utf-8?B?U3RGR1grbmh0M0dzZExYU0FiVHU3bTBDbCtxMktnZFdVMSs5UDhwNmJLKzdm?=
 =?utf-8?B?RlNua3ZvQUJyUGRib3hBdEk5TjgzbGl5cmx4SFQwZEd4dFlqV3JNaFdvU2RK?=
 =?utf-8?B?NXRvTzhJajNYb2k0RUVwbkwzaUJBb2lpeW4weUwybG1ma1U2UWczM0Y5RHRL?=
 =?utf-8?B?cWphQm5OMnltZXArdlk4a09zNE9KU2pNY1UxM0t4UW9BeWIvMzY0Y2dNT3Qz?=
 =?utf-8?B?Uk1NT2txcFhTQlZsclVnK0xLbXVsdklZU3Y3dEg5NUtidG9VYkUvSnhQdmti?=
 =?utf-8?B?cXRwRnFjZXRRR3dRdkhrWE1EemVldTFWUFI0NVlZS1Q1R1JRQkIwS1JTd0o4?=
 =?utf-8?B?bS9yVDd6TGlzNVd5WmJMN1phUWJocnZPdGZWYXdVN1FJblBDZ2hmVUVNWTJN?=
 =?utf-8?B?ZDRMOWxVRE1lczJ3OUJWYnNmY1pyTHQ5NUVzSDgvMWgyeDAyNEtJVy9USVdW?=
 =?utf-8?B?NkQvZ0t2d2d0bXRCdER6MnpFSDFiT0M2Mjl5MEw0WnU1eVpnMWNWVm9DUUMy?=
 =?utf-8?B?Y1FHYXB6aWNNVmduTkd5aEhUNFBpa0pHR0F3Zy9tVXhYallYMGh3K1IrRzAw?=
 =?utf-8?B?c3Uza1l4Mk5LbTFjcmUzOHpENllvdW02Tm95ZUdqaFY3dCthWVB1bFVyVjRI?=
 =?utf-8?B?TC9DcnZFTDU3ZHlFeGxaVmJkOTFFWnMrTURoYnFVTHdDWlIrcHJZa3ZtU0dr?=
 =?utf-8?B?aGtkWGxyTTEwTlZFTDB2YmZZRHVUNEY3bVNvRlEzdDRHRU1KellLRDFoRlZD?=
 =?utf-8?B?Zy9IaTlVVGRpK2VDUFNJdURpKzRPMlZmVUZDS0dlQXpsZEpnNVkyUHFTeFcw?=
 =?utf-8?B?dkxJMVJGSklCQTNHQW0zMlFudFZBWlFncHNpSlZjTXgwNXVrRk4xSS94NTlx?=
 =?utf-8?B?ckRaRktoNmFqZUdsK0puSFViMzFjWUtpSFNKTXpPM2ZEV0ZiM0FlaDdtK284?=
 =?utf-8?B?ZFpNVHVXMUZSSHdnYVRhYzVwK2JvQU44bzZHN1ZPUnQ2dG5GVUIzZXVmVUlx?=
 =?utf-8?B?Y3hKTDc5aVdUL001T1NOM3pZbFFkOHpRd3hhZVkrK0FGNDFmZnRGR1ljTWMv?=
 =?utf-8?B?dWlicHp6akJ5NWNqUU43SjFINU1hb0VqV3lMNEJyclpKUHJRUkpPRHBoeVhG?=
 =?utf-8?B?UVFvcGRaQXRLd1NJNXAzTXZoVldrczFmVFAyQkdndFR0NEtxaGN6NCtiRm90?=
 =?utf-8?B?NGJxaHZqWUNoZ001UnRJMDFSV1AyZDZtUnNyUm15MWhBTWJ1ajRqeHhjcHpk?=
 =?utf-8?B?OWNvQ05FekN6MHVqZUUrWVlkeVVyMERwWW1kVlVXdnVHTnF2WFpZb2VBaHVl?=
 =?utf-8?Q?zKAmnNfNhTKm22h0vZoIexou0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d45bc85-7538-4f24-52c0-08da91d84691
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 20:25:30.8926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ee2cd48b-958f-4be4-9852-b8f104c001b9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CPxFCX59xVytEFJB+3pVF6e29EwgBYB8jtFzWCDNWI7J4CaEO2QF82Ij096gZRgZt+NQT7ljqFOieYbSFORdrEtSD9M+vmg9M3Q4cugXPFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR01MB7452
X-Proofpoint-GUID: pedrEidPFpzh6zczxpcslVCkSeo2OJAS
X-Proofpoint-ORIG-GUID: pedrEidPFpzh6zczxpcslVCkSeo2OJAS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_12,2022-09-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 spamscore=0
 phishscore=0 mlxlogscore=852 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209080073

SGkgSmFtZXMsDQoNCj4gTm90aGluZyBzZWVtcyBwYXJ0aWN1bGFybHkgd3Jvbmcgd2l0aCB0aGlz
IHJlcXVlc3QuIEkgYnV0IEkgaGF2ZSBhDQo+IGh1bmNoIGl0IGhhcyB0byBkbyB3aXRoIHJlc3Ry
aWN0aW9ucyBvbiB5b3VyIGRldmljZS4gSXRzIGFza2luZyBmb3IgYW4NCj4gYWN0aXZlIHNjYW4g
b24gZnJlcXVlbmN5IDU3NDUuIENvdWxkIHlvdSBjaGVjayBpZiB0aGlzIGZyZXF1ZW5jeSBpcw0K
PiByZXN0cmljdGVkIGluIGFueSB3YXksIGUuZy4gJ2l3IGxpc3QnLg0KPg0KPiBGb3IgZXhhbXBs
ZSB1bmRlciBzZWN0aW9uIGZvciA1R2h6IGJhbmRzIHlvdSdsbCBzZWUgZnJlcXVlbmNpZXMgbGlz
dGVkOg0KPg0KPiBCYW5kIDI6DQo+ICAgICAgIC4uLg0KPiAgICAgICBGcmVxdWVuY2llczoNCj4g
ICAgICAgICAgICAgICAuLi4NCj4gICAgICAgICAgICAgICAqIDU3NDUgTUh6IFsxNDldICgyMi4w
IGRCbSkgKG5vIElSKQ0KPg0KPiBBcyB5b3UgY2FuIHNlZSwgbWluZSBoYXMgYSAnbm8gSVInIHJl
c3RyaWN0aW9uIG1lYW5pbmcgYWN0aXZlIHNjYW5zIGFyZQ0KPiBub3QgYWxsb3dlZC4gQW5kIEkg
ZG9uJ3Qgc2VlIHRoYXQgd2UgY2hlY2sgdGhpcyBhbnl3aGVyZSBpbiBJV0QsIHNvIGF0DQo+IHRo
ZSB2ZXJ5IGxlYXN0IHdlIG5lZWQgdG8gZG8gdGhhdCB0byBwcmV2ZW50IHRoZSBrZXJuZWwgYm91
bmNpbmcgYmFjaw0KPiB0aGUgc2NhbiByZXF1ZXN0Lg0KDQpZZWFoIEkgdGhpbmsgeW91IGFyZSBv
biB0byBzb21ldGhpbmchIFRoaXMgaXMgYSAyLjRHaHogb25seSBkZXZpY2UNCg0KICAgICAgICAg
ICAgICAgIEZyZXF1ZW5jaWVzOg0KICAgICAgICAgICAgICAgICAgICAgICAgKiAyNDEyIE1IeiBb
MV0gKDIwLjAgZEJtKQ0KICAgICAgICAgICAgICAgICAgICAgICAgKiAyNDE3IE1IeiBbMl0gKDIw
LjAgZEJtKQ0KICAgICAgICAgICAgICAgICAgICAgICAgKiAyNDIyIE1IeiBbM10gKDIwLjAgZEJt
KQ0KICAgICAgICAgICAgICAgICAgICAgICAgKiAyNDI3IE1IeiBbNF0gKDIwLjAgZEJtKQ0KICAg
ICAgICAgICAgICAgICAgICAgICAgKiAyNDMyIE1IeiBbNV0gKDIwLjAgZEJtKQ0KICAgICAgICAg
ICAgICAgICAgICAgICAgKiAyNDM3IE1IeiBbNl0gKDIwLjAgZEJtKQ0KICAgICAgICAgICAgICAg
ICAgICAgICAgKiAyNDQyIE1IeiBbN10gKDIwLjAgZEJtKQ0KICAgICAgICAgICAgICAgICAgICAg
ICAgKiAyNDQ3IE1IeiBbOF0gKDIwLjAgZEJtKQ0KICAgICAgICAgICAgICAgICAgICAgICAgKiAy
NDUyIE1IeiBbOV0gKDIwLjAgZEJtKQ0KICAgICAgICAgICAgICAgICAgICAgICAgKiAyNDU3IE1I
eiBbMTBdICgyMC4wIGRCbSkNCiAgICAgICAgICAgICAgICAgICAgICAgICogMjQ2MiBNSHogWzEx
XSAoMjAuMCBkQm0pDQogICAgICAgICAgICAgICAgICAgICAgICAqIDI0NjcgTUh6IFsxMl0gKDIw
LjAgZEJtKSAobm8gSVIpDQogICAgICAgICAgICAgICAgICAgICAgICAqIDI0NzIgTUh6IFsxM10g
KDIwLjAgZEJtKSAobm8gSVIpDQogICAgICAgICAgICAgICAgICAgICAgICAqIDI0ODQgTUh6IFsx
NF0gKGRpc2FibGVkKQ0KDQpCdXQgdGhlIHJvdXRlciBoYXMgdGhlIHNhbWUgU1NJRCBmb3IgYm90
aCAyLjRHSHogYmFuZCBhbmQgNUdoei4gIFJvdXRlciBpcyBwcm9iYWJseSB3YW50cyBtZSB0byBj
aGVjayBpZiB0aGUgNUdIeiBjb25uZWN0aW9uIHdvdWxkIGJlIGJldHRlciB0byBtb3ZlIG92ZXIg
dGhlcmUgaWYgc28/DQoNCkkgY291bGQgcHJvYmFibHkgc3RvcCB0aGUgaXNzdWUgYnkgc2V0dGlu
ZyBteSAyLjRHSHogYW5kIDVHaHogc3NpZHMgdG8gaGF2ZSBkaWZmZXJlbnQgbmFtZXMgaW4gbXkg
c2l0dWF0aW9uLCBidXQgSSBkb24ndCBrbm93IHdoYXQgdHlwZXMgb2YgbmV0d29ya3Mgb3VyIHBy
b2R1Y3Qgd2lsbCBiZSBpbnN0YWxsZWQsIHNvIHdlJ2Qgd2hhdCB0byBtYWtlIHN1cmUgdGhlcmUg
aXQgd291bGRuJ3QgY2F1c2Ugb3RoZXIgaXNzdWVzIHdoZW4gdGhpcyBoYXBwZW5zIGluIG90aGVy
IGxvY2F0aW9ucy4NCg0KVGhhbmtzIQ0KQnJ5Y2UNCg0KUCBQTEVBU0UgQ09OU0lERVIgT1VSIEVO
VklST05NRU5UIEJFRk9SRSBQUklOVElORyBUSElTIEVNQUlMLg0KDQpUaGlzIGUtbWFpbCAoaW5j
bHVkaW5nIGFueSBhdHRhY2htZW50cykgaXMgY29uZmlkZW50aWFsIGFuZCBtYXkgYmUgbGVnYWxs
eSBwcml2aWxlZ2VkLiBJZiB5b3UgYXJlIG5vdCBhbiBpbnRlbmRlZCByZWNpcGllbnQgb3IgYW4g
YXV0aG9yaXplZCByZXByZXNlbnRhdGl2ZSBvZiBhbiBpbnRlbmRlZCByZWNpcGllbnQsIHlvdSBh
cmUgcHJvaGliaXRlZCBmcm9tIHVzaW5nLCBjb3B5aW5nIG9yIGRpc3RyaWJ1dGluZyB0aGUgaW5m
b3JtYXRpb24gaW4gdGhpcyBlLW1haWwgb3IgaXRzIGF0dGFjaG1lbnRzLiBJZiB5b3UgaGF2ZSBy
ZWNlaXZlZCB0aGlzIGUtbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGlt
bWVkaWF0ZWx5IGJ5IHJldHVybiBlLW1haWwgYW5kIGRlbGV0ZSBhbGwgY29waWVzIG9mIHRoaXMg
bWVzc2FnZSBhbmQgYW55IGF0dGFjaG1lbnRzLiBUaGFuayB5b3UuDQo=
