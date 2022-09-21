Received: from mx08-00440002.pphosted.com (mx08-00440002.pphosted.com [185.183.31.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEE68462
	for <iwd@lists.linux.dev>; Wed, 21 Sep 2022 21:09:06 +0000 (UTC)
Received: from pps.filterd (m0267192.ppops.net [127.0.0.1])
	by mx08-00440002.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28LL2Y82004348;
	Wed, 21 Sep 2022 17:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landisgyr.com; h=from : to :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pselector2;
 bh=rp98OyriXkHZCl6o5QlM1N2egvUPgrsNPyGxcrURl+4=;
 b=TI8Th+Aa3gcp/0naovvgU8GdCR5GKVviiLk1uAV73TVs+9XWfttTzaOcyCn8xWCDVWH+
 T0GdIRxbMtbVmkFBEKYdx1ZtB0Ik+ZEtIeg+ndjmHovcw0Na4lSbrP6j+sSUfwfyqUoC
 n4YW403weUbwkG5ZKkUr46PJV9qac7k5q4PUGj2r2L4OagQWh+1jrVABtaogiOyJOp0s
 rU55DilwTpqaFIf0WGuWCzqIAIdHVkJbGdW9xVtnAkKrG3C1X3eOEVB13gnabwES0mM/
 9XLrDfFN3cbypeA3TnB9HdvRlw/FSkT3jgg4gzfR7OEIeOq4ExaKqtFShZ+qqOHW4ENl xw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landisgyr.com; h=from : to :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pselector1;
 bh=rp98OyriXkHZCl6o5QlM1N2egvUPgrsNPyGxcrURl+4=;
 b=oL6OUrEX0l+flZaNnPP5Eoxa5A7PZG8mB3srMA1wOsn/7x+IVbKx7R/nieeP8S2VVX8r
 97hGgm8D4aa0uTxDgRjGXFnhWjvQ5pXvy1sRIn0b2Ssz+hM3kJ32MIqz9hHszLTXXAt0
 Z4PrOKdM79rvw3M4EZYcSJv61lx2ZtSXpFOsdyOvsd/zW8u+nxaL8k8soppBI7NfJUiQ
 j7n5p+M4l58BezrRjY5O5Crull4BypHMoEkXD5tZoiRp6YmyBo9epQimoG52iOzerYJR
 4ZLXLSVrfQkeDcyYn6WBPrEHQMtDgLHF9eyiWWavXSPv+JExmPXVCS8nxWD3kOY62vzT FQ== 
Received: from eur02-he1-obe.outbound.protection.outlook.com (mail-he1eur02lp2055.outbound.protection.outlook.com [104.47.5.55])
	by mx08-00440002.pphosted.com (PPS) with ESMTPS id 3jn7v4vb24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Sep 2022 17:09:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZ43AAjXvD8OPs/bKD+Fen3pR4AOle8o1SDsi2us5IZGi63vaGkm6XeF5w4CgHjAzRHUW5QHYKrPMlcMePZxujvB1itZ4EAuovy71udEO/0yh0Q6xbsu7/++0/pLCIIkBeCoXTh2rOUgJwl1K/DV6SMAZC+D4aYwVXD3Sc+iCLJLmYEu1HBWWlkmNbbwz5fikm+H2tEfWfYquAQjOnAfC19sr6hRY7xaii6ZuM6R7lBQSWXEavoILU4BWosZ0tEhot/KRDVvncY5vUhLVw6Qy1kckPpWuKios9ADZQ7hV0x3aiXRBWXgQjvB1L2h0Lcm6ZXSlvW3g/W1sPtmhjBxaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rp98OyriXkHZCl6o5QlM1N2egvUPgrsNPyGxcrURl+4=;
 b=HTKxMyx0KKFd84swzvnmGL3kJ3b5nGfcvV1yV7mqISg2u7vtmzEBLZJ2F8tom2YNcYGn24rQuuZEWGCY1xkFmeilTYd0zATtSguwHntueMA70JoLiVwi4SLauQF1rt3PJnye79YjPZBzuIdLJf4UZMHCuCTbmzJcj/hT/MaKGwO9DB5u1XXi+xMovWu824f0ERweJhnCiB+hUYO3AJw16wgExb9Q3zhSLn4cwTekcz2AHvjHbHUgrR815byu/I8LzJK/7J0sT6xUd0rPGytnctcNk7Yxr1kY30o4XDbeUFbPQoaLzkJrsQ7G1YmAfj+whU8AViq0/+VVtIxRIMnBIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=landisgyr.com; dmarc=pass action=none
 header.from=landisgyr.com; dkim=pass header.d=landisgyr.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landisgyr.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rp98OyriXkHZCl6o5QlM1N2egvUPgrsNPyGxcrURl+4=;
 b=gTHd0lwGWKfh21Rm0iCkqLZADLxCxk8B/26wuqgYc4MzwIt7iNm7YHCCoSheeIC25yIAbrl5vZ/jS9j7bOTqXrGxb1jAzUxWZHXuXPxwZsg1yttAFRB+hmIfMTjhh1mtmGG72VwFSdewygRC7XYFxm4twXR8C95RUvdlbK0b3Ls=
Received: from AS8PR01MB7493.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:25b::13) by AS8PR01MB7320.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:238::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Wed, 21 Sep
 2022 21:09:00 +0000
Received: from AS8PR01MB7493.eurprd01.prod.exchangelabs.com
 ([fe80::abcb:ec37:67ed:db1f]) by AS8PR01MB7493.eurprd01.prod.exchangelabs.com
 ([fe80::abcb:ec37:67ed:db1f%2]) with mapi id 15.20.5654.016; Wed, 21 Sep 2022
 21:09:00 +0000
From: "Johnson, Bryce" <Bryce.Johnson@landisgyr.com>
To: James Prestwood <prestwoj@gmail.com>,
        "iwd@lists.linux.dev"
	<iwd@lists.linux.dev>
Subject: RE: wiphy_estimate_data_rate() failed
Thread-Topic: wiphy_estimate_data_rate() failed
Thread-Index: AdjN8lRkJil+fRmsST+H/QVnE9hZ/QACHmqAAAAYg7A=
Date: Wed, 21 Sep 2022 21:08:59 +0000
Message-ID: 
 <AS8PR01MB7493CF66E73AFAC6F6DCA636F44F9@AS8PR01MB7493.eurprd01.prod.exchangelabs.com>
References: 
 <AS8PR01MB74931FD1507D2D70FDFB5F05F44F9@AS8PR01MB7493.eurprd01.prod.exchangelabs.com>
 <77f95956dde70bfa43376b9e36430f5a14c71ee4.camel@gmail.com>
In-Reply-To: <77f95956dde70bfa43376b9e36430f5a14c71ee4.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_ActionId=573a9945-afca-4610-9516-f23610a37175;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_ContentBits=0;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_Enabled=true;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_Method=Standard;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_Name=724d29b2-602f-4b77-ba15-b7b42511c7c5;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_SetDate=2022-09-21T20:46:13Z;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_SiteId=ee2cd48b-958f-4be4-9852-b8f104c001b9;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR01MB7493:EE_|AS8PR01MB7320:EE_
x-ms-office365-filtering-correlation-id: 1715e096-b277-4049-91e0-08da9c15810d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 vgfpz/XtZl+ZUPgAiwNAx+QqhVrmv/yEUHFO4txjGVq1/6+a+RR24Oh21N6F0ZZf/5VWyjMwHz7Wz2XM7E0rQtLQFZid+5g0+WBPSk/9aiJGbIqI0ak3boSSWBGX9FyfA9zerh7N4Ldf4mihHJOTsuX6BHBuLsMShV5DYjQpXHzYt5hP7yTXBej0686zNRUX1tMhTdx0G1dh/+wxyDRNY4lriIfvogfBAAwU4T/8KoKTdch8yR9ZZzvY6EtBlijCBQ+FppFn2IO+/TP1O6+bUcBZSVupjaEFHq3bU/RGXs0tPe5k2T73IboZ7zxgLP/it9wfEEGF0bZLQeJQs0ldPcY7ocVsoj/Hjv8aWbS2SvewErrU/jkZHFpb1jp2qYNbNaGzATYr2v7Zic41RD7PAE5v2CY/Gfx06JJ8p5QcUlKRo5IaEAXMdsgolFTQjt0hjk/7M7JmUH2elN8KT14DEK7kgVXaaKffGkPHUmxEpHRmqEgNqov12ddVyX+2PLdBeNlpB8toSdqzyEuRBvdhjAqOYQsZSx0hhAAp0zb6/qqtiZBDOFSxfVx5Z00H9Ppj8ZX53gzimvp3md7lhjjojl5Jll9Q9VvnyP7tEqdWb1rXUt8BXhW/fv44jfCwC8ak6d/LOyvWK+Dx3NN6Ja2tldDJy2HsuskYNhqzBDY34pfAO3k635MGe3HB9bU2rEfD8GfSh9tlF4Lwh3zkAwiI54UlQycpPvV29GvUynhFHQ48njJ546rUVsgsqC2E0DemSRWdSn8DlGFOfA1Iaf4Ypg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR01MB7493.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199015)(8936002)(55016003)(6506007)(86362001)(7696005)(41300700001)(38070700005)(5660300002)(52536014)(66946007)(110136005)(33656002)(71200400001)(8676002)(64756008)(66446008)(66476007)(66556008)(76116006)(478600001)(316002)(2906002)(83380400001)(186003)(38100700002)(9686003)(26005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RGxxTXZlOVBKZUlPU25uTmo3cHVMYTU1MnZPQURrRTRoYzFTdzVhVW5RTEZz?=
 =?utf-8?B?S1VLV2QrdzFtN05RYmRXTUwxUHdxSHRzdjFVODc0UXdzajYxejkvcm82blVz?=
 =?utf-8?B?RjFRK3dZRUVzYzlSR0U5M3Rwa3g5bmVFWmlkejgzUXJBQUxyd2MvY0NXajg0?=
 =?utf-8?B?cGlEamZPaUsrckQ2UVN3UVBKajFROUpFRElTWnJPbGxWMWFZdGhVUnlxZmlX?=
 =?utf-8?B?UEt5SVFxWFVYTk95Y0JWcytHZlprSXFHOVNTNWp2bUhDbXp5U0pHN2pwMFRX?=
 =?utf-8?B?WXhVV0dna20yRFpubmEvRVZ2UXF4aEtBTGpxUDFuc0F5cEVxcWlzMlNSTU04?=
 =?utf-8?B?TjlBTDBoYVcvb3RjaUlNMGRIaWhGWElKR0pSN3FsenpWcGg0cmIzcTVXdElZ?=
 =?utf-8?B?dFExV0lGUzZxeUoyUURzNHpHOHptZGFRNXpPbkRSRU4yMVNyQnVLUDZTZVhY?=
 =?utf-8?B?UU9vV1Y5TWtlUkp5U3V6bmJRWlo3NWwvVm1wME84R3JUOHpEZThrMDBFVWJr?=
 =?utf-8?B?UkcwYjlkbHpKL0preVU0S1ExQjllWTdWaUNRYzdDSDBoTGhuYVF2SnRVdVVv?=
 =?utf-8?B?WFdBVU5YclpMMU4wTkR1QkUvOWdWU205YzVKeWFQQTQ4eVl0U25qVjQ2NUJG?=
 =?utf-8?B?dkNKZ1NTZW42UWtkM3ZCMmNPQmFUSlB3dDcxL2dmeHR1Y1R6bG9VYmdTMVRy?=
 =?utf-8?B?NHZYYmh0Y3lLZlpvNVZKYWZGQnBiM05nK0EvRTNpNUR4clh2amZ3Y202Y0Zz?=
 =?utf-8?B?V1UwZjhyYmVqamdPek50NU1QbkRmV1k4NzNFalA4NkRMRXh2UVJWam5GV2NF?=
 =?utf-8?B?R0d0VTNzNHUyWkNjMEd6YU9pRjFvV2czSFIrU3NjS1QySkVzNmFnbTNMYnNL?=
 =?utf-8?B?MDd6RVdZUDYwQVhmSkpCRHZKWG9yZ1h0cUErOXRwZTBXU0ZNMjVwZ05kLzZw?=
 =?utf-8?B?bWZUZTdTNURSTDA2V0ZPZHBrZGlQaExvV2VyQjJBZkQ2MFpYVmlhY1VQUnJq?=
 =?utf-8?B?UTUwWDlxSU9ncFNQMkVhUlZYVXFieFZWVjhHREZNbnI1dTNWY1gvMm5OZXNz?=
 =?utf-8?B?VW5TZ3owZFFHVXFTcTRNckE5c1NiZWUrK1hJWThNMnRUWi9oWlZ1blRKTGdy?=
 =?utf-8?B?dElsMkFISExqRzNnc21IdDJDdFQ0TTlNVHBBaTFBU2k5SmlTQTNtRTloRTF6?=
 =?utf-8?B?b002UWJ1R2tCallxOWJWaTNQdnBZQ1ppUVptSDZQSng4Z1d3NmZWZjNxSDMw?=
 =?utf-8?B?U3BMYldKdU1SRVducElraWptUTh5NEhKK1pTeG1Oc2l5ZFp5eTI2RVBzSlFC?=
 =?utf-8?B?TkNGL3BvSVB4TTFyNHNOY1gvbS81aGpZZmVSbDN3ZzQ1VEJBNHc4cG1rdUgy?=
 =?utf-8?B?SDlLTTVHWngrNGhvYkkwSE85eXNzeTNVUVNYVWs0a3AxVXVKcW02aWVhU05n?=
 =?utf-8?B?azl5ck1tdS93TVpBTHJtQnhVanl0NDc5ZXZTa3g1cXY4b0kwaHlsTnYyejc1?=
 =?utf-8?B?Y1ZUZ3loM3AvYmpMaE44Mi9udnRZNG5IbmZ1ektYYVVyRWkyc0hBTUl0b0VK?=
 =?utf-8?B?UVJTb1hvTnRuZGgvb1YwK3Zsd2gyVFVoRWhKWS9NUEgzRGUzajVtQStVSFhr?=
 =?utf-8?B?c0ZaZzhFc0NjOHkvelZnNmprcFFHYXJ4TlBSU0J5OGNBQWVPOFAxZXlIcWlo?=
 =?utf-8?B?WHdwRUVRSjBSRFpPS3hNTW40VU1MZGswc1plNzRnaWdrd0tkaGIrM3djNXdk?=
 =?utf-8?B?ZElZSi91cStMTmt6Sk1OdlBoWk5kZkN4R21HVWM0cGMybXEwTGFKUjkyUS9I?=
 =?utf-8?B?c2hYZ1FNc1d0WFYvWFYzemVOTzBSSlppZ3IzNVQ1NWpPOTJSVjRIeFQ2N0JW?=
 =?utf-8?B?QWk0ZnVoWDFBbitTMWpmN09abGhmUkU2QWlCZ0xTM1NZYWU1NHEwcUNGQzlW?=
 =?utf-8?B?VGRNbjdJNDhrbkFSOUVtOEpFODNMK3NoUDZkZWU0M2tuc1U4ejlsZFhub29r?=
 =?utf-8?B?ZDE4Z3JoSUI1RFVXdkNLT1lhd1o3Yi9STjRtSUk1V1F3MjNBUjJJOUswenVl?=
 =?utf-8?B?RjFiNEFDYUhCZmNueHgvYXlXZVVmODJpcmovNlJObVU4dU1WNVF4VmRKSUVp?=
 =?utf-8?B?N1hkM1NvdzI4cFUrN1ZiMUpaS2RaeXIwVm1hU3BTdkVrS3RwYy9ZK3A1UTI0?=
 =?utf-8?B?cWc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1715e096-b277-4049-91e0-08da9c15810d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 21:08:59.9587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ee2cd48b-958f-4be4-9852-b8f104c001b9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: osPom/QE2zqxX6AQziln57oTsDK0qSlD7dlsi9XMYZrUzmCr1oxRZsklsOr5/LAkfPwH/SAKFD4WbVAqyHOCB5XB2IvJmvZnBus75lASqnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR01MB7320
X-Proofpoint-GUID: uzOVJqzJyssbJp9QYNDUOq9YaQmYJzjq
X-Proofpoint-ORIG-GUID: uzOVJqzJyssbJp9QYNDUOq9YaQmYJzjq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-21_11,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209210142

DQo+DQo+IFRoaXMgaXNuJ3QgYSBmYXRhbCBlcnJvciwganVzdCBhIHdhcm5pbmcuIEl0IG1lYW5z
IElXRCBjb3VsZG4ndCBwYXJzZQ0KPiBlaXRoZXIgSEUvVkhUL0hUIG9yIGJhc2ljIHJhdGVzIGZy
b20gdGhlIHNjYW4gcmVzdWx0cy4gVGhpcyBqdXN0IG1lYW5zDQo+IHRoYXQgQlNTIGdldHMgYSB2
ZXJ5IGxvdyByYW5rLg0KPg0KDQpUaGFua3MgZm9yIHRoZSBpbmZvLCB0aGF0IG1ha2VzIHNlbnNl
Lg0KDQo+ID4NCj4gPiBJIHN0b3BwZWQgbXkgc2NhbiBzY3JpcHQgYW5kIG1hbnVhbGx5IGNhbGxl
ZCBgaXdjdGwgc3RhdGlvbiB3bGFuMA0KPiA+IHNjYW5gIGFuZCB3YXMgYWJsZSB0byBjYXVzZSB0
aGUgZXJyb3IuICAgIEkgZGlkIGFsc28gZ2V0IGEgZGVhdXRoDQo+ID4gZXZlbnQgYXJvdW5kIHRo
YXQgdGltZSB3aGVuIEkgd2FzIGxvb2tpbmcgYXQgaXQsIGJ1dCBub3Qgc3VyZSB3aGF0DQo+ID4g
Y2F1c2VkIHRoYXQuDQo+ID4NCj4gPiBSZWNlaXZlZCBEZWF1dGhlbnRpY2F0aW9uIGV2ZW50LCBy
ZWFzb246IDQsIGZyb21fYXA6IGZhbHNlDQo+DQo+IFRoZSBhYm92ZSB3YXJuaW5nIGRlZmluaXRl
bHkgd29uJ3QgY2F1c2UgYSBkaXNjb25uZWN0Lg0KDQpPay4gVGhhdCB3YXJuaW5nIG1heSBoYXZl
IGJlZW4gYSByZWQgaGVycmluZy4NCg0KSSB3YXMgaW52ZXN0aWdhdGluZyBhIHBvdGVudGlhbCBp
c3N1ZSB3aGVyZSBkZXZpY2VzIHdvdWxkIGxvc2Ugd2lmaSBvY2Nhc2lvbmFsbHkgYW5kIG5vdCBy
ZWNvbm5lY3QgKGJ1dCBub3Qgc3VyZSBpZiB0aGUgaXNzdWUgaXMgcmVhbCB5ZXQpLiAgVGhhdCBp
c3N1ZSBtaWdodCBoYXZlIGJlZW4gcmVsYXRlZCB0byBjb25ubWFuK2l3ZCwgc28gSSB3YXMgdHJ5
aW5nIElXRCBvbmx5IG5vdyBzaW5jZSB3ZSByZWFsbHkgZG9uJ3QgbmVlZCB0aGUgY29ubm1hbiBm
dW5jdGlvbmFsaXR5Lg0KDQpUaGFua3MgZm9yIHRoZSBoZWxwIQ0KDQpQIFBMRUFTRSBDT05TSURF
UiBPVVIgRU5WSVJPTk1FTlQgQkVGT1JFIFBSSU5USU5HIFRISVMgRU1BSUwuDQoNClRoaXMgZS1t
YWlsIChpbmNsdWRpbmcgYW55IGF0dGFjaG1lbnRzKSBpcyBjb25maWRlbnRpYWwgYW5kIG1heSBi
ZSBsZWdhbGx5IHByaXZpbGVnZWQuIElmIHlvdSBhcmUgbm90IGFuIGludGVuZGVkIHJlY2lwaWVu
dCBvciBhbiBhdXRob3JpemVkIHJlcHJlc2VudGF0aXZlIG9mIGFuIGludGVuZGVkIHJlY2lwaWVu
dCwgeW91IGFyZSBwcm9oaWJpdGVkIGZyb20gdXNpbmcsIGNvcHlpbmcgb3IgZGlzdHJpYnV0aW5n
IHRoZSBpbmZvcm1hdGlvbiBpbiB0aGlzIGUtbWFpbCBvciBpdHMgYXR0YWNobWVudHMuIElmIHlv
dSBoYXZlIHJlY2VpdmVkIHRoaXMgZS1tYWlsIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBz
ZW5kZXIgaW1tZWRpYXRlbHkgYnkgcmV0dXJuIGUtbWFpbCBhbmQgZGVsZXRlIGFsbCBjb3BpZXMg
b2YgdGhpcyBtZXNzYWdlIGFuZCBhbnkgYXR0YWNobWVudHMuIFRoYW5rIHlvdS4NCg==
