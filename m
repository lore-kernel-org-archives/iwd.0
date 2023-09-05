Received: from mx07-00440002.pphosted.com (mx07-00440002.pphosted.com [205.220.184.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87D1378
	for <iwd@lists.linux.dev>; Tue,  5 Sep 2023 16:49:06 +0000 (UTC)
Received: from pps.filterd (m0267193.ppops.net [127.0.0.1])
	by mx08-00440002.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 385GSVp0030243;
	Tue, 5 Sep 2023 12:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landisgyr.com;
	 h=from:to:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	pselector2; bh=GVUf6QPpKOUwZhKBB02kS+bsC0zmyF/dTYXIJ5iQCbo=; b=U
	6XwTpAMuZpknKVnV2cFpflsjFKhTYdMGkzAuA+cMfxNxtZuqKi0PBMiGGX+SSJ1T
	5UvzZEg0pfrTezJtgk6cB75j3ZKgvGxCY2WXkuVnS63XmStOTEfGat3t+CL0NmYr
	cdC27/Yp2naNjBAI3UDCvRaArGvlqqS5w1ALvxnSGPFGuH8wXxmEMF6uaEoXsCft
	81lrnPntUk1T4dIbETJ3UBv6CerdatIUSVtUsF86oJT+jSjQdaECb5W6CtAcvpIl
	ejIjDRKlVslRV3a135rWw5ymiM3LdeA3mxRmp3BhAypvA4bYsLZ3HJMbv4A9ffIq
	g/6wKbaHFRHlbRhXP/ZFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landisgyr.com;
	 h=from:to:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	pselector1; bh=GVUf6QPpKOUwZhKBB02kS+bsC0zmyF/dTYXIJ5iQCbo=; b=P
	LrsDakk18C9FqG3FQUvOyn0X9oKxFCTGZ9uFxx926lRA+xP65qHBmn9cfA+ioxyj
	/zlZEEprY5fVxUVIfD9ftXejXciGqtIJ7x7jmJ91zQDYTlp7Y9gkOWZ5XRVQtiys
	uIq+tINCtUOGYeSZuu03LR4l9jNgOKcjdP5z0XmDQCGiB5TvMmA7QNPWtUeILgva
	/cM33gONS56FWiJki6td0rpezSgN3zF9ZarVf63St6Z8dWVqaJ7FQqkEnAxNb7tS
	us62q4FeVs5Otvrbwjrfag6zhn+7SVvgNJunNjMa3eOxtwBtjm6qwll89T+iISs2
	ZwxduYMgLru/SjyLBQrZQ==
Received: from eur03-dba-obe.outbound.protection.outlook.com (mail-dbaeur03lp2174.outbound.protection.outlook.com [104.47.51.174])
	by mx08-00440002.pphosted.com (PPS) with ESMTPS id 3sv0x7ugkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Sep 2023 12:33:32 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBEpLjwPRrWs1SL9Un9OL43Mzj2hkIKz61yz9iYRotAS12MgFS9HkQAaMMX4CEUHM4KKI8bi832sD7JdW51LPKvSJj0EoizVO1Wb8U3WJMHsknG+NcZJfzJcNhPynX1UT9AL5IugEc3M6iyZelW5igKDWmAOTtOFJnGP6+hS2kFyo+v8NbrUsrP/GjUcboOenRELG74luFp5IuvsqR3KPhGPh+7j8l/mvUkq3Qz5+S5nEjD6PKzeNcUOzt27iShp/D54HDCIUzmKG5mZpKl9imrO1S/oj+No4jMguR2QT2jy6bnhBJq6rpaaA3PbIDkGR4BZb7baecZCeS7BI106kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVUf6QPpKOUwZhKBB02kS+bsC0zmyF/dTYXIJ5iQCbo=;
 b=gJuw7krsVwCbcGnoRvRrIrW5dnMLFoBS4ZPLzflNPCrPywKxYUZSM5gU8SAe6vmAO9k4C15/4NdlyCo8oHt4NGDJngCVGg0L/SgVHdVCkkc3BdxzRSEh7w+sMWFzV5K3SYU+Yw3g0qL2FubGLObH1p8Zmkmq0oWd5+Kb9F5dIKrV6h4SnHsLGZcwoq3AjCRgxcUbWDU0+jTzpJvecmiEbIOF7GnaSG3Pxa667QjbXed6i2Fyr1vbHtdbjopYDSsxJt4lYfskASq53RWj6Uz0RzfJnyd3zp+NL4jlgEz/lkBp6jXyhw/4dcXKTOOKoAYn8wT5L22OcyOOFW8ygstkgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=landisgyr.com; dmarc=pass action=none
 header.from=landisgyr.com; dkim=pass header.d=landisgyr.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landisgyr.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVUf6QPpKOUwZhKBB02kS+bsC0zmyF/dTYXIJ5iQCbo=;
 b=o9sr0Um4zK94FkhDszI0H6hZRcjnEhRtkN8zGqScfS+9iH3d2vfQYn0bH9KVyCDXSICB7N4zGid1QlOCKD38lKv8GUtgSjUvX41qlvQOMQWR7UYlI2WqOnEhl1eqnqeYfKtfpSdRVIDv1taWp6o863vXY9cbYcFxgns+dS2w7h0=
Received: from PAXPR01MB9217.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:2b1::18) by PAXPR01MB10394.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:245::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.25; Tue, 5 Sep
 2023 16:33:30 +0000
Received: from PAXPR01MB9217.eurprd01.prod.exchangelabs.com
 ([fe80::5ac3:bc:cb37:d2ba]) by PAXPR01MB9217.eurprd01.prod.exchangelabs.com
 ([fe80::5ac3:bc:cb37:d2ba%7]) with mapi id 15.20.6768.024; Tue, 5 Sep 2023
 16:33:30 +0000
From: "Johnson, Bryce" <Bryce.Johnson@landisgyr.com>
To: Denis Kenzior <denkenz@gmail.com>, James Prestwood <prestwoj@gmail.com>,
        "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Subject: RE: [PATCH 1/2] handshake: include additional sha256 AKMs for PMKID
 generation
Thread-Topic: [PATCH 1/2] handshake: include additional sha256 AKMs for PMKID
 generation
Thread-Index: 
 AQHZZzVvQYjWUqqjnU+IQ/ZE0EEWB68jQOYAgAGPVICACWTDAIABxC6AgAmoioCA07oygA==
Date: Tue, 5 Sep 2023 16:33:30 +0000
Message-ID: 
 <PAXPR01MB921752F18978A3F5A5E53C91F4E8A@PAXPR01MB9217.eurprd01.prod.exchangelabs.com>
References: <20230404203823.384260-1-prestwoj@gmail.com>
 <1d8a1939-93fe-12b6-5007-e6621dffa7f1@gmail.com>
 <f3259b4c-e8e3-8542-247b-9d6bd0ad00af@gmail.com>
 <05e63c78-5373-520c-15db-aa42cecd95b0@gmail.com>
 <3855c8ce-c2de-d1f3-e5d8-8c93610e4b22@gmail.com>
 <5789f7e4-793e-8e42-29d1-1a92696ec2f4@gmail.com>
In-Reply-To: <5789f7e4-793e-8e42-29d1-1a92696ec2f4@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_ActionId=12c9139a-9ab5-4f32-9bdc-bccb2c458da9;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_ContentBits=0;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_Enabled=true;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_Method=Standard;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_Name=724d29b2-602f-4b77-ba15-b7b42511c7c5;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_SetDate=2023-09-05T16:22:27Z;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_SiteId=ee2cd48b-958f-4be4-9852-b8f104c001b9;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR01MB9217:EE_|PAXPR01MB10394:EE_
x-ms-office365-filtering-correlation-id: 7509bc52-9c1e-49bf-032b-08dbae2dd712
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 s7YxN9Tc2qUa7Gh9nYMqK25Qhd3NZU29jkIEYsKLazP6yzmRBviVS7ejUvpU/QQJoLURubEtjcx8U3PtYxElcQPkQYTHQC1/qXcCjCxWVUx2BTES2Dy9tE6BiopLe229sQlX7Dppgnthk0J+CEoBhnooT8aDBPrpYoI7UJ4ZcJ7AsG1NufJ48y9rT3Duk8idc7RtH76nNtgX5YhLXq+cXLQQdqQDd1i+9KyDbXld4HF17/C6KmAuenkSEEwNih8SfvIPsLPuIcHiv9ndkriQmZIMLwpAJ84yHqgx3UQrf8h9RvTMg69/oxSjGJj1kY9/yUY2QffSjR0Lx1tKRerza0m3LP+BlHEzGVhrDNqAmc2v9zMBpuKl0QU+jmFFMa7Qnw9YAkQyucCtdXBct5PExQ82EYJFYUEvHPTDKHCWjPL2u5ynN6TUabYpJ+xPtKlccWHbK0pbue+klSJ3BCcgcgzvHAJCNmlUaRfK1ePCwXjxw2Fh5ij+MN60bE32iEsTXtwbT758mLsYRYFJsuleMZj5B+uvTXyhRVEC8nphQP92FS01h8/tiVGE/CTdomAtlenX9LsVRryQgJSQkKEfrORhdMwFiCdRtvo3/1uaEm5zkv7sY1nuNtEiUtWeHNcO
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR01MB9217.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(39860400002)(366004)(136003)(451199024)(1800799009)(186009)(5660300002)(8676002)(316002)(110136005)(64756008)(2906002)(66446008)(66476007)(66946007)(76116006)(66556008)(8936002)(52536014)(41300700001)(6506007)(7696005)(55016003)(26005)(9686003)(38070700005)(45080400002)(122000001)(71200400001)(478600001)(38100700002)(33656002)(83380400001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?OXQ4cFhYOWNwVmYwMysyM25qWmhzUlFWcGEzdDdYZHdjSXhTQkFaTUphZUdl?=
 =?utf-8?B?bDRFUFROS3ppQisvblZ2Q0EyNFFjRTZxbkswanZNdkE0RUUxN0s4bWJhVC81?=
 =?utf-8?B?ZW40T3poSG5uNVNrc2RtOUxSaUJBRHlFcWVzSStUQ3ZtRFZwZkpTN2g0MWNB?=
 =?utf-8?B?Y2t3MDBLUzl6bUZxSitZR2JOai91SnBIRWRlTGlGREM5UXlYRWQ0cjhHcE1h?=
 =?utf-8?B?M01NZUZUNVhyb0R5MUZCOVJWemhxcmpkZ2ppVUlVMFk2d3J4eXZmL0dWc1V1?=
 =?utf-8?B?MG1SRUd4Y2NSRzZ0NmdtY2FJZEZGaWdueCtBWHlZYXdpb3lDV2pKM1A1eWV1?=
 =?utf-8?B?OXY5WC9rRDNCQWVQVGdXZzBVUDFFcXNnTnlDcXN4S0hHajIzMzczWld1N0kv?=
 =?utf-8?B?OFJRSzNTcmJSaVNDOTB1TEd6REIxNmpJdVV2MVdDSmRqOURDUTZmejdxclZH?=
 =?utf-8?B?aTJ3ZiswUjFMYm5hRHgxZUV3MW8wa3BzcTVNbEk3SkJsS1VxSytld2I5RUtq?=
 =?utf-8?B?a09nN3pEU2k1dnhlUGxHZ1dhNDRXM3NTbEFUeHRqN2RuWmYxVHZmMis0WW5x?=
 =?utf-8?B?OWFTTXpYOWxURVJnTHJDRmh6TFQzdEw0QXY4a0UvUk5DOEFUTENZa0NzVzZ0?=
 =?utf-8?B?dWhyYnRBNGtvUUozN1gxWXpUYnUrc3pJRGRWS20yc2VWZ2lEZFoyWVRoNm1z?=
 =?utf-8?B?WEIrUUFWK0NhR2sxRXVLbzNyd08rTEE1M1dsV2tmOXl2eXlZcG94V2k3UWJK?=
 =?utf-8?B?QTZBVnFzMTlHaC9KYk82elBBUStkTHZpNFNWL0FVUE1mMm1ERFpMTlh5WGh4?=
 =?utf-8?B?NDNXYmYvYVEzd3lWdHJKNFA1ZUEzMEFpMWJpb08zS0xlTDBjaVFlZHNwRlVM?=
 =?utf-8?B?UmpTckFNL3RUR3VGb3ZCOWk1VjFsaDlwUDBQdEp3SDNhVUx6dHVXdHMySjA4?=
 =?utf-8?B?ZHhzaTdicDJ4WnM2Ly9tOG5FT3ZZZnQrTzNvRnpieW9RTExBbmVxVWRiOHc1?=
 =?utf-8?B?TXBOZVhyOHhhekJ3M0RXYlVuSEh4bGh1UlhqQWp6dlVWUVl5eXRpcnFrbGRj?=
 =?utf-8?B?Rnd6SndZMUowZDZ6d3E4c2ppaWJvWk8yaXU4VEo0YkQ1TytReTF4M2FGZElt?=
 =?utf-8?B?c3BSQ3B1L24vWG9VbXFzQy9uSmtwMjUzYzlZWmRnam9ZdUtNZEJGVHdWWFlL?=
 =?utf-8?B?TnVKd2RKRGNPK1Y3WVJMNURpbDVFaGhrK1lERjhlK3h2dW5PdG1OcGtmWW1k?=
 =?utf-8?B?c1N4UTN0c0ZFRUwzcE94SzdvRTQ4N2QyV251ZTVsenErYm1XMC9WWCtiek5N?=
 =?utf-8?B?Y1doTDFtTWh3bno5Um41OUVwRHNaUnlaeXZHS2Q1VW5HTUszNDl0azNlU1dB?=
 =?utf-8?B?Q2tJZFlEZVNac3JRUlBNWndMRGZXUGZFVDRIcmhqNWxzZ1BuWkZvdFNma2J3?=
 =?utf-8?B?V2QrSW8rSStydTlody9hM1Fxd2V1YmpiZG1aY2FhQm1OZ0U0NldnUWl5VlMy?=
 =?utf-8?B?MFlCcEJqNTRxRUgyZWZpNVMwcmx5bHRNcTk1QWZtOGsxUDcwZXRxdVVBUkZX?=
 =?utf-8?B?RGREU0pXQkNhbnBrb0orZzI0aVBMNmlKYm5XZXcxQVF1eDBOcC9vV0sweTVi?=
 =?utf-8?B?YmpxRHU4bWsvY0VVMzZsQ3ZVc0NIWlY5QjRpaTVoRjZha2FqUjNLbXB3Smlu?=
 =?utf-8?B?Z1BuRGkydjF0eG1IeWN3MS8xWGxLcGhFS3VDUC82ZHRMY1hHRTRERW1aRHMz?=
 =?utf-8?B?S0c5UXRSSFRZSDAzY1pZc3ZBenJXYUU5TUNZRXpUZDZPbjBTOTJsdEVzaXF1?=
 =?utf-8?B?bzZvckpKRXBqazV3R3JoM2FGZ1c3YWpkR2dSdEhXZG4rVng3KzZlVjBsUUZ1?=
 =?utf-8?B?KzVuOXNUUG55RllMRzFablByZE1EU2xZWWtuNkJvVUd3OU9QYXlSRnJXTlhK?=
 =?utf-8?B?YXQ3bXUwUEgvbTBrbjQ1UHdWTjd1MkUxSVFwdGMvZ09zZDNMNkFtQmRPNEd1?=
 =?utf-8?B?SkVJeVpxSllkd2praTlEK2JOc1FnMlVkUm1LN2RkVkltVFQ1WnV3NE1rMHpR?=
 =?utf-8?B?QVNoMVVhcC9nQkdBOHcvQmN6a1pFRjI2OWdUWFZOK0xxdjNnSG01TUhTZ3Vs?=
 =?utf-8?B?cWJiNVZJWmY1Wkh5bE1hMC9JaGM0ZnI5U0FKaEtIcnM1dDVCUVN2RGhZNFNp?=
 =?utf-8?B?b3c9PQ==?=
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
	39OhEaTxUWB4/DdBr0DAHKnKdHFkGLcqarRhiMtWAxiAX0uFlRRRS1NvWoKGdNjruDumDwVFBrEuBkkQbDoAZfrU9yf12BOv8xsiKgxk48DhvAbd3/uQw5bSKzz/xkl0OohwL6B4O88Sd/3SssPD0XhiRz1bGCsAcyKL5NxjUVSeUOJLJO0OcFczaSCPOj+BenlAjw7aS5URw/tnjWsNsDLICshBYb1CjF0iJyotXwNe7NDKWhJ9rQRRp/pNBp0XlCzmI3jAyOwTNlL9Xa6ocH7q+5twKuFHkvlH8chqrC7Mr5RgGWp8H0rgmbxNGM3uYuL7OHEZpJZjFZTaak89C7qqR0mhXikw+3aJTJH/D1ktV1E86vT1Cz35SiwQ0e7Qv5zIOLOYju8zWsn91UPcXHEvvX0la51Y/PWMnfJ8/ZNIbGw5eugzFwqXg1aH0XTsGsoDW6cRHjEfdmDOj/Rm93ei76aQ94oh3xn5bk2Gf9NasTvRzIqRvEi4+zeci0cl2zeILHvNCH3U7d/s/8eFXkoOXdcc2tgTkou5M01bZftgs1vtclSVTAjZamdwYVbSppI7t89eeX22L0+vYuJsIsVvOZOMQIdUy+q3JNPGxtj6nBKPKyuGhj17gFGUlRfMaHWcz2UPEGv6GTDyAFVwFDu6zf7PVaYbRmDoOp0IgAcpMKjssm1Cpwu4RJS3jKG6zwQS7POc4HwCyvFI52DM/PlqoZ1e5F86DoiBVTKMmWUPfiINgWTxKvS4bFau7PAtZPm6hI0kmbf+X9er1PjLS7zQDLTXqXT5VISRQYSIllMi1a98Kz+c+q4XVFEnUXj4
X-OriginatorOrg: landisgyr.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR01MB9217.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7509bc52-9c1e-49bf-032b-08dbae2dd712
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2023 16:33:30.8015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ee2cd48b-958f-4be4-9852-b8f104c001b9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wsrYQzMRPZ2YdH9g7P4795lUbMdcAZp33XCranFXs34i4iAERM0KfM0rlM9tHdsHxBPC53LgcojcwYb+1uMF7jWvR0rUvfe4DlEnH01Q+Vc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR01MB10394
X-Proofpoint-GUID: 9PwWoLBfro9J9UkZcm5Rfb8abtaOVKxa
X-Proofpoint-ORIG-GUID: 9PwWoLBfro9J9UkZcm5Rfb8abtaOVKxa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_10,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 mlxlogscore=959 adultscore=0 mlxscore=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2309050145

SGkgRGVuaXMgYW5kIEphbWVzIGFuZCBhbGwsDQoNClNvcnJ5IGlmIGZvcm1hdHRpbmcgaXMgbWVz
c2VkIHVwLiAgT3V0bG9vayBhcHBhcmVudGx5IGRvZXNuJ3QgZG8gcGxhaW4gdGV4dCBlbWFpbHMg
dmVyeSB3ZWxsIGFueW1vcmUuLi4NCg0KPg0KPj4+IFRoZSBBUCBjYW4gYWR2ZXJ0aXNlIGJvdGgg
RlQrODAyMXggYW5kIDgwMjF4LiAgU1RBIGNhbiBwcmVhdXRoZW50aWNhdGUgdG8gc3VjaA0KPj4+
IGFuIEFQLiAgSXQgY2FuIHRoZW4gY29ubmVjdCB0byB0aGlzIEFQIHVzaW5nIFBNS1NBIGNhY2hp
bmcsIHBvdGVudGlhbGx5DQo+Pj4gc2VsZWN0aW5nIEZUKzgwMjFYIGFzIHRoZSBBS00gZm9yIHRo
ZSBpbml0aWFsIGFzc29jaWF0aW9uLiBUYWJsZSA5LTE1MSBldmVuDQo+Pj4gaGludHMgYXQgdGhp
czogIjAgKG9wZW4pIGZvciBGVCBJbml0aWFsIE1vYmlsaXR5IERvbWFpbiBBc3NvY2lhdGlvbiBv
dmVyIElFRUUNCj4+PiBTdGQgODAyLjFYIG9yIFBNS1NBIGNhY2hpbmciLg0KPj4NCj4+IFllcyBJ
IHN1cHBvc2UgdGhlbiBwcmVhdXRoICsgRlQgaXMgYnJva2VuLCBvciBhdCBsZWFzdCBpbmNvbXBh
dGlibGUgZGVwZW5kaW5nIG9uDQo+PiBob3N0YXBkIHZlcnNpb24uLi4gYnV0IGZpeGluZyB0aGlz
IGlzIHNvbWV3aGF0IGltcG9zc2libGUgcmlnaHQ/IFdlIGRvbid0IHJlYWxseQ0KPj4gaGF2ZSB0
aGUgb3Bwb3J0dW5pdHkgdG8gdHJ5IGJvdGggZGVyaXZhdGlvbnMgc2luY2Ugd2UgZG9uJ3Qga25v
dyB3aGF0IHRoZSBBUA0KPj4gdXNlZCAodW5saWtlIGVhcG9sIHdoZXJlIHdlIGhhdmUgdGhlIFBN
S0lEIEtERSB0byByZWZlcmVuY2UpLg0KPg0KPlRoZSBzcGVjIGlzIHNvbWV3aGF0IGNvbnRyYWRp
Y3RvcnksIGJ1dCBJIHRoaW5rIFByZWF1dGhlbnRpY2F0aW9uIHNob3VsZCBzdGlsbA0KPndvcmsg
aW4gdGhpcyBjYXNlLiAgV2Ugc2hvdWxkIG5vdCBiZSByZS1jb21wdXRpbmcgdGhlIFBNS0lEIHdo
ZW4gd2UgYXR0ZW1wdA0KPnByZWF1dGhlbnRpY2F0aW9uLCB1bmxlc3MgdGhlIFBNS0lEIGlzIG5v
dCByZWNvZ25pemVkIGJ5IHRoZSBBUC4gIEJ1dCB0aGlzIGNhbg0KPmhhcHBlbiByZWdhcmRsZXNz
Lg0KPg0KDQpXZSB3ZXJlIGdvaW5nIHdpZmkgY2VydGlmaWNhdGlvbiBmb3IgYSBwcm9kdWN0IGFu
ZCB1c2luZyBJV0QgMi40IGFuZCBoYWQgYSBmYWlsdXJlIHRoYXQgbG9va2VkIGxpa2UgaXQgbWln
aHQgYmUgcmVsYXRlZCB0byB0aGlzLiAgKFNBRS01LjIuMSAtIFNBRS01LjIuMyB0ZXN0cykuICBJ
dCB3YXMgcmVsYXRlZCB0byByZWFzc29jYXRpb24gYW5kIHRoZSAiU1RBVVQgdHJhbnNtaXRzIGFu
IEF1dGhlbnRpY2F0aW9uIGZyYW1lIHdpdGggdGhlIEF1dGhlbnRpY2F0aW9uIEFsZ29yaXRobSBO
dW1iZXIgZmllbGQgc2V0IHRvIDAiIGFuZCBvdXIgZGV2aWNlIHJldHVybmluZyBhIDIgKGZvciBT
QUUpIGluc3RlYWQgb2YgYSAwLiAgSXQgbG9va3MgbGlrZSB3aXRoIHRoaXMgcGF0Y2ggaXQgbWln
aHQgYmUgcmVzb2x2ZWQ/ICBJJ20gZ29pbmcgdG8gdXBkYXRlIG91ciBJV0QgdG8gMi44IGFuZCBo
YXZlIHRoZW0gcmV0ZXN0LiAgSSBjYW4gcHJvdmlkZSBtb3JlIGRldGFpbHMgb3ZlciBETSBpZiBh
bnlvbmUgd2FzIGludGVyZXN0ZWQsIEkga25vdyB0aGUgd2lmaSBhbGxpYW5jZSBpcyBwcmV0dHkg
cHJvdGVjdGl2ZSBvdmVyIHRoZWlyIHRlc3QgcGxhbnMgc28gSSBkaWRuJ3Qgd2FudCB0byBkcm9w
IGFsbCB0aGUgaW5mb3JtYXRpb24gdG8gYSBwdWJsaWMgbWFpbGluZyBsaXN0Lg0KDQpCcnljZQ0K
DQpQIFBMRUFTRSBDT05TSURFUiBPVVIgRU5WSVJPTk1FTlQgQkVGT1JFIFBSSU5USU5HIFRISVMg
RU1BSUwuDQoNClRoaXMgZS1tYWlsIChpbmNsdWRpbmcgYW55IGF0dGFjaG1lbnRzKSBpcyBjb25m
aWRlbnRpYWwgYW5kIG1heSBiZSBsZWdhbGx5IHByaXZpbGVnZWQuIElmIHlvdSBhcmUgbm90IGFu
IGludGVuZGVkIHJlY2lwaWVudCBvciBhbiBhdXRob3JpemVkIHJlcHJlc2VudGF0aXZlIG9mIGFu
IGludGVuZGVkIHJlY2lwaWVudCwgeW91IGFyZSBwcm9oaWJpdGVkIGZyb20gdXNpbmcsIGNvcHlp
bmcgb3IgZGlzdHJpYnV0aW5nIHRoZSBpbmZvcm1hdGlvbiBpbiB0aGlzIGUtbWFpbCBvciBpdHMg
YXR0YWNobWVudHMuIElmIHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMgZS1tYWlsIGluIGVycm9yLCBw
bGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYnkgcmV0dXJuIGUtbWFpbCBhbmQg
ZGVsZXRlIGFsbCBjb3BpZXMgb2YgdGhpcyBtZXNzYWdlIGFuZCBhbnkgYXR0YWNobWVudHMuIFRo
YW5rIHlvdS4NCg==
