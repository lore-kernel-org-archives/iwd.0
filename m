Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80129.outbound.protection.outlook.com [40.107.8.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F8C6AA2
	for <iwd@lists.linux.dev>; Wed, 29 Jun 2022 21:10:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aC/6oo8At3EMlj/57mwcORudROhBACUiVAOI/fe6jr/kYdcFCmyGXB/Wt94L2KSPOffofXekuk7kL1soMV1hN1IVKxEM4w9aI/n7/Q4Tf1ckg4cnzL7TpDIX2WohTSGPC+rXz1fq4bFL4pR2WTM8PJS2pQ9o8DrOrUPAq5g+PzVk4wbhA/AClqJrnep+jxWsBv5082H1MYO7MP/mFq31+1QZpt/rhKx/ld27uLC7G6f+vqpdg2Zh1nO0Qs18BzbiA0HQ9JUmHByRj+Wi+6p7vqmNjWoBbVwGOf5GEPTNb5b9G+6XlkKVot0K2GulcM9poRiF0Z4IwPxctlU2ySAnqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wi0HahgCPgElcnKaTssTLXgT0pNbHafNOQjtrbHs8So=;
 b=iVOtCkKXd4M8Q2+s2RDkmR+9FRHq01g/Gr+iP37s1nnaecG35kkXhLcBQXKRlbtsl9aQ9MSxnq816bIg0vd9Ax1TSubl66PBOQpMwSK3+S5UdpKLB5BFW6WZ0czai5thfocmhBAYKVf1Gl/IMSi8LmGqYsSqiqOxi5xyBcBtkCJFq7w/RxgCZrMO2GJsXgPd7flZKH7M+H8b0Op4PV2cAxcm7KBfpf0T2Bd5xQz9QAi7e08q4Rhp6Y+2z6SQyX/Oe1jTC4kEPCs9TQx7Utc/GgfPrwt8RSJ23laibXPyjHBgRii6EwG5vfkuwSzEcad6fpIFAR4Ky3mHfKz94z/HsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wi0HahgCPgElcnKaTssTLXgT0pNbHafNOQjtrbHs8So=;
 b=aVt+7Yo1AfFKzXvy9u/WGEpebt7L1fm+9i0noPNnRNdXP2YnOzYO4lJFLQ4T+qAJnoFLAyJT+TFWJJTCQINhTqTaajFAFLScwZPPsUAOGv2c8lHEEQ0b2BKXlu/qJiWRSYoDJuwNaqKnVvm2v3Zlku29E3fLtBUdyTgf09r1ZgM=
Received: from VI1PR03MB3950.eurprd03.prod.outlook.com (2603:10a6:803:75::30)
 by VI1PR03MB4960.eurprd03.prod.outlook.com (2603:10a6:803:c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 21:10:22 +0000
Received: from VI1PR03MB3950.eurprd03.prod.outlook.com
 ([fe80::de7:d0ed:2d93:9f78]) by VI1PR03MB3950.eurprd03.prod.outlook.com
 ([fe80::de7:d0ed:2d93:9f78%6]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 21:10:22 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <alvin@pqrs.dk>
CC: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Subject: Re: unsubscribe
Thread-Topic: unsubscribe
Thread-Index: AQHYi/tinDk39LkwtEuaHeuo4yCXjq1m4VGA
Date: Wed, 29 Jun 2022 21:10:22 +0000
Message-ID: <20220629211021.cikirx27lbbn6du7@bang-olufsen.dk>
References: <20220629210049.oqeafvvbpow6kqye@pqrs.dk>
In-Reply-To: <20220629210049.oqeafvvbpow6kqye@pqrs.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9db2f12-886d-4065-05c8-08da5a13c77b
x-ms-traffictypediagnostic: VI1PR03MB4960:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ysCWTbxyGVkRvL59FbA/cXRstWheKd03uOPr57gp/OPDXXbOhXgeyQVNNl7WV8Q5wRvZ6ldekdtTonVyw8N7an4WSOTtZ7KszOR4iBVbfzYASniXH8DZfuoK5S7CM0LyMKkXB/re2tfwTXx2qCalFok4CSSGJVdy6knJiT8xPRDm1xn5Z2sT5L3qqHYsqKPk9skjUmuwJXw/QWCig+jY6KEuJOPP1KsVEz2zqMYKotgiVMRpSy1hJiDA+luoRNy9sJZK1JSNQ+je22SMhuYTdyFlMTnn8S96O7bdR41l2+Bl5mE33yVgZ/Pfd4tolu/OxPU1sD2VpROPQ7nBKG42g8mnBMZg5VOvP2RgDFZEKWcaoEGKh6i/0ggLoeLHxuH96eMjfGE2xLNE8TleZ9TpKB06YyRUfF3BPjz7omhaf58matGJM/3qPA9BEmsP5Mg+QTAZrB37k4c4De7pdzqalx2C4IIASs0bkURrR7vpakl8L4qUdhEuEdsLFScsM99dux6vxDmct62IS8iqdPXOJNxM2rAKmlbv5H0XxP6MJB2lu8YkF0A7x+FPeCWAho0x+8o+nwYV1ivyIJ2RwzaJQIO1qsJMk5OGUjJ9HBtB/WIWqmC6IJEmCc221nhJRFaVEQOpJkdCJanNDQRQDinusTqcxa4bHSoiXSM/VqjrA+hBYNC9F3lBjO7M29DViy3QfU4lIFJU+EL3vXXgOHpmhdzMhoN/d7iAGlttmNMQyuqXbJc4p0hheSxQiAt1/kd9oLtid4eiQoUqW67mpC7Bqqk4AYGvcV1N1qniqLauFyQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB3950.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39850400004)(136003)(376002)(396003)(346002)(122000001)(71200400001)(38070700005)(7116003)(6512007)(8936002)(38100700002)(86362001)(8976002)(26005)(558084003)(6506007)(316002)(41300700001)(5660300002)(91956017)(6916009)(64756008)(66556008)(66476007)(76116006)(66446008)(66946007)(3480700007)(186003)(2616005)(1076003)(36756003)(85202003)(6486002)(2906002)(478600001)(4326008)(8676002)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZEVIa1JNVkZtUU5Jc0lnQVplWDkvY1VQU2NqR2VkTHA5V2JablZkUnBmRFd3?=
 =?utf-8?B?b3JHRFA2Tm1GaDBRUUhnRXFyZHFLRUp2ZEdWaDJpbXRFVmg0WWZWR21hVWNR?=
 =?utf-8?B?dEdueEk3bzBNU2RjUnVEUFVNb0NDU0cralQveE5yU3Bkak9NUUZyUEhmU0xD?=
 =?utf-8?B?SGNiOWp3NWIrbHFTYkREa20vcGw3MG1XcEozcDZuc3h3MkJoWXF2aFNXK0pt?=
 =?utf-8?B?dXNQTGw0UDZXdThZVGVpVkIzRTIvU05DdTVRQW1FVzVjZHpUcDdqTktyOTI5?=
 =?utf-8?B?T2dHZXRIdTVZRy9vakhJdVdoeUsrQUJWcWJncDZhTmk4akdvcjczVnduZndV?=
 =?utf-8?B?Y0JDalJTQkoveG9STnNqL2ZjZUEyOUU2Ri96Rmc5KzFEQURwaUozQUN5QUJs?=
 =?utf-8?B?YzNwZE5MeUh6N2VuWkR3TWljbnJENUhpdUNHV0wxWlgyY04xUithT3lHbndh?=
 =?utf-8?B?U2F3YjBJWnFjeEFNdzhJVDRJVVdPZHBBd0hNVVh1V0tkajZ1VXMyZnJMbkll?=
 =?utf-8?B?TFp4Tnlod0JQN0ltbURPWnJTWmV2Z1U1M3Z2TUc2VndDQ3V4eDZLc3plVTJX?=
 =?utf-8?B?cXRFdWkvdGR1YUVxbWNqbU05ZDJZQzBoSFU3S1Jlc05LTE1WQVpWWi9RUVM3?=
 =?utf-8?B?MWN3cEZVVTlONkl3SEw1a3BRbWx5dVVPYkYxT0hITlc5bnphZ2M1MVdoVXoz?=
 =?utf-8?B?c253VkprYi8zT05mQ1F6VnF2VGRZVGI5NHlhdEtQeHVSUzJwV2dvZTEwNE91?=
 =?utf-8?B?cVlTWlVaQ2dXY0N4RldqNWVHM1VQS3hBT0JvMHZlcnJZTGgxanhPZ3VoaVor?=
 =?utf-8?B?a3h3RUdFQTBkT25BL2REdk9wVnpWK056N2dsczZFV05sVUpwWkMyYTJOd29H?=
 =?utf-8?B?WlBpQVJ1VHMvcG5iQTIwajdDaDR0VlFQUi9ZRE9jWE5YQ0RPZVd1Wkwvdmxl?=
 =?utf-8?B?NytuSmVBVGY1WE1lTTJZeDBobWtGL3JHMkU1VFJNcWNxNDJLbWZxa092N0Z5?=
 =?utf-8?B?UStRZ2YybkxpSTFqVEs3cUpCWWRLcG9UZHJMTHg0Q1RiYnNiT3JNN1VPcHVl?=
 =?utf-8?B?RjYyN0IrWFFES2M4UC9MQXM4QlFXWVZqWTgyRFdkejBpaHhrWWFxMDdicTZ2?=
 =?utf-8?B?UUt3Z1pjdjFXSDkyRGVxUnV0SGVSbGVKZ2ExUzh0Y25vRThDVkNQSkNyMk04?=
 =?utf-8?B?UHdZcDFCcXhsNkNTcmg2VVNHZkNIRGhXRnRmNXZDeEtWamZYNWhrV2s3MEdY?=
 =?utf-8?B?SERrS1JSd21jbUZMZG5mcmo2WHR3a0V1V0VsZm5DVkw4Wi94QjI1YmcxOERh?=
 =?utf-8?B?NG95b0Q3K0pHblM1Q2xxL1lsNC9sb3F0QXpMNlFwZUM5TDlXTlBDTnRkOGpC?=
 =?utf-8?B?eGljR3p6T2x1RXNRSWtUZDBlUDFwVTgyRk1ySTFMVzIrNlBJSnhRY0xJd3R3?=
 =?utf-8?B?Yytkd0ZXblBJQnNOQURTdEJFQ1R3K2lCYUF4N2theEdxenQ3aHMxb2FFMEJG?=
 =?utf-8?B?bnlmYzc1YlA2RVMxc0ZRb0p1eVF6Sy93MDhiRldlREdoeHdkbEdpYVltL0hP?=
 =?utf-8?B?VDMya1F0QlREaXpJdTRhS2dQOThOQnFudmVCbWVPQUk3aGhOZG45TFZGTW9n?=
 =?utf-8?B?NHpmRXY4bHE0eDkyZ1JmbVM4V3lPenlqa3BXb0I1NlB4WnJ5YkNpWW5CRGh6?=
 =?utf-8?B?KzJGRHdPZUExNlNCTFUwR2lYdnJ6azV4cHZlbHczUlJEeEw4ZjhIRDJScGJl?=
 =?utf-8?B?WS81VlpxM1AxTk9OSWhpTW5oVEprdlVheXBpQkROWXVVUWp0VTBXSVhhWkVB?=
 =?utf-8?B?ZXpJd1lTam9GSlFtOEYvdGMwMDBCTVJtaHN6QmF4M2F3c1QxbmpXcE5jVGVP?=
 =?utf-8?B?SzBKWnNaYkgyc0hLUCtoaGlManpyMVM1TFpsa2YyVFM3bHdKOW5MNkxlWG5Q?=
 =?utf-8?B?UDlMZU40WEs2TmRBbjA2Z1Fya0FNYXpIVUFIYU10bFFrb29JaEkxamtaSTcy?=
 =?utf-8?B?YTVNdG51ZlZzeTFZRWI2TnM5OWVzU0xrcmVUMUE5M0FuaG9xajhpaXJoaGQx?=
 =?utf-8?B?YmlSSzJaR3BnV042UTIvYmFKaTBnd0Jib0ZmN2g5NGZkS3dzcU5zdW5zcjdz?=
 =?utf-8?B?d3d4K0crSFpnVkg5eWJ4cUZOL0FkMU9JNXpvZHhmRU0zeUxQSGJqY1NaQ3Nl?=
 =?utf-8?B?MWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <76EAD86BAD30084ABA69F07743775882@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB3950.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9db2f12-886d-4065-05c8-08da5a13c77b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 21:10:22.3640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OUtEbwe1qJeR2gd7gx5Aw+M1/HsMnrywsqisLET3NwFKCFpoGTutF/HfxTLaUuFu4dukiwW9BtDXH9KgNsmaIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB4960

V29vcHMsIHNvcnJ5IGFib3V0IHRoYXQuDQoNCkZvciBwZW9wbGUgY2x1ZWxlc3MgbGlrZSBtZSwg
dGhlIGFjdHVhbCB1bnN1YnNjcmliZSBhZGRyZXNzIGlzOg0KDQppd2QrdW5zdWJzY3JpYmVAbGlz
dHMubGludXguZGV2DQoNCk5vdyB0aGF0IHRoZSBsaXN0IGhhcyBtb3ZlZCwgaXQncyBwb3NzaWJs
ZSB0byByZWFkIHZpYSBsb3JlL2xlaSwNCndoaWNoIGlzIGdyZWF0LiBUaGFua3Mh
