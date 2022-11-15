Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20138.outbound.protection.outlook.com [40.107.2.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067072592
	for <iwd@lists.linux.dev>; Tue, 15 Nov 2022 09:18:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrTQFR2IPMi3XBuuhdbZ45RnUcwwSkF9nq5KeFJGTda5zFQF8jwQQ0jVsMhSixgUpm2+yRczCa8dYI8KQA+J7RPivOrSBn12SON9vLzcAFRYAANbO527dc34FPqZd913EzJ0m8H457XUdGWbq28G/txH5w3JTj4TaSi4KfM5HsAZco5JZSkMM9lO9gDODwu1KnpwsZkJ+vi0E4q70Ev8Xc7leh95CtqH/LHiMzZlDeXCRJ5cb8SQWsYBBLeCU6lDpGq57Ckk0c18rEkwnOelwE03Z+u0BExM+cCz0r6W9s7vhV0JitQICLCrIG4E8zmkjnEihR9DKpnYT1uTndgACg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=voDgblF4wnFvcNAWOzDDuS6CucosYOExwUlCQtAnD08=;
 b=emLEE0Deb4/SwuDrTG1gDvBLRKhK/Zyg8Nz9VPftpcpy1lc5hS4ZQX7Qmxt6RmRzuCGbtwbNjdgnu2IZIQNiXFDpv1oC5r0OX2z5Z1TY43oBSF+C8auzrLSTl7Xj5mZvTPs6ss8qXQ/hlOeE2Ae6whGb7evQQBK0S4TfP1vv2j2eOF7o4bmSZs5txTKTsrrEpK2JZlraCxZZCwIEgZI0hrtp4HobBfQf7ySPt/NvJiQC8xBFb/Pf44Dj8piog5WncB5Q2xJyCy9jxkF1y7RDrnMWYUykn+X3HfhNym0eb7kpHHrbzsDs/ubCFFP4OcnrXTTKpkOiMZRN2T0JKik8fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voDgblF4wnFvcNAWOzDDuS6CucosYOExwUlCQtAnD08=;
 b=jkPnge0o0JTf/wvD7/b7HpxOvLBiAryFIxfKk9i5mlLryyP8ISNT3v2upv94jVVamBDQsmuOqbKpk/hKj+Plxz6pQmHp/Kcuz6roueNfvDCAc4dpMI2MI5zpo28yAhHCuA2R1RFsVFnSL3L9nGV2O9uD2EXFE7VIIyhjTBQoqcg=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by PAXPR03MB7886.eurprd03.prod.outlook.com (2603:10a6:102:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Tue, 15 Nov
 2022 09:18:36 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::5c3c:8e4f:b41a:bcb9]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::5c3c:8e4f:b41a:bcb9%4]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 09:18:36 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: =?utf-8?B?Sm9uYXMgRHJlw59sZXI=?= <verdre@v0yd.nl>
CC: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Subject: Re: Scanning hangs up with Marvell wifi card
Thread-Topic: Scanning hangs up with Marvell wifi card
Thread-Index: AQHY+NM90f330kuSLUe2CMTx4SQ6oQ==
Date: Tue, 15 Nov 2022 09:18:36 +0000
Message-ID: <20221115091835.hzvvqy5ktxxdvfjn@bang-olufsen.dk>
References: <1e372397-d06d-df32-dda3-d89a580a9ee7@v0yd.nl>
In-Reply-To: <1e372397-d06d-df32-dda3-d89a580a9ee7@v0yd.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|PAXPR03MB7886:EE_
x-ms-office365-filtering-correlation-id: b5c07880-c3e5-4fa8-a7cc-08dac6ea600e
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Coz1vYmmsYkf5hAlRO2LPn5skvufTqYLzRVlQKU6hFPglFH0EAV2ms2Eq8IUm17hZ0rGX2HMWzxJa1aGQNVi+MR68qkdV/lDQDGnKf6S7HxhwkIFAZ5bzIJVctkuwdFPmr/x8V8uH4lDaao8Ya2AhqkIQvSoyxwokgmcY8D0h/BqLPQRZzd/O2cXwLpOMw79SFU6Ctqtp0K0Q+arI84M7Zg5nOzxh8nV213QijcubjPWea0mfa1PUNZQS4oHFhT/S9reiSSsBu4sy/YErX8gwzlCjo9JX8iXxeACKTH+eS0oFk3uzobEyXjXo3fj8DBwqbQ0Nz7Ftj2zbhR975qijRXETpUEq1+j+TmWK/ll2hAXmaF1DS3o3FMMXn2kLkSfHFFPbMmNfuKk8UL6H65o9aI6x2+BjY/37SCV193czeK9m6bvRntcPUpksK6nuOCfnSZILV9obuyQBjOpHjpbZZ51ysyZ9WSursoR7qvEQx+zYlmtINUKCRyOIVfuCa2dsNPQESQ03ZTvGccdukD6Bha1VxPAHIevlOJFIYQWsgpLWAQayoI+Q27S+LKcGYdnqUU37Mu8j4Oj5gRZV3+p6KW7HQBKL67ayMGWaPhcJ/xcgCvWZOWffWu8ZroKRhViWx8gvbHjn83VA10du3Kbjted8YQPstTyl7G6duknjKi4kq8QKwJHhWDDl12NIHsr3W/LojE2mJ9gH70WntJywottenyQIVNnkE4d4Y22tAkLYLF69sOUi5snEjecIKYfP7Mdt/FwHYChXgz9mPPeLJAi+FL7GsSivVeHydXGPZA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199015)(83380400001)(478600001)(26005)(6512007)(1076003)(186003)(2616005)(66574015)(85202003)(6506007)(86362001)(122000001)(38100700002)(85182001)(36756003)(38070700005)(8936002)(8976002)(41300700001)(2906002)(5660300002)(71200400001)(6916009)(6486002)(966005)(8676002)(316002)(4326008)(76116006)(64756008)(66556008)(66476007)(66946007)(66446008)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eFoxRmtoV3VudHdlS1JSdFNaZC9tajRZQlFaMlFTK3lWbW1ZQ0grQ0R4bHpj?=
 =?utf-8?B?OXpsb3dsN0htT21rWWd2WmI2cDJkbS9KNzFYQzRDVzZHelpTeDJINThRcFVh?=
 =?utf-8?B?VHdXQWQ2NVNvZHhJTUh5dnVRVFpJTS9jdmZ4SS93eHpEN3NaelVtbG0wZ0Vt?=
 =?utf-8?B?bzJiWU9SNWMvWVB2aWVoWEZ1T3hpN1ZROXoxR00rV25kVWZiMVdtWlhkVjVR?=
 =?utf-8?B?Q2t3VWNDd3FzZ0M0QWlUQ28zWEhoVER6OG0zaUw1bFlIckUzTjRMVjBncG1u?=
 =?utf-8?B?elpKTWZGYkFTREY2SEhPQ25wVEMrVzVUM09wNFBFTDI3aEZqUnl4ZHB6cGdz?=
 =?utf-8?B?eGszMVc2Q2dpTXMrRDg1Wmp2bFpCSCtaN0xtVnY2U3Vtd3hSWTFmNnVtMmR5?=
 =?utf-8?B?SzRjdGVsNDhvcGgrUzkwSnhVVXA5aTVjVlFEbm9SSWQwRkgxTHlwM0lhOHd6?=
 =?utf-8?B?ckJMWGJqWFZueC9EREZzZnR6eGlhcjdCVnNKclpRQXNzNythZTk5RGIySEdR?=
 =?utf-8?B?QjhyK1lRWk41YUJpZDRINFd2bVNaL2grYjdYUjY0NG9oUG40Q2VxY3pEcnpr?=
 =?utf-8?B?MTVHckllU2tnaEhFcjgwd3lPMDZmQlNrWi90VUt3RTZOU3pqdTFDMzdXWlpj?=
 =?utf-8?B?TENieCt0bDAxMFVIOUN0d2N2SFBZdURKYmppOVQ5Y2JhREZCc09tZXo1Z2cx?=
 =?utf-8?B?RzZrT0FFY0tydUsxZmJuNVdVYXc0eS9iZy9pTEpjc0FHOTExb2lUa3ArTzQy?=
 =?utf-8?B?RFhXUDY0SWhyMjVySjVtb1I5TjNVSGo4OGdWQnUyb3Y2SEJIcFpoZS9VL2Ir?=
 =?utf-8?B?MnZPeURyVTRpMFhOOWRPc011UEdxMlAxR1cwb2xyb09GN0oxMmVTUkM5TUF0?=
 =?utf-8?B?a1Fpd1ZBQWx0L3ZYVTNDZnpRdkZwL3ppVDN5bXQwMWRtdVcxa2Exc3ZkUkwv?=
 =?utf-8?B?UGlvWXI3dFB0SzNJajdqdWtIekdKY2tYVmlpWjhIeEQ5WUtkZkFLZllPSE5N?=
 =?utf-8?B?Tktld3kxcVBtTFZhelBvWVZEaFpYakgrcFdTOXI5TmQ3SkJ4c3EvTEhtUlpJ?=
 =?utf-8?B?V0plMjhJS1FoeFIvcWZCSXVxUlBBMDgzZmFRVk0zc3VzQU9OczFDUWZHWHpI?=
 =?utf-8?B?dW9PTmxXNjJ2Tk9wbHQ0MG9zWEN6RW0vMTJrUy9xQkptYmwyNG5vSmlTWG9r?=
 =?utf-8?B?QXJvOTFlUVgvRklpN3dzZ3VNSE9nTkZEbjZwWk1VUVMwTjBsd200ZkhaR0xV?=
 =?utf-8?B?U3RGaE5BNmRwd2owa2pJTHRUR2lpL2tyVmdxVHo4SzdpYjZSenAyKzBNc1hS?=
 =?utf-8?B?NndEUDI0cVhPNG9zenBnR3hhUmVyTFZOeDF2RURSelFwSjlOSy9vUUE2VTVo?=
 =?utf-8?B?SEx2SWlWbjdTMDNod1NOT0MrUk05MTI0bHRiNmNBclVBelhqUFVmR1JvbXlC?=
 =?utf-8?B?K25NN2dMdnJrekdMcDExMVJ3SU1XWVkrTlp6cU50VHhicW0vT0xpVy9sNWRL?=
 =?utf-8?B?alpNRzh4bEM1a0EwSlVUMmI2L0E0aDZZS0Y3di9nZEl1NUI0dXFndTVZTkpi?=
 =?utf-8?B?aE8rL2REb2lCUDNwMkxuQVdTSjJMNDBQeDBLZHE2WFlsMlMyTm9YcHRWa3Az?=
 =?utf-8?B?VlBYZm5JQ25iZ2kzR3VEc0pSZDBYYnROemZjbktLR0ZsR013cGZOZklkRFlZ?=
 =?utf-8?B?bm1YYm5VY3lTRHRGeGs3b2FiSllwWnJrMlV5bDlTdEZPYzFaRFJ6bytjUXd3?=
 =?utf-8?B?SHZ1OHlvQnl2NmlScmY3ZDduRXVnaWpkZklQbDRPL1Jjb3ZMQk43RmhPb1Zv?=
 =?utf-8?B?T2tRNmxGd2VMbUJSN2x1cXhRWm5IaTdjL2NWeFZKdkEzTnlnWENDMklJWVFW?=
 =?utf-8?B?RE94enQvdnhyKzlObFBPbkFrd3pFOUtEcHl3NVRHbDZJWFV4VnpEeXBOZ3F1?=
 =?utf-8?B?bnlBaTRrSjc4UXQ4ajFJVFRlVjU4NUhJeW1jNlVGNC9jZWNFRnNiQm9VeWx2?=
 =?utf-8?B?ekFGK0VzNC80Y3lwQzZDWHY0aHlBZHJ3Ni8yS1RWZ3R3ZngzbHlTZWNBUy9H?=
 =?utf-8?B?OGlRUjJKblhmaC92eHNleDhxaDhXRTBmazJZcDhLTEZaVk1OZ21WcFBOMTB4?=
 =?utf-8?B?OU9DTUZaNmt4VmNHOW5vbjg5bFpsdTk2Mkt1SXJ5MkpQbEZEOVdXTUV0TUhq?=
 =?utf-8?B?a2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0AAC42D014CECC4689C147ACE7166781@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c07880-c3e5-4fa8-a7cc-08dac6ea600e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 09:18:36.2097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C0sBkyHm5vuTkUjBzoxfwEqvsv5Mnr0QnUJ03lNRGVDHB2V0kpHtt+DkJOyl0JDrSLa+aXW0ltJ6UAFeOmYdtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7886

SGkgSm9uYXMsDQoNCk9uIE1vbiwgTm92IDE0LCAyMDIyIGF0IDA1OjE4OjQ2UE0gKzAxMDAsIEpv
bmFzIERyZcOfbGVyIHdyb3RlOg0KPiBIaSBldmVyeW9uZSwNCj4gDQo+IGl3ZCBpcyBoYXZpbmcg
dHJvdWJsZSBzY2FubmluZyBmb3IgbWUsIGl0IHNlZW1zIHRoYXQgYW55IHN1YnNlcXVlbnQgc2Nh
biBhZnRlcg0KPiB0aGUgZmlyc3Qgb25lIG5ldmVyIGZpbmlzaGVzLiBBIHF1aWNrIHJvdW5kIG9m
IGRlYnVnZ2luZyB0ZWxscyBpdCdzIHdvcmtlZA0KPiBhcm91bmQgYnkgYWRkaW5nIGF0IGxlYXN0
IDEwMG1zIG9mIHNsZWVwIGJlZm9yZSBxdWV1aW5nIHRoZSBzZWNvbmQgc2NhbiB3aXRoDQo+IHN0
YXRpb25fZGJ1c19zY2FuX3N1YnNldCgpIGhlcmU6DQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcv
cHViL3NjbS9uZXR3b3JrL3dpcmVsZXNzL2l3ZC5naXQvdHJlZS9zcmMvc3RhdGlvbi5jI24zODg2
DQo+IA0KPiBJJ20gdXNpbmcgYSBNYXJ2ZWxsIHdpZmkgY2FyZCB3aXRoIGZ1bGxtYWMgZHJpdmVy
IHRoYXQgaXMga25vd24gdG8gaGF2ZSBhIHRvbiBvZg0KPiBpc3N1ZXMsIHNvIEknbSBhc3N1bWlu
ZyBpdCBkb2Vzbid0IGxpa2Ugc2VlaW5nIHNjYW4gcmVxdWVzdHMgdmVyeSBxdWlja2x5IGFmdGVy
DQo+IGZpbmlzaGluZyBhIHNjYW4/DQoNCkFyZSB5b3UgdXNpbmcgdGhlIHByb3ByaWV0YXJ5IChv
dXQtb2YtdHJlZSkgZHJpdmVyIG1vYWwvbWxhbiBmcm9tDQpNYXJ2ZWxsL05YUD8gT3IgdGhlIHVw
c3RyZWFtIG13aWZpZXg/DQoNCkkgaGFkIGEgc2ltaWxhciBpc3N1ZSB3aXRoIHRoZSBwcm9wcmll
dGFyeSBkcml2ZXIgYW5kIHRoZSBwcm9ibGVtIHdhcw0KdGhhdCB0aGUgY2ZnODAyMTFfc2NhbiBk
cml2ZXIgY2FsbGJhY2sgZGVsaWJlcmF0ZWx5IHRocm90dGxlcyBzY2FuDQpyZXF1ZXN0cyB3aGlj
aCBhcnJpdmUgbGVzcyB0aGFuIDEgc2Vjb25kIGFmdGVyIHRoZSBsYXN0IHJlcXVlc3QsIHdoaWNo
DQp3b3JrcyBwYXJ0aWN1bGFybHkgYmFkbHkgZm9yIGl3ZCBiZWNhdXNlIG9mIGl0cyBzcGxpdCBz
Y2FuIGxvZ2ljLiBTZWFyY2gNCnlvdXIgc291cmNlcyBmb3Igd29hbF9pc19zY2FuX3Jlc3VsdF9l
eHBpcmVkKCkuIEhlcmUncyBhbiBleGFtcGxlDQp1cHN0cmVhbToNCg0KaHR0cHM6Ly9zb3VyY2Uu
Y29kZWF1cm9yYS5vcmcvZXh0ZXJuYWwvaW14L2xpbnV4LWlteC90cmVlL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL254cC9teG1fd2lmaWV4L3dsYW5fc3JjL21saW51eC9tb2FsX3N0YV9jZmc4MDIxMS5j
P2g9cmVsX2lteF81LjQuNzBfMi4zLjImaWQ9Njg4YjY3YjJjNzIyMGIwMTUyMWZmZTU2MGRhN2Vl
ZTMzMDQyYzdiZCNuMzc2Mw0KDQpJIHBvaW50ZWQgb3V0IHRoaXMgaW5jb21wYXRpYmlsaXR5IHRv
IE5YUCBhbmQgZXZlbnR1YWxseSB0aGV5IHJlbW92ZWQgaXQNCmFsdG9nZXRoZXIgZnJvbSB0aGVp
ciBjb2RlLCBzbyBJIHN1cHBvc2UgaXQgbWlnaHQgbm90IGJlIG5lY2Vzc2FyeS4gT3INCml0J3Mg
YSB3b3JrYXJvdW5kIGZvciBzb21lIG9sZGVyIHVuc3VwcG9ydGVkIEhXLg0KDQpObyBleHBlcmll
bmNlIHdpdGggbXdpZmlleCBJJ20gYWZyYWlkLg0KDQo+IA0KPiBGd2l3LCB3aGVuIHRoZSBzZWNv
bmQgc2NhbiBpcyBzdGFydGVkLCB0aGUgbGFzdCBlbnRyeSBpbiBkZWJ1ZyBsb2dzIGlzIHRoaXMs
IHNvIEkNCj4gZ3Vlc3MgdGhlIGxhc3QgdGhpbmcgd2UgZG8gaXMgcmVhbGx5IHF1ZXVpbmcgdGhl
IG5ldyBzY2FuOg0KPiANCj4gc3JjL3dpcGh5LmM6d2lwaHlfcmFkaW9fd29ya19pbnNlcnQoKSBJ
bnNlcnRpbmcgd29yayBpdGVtIDINCg0KS2luZCByZWdhcmRzLA0KQWx2aW4NCg0KPiANCj4gQ2hl
ZXJzLA0KPiBKb25hcw==
