Received: from mx07-00440002.pphosted.com (mx07-00440002.pphosted.com [205.220.184.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26D98C03
	for <iwd@lists.linux.dev>; Thu, 17 Nov 2022 19:37:09 +0000 (UTC)
Received: from pps.filterd (m0267194.ppops.net [127.0.0.1])
	by mx08-00440002.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHJ1Vqs024585;
	Thu, 17 Nov 2022 14:15:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landisgyr.com; h=from : to :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pselector2;
 bh=Jq9n1gd/feRdv78pflVSQGyAlqMFdXp62Ib9/+rFnaI=;
 b=m7LhEFjq2PpwlQVnQvzXj2by9y25jxyhJ9em74V2nxdxpcE0LjLCOEaq0ODcwytzjXYS
 rENQakgj/lNpZA5u1MFWd1jlfBsCitJFlykCeSpVHdWd8H67tn9iDzmhAOD2Yw6PMGuR
 Fbd301GLYdnoPwx0MUShfMeYL+1ZuLa1CBjKndGrNAUxZTXVVBT7j94P+Z10WGw6r+PI
 iHJGS2aq0rVGVWcAcVQBwfPdDmxbkt3TSG2m0hxpyvdnB+cAM4YDaVl6zeWmegm25mR8
 JEaTDDy4Bl7QOW1dp1F2w6DCUf7VS9Pzf8sXCDCqVNhlXTklsoz5T8yAHHV2dbdVghKd AA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landisgyr.com; h=from : to :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pselector1;
 bh=Jq9n1gd/feRdv78pflVSQGyAlqMFdXp62Ib9/+rFnaI=;
 b=gfClpb1Nst0CxhdmHzD7UzW465z0fC33k8hshJObVDmLPk/bXgs2fPAJ8KxvOVMqOioC
 q8E/lD7UVug8Ls7NVYzKNcyUICpA0btbspEt6LBEOxMg0jWRKlLnZFYcLh1lQ7I79Top
 t7NT0wnIeGMdi933JPerDaUz24DSwGoap5YGpKbaxrVU4VKUfLKNcdXx8P3hsuJc8MJE
 jSlqUodg0qYsp5w6isI0YpdI2O9VjqhOO2IMEN+VO4zxZQzpR2UyIo182HdpMLJwyBuT
 xgvI0s64Wbf9vCIojQlQ/4yDQC2OtzPQY3P2aiGlnj/zmLYrz9b9rapDypDREpWXOt1+ /A== 
Received: from eur05-am6-obe.outbound.protection.outlook.com (mail-am6eur05lp2111.outbound.protection.outlook.com [104.47.18.111])
	by mx08-00440002.pphosted.com (PPS) with ESMTPS id 3kwjqqrfhq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Nov 2022 14:15:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbJd7AbuxH322LmU0shry+RHfiXK+kmyx8loVQak/wjSFVFGsAS8YXP6eaYWMdpBEvzOsjf91X2UzRLclh68CC5/ePX9hIVIKsEg4+2x/fkKVlFbP+Q1dA7038+mP5R5gF8sOfzZdxPnDJ0IKcjMyo32tBTZIrcYoUUasn3JjdSyB4v3M/MYyBVvnsY1CgHyIdbPOpZytfjPPW4nxODVZhYP+ehjpHJPSSk3kGGXEfcgO7IxtP7+aLRCc1e426SI4eRDXCpWkRKcUgMtpl8xIjrX4uf420V3Ueg8mWBOq6SbnJVJpeSc27ZachDtmrEYAzvMdxkMgC0rDfkjmnSeRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jq9n1gd/feRdv78pflVSQGyAlqMFdXp62Ib9/+rFnaI=;
 b=c/M8GQp5nCHZdWQkgD94oQZcPfLCfKCH+p59jODj9HHpLkltO0cFcaPCgi/ol2ZX5oqIzTdCXKRjdx020RnN1hET/cHmWn/QPw8YjsYMNXPS+FWAmz2Ky6UBCCTBbDuzQeSLj7Xlolsyc3rFD9Yceuj5MfpLOgxp8qmSbwHwkSqpTf9llhmhBOlp59AubIkdkPKV3yftrW52Q8PbcG97PTyn9EgyMsOpWc3WT0SKo3iCx2S00M+eNAEqCkJhNr0tjvJHun7MXcnVIe01DsLWZrSUkY4XA8hlSKcTFJAHB5/AN64+dRaRPrZTfj3cuh2xUhFPVIqc/e4N31oIYtP3zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=landisgyr.com; dmarc=pass action=none
 header.from=landisgyr.com; dkim=pass header.d=landisgyr.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landisgyr.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jq9n1gd/feRdv78pflVSQGyAlqMFdXp62Ib9/+rFnaI=;
 b=ovXQlDOHl85QMAcZ5MrrEtiLrmT8u0Jtsj+K8sjsmF56uc4SJ6zHacC4/d5MPJeddylUej4RD6oBhPzWuDJzy1hkjGgNXnI9bTueI/6d+zpaWkmxm4oo5mQft7eammVEZ+2awYJIMy35HuJlOXvEKpRofjP9wxMlJRCkPS+4kPQ=
Received: from PAXPR01MB9217.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:2b1::18) by DBAPR01MB7110.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:195::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 19:15:46 +0000
Received: from PAXPR01MB9217.eurprd01.prod.exchangelabs.com
 ([fe80::c053:f873:195a:7aba]) by PAXPR01MB9217.eurprd01.prod.exchangelabs.com
 ([fe80::c053:f873:195a:7aba%3]) with mapi id 15.20.5813.015; Thu, 17 Nov 2022
 19:15:46 +0000
From: "Johnson, Bryce" <Bryce.Johnson@landisgyr.com>
To: Denis Kenzior <denkenz@gmail.com>,
        "iwd@lists.linux.dev"
	<iwd@lists.linux.dev>
Subject: RE: IWD dhcp issue?
Thread-Topic: IWD dhcp issue?
Thread-Index: AdjR5Sdp5fEpeP/YRLClAbci1XoOuwAP5gIAAB01dOAANWJpcAAEK84ACc3qgfA=
Date: Thu, 17 Nov 2022 19:15:46 +0000
Message-ID: 
 <PAXPR01MB92178BE1F2938E74F0D7FA84F4069@PAXPR01MB9217.eurprd01.prod.exchangelabs.com>
References: 
 <PAXPR01MB9217E777D1480543FFEC84B5F4529@PAXPR01MB9217.eurprd01.prod.exchangelabs.com>
 <d741365d-e97e-57a1-2521-40e921edbdbb@gmail.com>
 <PAXPR01MB9217CF309994538C6383C6FDF4559@PAXPR01MB9217.eurprd01.prod.exchangelabs.com>
 <PAXPR01MB921770F406F322FC843535D6F4549@PAXPR01MB9217.eurprd01.prod.exchangelabs.com>
 <6c107e6b-b572-a4bc-899e-ab12745672ab@gmail.com>
In-Reply-To: <6c107e6b-b572-a4bc-899e-ab12745672ab@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_ActionId=4a43901a-da5e-4be1-9302-31e1a27f5dad;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_ContentBits=0;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_Enabled=true;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_Method=Standard;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_Name=724d29b2-602f-4b77-ba15-b7b42511c7c5;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_SetDate=2022-11-17T19:04:50Z;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_SiteId=ee2cd48b-958f-4be4-9852-b8f104c001b9;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR01MB9217:EE_|DBAPR01MB7110:EE_
x-ms-office365-filtering-correlation-id: b7177d3b-f36b-471c-3537-08dac8d02186
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 2G0Nutuy7ahvNo/4IOcBKim5cjzqyg2/LRRqLlWEKuw3k+cY8N+oXQSpda02BzocKmrkiZzJR6FXX/e/XxmdCa3+mNQt0KtWb/+UVSjj5ismM53Ei1Jxt3TaoO7SgHi86S577v/M8xU0vT1aPkDpXSa5ZomdLxVVeAWnOmT7SLkYVw+E/OfMuIRaOLCecZ2huvqd4zzyX51ZBTUyqVxeatn8gkt9JA5Wc4TVHfFJcGwE1FI3Ca2R1IGynnbkNGXCIuBIk2epSHicPlH4E2SShYK/8djLNvux8CelUABZitOisFp8dQMruTlLh2JpC3ur2DY0SnaSNVkXhSP4Epi7SjsiNsUZZjabNNIdwhr/i1yWDijn8Me780t04LJxF0tWzNSrt+mTQLyrxjwMB/4JlVOwZCCeutB356AraRjmHb+o2RNwpCve7L03gRj32i7PRgDBDt1slZk5CsFpSbsBDiefg7cprj/JFGiSm2Qu4UfVxgFNwtXmgblTSNI7Zm4McB8ZghsuSzqbHPb8kRSA4FuGl9RMTENMvuE+fF2XQB+f36KLuxyJINZxrvUwcRwvco6Y+5QgqUUG3aFD8JRneiHoz8rcsoCLkep8MBE2Tj3w0oUhRLjPWdJn5yKncj3yK1/g1rQGbxOCt17aJKQTyFbZsk1K7UaPIzgbXnIHLyWnRuL5UZ1qJjNk7pMA/QA74zk+9uXSMqVXegCdqY+T5A==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR01MB9217.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(39850400004)(136003)(366004)(451199015)(86362001)(9686003)(26005)(6506007)(7696005)(122000001)(38070700005)(38100700002)(55016003)(33656002)(3480700007)(186003)(83380400001)(66446008)(64756008)(66476007)(76116006)(66946007)(66899015)(7116003)(8676002)(66556008)(2906002)(5660300002)(52536014)(8936002)(41300700001)(71200400001)(478600001)(316002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?OVNubTRtTmlLK1hhUUpVME5yS0lITU5PZ1grZ0wvMjM2OGcwNnNydGFUMzg5?=
 =?utf-8?B?YWtTam9EMlZRYWMxQWRZSkliNklzaG5WSFFUazdPMFhRQk9hd1NiQTZqZXRS?=
 =?utf-8?B?REdKbTNsMHZkRllOd3RNWElQZ0JqNDNSVHB0ZXhndDVnZmdZVWpHVWRWc0VL?=
 =?utf-8?B?akNudGszeFk1NC80bVcvNWx3Ylk1cWZPbk1Ic1I4UlFieFZ1U1duTkozV2tZ?=
 =?utf-8?B?cHpiQ3V5emd1Q2pVWXdmRVdmc0dCYytnUUphNEg4cDBpbW1NVGxvSVVSQ3Q1?=
 =?utf-8?B?K3JqK2hDSFNtbjVLRXh6NkVVeEZvQnVVeW5pT0M0QVNNMlpnQU11RDB5M3pY?=
 =?utf-8?B?NjZDVVFhUGNlQ0JPZXQ1V3dEUlVTSXFkL1JXc2t3OXVkcTJQd04zSTFmNmVl?=
 =?utf-8?B?SnlQeGFhQUZDeGtjTTl0Nm9lTVdJK3VIQWNsc0VEREZ2TWZGdnpYdi95eTYx?=
 =?utf-8?B?akdCeVZ4S011dmNwTHl1OXl2OUdNZEtxK2ZuZ0VWWTJabzlSZ0RDV09xWGZh?=
 =?utf-8?B?YUNnNGlJTnIzL0tQZWREM1llWVErZjU4V2JjV0RXb3lDWE9ZWEpmd0UyYzNx?=
 =?utf-8?B?UjVYYWFQaFhneTVmWXFsMnlzN2xFdk1PT1JoeTZaY1YvY0JhVzBSZ0RtTjVB?=
 =?utf-8?B?YXhaUEtyYjNLUms2K1ZGSWFDaHFWMklXUWdUT2x4bFZqb0RHWkNuNkVsTEx5?=
 =?utf-8?B?N2VUbk9HTUNMS3EwQ1ZmWWVpYkVnS05iV2xZNElYdEU0SVd1VUQyZ1hLRXlN?=
 =?utf-8?B?TTRlVEN1ZFFvajNrUFBWWFZuTTF4NVNtU3c5TWt2Z2lTK052NjYzckFMZDFK?=
 =?utf-8?B?QlAzUVhaRVBZam5CQ1UweVNaODdtT0h5WWVjR25idyt2ZjM1TUhkcnRPMTFs?=
 =?utf-8?B?SDhLUkNndnFHcXg3T0xienNQc2YzS21XUEN6U3VNQVRDZUtkZ1pTeGp3enlY?=
 =?utf-8?B?M1VjdjNlRzVhVldmUmsrOFJ0cFF2bmNCaXZZWCtrS1I2QjJYQlo5TFVTNHdz?=
 =?utf-8?B?LzdIemxObjlPWk1XWE5tN1BHNGZMSGdRa1FwV1N4YmFMRVZVRGxnM2pNeVli?=
 =?utf-8?B?ZnpSdzV4em44S1ZiZXZOU05JYnpENG1rZzFhQk1jajJkdURQVkZ1SkRXVk81?=
 =?utf-8?B?SytPWDF3K2RhQzJxSEhuZkhRTXRmK1B6SzBOandrc2UzbGc5U3JtQ0dSZEt6?=
 =?utf-8?B?SDl0T1M1dm9pNytHWEVyNDF6RDFzWVJJWHVDV1JoRUg4aE9YQ1NHaEFXWUow?=
 =?utf-8?B?cXZ2NEpEeFZwcmoxMjV0U2l3Zy95TWQzZTROYTlWS0JmSHZCY3ZvaGkwQ0hV?=
 =?utf-8?B?R2xiQ0pSMzhhWlo3ZFFYczdXSmNjZ0trTU1WcmhIMm1UdkJLbUJkaFpjd3lv?=
 =?utf-8?B?YnFrR0tZN3VZeFpEM1lvc0JVUW1yYmNtVm9DdTY2NmRJMTFnakNFUjR5MklF?=
 =?utf-8?B?RW9ZSXR2di9XdlZmN3NwUVB5eFFYZFhWOVgzZjA1MG9TazV4QjIyVHc2ZWVp?=
 =?utf-8?B?ZS92U3dVUFNhVHJzNmQySDcremN3NWlqTTA1Z1RDcnlNWEx0UFFkTExQQU43?=
 =?utf-8?B?YlZUejdma2oyUkIwRjVPdE5TdllibW5CYmhPWUtYYzNVTnlyUjRpejF3TGxT?=
 =?utf-8?B?a1Q4Y21IT3dkQ1hxOWpUdU5IdmtQRzVqYlNEQ1pwMjE0OVUvNmRJbm1xSW1K?=
 =?utf-8?B?Vi9xVzRCWGkzTi9TVnIxY0FrY0VzL25XMTliNjg2Nms5djcvWS9aREFQSG1h?=
 =?utf-8?B?S1JVZVRqS1lOQ1NmUUdITUxmSnNWMk1EWTR0Y2ZaVUlCeklrcnd5aS9ERUhT?=
 =?utf-8?B?YnpmTmExR3JRZWtDd2QyQU10b2pOU1NYWEoyY3IwemJyUklHbk1sVnJxNzgx?=
 =?utf-8?B?Rm42YTNzUHVLcXVTWEIwblg1SE8yZ0xyaDRGUWtZQ3pmcFlpdW1LaEEvVkts?=
 =?utf-8?B?UWhRdk9FQ2RMRWkvWUNpQW9SdE90WlQ4Rk1oR1V3NFdVS0ZUbTA5STRWcUV5?=
 =?utf-8?B?ZWRmUTIyM2FTZGVjb3JKbnJLWFFGcG9QckltcnR0YitWYW1ONzUvN1lRcjF1?=
 =?utf-8?B?UW9FL2xSTENwcmduZlNzNWNHUW04ek95V3lDSEFkMk5sNkt5WWFPSk00T0x0?=
 =?utf-8?B?K08zNGlvVS9WL1crNTZCRkZoT0hScUlVNFJOZFo2bGdWZTRCT2s0L0JIMUxx?=
 =?utf-8?B?bnc9PQ==?=
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
	wTtXVRu2AVHo9bqQ3mwHJ5L4ZVDML+5cYX3RNQxNg+ez+R1+we7CPcgNakze55MoQO4iF7nL45hhr0GpqxGYFrhILDPxJATDSOvwvdVSqTZ/TYj6r9kzL3C4zKVeJXw4GWFsUxGeJd2kPEtluwbMli7PJrRoMZSQeQrHWizIXdrQg0GjHxi2fM3t0DAkE0snwBHTEZOv7kSYgAuXa9DcywQZ+h/60LfQ5EBgj5PP+IJZWUrIMh6nHQK2gpj35e1IqDXMjqTUh5IZoUMzgDQxum3NMH7uF+4QYZIlMimq4DENg3Lioa2x94QFM0ZatwHGaosx2lmowZ3WKUE7Htfqa6GvmmtoR6IGEidbuJHUI57C/1eUKYKDV+fIV61Q+a09Ecfr2fizSnRqluh0OpOWgdP7l+97z33C1BnfY6XES7zHnZDEyhynrxoq13Ti+9N8tyfT8YmSeJEllVcXfmILvzT8HFYf8Mtgvd4CB8T7UQMaX3wa66EdMryKQrPKjRtNPuA5SXlggHSwHHDdBLERSn+oQkMnbBaS44VAKXmhfQNFyTSN1xCJ9P85KTQrpcMZJpZm2CZhXgPPUQ0itkhQKfxt6LT5NOfSIhpcPSoLat1CSFvGTsiEd1mOobDvwyihP8kmMbhM97vJy1QpQPsGqHtyPqqgQ7D8F5TkzyorL4MlKBaP8fiOmfAyRv5sVxVejGNTLiEiy+kitFpVFJqRetZhjFplYxiGoJbbXRlcHuBbeXS2ze814PSatHIixzcuxuY5g8PROCoLBLIi+IhrdLDxCXa8GAwFBUJAdoxnL2SRvnFseEuVVDBgoScIHcPXVV3Zn2DHSWxam678HikEqw==
X-OriginatorOrg: landisgyr.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR01MB9217.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7177d3b-f36b-471c-3537-08dac8d02186
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 19:15:46.6917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ee2cd48b-958f-4be4-9852-b8f104c001b9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YyL28sVc3mjqciYh8JhxhVxgHX7YkQjdGOFLa8YZo+xw8DWeYUiQqmGpXJwZ4ADUX7xZ3HDOY3NXRyepfbwbHaMKJkzOqf6ysxgOeC4SfYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR01MB7110
X-Proofpoint-GUID: OspjBSrnlFUEv_1XJMqVtV-z5LaTXbij
X-Proofpoint-ORIG-GUID: OspjBSrnlFUEv_1XJMqVtV-z5LaTXbij
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211170139

SGkgRGVuaXMsDQoNCj4NCj5OaWNlLiAgVGhhbmtzIGZvciB0ZXN0aW5nLCBJJ3ZlIGFwcGxpZWQg
dGhpcyBwYXRjaCB1cHN0cmVhbSBub3cuICBTdGlsbCBub3Qgc3VyZQ0KPndoeSBtdWx0aXBsZSBv
ZmZlcnMgYXJlIGJlaW5nIGdlbmVyYXRlZCBieSB0aGUgREhDUCBzZXJ2ZXIuDQo+DQoNCkkgdGhp
bmsgd2UndmUgZmlndXJlZCBvbmUgb2YgdGhlIHJlYXNvbnMgd2Ugd2VyZSBydW5uaW5nIGludG8g
dGhpcy4gIFdlIGhhZCBib3RoIElXRCB3aXRoIEVuYWJsZU5ldHdvcmtDb25maWd1cmF0aW9uIGFu
ZCBDb25ubWFuIHJ1bm5pbmcgKHdpdGggSVdEIGJhY2tlbmQpLiAgRm9yIHNvbWUgcmVhc29uIEkg
dGhvdWdodCBpZiBFbmFibGVOZXR3b3JrQ29uZmlndXJhdGlvbiB3YXMgc2V0IGluIElXRCB0aGVu
IGl0IHdvdWxkbid0IHVzZSBjb25ubWFuIERIQ1AsIGJ1dCBpdCBhcHBlYXJzIHRoYXQgY29ubm1h
biB3YXMgdHJ5aW5nIHRvIHNlbmQgb3V0IGl0cyBvd24gc2VwYXJhdGUgREhDUCBtZXNzYWdlcy4g
IFNvIGJvdGggSVdEIGFuZCBjb25ubWFuIHdlcmUgYm90aCBzb21ldGltZXMgc2VuZGluZyBvdXQg
REhDUCByZXF1ZXN0cyBhbmQgcmVjZWl2aW5nIG11bHRpcGxlIGJhY2suICBTbyBpdCB3YXMgYSBt
aXN0YWtlIG9uIG15IHBhcnQsIGJ1dCBhdCBsZWFzdCBJV0QgY2FuIGRlYWwgd2l0aCBpdCwgYWx0
aG91Z2ggb2NjYXNpb25hbGx5IHdlIGNhbiBnZXQgbXVsdGlwbGUgSVAgYWRkcmVzc2VzIHNldC4g
IEknbGwgcHJvYmFibHkgZGlzYWJsZSBFbmFibGVOZXR3b3JrQ29uZmlndXJhdGlvbiBsZXQgY29u
bm1hbiBkbyB0aGUgREhDUCBmb3Igbm93Lg0KDQpUaGFua3MNCkJyeWNlDQoNClAgUExFQVNFIENP
TlNJREVSIE9VUiBFTlZJUk9OTUVOVCBCRUZPUkUgUFJJTlRJTkcgVEhJUyBFTUFJTC4NCg0KVGhp
cyBlLW1haWwgKGluY2x1ZGluZyBhbnkgYXR0YWNobWVudHMpIGlzIGNvbmZpZGVudGlhbCBhbmQg
bWF5IGJlIGxlZ2FsbHkgcHJpdmlsZWdlZC4gSWYgeW91IGFyZSBub3QgYW4gaW50ZW5kZWQgcmVj
aXBpZW50IG9yIGFuIGF1dGhvcml6ZWQgcmVwcmVzZW50YXRpdmUgb2YgYW4gaW50ZW5kZWQgcmVj
aXBpZW50LCB5b3UgYXJlIHByb2hpYml0ZWQgZnJvbSB1c2luZywgY29weWluZyBvciBkaXN0cmli
dXRpbmcgdGhlIGluZm9ybWF0aW9uIGluIHRoaXMgZS1tYWlsIG9yIGl0cyBhdHRhY2htZW50cy4g
SWYgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBlLW1haWwgaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkg
dGhlIHNlbmRlciBpbW1lZGlhdGVseSBieSByZXR1cm4gZS1tYWlsIGFuZCBkZWxldGUgYWxsIGNv
cGllcyBvZiB0aGlzIG1lc3NhZ2UgYW5kIGFueSBhdHRhY2htZW50cy4gVGhhbmsgeW91Lg0K
