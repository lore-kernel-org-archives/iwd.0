Received: from mx08-00440002.pphosted.com (mx08-00440002.pphosted.com [185.183.31.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B93413AEA
	for <iwd@lists.linux.dev>; Thu,  7 Sep 2023 21:09:53 +0000 (UTC)
Received: from pps.filterd (m0267191.ppops.net [127.0.0.1])
	by mx08-00440002.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 387KbAXj000455;
	Thu, 7 Sep 2023 16:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landisgyr.com;
	 h=from:to:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	pselector2; bh=8tr4nQOJuDeDgsVETSb5CcMqnKEAgZSWyOAIhlmjoFc=; b=Z
	WPenVsiFFWpghkCClP4gqnV9M0F5HIdrDVR9QIH08oPTfdgB1BkI1x6xMbqb8mMy
	XlxtCh4iV9SXxRHPdU9yBWdyBqCa6StWvtVGCD1nYtsiX/XE4GRB05PPlD+3m808
	TmtS6Nww4rkh3dDo0oxS6TR2kjnEG3fj3dRlp23iogIGWYC6S+QMLIIhl3AGLh1Y
	tSXjWfsex4XPQlZilY0mfYv37z2sHEf0zP7MUkTagpSTpQVDxqk+EJudVVWbK/yL
	TuaoPjt8GVMKBsOcwoBfvNKCmNIJUu1qZQt15bXDCA/crdiUDnW57Cd52vt9HREW
	RwFhwzF05BLSwxUfdD4ZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landisgyr.com;
	 h=from:to:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	pselector1; bh=8tr4nQOJuDeDgsVETSb5CcMqnKEAgZSWyOAIhlmjoFc=; b=R
	brw9h2tgfUy4R2LUf5YKP9j14v3caNQMsV3gXqqIGXdwvNW1mRymB1DLrcqZ6m72
	71QzifPA4412H5OrzgXU0jJ15W9M5tEfk0HvdvFj+m7x02URF2k69UJvTjTBJzK5
	07dkcxdWo41wP36g2/kbfeIkru6YeL6I94s+zzWBC6Xcej50xLAkcnXOhSPavy9A
	YKXT4RMDSZm8M8UM2ObuCO4g6TpSrOwLgUfYAM7dnz2L0M8qCAbpTra1vWbc8YBa
	/++NHrpw+nkyAu1MlAw+7t5H+AJn3OVRWHgsOooY4p0rjOoRIztA78QSHKqAt5g2
	ucu22NdbN44tBRehLgKXw==
Received: from eur03-dba-obe.outbound.protection.outlook.com (mail-dbaeur03lp2170.outbound.protection.outlook.com [104.47.51.170])
	by mx08-00440002.pphosted.com (PPS) with ESMTPS id 3suwr2xfdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Sep 2023 16:40:51 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnlPR6msbAS9+WPTR2e3ygHjTHbYd2zuaYWkizPnL/rG0VlYVRPcCfdAnOgQw1Z6uCXOXsuM0wrEe5oZvO0hNsQZoa276bIB6Duad6CGaS4a1D6HPtA2zWo+8jTRB9PdodG6KyLgSTqbibLauAx3OTmAF+FOQzcG2ZMU3VhAtVHsVi33MEQ2Ie5tc5lCD2bIQeMxnvXeeCI7FbjlluEHrtdhgD9/1c6vGKzKQQ8EVmDGB2cCeLXlDi9jvgw3Obj3yxZQb9PURVZ9cjJ0iv8WiK7xNwG8aRYvRbiAnbTjX6IsZL/ICh2QX1tshsyfEXFMACoh7HhVaIRHfSLjgkzHhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tr4nQOJuDeDgsVETSb5CcMqnKEAgZSWyOAIhlmjoFc=;
 b=fcLhJrd1rV7wob8EmhBFjgbqBylC51mSeeN7qdklEju3+/ktyotpOi344s+9MVg2yTKKdUj/ezC/4eNE82xXrHQoT6Fmu+L1YM/6c8Ht/wwbRrg+tAcqk4dSuoQ/DFFFc3XFj09SqqacsvTv2u2IWox5kUrCcZbyN15l02hLVTWoeGckAQGnOaWcu4M2iEiBwYES9eWLVZU+yaKCQkPkj01XRSEBgkX+zpfcMd0l/X3KcugZEAeWr1XfLkREQtIeroIRoHtJF0AP8qyJSps5eF9RpzrxEJ+HANpWf5Z99O06ZLOO60Gb49QSPhk8UpzefzhBfehRRcws/m6WnNZo3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=landisgyr.com; dmarc=pass action=none
 header.from=landisgyr.com; dkim=pass header.d=landisgyr.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landisgyr.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tr4nQOJuDeDgsVETSb5CcMqnKEAgZSWyOAIhlmjoFc=;
 b=G3iaZiwfAnFMWUZiCAxCjJQHDWBxXO5Xj6N8I1H9+UGDQQkqm+TSIC6bFh3DveeKD9RXmm1685tHlXFC0gH0U0o0rOCQj/UPmegBlT7shJTzukX1p7chgzxtUci+stmbu9/c1ho6Ktq14FIY96QASVYU9dNyo9ViXvWAY/6BEo4=
Received: from PAXPR01MB9217.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:2b1::18) by PA4PR01MB7184.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:f7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.10; Thu, 7 Sep
 2023 20:40:49 +0000
Received: from PAXPR01MB9217.eurprd01.prod.exchangelabs.com
 ([fe80::5ac3:bc:cb37:d2ba]) by PAXPR01MB9217.eurprd01.prod.exchangelabs.com
 ([fe80::5ac3:bc:cb37:d2ba%7]) with mapi id 15.20.6768.024; Thu, 7 Sep 2023
 20:40:49 +0000
From: "Johnson, Bryce" <Bryce.Johnson@landisgyr.com>
To: James Prestwood <prestwoj@gmail.com>, Denis Kenzior <denkenz@gmail.com>,
        "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Subject: RE: [PATCH 1/2] handshake: include additional sha256 AKMs for PMKID
 generation
Thread-Topic: [PATCH 1/2] handshake: include additional sha256 AKMs for PMKID
 generation
Thread-Index: 
 AQHZZzVvQYjWUqqjnU+IQ/ZE0EEWB68jQOYAgAGPVICACWTDAIABxC6AgAmoioCA07oygIAACEYAgAAmWACAAVIvUA==
Date: Thu, 7 Sep 2023 20:40:49 +0000
Message-ID: 
 <PAXPR01MB9217D3D30DCE9AB01A000F5AF4EEA@PAXPR01MB9217.eurprd01.prod.exchangelabs.com>
References: <20230404203823.384260-1-prestwoj@gmail.com>
 <1d8a1939-93fe-12b6-5007-e6621dffa7f1@gmail.com>
 <f3259b4c-e8e3-8542-247b-9d6bd0ad00af@gmail.com>
 <05e63c78-5373-520c-15db-aa42cecd95b0@gmail.com>
 <3855c8ce-c2de-d1f3-e5d8-8c93610e4b22@gmail.com>
 <5789f7e4-793e-8e42-29d1-1a92696ec2f4@gmail.com>
 <PAXPR01MB921752F18978A3F5A5E53C91F4E8A@PAXPR01MB9217.eurprd01.prod.exchangelabs.com>
 <82109cb9-3264-4b99-a6f7-e3d71da45270@gmail.com>
 <c69115a4-858b-4602-acf7-f968be707ea4@gmail.com>
In-Reply-To: <c69115a4-858b-4602-acf7-f968be707ea4@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_ActionId=352be92d-c069-4db9-b8ff-9cf435ff0abe;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_ContentBits=0;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_Enabled=true;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_Method=Standard;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_Name=724d29b2-602f-4b77-ba15-b7b42511c7c5;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_SetDate=2023-09-06T15:19:42Z;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_SiteId=ee2cd48b-958f-4be4-9852-b8f104c001b9;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR01MB9217:EE_|PA4PR01MB7184:EE_
x-ms-office365-filtering-correlation-id: e417e383-e360-4516-aad4-08dbafe2b82d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 RnSrO0G+47/bNTUZF62dw5M6SEndffor3v5g72bkQXmVQdTmxCV+d36MpQ/QSu9yhyNJ0m12KvkLhCRgRaboctBchpA8YZUl8Wv2/+icpZkXrubkn/Pv7MEWBAAXY9xT/Wz5WwIiqB/R3urYXBeRJe/9TiwjLfqBzmiSXVG7L9VaLvQBFKoYTuScgjydbeC8CpPMgHg/TNpdJJbSYAQ2P/XmfrXuzl9+4cYfIJz2irExCnymUJSUeVGRhHv/PyqEhj7zP1MOyhFmusf8R62ZFR4YfBUq2kUF8gb7ytni/VpwIOiL1AHnfmUxOMRGXOC5M4ENAOElU6O+WdI5GSxvLFu8bc7FMhPIJTlwnUcjmxJIA3rRNWeOrqoYkoWJLlf7dOPGTv7R9d904UlU8D9rf8LP6Ei5A3TaUI1zZnzFfQHNoSKT6qJPn/bm3S1b3Dj716pA08siZgYxgnx4jC51F3BpXE0bDNbHSfmSXSgxJXBZYbsTXIlEvfEtohOh5D5qSv8G5+lGbV5Vo7cJDkz4JqafQmldx/dxg7p5NVT1P13Nej2iQd/Z8t+fiPA3IVK8gl8i9PU+LWD8ZxmwBAFkSVWXgOusZE5Y6sxRLsZTmN4GifXrsiH0PtQlS5yPE8lf
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR01MB9217.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(136003)(376002)(186009)(1800799009)(451199024)(122000001)(38070700005)(38100700002)(55016003)(86362001)(33656002)(2906002)(9686003)(110136005)(71200400001)(76116006)(7696005)(6506007)(8936002)(8676002)(52536014)(5660300002)(66556008)(66476007)(66446008)(66946007)(316002)(64756008)(41300700001)(478600001)(83380400001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZE1QZE00Sk9TM292aTdVbXJxelhuVVNmdDFxZmZPUnRkSVVrRlpYemZDdEtK?=
 =?utf-8?B?Y2gyT1lnMEgzOFZwK0JKbVM1ZnBZdmI2M25sQ2pSekZibUx3emYyOGtiVzRS?=
 =?utf-8?B?UXNuMXpRTmVGWW51d3BnT0IzOE9BeDdJQ2RzQ242bUpxQVhKaldIeUNoL1ht?=
 =?utf-8?B?TlJzVUgycTRrMXpMN2Z5R1liejV4cEYxd3E5RlZ3NVRKMXVVYTQ2WXk0V21P?=
 =?utf-8?B?MzZieDlwSys1NXF1UmtydUxmZklhU1BPa3RpQXc1Nkl2NXE0cU1Ock5VckJy?=
 =?utf-8?B?N2kvWFNhUEozcXRYMkNxUUEzemc5S0xWRi9ZOThHaUdITUIxMGRPc1A2M0o0?=
 =?utf-8?B?SU9kblVIZXU1WFdBYlc5aWhTdjhhdkY3YkE3QmJHTk5oK0k1RnpqeUd6a3dJ?=
 =?utf-8?B?RC9MOW16VVRoL0FTNGU3TXdRT3h5bFdSTU5hM2F0NmE4RHgydjZGbzRmZUR1?=
 =?utf-8?B?UFM1VExGNW5YNDZuT2JNK0paNU5YKzRXb0FQWXNsQVgxNE5HQjllYnk0ZnpV?=
 =?utf-8?B?em9XVkUzNzZ3SVBWSUYyQ3NKRmRYZkl2ZE1BZGh6Q2JqQTFMdTY4Mm5QajJy?=
 =?utf-8?B?S0xZQTZrRE5XcjlMRE5BNDJtSkZ2dUt4RHg0cjVQUmcvOEtFVExDMTFtdHJG?=
 =?utf-8?B?YVcwU28wdU82aDkwaytQa0pqSHlzeURlVlBWMzA0RnI4M1ZEK1Z1K0xVR2tS?=
 =?utf-8?B?T1pIVTI5cjI4bXkvSWhRekhqL0RzVzQrYjRySUp0SklCbmNFYmxzSFd2MWJ0?=
 =?utf-8?B?Z1UwaXE5aEh2OU5hUEVmZ01Nb3gzT2dqdlVTbUNTRHhWcHVFcXN6MWFHeVdZ?=
 =?utf-8?B?SnU1dTZmaGQyZkluTDk2RXhmcFVhdlpDbDVYQUZwU1BRdDJmUXFKMkp6bjB5?=
 =?utf-8?B?TEVaVG9IVEdiWWN0VVVtT3d2RE5IbHlYc2JDS2V3cG9VOGpGY1JWd2FZeEFX?=
 =?utf-8?B?RFdvbmRMMFRUTGwzTUJVY3drVmMwTkJtR0NBTG1aN3cxSlJlbTFsWUlvUy9y?=
 =?utf-8?B?bXJHZENsM05GSVdqbmpNOW9oTWhJaGFYVHdEYmp3YkNyNDlvRXdxM2QyYm45?=
 =?utf-8?B?cGl1bGxmODg1bGpLTExaR1REdzhWQ2xPcXlXTmlkYmgzY2hydmdUY3dQcGh1?=
 =?utf-8?B?SzJsRDVRRHdoNXlnc3NjemtuSXA0S3BhZXE5TVZVTU5GL2U0Vk5mRWwrd1hn?=
 =?utf-8?B?ejRnbC95UktKWmxTUmVWWElrS2o0MExucnoxMmI4ODdTRlIrcnJRQ293TEpF?=
 =?utf-8?B?bStqZ2xzTVNoeW14NFM1bXE5SXFzaU1kVUFCdUEzT1UyRGkzMHpKZjBOQ1N1?=
 =?utf-8?B?WUdkc3AyNFNhMG1vb2l6anZsbWI4dGdvZi9wa3U1akw1Sml0VjUzMnArTk9D?=
 =?utf-8?B?MktGT1hSUGsvcE14Sllob1lSRjhIRzJ3Y1lIaUhtb0hpT0l2MHdvNGpqWmhr?=
 =?utf-8?B?aHFESFVCd3JRS1VwZUtVWTVEdy9nTjZyUkVpcmFNdTBXcitNUGJBMTh0QXMz?=
 =?utf-8?B?cENGUjZTWnJOSnVSYzhrL05aTUpGanJMMXhZMjB5cGpDWlJIWFVNMy9UeW4v?=
 =?utf-8?B?ZGc5OFEvd0ZqQUpWV1ZxU3FtZFkwYXl2WnkxSGx6T2xLaTlnbjljR0tnb1ll?=
 =?utf-8?B?VHZSVzk5OWFmRm90cnVUWU8wMmRCNFBFSE9IQ2pOa25aUmJqTWRtWFdPK3hH?=
 =?utf-8?B?VjE5TDFGMWZGdm1UVUxWVWFrZElqOEtuNFc4MWF4Vkxza2hPSm42SWpSNGdy?=
 =?utf-8?B?V2pQcHVBYmpFUzlUNlFUR2lKZzVNcWoxNFBOK25EOHBXMVJsK0dtTUtjb2pa?=
 =?utf-8?B?YjU3LzNsZlNrdkpibGJyVnJwQkE2OFJScjVXQ1daWElTanhOcW1pdUtYM0dh?=
 =?utf-8?B?eEM5Y1VTVUo3U3pQVEszQktDTDh6a0hTc3Fodm1Ob3Z0aFoxd0xEM2JyU3lh?=
 =?utf-8?B?MU9QdzlxVzZDbjd5NGk3QTQxWWt1R3lpdGZkcStjODdmV0dBeUNWOWpDWEtP?=
 =?utf-8?B?UTNvb1YyNVRHdzJrZHNRaUVHc21DTElBemt4b0FGS1QwaHFTbklmZlpHeHZC?=
 =?utf-8?B?cnlmNFNZcmZ6MkRibzFIZWlzNHdSWmFtYVNaMCtnTkU4VTZhYkVqL3VhM1pU?=
 =?utf-8?B?VXVSYUNLWkhKMm5LeUdwSTZOTlA3ZEprcFRuVHBmNDkzNnpGLy9RSlFhando?=
 =?utf-8?B?Wnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pZglH/Wd7xm4aLL/y7Nnf6HWGmYQVkmgPhNZ1sATllN8owdqRHaBB4ocMd35m0QiZNMqvCDlOedUPLM4rjwmSWKxTXjMPK4nN6mxT36/WpmVklOcm4qJ2YXuvvxK8p1UvV/VnA0+JnG1tuEvJyzAzNT92SKLBrSJEgp0VjnZp90G0r66PHOX9GvC/lUKkqUntA2w/cvggNvbXDtj7JTiNP+S45CNeFfNELVb4Vb/7RqKhIqZ86sIGq1bh3NJBSgBLAwLMYsDKFj1jo96CnSg6NyoWOTlOCgauzIrrfrAoB+lLYbgASCmO4KrUcQkh+d4TWqUPIN5N+xdPt1wp4laLlMtJoYvW/79Mn3EiXii3iD121YbVlOkm4ef41uBmxkQg2Hhdo+lJ4HCisG1oLOuQ+obqJd4QQ/54IjfRjLoQFi/qZBRcL24+WZnxIpkAqds+AkoAf0AIOKTYJrqIlhVYbpmK4cn5iWgtYEHoKhVL/0XCxielvar0xLnp5JhJ/QfwRYEtS5VRNgoZ9NjvdIXiBsy/QdxnAkUScBXupjjkO9ltic7tB29yN4D6BnP8pCsu3GgTx0LnoEVk/IsvcZbO45BAz/gOUHA8XuIQWaNew3jGstWMmNcQuOAzBAgd6SnSRCKPGhmZr/Hrc8LJPH96HqpGyLmMWkHhB+qwtr56WBbK9DbHAgnGkQvGXKRrvkqH9As0iOQuZIVArKYTKdpAEOCMm7xplLfEjLGtBircUGbS5RhRvgyM+6XrU+soEXO11NbA6FRbZJwaiv5DzUp1Yi9CRNdoLjdFqssgTaEmkM7WZFSrvpHgfeRhbbcngZb
X-OriginatorOrg: landisgyr.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR01MB9217.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e417e383-e360-4516-aad4-08dbafe2b82d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2023 20:40:49.0518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ee2cd48b-958f-4be4-9852-b8f104c001b9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Af/OJIKQhRnfJsqLdLL3NiRYckQpS0gUQfggQpuzcHNPEnPEpCeXoE1D36Vb6qdo1UPKhMvd+mu+pXSTvwI5VBstbfz7C1H0yTYKLCw+GtA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR01MB7184
X-Proofpoint-ORIG-GUID: OugXMHL2PcMasPG9YhK-J0sb8PWfvMHU
X-Proofpoint-GUID: OugXMHL2PcMasPG9YhK-J0sb8PWfvMHU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2309070183

SGkgSmFtZXMgYW5kIGFsbCwNCg0KPg0KPkluIGNhc2UgaXQgaGVscHMgYW55b25lIGVsc2UsIHRo
ZSBpc3N1ZSB3YXMgdGhhdCB0aGUgdGVzdCB3YXMgZXhwZWN0aW5nDQo+dGhlIFBNS1NBIHByb2Nl
ZHVyZSB0byBiZSB1c2VkIHdoaWNoIElXRCBkb2VzIG5vdCBzdXBwb3J0LiBXaGVuIHVzaW5nDQo+
UE1LU0EgKGV2ZW4gd2l0aCBTQUUpIHRoZSBPcGVuIFN5c3RlbSAoMCkgYXV0aCBhbGdvcml0aG0g
aXMgZXhwZWN0ZWQgdG8NCj5iZSB1c2VkIHdoZW4gcmVhc3NvY2lhdGluZy4gSVdEIHdhcyBkb2lu
ZyBhIGZ1bGwgaW5pdGlhbCBhc3NvY2lhdGlvbiBhbmQNCj51c2luZyB0aGUgU0FFICg0KSBhdXRo
IGFsZ29yaXRobSAoaXQgbXVzdCBoYXZlIGJlZW4gYSBtaXN0YWtlIGJ5IHRoZQ0KPnBlcnNvbiBh
ZG1pbmlzdGVyaW5nIHRoZSB0ZXN0IHRoYXQgc2FpZCBpdCB3YXMgdXNpbmcgRlQgKDIpKQ0KPg0K
DQpUYWxraW5nIHdpdGggdGhlIHRlc3QgcGVyc29uLCB0aGV5IHRyaWVkIHdpdGggYm90aCBQTUtE
QSBjYWNoaW5nIGVuYWJsZWQgYW5kIGRpc2FibGVkLiAgSW4gdGhlIGRpc2FibGUgY2FzZSBpdCBz
aG91bGQgZGVhdXRoZW50aWNhdGUgdGhlIGRldmljZSBhbmQgY2F1c2UgaXQgdG8gcmVhc3NvY2lh
dGUuICBCdXQgcmVhZGluZyB0aG91Z2ggdGhlIHRlc3QgY2FzZSBpdCBzdGlsbCBpcyBjaGVja2lu
ZyB0aGUgQXV0aGVudGljYXRpb24gQWxnb3JpdGhtIGlzIHNldCB0byAwIG9uIGJvdGggY2FzZXMg
KGV2ZW4gaW4gdGhlIGRpc2FibGVkIFBNS1NBIGNhc2UpLCB3aGljaCBkb2Vzbid0IHNlZW0gY29y
cmVjdC4gIEl0IHNob3VsZCByZXBlYXQgd2hhdCBpdCBkaWQgb24gdGhlIGluaXRpYWwgYXV0aGVu
dGljYXRpb24uICBJIGhhdmUgdG8gZW1haWwgd2lmaSBhbGxpYW5jZSBhbmQgZ2V0IGNsYXJpZmlj
YXRpb24uDQoNCkJyeWNlDQoNClAgUExFQVNFIENPTlNJREVSIE9VUiBFTlZJUk9OTUVOVCBCRUZP
UkUgUFJJTlRJTkcgVEhJUyBFTUFJTC4NCg0KVGhpcyBlLW1haWwgKGluY2x1ZGluZyBhbnkgYXR0
YWNobWVudHMpIGlzIGNvbmZpZGVudGlhbCBhbmQgbWF5IGJlIGxlZ2FsbHkgcHJpdmlsZWdlZC4g
SWYgeW91IGFyZSBub3QgYW4gaW50ZW5kZWQgcmVjaXBpZW50IG9yIGFuIGF1dGhvcml6ZWQgcmVw
cmVzZW50YXRpdmUgb2YgYW4gaW50ZW5kZWQgcmVjaXBpZW50LCB5b3UgYXJlIHByb2hpYml0ZWQg
ZnJvbSB1c2luZywgY29weWluZyBvciBkaXN0cmlidXRpbmcgdGhlIGluZm9ybWF0aW9uIGluIHRo
aXMgZS1tYWlsIG9yIGl0cyBhdHRhY2htZW50cy4gSWYgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBl
LW1haWwgaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSBieSBy
ZXR1cm4gZS1tYWlsIGFuZCBkZWxldGUgYWxsIGNvcGllcyBvZiB0aGlzIG1lc3NhZ2UgYW5kIGFu
eSBhdHRhY2htZW50cy4gVGhhbmsgeW91Lg0K
