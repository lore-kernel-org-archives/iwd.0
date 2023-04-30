Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2095.outbound.protection.outlook.com [40.107.20.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AE120F0
	for <iwd@lists.linux.dev>; Sun, 30 Apr 2023 10:22:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=niCg2Hoz/QK6itpzSPv5u5df5bdZhpNCic7ZjI4br/swkhrtBK+QRm5+lcyi8IPIFAlIPDM3OrqIELJpa0NJy46zwfXWlhEcRXejEcaHgUo4Ptpy3riJM4dGljkJYRAWWhT/M5AsLevpHEP4/wouoVJWw8rhiy12se9ikrysQ32IEmeeAdycMDbJhCV+Xath3MF9MXcqmQDwIyzzi5J15G5zQQgXRjECoVzO0tPrJ1Td+2Y8prdsyJaXM/C+5BVT11ZpF7sk5YXBmSBWa1RYPIv0NRATG8g7cGNRXgs1L1iKPRxi99Y6C5YkiwhDkNDBJOww23gk7e4w4tscgGd3XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ed4UY9MzUgUotbiSnuc9CAXgCZJLkJ+XpnpoDsB2au8=;
 b=B0igEs4xkLqz+1zF2YGCJdh+gKxruSAp+JAp7wwN3dqhq5BASP2gQygJk8tQuqVIeWm6Ruq43LJOZq2rgtCJVMBDchOHedEPUeJtoOy+ZifavkdcQphENGWhmXnvAu9NqBmjtpG/iTbCG2leIou/vtvKiWV7fnJNcQ8brc3YZs7kFrATmhtWsjzAH6r8n7pMu6Ai+OkCxCI6HX5Irr8JH/HV+trHpv2kS8Kcdw0oFRToo/Ea3bAjy7qema/yWNQPw5cLQmFcSEaAXBLu1DP19crgX5ypqy5AHAAwBYxIFOXMY75YxpQnDXHIH3sYCA1IojlutX/SYK12OMtyfk0+FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ed4UY9MzUgUotbiSnuc9CAXgCZJLkJ+XpnpoDsB2au8=;
 b=HdZ1PCJgUO9OX/PNuiorfUCfpQr+t32/sJPOZpRyN7HUQCIxxfyHglbWeEUjpROTWREvXRapT+GrptQYFqhEsB1ydj8H/LO19ph9zjI3td2f6pdguG9zwqXqESHEpCW/1XD+IBYlCRzVo7sLJ83hGxluQvzZQnnWKbL6X7dhDXU=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by AS4PR03MB8436.eurprd03.prod.outlook.com (2603:10a6:20b:51b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.28; Sun, 30 Apr
 2023 10:22:29 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::42b3:97d6:3d61:b1b]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::42b3:97d6:3d61:b1b%6]) with mapi id 15.20.6340.023; Sun, 30 Apr 2023
 10:22:29 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: James Prestwood <prestwoj@gmail.com>
CC: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <alvin@pqrs.dk>, "iwd@lists.linux.dev"
	<iwd@lists.linux.dev>, Dimitrios Karnikis <DIKA@bang-olufsen.dk>, Claudio
 Cabral <CLCA@bang-olufsen.dk>
Subject: Re: [PATCH] station: handle ROAMING state in disconnect event (again)
Thread-Topic: [PATCH] station: handle ROAMING state in disconnect event
 (again)
Thread-Index: AQHZZjdUs9XT8avmIkmHb8xm4XdbCa8aLL8AgAJERQCAJ13igA==
Date: Sun, 30 Apr 2023 10:22:29 +0000
Message-ID: <nxr432iqvnvzmhkp5afjjt3oggkh5b3yydemd2litlaex2qud5@vus3zhhuo4a6>
References: <20230403141927.235014-1-alvin@pqrs.dk>
 <c9b5a931-ac35-2755-c656-acd567c1505f@gmail.com>
 <bfvlzfzk2ov4gzgedn66pblygsbzx5znyfa6vg5b7rocqbnnmp@qdwzifi5ofmq>
In-Reply-To: <bfvlzfzk2ov4gzgedn66pblygsbzx5znyfa6vg5b7rocqbnnmp@qdwzifi5ofmq>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|AS4PR03MB8436:EE_
x-ms-office365-filtering-correlation-id: e8abb13f-642b-47df-c9af-08db4964cd84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ToFgBskIt1DNmeDpJ2xTzf9EQOr45uLdutz3DDjk0ap7FXfLgeBpg1PecgfmbJUtQypm15P7T9EvbQdj2+7j3KXm9dzamAF3ZQXAavgSG8TePZTBIVlyhi2qjas9+FXOXcOFmmPER4DfNL9EfP0x2Z+vb9Ozo3FvkqAKEMlOtIixhVAtXiwihNnjRB04OEJwt3bJUGCP/B4p5Eh2EQCyGqmGm+H3J+anrlUtHvuC35n8cMdAVbpAbKU/3+jdm+l0+S5zG0yRhdOEYlMvlUvnK79jE22NMz6gfkbVNa+xrzB9PQNo/tXrSXsxVopn0ZFgnQA1mZW6n7Oy9uYtPFTuOfteRPyVKmYwv3gL0gQyxAvJSDNdOeoPxi5Dr87g1MGMdTDijcqgMTjHUTzSOvpiG+XWnPvXZ4N3Ho7QilCbMfKTv6dWD89jgUpJmcFFW6Pzp8KycYA9d/1ty/02Gv22eGA7IdpJ8ddKZHwvwhV1belqPDsoxh5+9u9dRXJ9fsjNW+h8rpzPy7ZSdV308tt6J8YbtMN3dpnp6T4afEkctY6yKPif6AVRvZeQ0BZOlloIfjshuFIfSVAhXDTIminiUZBROTyd9KQlgTzUh4ZAJNtFjZXsz4f6X6E31woCiseJ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(376002)(39840400004)(396003)(366004)(136003)(346002)(451199021)(33716001)(316002)(4326008)(53546011)(9686003)(6512007)(6506007)(186003)(66574015)(41300700001)(83380400001)(26005)(478600001)(76116006)(66946007)(91956017)(54906003)(107886003)(6916009)(66446008)(6486002)(71200400001)(64756008)(66476007)(66556008)(38100700002)(2906002)(122000001)(85202003)(85182001)(38070700005)(86362001)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dHZtUWJpMGUwUFp3b1BuWGdFbDBIWFNFamRNOU1iUXVIUno1d3dmK0J4bXJN?=
 =?utf-8?B?WktINzJYNkYwSDVMTmpUTGRLYnpOMkg2ZWI5MFRzSHdwSit0bURGOFJpUzg1?=
 =?utf-8?B?TGk2ZklJMGNhempwT2FDaEVxbGV5S09xUUxlODczUi9XbWZDcmpxUUlsMURG?=
 =?utf-8?B?bEdlVjI4Nm1RN1lpTWdZM0NXbFBrckdXdDcvVmNHMWpoMDVEYU5MdE5LM3k5?=
 =?utf-8?B?K2JmUFk5UWRVWjhjd05hVmlYZTN6TzVpTUFZMkltZHJDSERERU9xaXVpY0Nx?=
 =?utf-8?B?K29IaUdzSFBGRkRaT2pDaEFoYWpEbCtoSlgrNXhTVUpqelRwcTdROFdBcTE4?=
 =?utf-8?B?Q1JvMEpTNDV0NUFXMldJZkxqRG1aclAweEhMTUw3Z013RHlWK1FiMFB4Zmwy?=
 =?utf-8?B?MzdNNisxR1N4cmpKcmt6ZlBJSkc0WENBMnoweWFycnBLYlNpUmZWL0hLMzVW?=
 =?utf-8?B?L3JTcVhscmV1R0ZQSDRDRndZRXhOb0ZMN1FMN3pPdE04cGhXb0Y3VWVMQ1RQ?=
 =?utf-8?B?TFJPUXV4U0FDaktPM3AycEp6TEhZZEoyYmhHUUllcXFYYlgrZXcwbUFqdjVC?=
 =?utf-8?B?QkZTNFAvcVBRbmpkd3NCVS96enovNWN0bmtENzVNei91ZjB0K2lhSk1xZlcr?=
 =?utf-8?B?WUlGSjdZU0xZVms5aFBucTR0NWx4cHRCb01hMk8vTjNUVE03QmhQV2dRcjBI?=
 =?utf-8?B?enB6VGVxYUJ5WitFSHJYK1o2dU1oSWE2QjlVa2RzWEtBd2w0STE0cjMvM0NO?=
 =?utf-8?B?bW92QXpxdXlCREtwZ2J3Mnk0UzdKbndtS2VmUmhpNzl1VG1kWkZMUTRjTmpo?=
 =?utf-8?B?TzJhY0tZUnduZFZjRUkzcWlyV1M2TjhuOEtFcWswZ3BSMFhnN2VOQUFnNDdD?=
 =?utf-8?B?VkdMVUtJYlVJZEs2dzgxOER3WFBtdHBUb0ZYSlJHVHNsdURmY2h2N1JtSzFq?=
 =?utf-8?B?SURhbWZTOVc4TmwzTTYzcUtFc0FkcEY3VFI3VWQ3T1ZzRXgzVHBKOWdZMXVR?=
 =?utf-8?B?S08xdUY4Ui9VS0ZvSUNoVU5URHlWM0twWUlOeGYyVWl0MzJmczQzOFpjTU15?=
 =?utf-8?B?bXhWRDQyS0wzL2Q3bkF1VXF5VHVoZkFpYmppQVF5SkpxamdOc3JCamkvYk12?=
 =?utf-8?B?eXp5eXhFRndRY3ZZYzJNbXk5ZHRmWjUvVi9xM0Q0eUVkM2g5eHF2S2ZQSmNJ?=
 =?utf-8?B?MXY3QzQzUGVTUytURExWRUhGdjkrK1h6UzE4KzhpMXhkbVA3SFZlYkdycVlw?=
 =?utf-8?B?bG5KcnFjOHBtYUVTbVQrc1NjZGx0N3Q5dy8yZGRwdnFaekVWNjBxeUxRVGRw?=
 =?utf-8?B?NXF0R3g2K3lWNHJzdEpzNWdvK09QQUV2M00weUxxV3VFSUdXTGRnSzhhdmFM?=
 =?utf-8?B?MXNGUjFrS2pyeUcvQTRIdDJrajUzNDVxVTZDK3M1Zzg3Yy91M1NnZE9rV3cw?=
 =?utf-8?B?U01nd2NVSlpWZmFyTUNraTE2a0hKOTJ3cDB0bUdsZ3dBTkN5MEpURm1mMFR2?=
 =?utf-8?B?WkpXMkRkbDJrek1MbVVyZnlQWi96bFhoa1RkeXJpU2xPZkxRYm1YVzJMWVVY?=
 =?utf-8?B?YUNGZGRURk1iRXpRSHkrOEFvQkYxemZmS09vd0N3bnFTQ3c1UG5YWXdnelhp?=
 =?utf-8?B?WVhNcm5iSnczdFZ6TWFVWHNLMlJYa0ZMbFYzZkNFd01ienZUa3lJSC9TNWNy?=
 =?utf-8?B?YVVWcVhrRlFOSVFGYUE3TWRkMFFqRlVtUDVkZVlBM0NFbWk0dVpXUG1LQk1p?=
 =?utf-8?B?UGptZ1J3K3grSDNNRWlWODFnUDlONG1TSVc0UjNQOFJYQUxwSlBMc2I0c0E0?=
 =?utf-8?B?amJFNEJvOTJmOVIxS0JBbTVWNHZ6ZU5VQlc1VEdHSks1MzArN05TZFIwSTNn?=
 =?utf-8?B?MGhCcXFHck55UFNyUGVwT0V5am14eGJzaEl5bUhSeXZ5bGNSV2JVeVNUMCtu?=
 =?utf-8?B?SkJGbkpNVE0xd3VQQXB2Kzh2eHhXZ0p5UUM1SHoybktHNXdOVHJPeDJRSlRL?=
 =?utf-8?B?VHRGNTZzSjBHQ0ZGV1dScXlENDRoUVRvRklvZlJFQkpaM1cybW1MbWlRVkdv?=
 =?utf-8?B?ME1kMXp0YnFVWWVIVm51TjJOOFdpZXA1S1RxNEpNdDkrR2NMNTdGL3BQamlt?=
 =?utf-8?Q?RYuxSBHuh0cttOb/LRhjs7nDo?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3544DE76EAF5E941813767A885E2F35E@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e8abb13f-642b-47df-c9af-08db4964cd84
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2023 10:22:29.6502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1zSO+Z1TI3Juqj3meaed6v2K+vXE0fU+pAYgnD/9xq8xo4CIhzVgJdHZ30UEeP6IGmnAooUt96vB+VFKyZqLIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR03MB8436

SGkgYWdhaW4sDQoNCk9uIFdlZCwgQXByIDA1LCAyMDIzIGF0IDA5OjEyOjIwQU0gKzAwMDAsIEFs
dmluIMWgaXByYWdhIHdyb3RlOg0KPiBIaSBKYW1lcywNCj4gDQo+IE9uIE1vbiwgQXByIDAzLCAy
MDIzIGF0IDAzOjM1OjI4UE0gLTA3MDAsIEphbWVzIFByZXN0d29vZCB3cm90ZToNCj4gPiBIaSBB
bHZpbiwNCj4gPiANCj4gPiBPbiA0LzMvMjMgMDc6MTksIEFsdmluIMWgaXByYWdhIHdyb3RlOg0K
PiA+ID4gRnJvbTogQWx2aW4gxaBpcHJhZ2EgPGFsc2lAYmFuZy1vbHVmc2VuLmRrPg0KPiA+ID4g
DQo+ID4gPiBUaGUgYmxhbWVkIGNvbW1pdCBjbG9iYmVyZWQgdGhlIG5vbi1GVCAoUmVhc3NvY2lh
dGlvbikgcm9hbWluZyBjYXNlDQo+ID4gPiBpbiB0aGUgZGlzY29ubmVjdCBldmVudCBoYW5kbGVy
LCBjYXVzaW5nIGl3ZCB0byBwb3RlbnRpYWxseSBnZXQgc3R1Y2sgaW4NCj4gPiA+IHRoZSBST0FN
SU5HIHN0YXRlIGFmdGVyIGEgZmFpbGVkIHJlYXNzb2NpYXRpb24gZHVyaW5nIG5vbi1GVCByb2Ft
aW5nLg0KPiA+ID4gQWRkIGl0IGJhY2suDQo+ID4gPiANCj4gPiA+IFRoZSBzdWJqZWN0IGlzIGlu
c3BpcmVkIGJ5IGEgcHJldmlvdXMgY29tbWl0IHdoaWNoIGRpZCB0aGUgc2FtZSB0aGluZywNCj4g
PiA+IGJ1dCBpbnRyb2R1Y2VkIGJlZm9yZSB0aGUgbmV3IHJvYW1pbmcgc3RhdGVzIHdlcmUgYWRk
ZWQsIG5hbWVseSBjb21taXQNCj4gPiA+IDg3NThjYzg5NDg3YiAoInN0YXRpb246IGhhbmRsZSBS
T0FNSU5HIHN0YXRlIGluIGRpc2Nvbm5lY3QgZXZlbnQiKS4gVGhlDQo+ID4gPiByYXRpb25hbGUg
aGVyZSBpcyB0aGUgc2FtZS4NCj4gPiA+IA0KPiA+ID4gRml4ZXM6IGVkZjU1NmNjN2JiOSAoInN0
YXRpb246IGFkZCB0d28gbmV3IHJvYW1pbmcgc3RhdGVzIChGVC9GVykiKQ0KPiA+IA0KPiA+IElJ
UkMgbGVhdmluZyBvdXQgdGhlIG9sZCBST0FNSU5HIHN0YXRlIGluIHRoaXMgc3dpdGNoIHdhcyBh
Y3R1YWxseSBkb25lDQo+ID4gaW50ZW50aW9uYWxseS4gVGhpcyBpcyBiZWNhdXNlIG5ldGRldl9y
ZWFzc29jaWF0ZSgpIHRha2VzIGEgY2FsbGJhY2sgYW5kIGFueQ0KPiA+IGZhaWx1cmVzIHdpdGgg
dGhlIHJvYW0gKnNob3VsZCogc2hvdyB1cCBpbiBuZXRkZXZfY29ubmVjdF9ldmVudCgpLCBhbmQg
aW4NCj4gPiB0dXJuIGNhbGwgdGhlIGNhbGxiYWNrIHdoaWNoIHRoZW4gbGVhZHMgdG8gdGhlIHNh
bWUgc3RhdGlvbl9kaXNhc3NvY2lhdGVkKCkNCj4gPiBjYWxsLiBXZSB3YW50ZWQgdG8gYXZvaWQg
dGhlIHBvdGVudGlhbCBvZiBhIGRpc2Nvbm5lY3QgZXZlbnQgQU5EIHRoZSBjb25uZWN0DQo+ID4g
Y2FsbGJhY2sgYm90aCBjYWxsaW5nIHN0YXRpb25fZGlzYXNzb2NhdGVkKCkuDQo+IA0KPiBZZXMs
IHRoYXQgbWFrZXMgc2Vuc2UuDQo+IA0KPiA+IA0KPiA+IERvIHlvdSBoYXBwZW4gdG8gaGF2ZSBh
biBpd21vbiBwY2FwL2xvZyBvZiB0aGlzIGJlaGF2aW9yPyBJZiBpdHMgYSBrZXJuZWwNCj4gPiBi
dWcgYW5kIGEgQ01EX0NPTk5FQ1QgY29ubmVjdCBldmVudCBuZXZlciBjb21lcyB0aGVuIHdlIHBy
b2JhYmx5IGRvIG5lZWQNCj4gPiB0aGlzIHBhdGNoLCBidXQgbWF5YmUgaW5zdGVhZCB3aXRoIGFu
IExfV0FSTl9PTiBvciBhIGJpZyBkZWJ1ZyBwcmludCBiZWNhdXNlDQo+ID4gaXQgcmVhbGx5IHNo
b3VsZG4ndCBiZSBoYXBwZW5pbmcuDQo+IA0KPiBZZXMsIHRoaXMgd2lsbCBiZSBvdXIgbmV4dCBk
aXJlY3Rpb24gb2YgaW5xdWlyeS4gRWFzdGVyIGlzIGNvbWluZyB1cCBhbmQgdGhlDQo+IGlzc3Vl
IGlzIHJlcHJvZHVjaWJsZSBieSBjb2xsZWFndWVzIHdobyBhcmUgb24gaG9saWRheS4gQnV0IEkg
d2lsbCBmb2xsb3cgdXAuDQoNCkp1c3QgYSBzaG9ydCB1cGRhdGUgb24gdGhpcy4gQ3VycmVudGx5
IHdlIHJvb3QtY2F1c2VkIHRoZSBmYWlsdXJlIHRvIGEgYnVnIHdoZXJlDQp0aGUgMm5kIHBhY2tl
dCBvZiB0aGUgNC1XYXkgSGFuZHNoYWtlIGdldHMgc2lsZW50bHkgZHJvcHBlZCBieSB0aGUgZmly
bXdhcmUgd2UNCmFyZSB1c2luZyBhbmQgdGhlIHZlbmRvciBpcyBsb29raW5nIGludG8gaXQuIFVu
dGlsIHRoaXMgaXMgZml4ZWQgd2UgY2FuJ3QgcG9pbnQNCmFueSBmaW5nZXJzIGF0IElXRC4gSSds
bCBmb2xsb3cgdXAgb25jZSB0aGF0IGlzIGZpeGVkLiBUaGFua3MhDQoNCktpbmQgcmVnYXJkcywN
CkFsdmluDQoNCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHF1aWNrIHJlcGx5Lg0KPiANCj4gS2luZCBy
ZWdhcmRzLA0KPiBBbHZpbg0KPiANCj4gPiANCj4gPiBUaGFua3MsDQo+ID4gDQo+ID4gSmFtZXMN
Cj4gPiANCj4gPiA+IC0tLQ0KPiA+ID4gICBzcmMvc3RhdGlvbi5jIHwgMSArDQo+ID4gPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEv
c3JjL3N0YXRpb24uYyBiL3NyYy9zdGF0aW9uLmMNCj4gPiA+IGluZGV4IGQ1NjUwYTI5OTVhOS4u
NjlmOWJlNzk4ODBkIDEwMDY0NA0KPiA+ID4gLS0tIGEvc3JjL3N0YXRpb24uYw0KPiA+ID4gKysr
IGIvc3JjL3N0YXRpb24uYw0KPiA+ID4gQEAgLTMyMDEsNiArMzIwMSw3IEBAIHN0YXRpYyB2b2lk
IHN0YXRpb25fZGlzY29ubmVjdF9ldmVudChzdHJ1Y3Qgc3RhdGlvbiAqc3RhdGlvbiwgdm9pZCAq
ZXZlbnRfZGF0YSkNCj4gPiA+ICAgCQkJCQlldmVudF9kYXRhLCBzdGF0aW9uKTsNCj4gPiA+ICAg
CQlyZXR1cm47DQo+ID4gPiAgIAljYXNlIFNUQVRJT05fU1RBVEVfQ09OTkVDVEVEOg0KPiA+ID4g
KwljYXNlIFNUQVRJT05fU1RBVEVfUk9BTUlORzoNCj4gPiA+ICAgCWNhc2UgU1RBVElPTl9TVEFU
RV9GVF9ST0FNSU5HOg0KPiA+ID4gICAJY2FzZSBTVEFUSU9OX1NUQVRFX0ZXX1JPQU1JTkc6DQo+
ID4gPiAgIAkJc3RhdGlvbl9kaXNhc3NvY2lhdGVkKHN0YXRpb24pOw==
