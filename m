Received: from mx07-00440002.pphosted.com (mx07-00440002.pphosted.com [205.220.184.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1018729A8
	for <iwd@lists.linux.dev>; Tue, 27 Sep 2022 18:33:57 +0000 (UTC)
Received: from pps.filterd (m0267195.ppops.net [127.0.0.1])
	by mx08-00440002.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28RHFl5f028869;
	Tue, 27 Sep 2022 13:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landisgyr.com; h=from : to :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pselector2;
 bh=7CG0kn4VrtcU0Cj/KUBbgFmhgXD/AT5XbxR2YUmnT8w=;
 b=lsnExDJx+NGoAqrA2xwokpP9D/uXGxPJ2j0dSj/NvBg0hvDk1TbMkAOotZFOVtzTHMZi
 0EnwyWtohcnx7AOuHEBk6UQp0EvIe50qUOh+aMj8CJGV0niPEtmeHe3Y4xlkELvx1iI7
 IDIKxFvIMWXIx/11fWCKQvnz9UXWmDmh6aGE4a7F7dhrnaHU8GJbXnfsD3hekkqVWjKy
 VdKPKarkQOybn9wJal8blSwhJ2AYRxeH1HgAZmix5Ds3pKcUZcdtFAQ8pUUSD5Zrl9tb
 Wiifem4zTaLDBPuhxvxjeSQJZ21tEtRmWn4BkFvC4V7kG5Dc/qYdazCC7m8vvxqSjfdK HA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landisgyr.com; h=from : to :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pselector1;
 bh=7CG0kn4VrtcU0Cj/KUBbgFmhgXD/AT5XbxR2YUmnT8w=;
 b=R2J1j/7VjP5wEPdfbQaw0z/HpVaRHS/eSianxAWFdEFlygs/8bb036ZEYmyUnHXgHbQI
 L3Ha8N+MuT0LPBh+L1/4/w+6PtQbB4XyPTPpcJDJC+pyJjOmM7+xwPoXZFzs6tb/PGm6
 3kQYXXQdEZHdg7S4RoT7QW5RLdZ5KRBqmwuatDF2dYvEpwx62BWwxIfCYqVQDvkBOuz1
 VZEcq91osc6NAnPPpEIzJyqNU8C0PlGaEezX/ZctB2eMAN7bPDUcONQcNBwoYZIRxlsj
 R0sSUhgwMuDHlh/M9B9le9m0a0GST1lHofw1HqAUQmtGCzkHF58TVdu9lLhPCJfeikCE Qw== 
Received: from eur02-am5-obe.outbound.protection.outlook.com (mail-am5eur02lp2057.outbound.protection.outlook.com [104.47.4.57])
	by mx08-00440002.pphosted.com (PPS) with ESMTPS id 3jsu9p3359-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Sep 2022 13:54:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RiK8LChoGxGiwAgPToGb668lYlpIKP94vxzXI038ZZf+AJHS3Jhx4G4bcIHFLK0wjs7Y1XIKe5Ry9OoDMh1xXH8T9I+g+61ozSf0O6UhqxsPPJh0xoy0xsllN1/JJDyLbih9GN8CuHGZ/cwX5F88ywol75cpK1c0YXSglFoMBm2J/WUMXNuR8tYwsWux8uH95AggUwTHQGsjVMWKopzLGsSL5l3cYl2AglbF2MoJOtvIkN0xGY1LXKdLGfeZyG8ikv3MG0F33cJ2HRGdBDtrBjbCMPhJK/+YCYHeQnGx0qhHhQ4/snE3o3PuW1DnSn65+hBcttVqAdIgxlRZnPioBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CG0kn4VrtcU0Cj/KUBbgFmhgXD/AT5XbxR2YUmnT8w=;
 b=ju4+pzsswuHWBV63ZZzjDa9P/sBtv+R8QHY1KwPSYKKXFAgxsxrYXSoTbfWjKFSO1Srcxzd3ngMvL8b5KOaK61rO1aG10KP7rP8JgY4J4EGQf427RpkeAVdwsUXl3lWMMdTVZOWk1ddiThEMZ/VNWIDdIuT8UNe2V/JAlDicvePQBqoaQNioQhqOdvifC1TC3EBzYGqdQKqcyGIZ4pQ/ihAMhi6IHuPBr/0E+FqyucQWPFAi8RCSIgun5NrNb75vkGWqRQ2ILXcrNUQAMnaGicRYnaN6X11k+TggPK2LkiZ2Ec3D6z5B952YPxA/GfvMlahydizDpNC/Rmcme3I8rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=landisgyr.com; dmarc=pass action=none
 header.from=landisgyr.com; dkim=pass header.d=landisgyr.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landisgyr.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CG0kn4VrtcU0Cj/KUBbgFmhgXD/AT5XbxR2YUmnT8w=;
 b=QffWjhL02+cw63j5606p2WXql72M3Tg5hQbCyufw1aRhvfc05TMEvRVR85JZZe7253iG87f4kR/xR/kd8gZRuVlgbkBDpwp4Hn6+4/0Ys4HFO0clxqoDig4romC2zezCWPyXg2MrjjZJChUKuJmY2Tje+ctVbASbp/scbHbkWKs=
Received: from PAXPR01MB9217.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:2b1::18) by AS4PR01MB9471.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:4ca::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 17:54:27 +0000
Received: from PAXPR01MB9217.eurprd01.prod.exchangelabs.com
 ([fe80::7055:a44:30c5:983c]) by PAXPR01MB9217.eurprd01.prod.exchangelabs.com
 ([fe80::7055:a44:30c5:983c%9]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 17:54:27 +0000
From: "Johnson, Bryce" <Bryce.Johnson@landisgyr.com>
To: Denis Kenzior <denkenz@gmail.com>,
        "iwd@lists.linux.dev"
	<iwd@lists.linux.dev>
Subject: RE: IWD dhcp issue?
Thread-Topic: IWD dhcp issue?
Thread-Index: AdjR5Sdp5fEpeP/YRLClAbci1XoOuwAP5gIAAB01dOA=
Date: Tue, 27 Sep 2022 17:54:26 +0000
Message-ID: 
 <PAXPR01MB9217CF309994538C6383C6FDF4559@PAXPR01MB9217.eurprd01.prod.exchangelabs.com>
References: 
 <PAXPR01MB9217E777D1480543FFEC84B5F4529@PAXPR01MB9217.eurprd01.prod.exchangelabs.com>
 <d741365d-e97e-57a1-2521-40e921edbdbb@gmail.com>
In-Reply-To: <d741365d-e97e-57a1-2521-40e921edbdbb@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_ActionId=99ef41b0-477b-4413-9006-0a8df86c2daa;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_ContentBits=0;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_Enabled=true;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_Method=Standard;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_Name=724d29b2-602f-4b77-ba15-b7b42511c7c5;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_SetDate=2022-09-27T17:50:08Z;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_SiteId=ee2cd48b-958f-4be4-9852-b8f104c001b9;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR01MB9217:EE_|AS4PR01MB9471:EE_
x-ms-office365-filtering-correlation-id: e4d61671-e20b-488e-606f-08daa0b151de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 XKyv3Az1dFZOlo74izsA2x1JeQ/mVkHkkwhWXAb7bc0EDoe2udx2CnsA+KAwF/9mPzvQjiRfDkb65VqboWRW8zn97wsejrPyBpKdOeWOKxDvoXzAN+OK6YdeqqoznZ2Yi5NDEuoZz5sIdBikMJnttsh6v0PTtiuJjzbmN2/R/cViHufyfiZSZcQ4RuSVa2m0gNdBbk9eIzYCpQ94MxKV1C+CEST6qL+baXhK0/t7vQuIMAuejHwG4vpKZz7j5EfMHehFXrIb5uqzgwyPVz9ODra7lkoonY6Cd+tWZu0Fq3i8tsTJL38qJgs4RqTwiMc+RYX8fej5BCeJtN8ddY9++YzZvsJnylnFwIlQnqN8Kl0T8WarGJ/xDFrnD3BQKtJHECrRKbcduesrT04neC4UMy5LqCZQQA26sCEgO15sMgm1PLXTaGP1JffKPOAP8N4Y7FLuJiwmaBnYijPkwu2sFNy8hK+7HGDf8bZQNKMckzhOvQdq26FvEjW6uYhlZBTK074tbDMDnRfVw+kf6nWeKnsAaeQ3Lt4NHH/BTfa+qbp20dNfcKUGTnebblOqFboyr+1voMNDWzTc9Ln0cV9egUKH0WPCrvxNvzIYK7RaSK+QxujdWN23BuxSKmkXcC2D3zfbXFK2zqC0k6kRg+gZYhXF1yvlqg+3RhehReqV2roiZN/A4adN2baCPPCfI1q8rhCa24eAl7wfl9lZuL7HcfKBDUnROVNhsgU2Xv96YVmzPCxo9hbLwCE3XPiWRtiivJnP6ASzRxr749fEQal1Pg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR01MB9217.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199015)(66446008)(3480700007)(86362001)(64756008)(66476007)(66556008)(8936002)(52536014)(5660300002)(33656002)(2906002)(41300700001)(4744005)(7116003)(76116006)(8676002)(66946007)(316002)(110136005)(55016003)(38070700005)(122000001)(38100700002)(83380400001)(186003)(9686003)(26005)(71200400001)(7696005)(6506007)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ajNhUURwOVJUTTJnV09rVVdOU09yZGM0b1Y3eDNwbk02dXNnbXN5WXA1ejJ0?=
 =?utf-8?B?U0Zyd1AzeWdZdmpFUnE0Q0hYc3hvZjBJWXdMdVhkS3FvQnFMeHBodXRwNTBl?=
 =?utf-8?B?eEdKZXhuNkxlczhBOFAxWitTOEFhUDRUVThwcHpaNDEvTS9lOHUrR2FmRHVs?=
 =?utf-8?B?ZW95eWZFcVFqZDhYMUtYRXVVeEtCblgzTmNrd1BaYjJmdFk3dDR2Rmo3QlVq?=
 =?utf-8?B?Rjk1MEJNcmpmN3JMNitMamYxZFJIWnd6WCtmWDVhVzFlTXVZR2s5ZkxqVlBr?=
 =?utf-8?B?SVZOU2J6Q2ZKMUdFb0V4anZnY1FtbDZTODA0QTlERGhqSW1RNmlUZmw1Sjhm?=
 =?utf-8?B?VUh2aUMyL212aUgwQWZUeXFnZTErUlpMMDNVN1lKZHlkQXVoT3llQjZZaHd1?=
 =?utf-8?B?VWpvQmtXNXhSUk9XNUtXMmpCZkNkdTBaQlRpQ2c1OVA1RUlpdUh2SEdKUjlB?=
 =?utf-8?B?bE5GY0RZK2JxV0FWMEdmQzNyNHl1MWQ1SWNxNkJlVUQxQUVweFVEZUttRi9C?=
 =?utf-8?B?SE9WaDB2b3hMZUR4OFV1Y05UcnRsUEJGZFdwenJ4RDQyZmhJU1hEb2sxV2VW?=
 =?utf-8?B?b0NzUEZTcXVJSlVDclJpVjhnNFQyRTE0S3pGMlZiaFhxZ2F2ZGVxaG5NRnJH?=
 =?utf-8?B?WEcwQlNuY3Y4TWtva2lrbG5zYy84c1lRekZ2TFMzcUtPWlVtMnJqTGZ3N1J5?=
 =?utf-8?B?d3J6ME5YdlUxTDB5MmNYZG1uQ212OTVZall0YURGcG9iSTk3WVVvZ3E5d0w1?=
 =?utf-8?B?THhqaVQwb3plQ1gvajVTRUkyNjVtQSt1YWRGS3Y2ZzVBa3BTSnM1eVFPcFJ4?=
 =?utf-8?B?SmpqWmNhckQrUmRYSHVGOHRUNmw1NnZPdjlCazQ5NzBDSVJPaVZnRVpqSFhU?=
 =?utf-8?B?OGRuOGRQTmJacXVJWUQ4c2x3cFdJY2paVjZKYkkrRWJ6YzBWcFJxMlJlazUx?=
 =?utf-8?B?S3g2RzVqbmxOOWpwWmtEYUp3SFlpQTUrUzlQZ1BROWk2QW1FZFp2MXpsWXJW?=
 =?utf-8?B?MGFCb1owUUNmNkRoZ3Nmb0N2Z0EydWlpY1BQTlJqNytMVm5mWmhVRjFoaExp?=
 =?utf-8?B?LzMyNG42YnNLSkdPdVZaZlhuWFdQMkRscXozSGpaZ1BDbWFhdWVHcUVuV3lP?=
 =?utf-8?B?eXNWMEZEVm41SFk1R2Z1bndvVjhKczZYdDV2RHBac21jbWNQOFhnVDhCWVBR?=
 =?utf-8?B?U0xzNHVkbjc2UDduYjE0T3BLc0swNEtSQTNsRDYzdUE0TXFkdmtRcjhGYXpt?=
 =?utf-8?B?YTlWcFRleXQwODFBM2crcGQ4RGVUeEdOU2wzOWR1VEVCQjllWTh1UVpEMUhI?=
 =?utf-8?B?MjhuQ1BGRUZ2dHR0QU5KUHpvY1hicno5RWxDOHVTNHNrZFl5cnZrWnBSUVZF?=
 =?utf-8?B?dlZ4Mm9vSkh5WkpTeEZkN3M0Q0x3eEpVK2kyQmpyZnFvcHdYZlNLUHBKYjc2?=
 =?utf-8?B?N2ZzbHdrVlJ2dEI3NDhzaisvZ1BZNEVtcktTTDRPNGJwUURsbXpYd2ZaRGto?=
 =?utf-8?B?azRONWxRbVNwS0k0MEFDOHplYk1oYWtNZUJDSmxyaGI4MHdFdytYZjFsWElS?=
 =?utf-8?B?YzQ1dGVyNVFpR3RxRzFYMW1IQmVTTXdRMUV3Nk1HYnZRTkV2K1FtZDJTS0ZE?=
 =?utf-8?B?dlFhQjQxQXRUUzFqWUYwRVV4dUFjL2JnT2tDQ3VDdUZzS01LWXVkd3k1NmJ4?=
 =?utf-8?B?N0hXbmZadUExcGd0M21xWXJ5aEk2b1VmWFg4cGJlaDcrRWx0N1lGeW90dHcx?=
 =?utf-8?B?alJ6b3NnMGZWTTNWLzFwUlpDc0haZ21qdE43VmpCSVgwVUxXQUlTTE5BNXln?=
 =?utf-8?B?Um5mdXIyMFhEczNCQkJVWFBpSUFOMk1XeDErRFlBNmtBemVWVHZzQ0lTNEY0?=
 =?utf-8?B?NTQrbHBVZGo1U2FHTnhTdGxBYVZ1QWVBU3RBNVVteFp6ZjlSanZtMFcrOWVV?=
 =?utf-8?B?WDB0M2loMzdkeUVHZHJzME5GTVphK3JTY2pXWFNRRllkazlUZlc2THp3U3Vs?=
 =?utf-8?B?ckl0Q25jSTk3T2lQNk9MYi9nMVl4aHpXMmlLRkRwTXI1dHpqRHdFczJRMkEw?=
 =?utf-8?B?MnUwUVV4cmx4N3dpZlVUSHVqc0FJNnFsUFRkdFEzOTRCZGdOZXZ2SGdzYXdt?=
 =?utf-8?B?L0l5UUtONytSNmtuRWtabFd4RmtzTjRqZXp6U2RXQXRydVhJTzdoTFJ3Y1Vr?=
 =?utf-8?B?aXc9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR01MB9217.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d61671-e20b-488e-606f-08daa0b151de
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 17:54:26.9217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ee2cd48b-958f-4be4-9852-b8f104c001b9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3oOscwAjYx7hQt50ZANCXW41imgYP7gTs2pqumsN4VSYw5jz81BgtRS5PA82AvSnQhgng5WqcpE2Uy/XkTNMOkkKFRK9eMTrfJQdvuj4AOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR01MB9471
X-Proofpoint-GUID: qeN2OG5p5qm5zQE2mJ5KyBkDHS9ocv3D
X-Proofpoint-ORIG-GUID: qeN2OG5p5qm5zQE2mJ5KyBkDHS9ocv3D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_08,2022-09-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1011 mlxscore=0 adultscore=0
 mlxlogscore=819 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209270111

SGkgRGVuaXMsDQoNCj4gQ2FuIHlvdSB0cnkgdGhlIGF0dGFjaGVkIHBhdGNoIChhZ2FpbnN0IGVs
bCkgYW5kIHNlZSBpZiB0aGF0IGZpeGVzIHRoaXMgaXNzdWU/DQo+DQoNCkkndmUgYXBwbGllZCB0
aGUgcGF0Y2ggYWdhaW5zdCBlbGwgMC41MyBhbmQgSSdsbCByZXBvcnQgYmFjay4gIE1pZ2h0IHRh
a2UgYSBmZXcgZGF5cyB0byB0cnkgYW5kIGNhdXNlIHRoZSBzYW1lIGlzc3VlLg0KDQpUaGFua3Mh
DQpCcnljZQ0KDQpQIFBMRUFTRSBDT05TSURFUiBPVVIgRU5WSVJPTk1FTlQgQkVGT1JFIFBSSU5U
SU5HIFRISVMgRU1BSUwuDQoNClRoaXMgZS1tYWlsIChpbmNsdWRpbmcgYW55IGF0dGFjaG1lbnRz
KSBpcyBjb25maWRlbnRpYWwgYW5kIG1heSBiZSBsZWdhbGx5IHByaXZpbGVnZWQuIElmIHlvdSBh
cmUgbm90IGFuIGludGVuZGVkIHJlY2lwaWVudCBvciBhbiBhdXRob3JpemVkIHJlcHJlc2VudGF0
aXZlIG9mIGFuIGludGVuZGVkIHJlY2lwaWVudCwgeW91IGFyZSBwcm9oaWJpdGVkIGZyb20gdXNp
bmcsIGNvcHlpbmcgb3IgZGlzdHJpYnV0aW5nIHRoZSBpbmZvcm1hdGlvbiBpbiB0aGlzIGUtbWFp
bCBvciBpdHMgYXR0YWNobWVudHMuIElmIHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMgZS1tYWlsIGlu
IGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYnkgcmV0dXJuIGUt
bWFpbCBhbmQgZGVsZXRlIGFsbCBjb3BpZXMgb2YgdGhpcyBtZXNzYWdlIGFuZCBhbnkgYXR0YWNo
bWVudHMuIFRoYW5rIHlvdS4NCg==
