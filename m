Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2127.outbound.protection.outlook.com [40.107.104.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB883219F7
	for <iwd@lists.linux.dev>; Mon, 13 Nov 2023 15:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="mUzWZpOB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOE8eVod3OlpOxO6y5AucjQv8ptxIHVdTurPZ56rpn/Szo0OPoLuaXMhEMk503ixn3qtlgebn1JomsC73iwc2tMH6hwoaDdR9bT50Hc9sMseQWLZTuAkQm6XtZS1jdk0rv2w/fsjajGW1Xgp46fDZjEmNmW58BRd/7PcU+J2bzFK2dlp5yiPxQdHbnAq6U1/EDQBXvsLVqhvZfSchQXpKSV/YuKXw68sMJUgKlTKVp35Je7mHbIqDEu/ofdHsqCEx29mTVGGHrUkqzqjWbDqGHNMsPsMwEundEwwaUmbLKnKQDNP7qPnnxWU0eFXM2ZCIc2VHhpPXNJUa/xqR9GEpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8PVbnEqUvcHM/FOAypAMR6/LsPtd7+kWFZMc5gKae8=;
 b=KxEuxMSnkC1vAq7L77aazdLH/M+5Z4vxm4i4NMESlciN4sEbt6t/Ygn8fPyT/Hf4Q2p/1llBKpdJNYP75g5fV5KnwscjfyrxAtoRUvijIGSZOtdiv+NqcTfSQgQA9x+tuu1Fj9iaDa3/A8WmMJlrMhuGszEmHOSQj6HsCN+ZY/BU6dCaIdcuC3YIwhzYaiG/ds1YjOo5tr+K6ttbxR9/+56SG06Cjrzgu4Zd2eWFfgCV7zF7hDvmkXqy88uGlhHwRugxxN5Blm5nfcCe7tDod6XEuC8t1WvBWT45LpfBItADYNVgidzICCqRc5oAAuBjZ4idt0xVyzr1+w44cyQfJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8PVbnEqUvcHM/FOAypAMR6/LsPtd7+kWFZMc5gKae8=;
 b=mUzWZpOBYJzLzLs95Bq18j5tQ0wcB2TmrLv+nxzuTT2PhEJq9Fx2WzP2M6tggkanF8yBv9+bLDMvbA6dJMyZ6AI0tcj6de8BVuQ986D4f3+ojCZcWkR6M+KhrpvtvFF5FAvoN0PT1sdjnUc5wIbkpcEl6Bxs4gYbGD0kkGymv1U=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by AS4PR03MB8505.eurprd03.prod.outlook.com (2603:10a6:20b:575::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 15:45:19 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073%3]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 15:45:19 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: James Prestwood <prestwoj@gmail.com>
CC: Denis Kenzior <denkenz@gmail.com>, =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?=
	<alvin@pqrs.dk>, "iwd@lists.linux.dev" <iwd@lists.linux.dev>, Dimitrios
 Karnikis <DIKA@bang-olufsen.dk>, Claudio Cabral <CLCA@bang-olufsen.dk>,
	=?utf-8?B?UGVkcm8gQW5kcsOp?= <PEDA@bang-olufsen.dk>, Johnny Kudahl
	<JOY@bang-olufsen.dk>, "achyut.hegde@nxp.com" <achyut.hegde@nxp.com>,
	"yuvraj.singh@nxp.com" <yuvraj.singh@nxp.com>
Subject: Re: [PATCH] station: handle ROAMING state in disconnect event (again)
Thread-Topic: [PATCH] station: handle ROAMING state in disconnect event
 (again)
Thread-Index:
 AQHZZjdUs9XT8avmIkmHb8xm4XdbCa8aLL8AgV9lpgCAAAatAIAAJe8AgAAA4ACAAARvAA==
Date: Mon, 13 Nov 2023 15:45:19 +0000
Message-ID: <dlgmutmqycq46gc2dtrlxo73yoif7ephoo6sb5hsdtj2j66yko@3xk5ll3ehg4x>
References: <20230403141927.235014-1-alvin@pqrs.dk>
 <c9b5a931-ac35-2755-c656-acd567c1505f@gmail.com>
 <lrv3ytp7a6jvuupcu4pvx2w5jmud4yj6jxbk4imflcqeuosugo@vu7fco6auklk>
 <4d8b889f-0b31-409b-93d1-7a06051adf9e@gmail.com>
 <b4e0927f-b319-48a4-b300-1b319b1c7185@gmail.com>
 <068ee7ac-298a-4bab-971f-e4c797dbdd4b@gmail.com>
In-Reply-To: <068ee7ac-298a-4bab-971f-e4c797dbdd4b@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|AS4PR03MB8505:EE_
x-ms-office365-filtering-correlation-id: a23cdf3e-b848-4242-e73c-08dbe45f89fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 tktVo/kH0XLH9UOHf57rw8zc0Pw2wkHFr/tLSRiKQebsWx51WsSGulbVqWtr+TfgUb/dPxq32xQiP8EgWklSXgBRGCUnQzY2+8jYOfFrNn0WyezsAQZtgKthhHdPtpYLQMSxlaU0riFi+ry2H0fyBrB+WFYMgcYHtE2bp5dgSMi3TcMkm4Q41vR2p7pAPpIfC8ILw5DEBy8ZmVKwh6LqCYHkynjaS4eKXmb1Qk5iQ7SkuWUOkdLcOSDF32YZOYzFBEsC1JeJM5DnNJh/A4xYuOW7Crlv10lTc6PhnrKOAqkTcd/uibFhsysyok2VNCg/Iy3OGrQqyfotvUbfLuUz01KTneIMukC1kkHFZYJGisbd0NYEeMOByEDt2InPOjwdIyiTE8TSJR9Cb+89hrREu6mOKiWFpwTnDIKK/FkxPOK1hLvOoMRVlHp4lRPeAvqIzfzvl/X0AHb78poG/LGJtBeg+UkCu/drhSr6xO/ycpJBverbAyy7HeB2S6egrQN9xsbED7hVOrOoLrA2LiKpqmpUbnei/k1JnAcm6Z6zbGixp97yWRjT6Ast4GsulPm9V5isU+O1bz8pEEzzIXuh7UZhEclrojdzUuxKpZZ7GFBFg6+P9ZQjeGo+rYj4LKgK
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(136003)(39850400004)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(66476007)(66446008)(64756008)(54906003)(66946007)(76116006)(91956017)(6916009)(66556008)(38100700002)(38070700009)(122000001)(85202003)(85182001)(86362001)(6512007)(9686003)(83380400001)(26005)(6506007)(33716001)(71200400001)(53546011)(2906002)(478600001)(316002)(6486002)(5660300002)(4326008)(41300700001)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bGNRV3RvV3JlaXdFeHF6bytWdnEyUUN4UEdqT0tYZDJPWnVrVUsyRis0cndR?=
 =?utf-8?B?VEJYYm9oa1plL2xFZkJaWllxSnMxYmY5OVRKRFVpSjlxVGYrWWIvNjhncG9t?=
 =?utf-8?B?ZWxXOGU4dlVpRTljempKUjI0dHpzeVBBUkVyTnlBT1oyUExpS3Y2eUhDZ0Jt?=
 =?utf-8?B?WXk4VXBqR3FiVkxPWS9RdlNydi9OUUh3Z2VPSml6dUY2OUxRNjlUSytNNTl5?=
 =?utf-8?B?NDVLcFRQTzZMVUZlZnV6WHZ1WVIySC9Qbk43MXJBZEpVdmtOWit2UWJnY2to?=
 =?utf-8?B?QTRid2dBR0t2eEZuYnl5YXRDN212bjlpMTZZYXp2VUZRSEdab1R3RDJNaWlG?=
 =?utf-8?B?YkZRS25RR1BqSnlGOWlCSUxiRWdvQW5VaUFlUnVvc3U5RkJFTmttM0ZuWjZH?=
 =?utf-8?B?dnVXSkhETnZ2VnBGUi9KYlJETE4zdmJDRDd5eHppMGltNlVQZFNjTm4vN2tr?=
 =?utf-8?B?VVd5Y3JmcDYvUGVCRWkyVXBMeG9Wc3lqN0hjZHN3bWo4SEdaVEQ1bm9sRDhC?=
 =?utf-8?B?K2ZVQW9ublJaSjJ5b0dzbk4yZndRMTQ1eFVxcGVXYVZITDVlQTBaZklIbjBi?=
 =?utf-8?B?NEdCcDB3V2hmS3NUK3hQMGpRd25qc0FGMUI3WWRmczYwMFBLQ0gvV0tzb0ZR?=
 =?utf-8?B?aGU4Q3p6dlUxNXFwRWFWdjNIQlJBMHRBQzgya2Vxemkvb20rbDdLZmV5ek1N?=
 =?utf-8?B?Z3RCc1pmVXNnSFVXVEtmdVA0QTl0WEw3UlFpb3hFTUdCMGxrVGc0TjhCaksy?=
 =?utf-8?B?V3RMKzhkSkFpenluQWZzZkNHVU55VTU4a1Vlc0gvRWZtVXR1a1BvdisycVBl?=
 =?utf-8?B?a0ViUWwwUjdzZFhyYUNBQis5d3gwY2ZQRGxlbGEvU1VPeXlHY0Q4ZUM1Mk5m?=
 =?utf-8?B?ZE9zRWpIQVEyR2dkKytpUE1GL3puS0pEWTIybEhLWlBpU040cHJrOXNyY2ZW?=
 =?utf-8?B?bEoxUXBkZzBQUjAweWZmREQwTThiSW1ydmpHUDdUR29BdTRTaWZBQWpTSndw?=
 =?utf-8?B?WHRFejc4NjV4QU1GTlZWY3N2UE9PaE52NTIwZ3JaRzlDY3QxQjB2M2dpeEdJ?=
 =?utf-8?B?Q2g3RHl1Zy9tbm1OOTF1NmRQcHQ5N1BqT25sTTFQZ3RqU2lMbEhva2JDSXBK?=
 =?utf-8?B?ZVIxUlpTSVhPSmJhSjhpeUpYS3FCTHV4S3JaSWVNOURkcktIaGMxd2RaUUhu?=
 =?utf-8?B?YmJoYmdVeEJGMVJvNUs5aEExYnVzS0pYN1NVY0RPYlVZZHMwTmUvYmdyTFBq?=
 =?utf-8?B?bkYwYXZMWisyTEhzc3I0RzBmOUs5SGdrNGFOZUYwZ001MUJMM0NsMkc3THZz?=
 =?utf-8?B?QjhIMVBrVmhGOWIrd05pSEZUTkxTSm1vd1VmaTkwSEhlVFVYUzRPWnNlQVhR?=
 =?utf-8?B?dlZJK0VKY3lZeUF3VWMrVkhkTjV1aStIT0drTEtsVkt2Uzhma2ZXWDFhOTVS?=
 =?utf-8?B?SitTZUVkUzBhRDhuZ0JFVzU2ZHFFeUE3WW5SdERmd3NULzRoUzhWM2FhVzJ3?=
 =?utf-8?B?dGxsL08xMUZFMG43RlhKQnR1NEhJQUpITi9aWEl3a0x6RUZhYWRYcG5RVzUw?=
 =?utf-8?B?QS9heU1pSy9PL1d0M05GNjVDZnF4VTJkU0RrUjg3eVdhRU1aTUY3ejZwOXJV?=
 =?utf-8?B?RjNWMFNpaXNGM3FlQldtY2g5NGM3bnFpTTdqVE9PVS92V0o1VmRhcVhoVW15?=
 =?utf-8?B?cDlHeGFxSWhKMElLYWxTMnRJVkYyWURxdmNqTVFoVWdDTVovbWhNbkhnYVgw?=
 =?utf-8?B?SUIrVTNaZnFCTDZrMzVUdnNwOVI3dHpIZXNNNGRodHpVUkJQTjdKdDV0NUQx?=
 =?utf-8?B?TDMxdlZjTVlVYkEwSW9JV0NRVEJQczFYeGhjaGJSR3djWC90ekFxZHg1L0Q4?=
 =?utf-8?B?c1d4L3llUVoyL1VlSkFpWXVHQ2hXbXlzSVJNV0MrRWRWZVlIN3RwT0w0cG5T?=
 =?utf-8?B?RXFDbGJNeFowS3VncHJKcUhlU3RsTDFHU1VkTTluM3AxOHdLaXVrVVNJUG03?=
 =?utf-8?B?UWxNY2s1a1pqcUlqZk9tOHVHdWRpQ2xGdXlvVFNNWDJObmVhNE00MHVXOGJG?=
 =?utf-8?B?ODBEaGRNd1QzSmdNRnBvUHNDRHdyeE1VME5BYk1qWEdSajF3SkxRYTUyL3Bl?=
 =?utf-8?B?U3c5TmJDVmoxRjNOWFJhMnJjVDlQbTlieXRObzFEbC9XOUJiK0hzOVByY1BX?=
 =?utf-8?B?L2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4AF00025FAB3742BF83CE9A46BA8774@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB3943.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a23cdf3e-b848-4242-e73c-08dbe45f89fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2023 15:45:19.0683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ntvfR2xF3H5ZsJfp+pnuspB4NWhE+B4BKjE4IuQvRNLJV/XyFX232Q3mv0qFkWjq6oBJorhpne7v7jhuuw1h5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR03MB8505

SGkgSmFtZXMsDQoNCk9uIE1vbiwgTm92IDEzLCAyMDIzIGF0IDA3OjI5OjE0QU0gLTA4MDAsIEph
bWVzIFByZXN0d29vZCB3cm90ZToNCj4gSGkgRGVuaXMsDQo+IA0KPiBPbiAxMS8xMy8yMyA3OjI2
IEFNLCBEZW5pcyBLZW56aW9yIHdyb3RlOg0KPiA+IEhpIEphbWVzLA0KPiA+IA0KPiA+ID4gDQo+
ID4gPiBPayB0aGlzIGRvZXMgbWFrZSBzZW5zZSB0byBtZS4gQSBkaXNjb25uZWN0IGZyb20gdGhl
IEFQIGNvdWxkIGNvbWUNCj4gPiA+IGluIGF0IGFueSBwb2ludCBkdXJpbmcgcmVhc3NvY2lhdGlv
biAoZHVyaW5nIHRoZSBST0FNSU5HIHN0YXRlKS4gSQ0KPiA+ID4gdGhpbmsgd2UgYXNzdW1lIHRo
ZSBrZXJuZWwgaGFuZGxlcyB0aGlzIGR1cmluZyB0aGUgYWN0dWFsDQo+ID4gPiBhc3NvY2lhdGlv
biBzdGVwLCBpLmUuIHJlbGF5cyB0aGlzIGluIHRoZSBjb25uZWN0IGV2ZW50LCBidXQgZHVyaW5n
DQo+ID4gPiBlYXBvbC9rZXkgc2V0dGluZyBJIHRoaW5rIHlvdXIgb3JpZ2luYWwgcGF0Y2ggaG9s
ZHMgc29tZSBtZXJpdC4NCj4gPiA+IA0KPiA+ID4gSnVzdCBzbyB3ZSBoYXZlIHB1YmxpYyByZWNv
cmQgSSd2ZSBzYW5pdGl6ZWQgdGhlIGxvZ3MgeW91IHNlbnQNCj4gPiA+IChyZW1vdmVkIGRhdGVz
LCBob3N0bmFtZXMsIGRyaXZlciBwcmludHMpLCBhbmQgaXRzIGNsZWFyIHRoYXQgYQ0KPiA+ID4g
ZGlzY29ubmVjdCBhdCB0aGlzIG1vbWVudCB3b3VsZCB0cmlnZ2VyIHRoaXMgIlVuZXhwZWN0ZWQg
ZGlzY29ubmVjdCINCj4gPiA+IGNhc2U6DQo+ID4gPiANCj4gPiA+IGl3ZFszNTg5XTogLi4vaXdk
LTIuOC9zcmMvZWFwb2wuYzplYXBvbF9zdGFydCgpDQo+ID4gPiBpd2RbMzU4OV06IC4uL2l3ZC0y
Ljgvc3JjL25ldGRldi5jOm5ldGRldl9saW5rX25vdGlmeSgpIGV2ZW50IDE2IG9uDQo+ID4gPiBp
ZmluZGV4IDgNCj4gPiA+IGl3ZFszNTg5XTogLi4vaXdkLTIuOC9zcmMvZWFwb2wuYzplYXBvbF9o
YW5kbGVfcHRrXzFfb2ZfNCgpIGlmaW5kZXg9OA0KPiA+ID4gaXdkWzM1ODldOiAuLi9pd2QtMi44
L3NyYy9lYXBvbC5jOmVhcG9sX2hhbmRsZV9wdGtfM19vZl80KCkgaWZpbmRleD04DQo+ID4gPiBp
d2RbMzU4OV06IC4uL2l3ZC0yLjgvc3JjL25ldGRldi5jOm5ldGRldl9zZXRfZ3RrKCkgaWZpbmRl
eD04IGtleV9pZHg9MQ0KPiA+ID4gaXdkWzM1ODldOiAuLi9pd2QtMi44L3NyYy9zdGF0aW9uLmM6
c3RhdGlvbl9oYW5kc2hha2VfZXZlbnQoKQ0KPiA+ID4gU2V0dGluZyBrZXlzDQo+IA0KPiBIbW0s
IGdvb2QgcXVlc3Rpb24uIEkgZGlkbid0IG5vdGljZSB0aGF0IGJ1dCBpdHMgY2FsbGVkIDJ4IGlu
IHRoZSBsb2dzIEFsdmluDQo+IHNlbnQgbWUuIEFsdmluLCB3YXMgaXQgYSBjb3B5LXBhc3RlIGVy
cm9yIG9uIHlvdXIgc2lkZT8gSWYgbm90IHNvbWV0aGluZw0KPiB3ZWlyZCBpcyBnb2luZyBvbi4N
Cg0KSXQncyBteSBiYWQuIEkgc2VudCBKYW1lcyBhIHNuaXBwZXQgaW4gbXkgZW1haWwgd2hlbiBh
dHRhY2hpbmcgdGhlIGxvZ3MgYW5kIGhlDQpqdXN0IHBhc3RlZCBpdCBiYWNrLiBTb21ldGhpbmcg
bXVzdCBoYXZlIGdvdHRlbiBzY3Jld2VkIHVwIG9uIG15IGVuZCB3aGlsZQ0KY29weS1wYXN0aW5n
LiBIZXJlIGlzIHRoZSBwcm9wZXIgc25pcHBldCBvbmUgbW9yZSB0aW1lOg0KDQppd2RbMzU4OV06
IC4uL2l3ZC0yLjgvc3JjL3N0YXRpb24uYzpzdGF0aW9uX2VudGVyX3N0YXRlKCkgT2xkIFN0YXRl
OiBjb25uZWN0ZWQsIG5ldyBzdGF0ZTogcm9hbWluZw0KaXdkWzM1ODldOiAuLi9pd2QtMi44L3Ny
Yy93aXBoeS5jOndpcGh5X3JhZGlvX3dvcmtfZG9uZSgpIFdvcmsgaXRlbSAxNCBkb25lDQppd2Rb
MzU4OV06IC4uL2l3ZC0yLjgvc3JjL3dpcGh5LmM6d2lwaHlfcmFkaW9fd29ya19uZXh0KCkgU3Rh
cnRpbmcgd29yayBpdGVtIDE1DQppd2RbMzU4OV06IC4uL2l3ZC0yLjgvc3JjL3N0YXRpb24uYzpz
dGF0aW9uX25ldGRldl9ldmVudCgpIEFzc29jaWF0aW5nDQppd2RbMzU4OV06IC4uL2l3ZC0yLjgv
c3JjL25ldGRldi5jOm5ldGRldl9tbG1lX25vdGlmeSgpIE1MTUUgbm90aWZpY2F0aW9uIEF1dGhl
bnRpY2F0ZSgzNykNCml3ZFszNTg5XTogLi4vaXdkLTIuOC9zcmMvbmV0ZGV2LmM6bmV0ZGV2X2F1
dGhlbnRpY2F0ZV9ldmVudCgpDQppd2RbMzU4OV06IC4uL2l3ZC0yLjgvc3JjL25ldGRldi5jOm5l
dGRldl9tbG1lX25vdGlmeSgpIE1MTUUgbm90aWZpY2F0aW9uIEFzc29jaWF0ZSgzOCkNCml3ZFsz
NTg5XTogLi4vaXdkLTIuOC9zcmMvbmV0ZGV2LmM6bmV0ZGV2X2Fzc29jaWF0ZV9ldmVudCgpDQpp
d2RbMzU4OV06IC4uL2l3ZC0yLjgvc3JjL25ldGRldi5jOm5ldGRldl9tbG1lX25vdGlmeSgpIE1M
TUUgbm90aWZpY2F0aW9uIENvbm5lY3QoNDYpDQppd2RbMzU4OV06IC4uL2l3ZC0yLjgvc3JjL25l
dGRldi5jOm5ldGRldl9jb25uZWN0X2V2ZW50KCkNCml3ZFszNTg5XTogLi4vaXdkLTIuOC9zcmMv
bmV0ZGV2LmM6bmV0ZGV2X2Nvbm5lY3RfZXZlbnQoKSBhYm9ydGluZyBhbmQgaWdub3JlX2Nvbm5l
Y3RfZXZlbnQgbm90IHNldCwgcHJvY2VlZA0KaXdkWzM1ODldOiAuLi9pd2QtMi44L3NyYy9uZXRk
ZXYuYzpuZXRkZXZfY29ubmVjdF9ldmVudCgpIGV4cGVjdF9jb25uZWN0X2ZhaWx1cmUgbm90IHNl
dCwgcHJvY2VlZA0KaXdkWzM1ODldOiAuLi9pd2QtMi44L3NyYy9uZXRkZXYuYzpuZXRkZXZfY29u
bmVjdF9ldmVudCgpIFJlcXVlc3QgLyBSZXNwb25zZSBJRXMgcGFyc2VkDQppd2RbMzU4OV06IC4u
L2l3ZC0yLjgvc3JjL25ldGRldi5jOm5ldGRldl9nZXRfb2NpKCkNCml3ZFszNTg5XTogLi4vaXdk
LTIuOC9zcmMvbmV0ZGV2LmM6bmV0ZGV2X2xpbmtfbm90aWZ5KCkgZXZlbnQgMTYgb24gaWZpbmRl
eCA4DQppd2RbMzU4OV06IC4uL2l3ZC0yLjgvc3JjL25ldGRldi5jOm5ldGRldl9nZXRfb2NpX2Ni
KCkgT2J0YWluZWQgT0NJOiBmcmVxOiAyNDEyLCB3aWR0aDogMSwgY2VudGVyMTogMjQxMiwgY2Vu
dGVyMjogMA0KaXdkWzM1ODldOiAuLi9pd2QtMi44L3NyYy9lYXBvbC5jOmVhcG9sX3N0YXJ0KCkN
Cml3ZFszNTg5XTogLi4vaXdkLTIuOC9zcmMvbmV0ZGV2LmM6bmV0ZGV2X2xpbmtfbm90aWZ5KCkg
ZXZlbnQgMTYgb24gaWZpbmRleCA4DQppd2RbMzU4OV06IC4uL2l3ZC0yLjgvc3JjL2VhcG9sLmM6
ZWFwb2xfaGFuZGxlX3B0a18xX29mXzQoKSBpZmluZGV4PTgNCml3ZFszNTg5XTogLi4vaXdkLTIu
OC9zcmMvZWFwb2wuYzplYXBvbF9oYW5kbGVfcHRrXzNfb2ZfNCgpIGlmaW5kZXg9OA0KaXdkWzM1
ODldOiAuLi9pd2QtMi44L3NyYy9uZXRkZXYuYzpuZXRkZXZfc2V0X2d0aygpIGlmaW5kZXg9OCBr
ZXlfaWR4PTENCml3ZFszNTg5XTogLi4vaXdkLTIuOC9zcmMvc3RhdGlvbi5jOnN0YXRpb25faGFu
ZHNoYWtlX2V2ZW50KCkgU2V0dGluZyBrZXlzDQppd2RbMzU4OV06IC4uL2l3ZC0yLjgvc3JjL25l
dGRldi5jOm5ldGRldl9zZXRfdGsoKSBpZmluZGV4PTgga2V5X2lkeD0wDQppd2RbMzU4OV06IC4u
L2l3ZC0yLjgvc3JjL25ldGRldi5jOm5ldGRldl9zZXRfcmVrZXlfb2ZmbG9hZCgpIDgNCml3ZFsz
NTg5XTogLi4vaXdkLTIuOC9zcmMvbmV0ZGV2LmM6bmV0ZGV2X25ld19ncm91cF9rZXlfY2IoKSBp
ZmluZGV4OiA4LCBlcnI6IDANCml3ZFszNTg5XTogLi4vaXdkLTIuOC9zcmMvbmV0ZGV2LmM6dHJ5
X2hhbmRzaGFrZV9jb21wbGV0ZSgpIHB0a19pbnN0YWxsZWQ6IDAsIGd0a19pbnN0YWxsZWQ6IDEs
IGlndGtfaW5zdGFsbGVkOiAxDQppd2RbMzU4OV06IC4uL2l3ZC0yLjgvc3JjL25ldGRldi5jOm5l
dGRldl9tbG1lX25vdGlmeSgpIE1MTUUgbm90aWZpY2F0aW9uIERpc2Fzc29jaWF0ZSg0MCkNCml3
ZFszNTg5XTogLi4vaXdkLTIuOC9zcmMvbmV0ZGV2LmM6bmV0ZGV2X21sbWVfbm90aWZ5KCkgTUxN
RSBub3RpZmljYXRpb24gRGlzY29ubmVjdCg0OCkNCml3ZFszNTg5XTogLi4vaXdkLTIuOC9zcmMv
bmV0ZGV2LmM6bmV0ZGV2X2Rpc2Nvbm5lY3RfZXZlbnQoKQ0KaXdkWzM1ODldOiBSZWNlaXZlZCBE
ZWF1dGhlbnRpY2F0aW9uIGV2ZW50LCByZWFzb246IDEsIGZyb21fYXA6IHRydWUNCml3ZFszNTg5
XTogLi4vaXdkLTIuOC9zcmMvd2lwaHkuYzp3aXBoeV9yYWRpb193b3JrX2RvbmUoKSBXb3JrIGl0
ZW0gMTUgZG9uZQ0KaXdkWzM1ODldOiAuLi9pd2QtMi44L3NyYy9zdGF0aW9uLmM6c3RhdGlvbl9k
aXNjb25uZWN0X2V2ZW50KCkgOA0KaXdkWzM1ODldOiBVbmV4cGVjdGVkIGRpc2Nvbm5lY3QgZXZl
bnQNCg0KU29ycnkgYWJvdXQgdGhhdC4NCg0KS2luZCByZWdhcmRzLA0KQWx2aW4=
