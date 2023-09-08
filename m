Received: from mx08-00440002.pphosted.com (mx08-00440002.pphosted.com [185.183.31.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A5063AD
	for <iwd@lists.linux.dev>; Fri,  8 Sep 2023 14:02:02 +0000 (UTC)
Received: from pps.filterd (m0267190.ppops.net [127.0.0.1])
	by mx08-00440002.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 388AlelL011294;
	Fri, 8 Sep 2023 10:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landisgyr.com;
	 h=from:to:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	pselector2; bh=lAMJ18vPZVTsNFCE9oG/RD7j5Pq0BcaVcgl5Dt78CwE=; b=V
	S8GK4eXCoj+w8u7xPjk+vxrMjL4bjlxugqqIPDkFezkbq/CDEi7ZUZSyJTYXD8fN
	kakHQUomkvLC0FlszzzgA42rJ/j6V/RUcUaMkj0byA7hfW658RFaGqBfxBfgtvHu
	TbUs8GvdR024DXVrwuQSs7LNOK3xI/Ft4pj0uzczAXm9cdUiIEs3Hgw512MsD8DM
	RehqbBBzvnOY3HVyV1tJRjWi927vxBxzGGi47TCWrM3FTXmsRTe5QxoZgy17Szc1
	xv0+yLOwox7+iHARayKpIjcCsT+8uQMyGJNY1OBruw3VnfXc/fHnCdGvdPn70nQR
	KykbL+i/U2uQjyMpi3dYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landisgyr.com;
	 h=from:to:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	pselector1; bh=lAMJ18vPZVTsNFCE9oG/RD7j5Pq0BcaVcgl5Dt78CwE=; b=v
	MWHCPiPi4VaDMkSdwC9Of59ZQt1xCkcmfDSCRUChBj5fIQyCj5LF8sT8SZ/vCo12
	CSpy1tDxBqQTJZ3n4ZhBd1Avj4K99aokjrjdFsHfVlGg61kig55R49IpNCVljuYD
	dHqU0NSmn9sHp45r+Qm1qRCYFWIP/AulEHfuFFSuOKJ7srGYlSbm8g9/fkksC+/x
	Jg5MBvrkJXP8bttq1apbtIKQcRVQ3/Eu8STunzGigxU7l1MG2kbs7aL/zHk6koKl
	TcSrTWMHqEG/WTiYqp3B+slc34z5MkrJ+7fKJHtKkHH2rF8w/WnARV7tmm5zYTzj
	OsQuip3YvIpzArdotZVqA==
Received: from eur02-am0-obe.outbound.protection.outlook.com (mail-am0eur02lp2239.outbound.protection.outlook.com [104.47.11.239])
	by mx08-00440002.pphosted.com (PPS) with ESMTPS id 3suyqtq8jx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Sep 2023 10:01:59 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3lUjEsvmlVQaCkhSzwnPP9QDTpsIR02tF1lHCsMlHFkDLLrrzWagi17tDHVU349fcaC2QeZt1Pdg00uDDsIL/RQupgy7oPDBbHQEOdKFWbRYKtYIBS2apIwpgU7t76Dt8giKWehzsWM020sSpKaiyV5i0rJXqBBXMbvdlCWC2G+IK5YZUsGp15K4hLP5/l1qXF3MnOLd842GYdX4z0Gyk0amut1dXHLwU/hX4Xs7TqG3DLl1PvX9n5x2nPJOxSQwv+dEQieuG/EUGHEtdQAvvkx+6AwiaaAyE2cIc5HdGcU+/dpHp0suspy8FT68AEQcpQ8RRfmp7tb0t+YhcUu3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAMJ18vPZVTsNFCE9oG/RD7j5Pq0BcaVcgl5Dt78CwE=;
 b=KlZ2SktAyrn31oe1UQVI7gT0rv4ozkhb38gBsSH61YrgKwfFW3EC9Q+RNACjBDtLkxtDlXFpPbZo4X4W5qB6zj9aLODH/PfzPrHgGoqCWAwFWEZ724ibKhqfLpDSmXGORBKz9bBSoN0jZiIqLyW/6hJmfVBS8WGX4+Eoisn1t3/XdLkiUXT9qWO7TeTHcDTBon4kfFeZFqaX1iK/bX3IJWEa63I4+qvfjhcXPdK3xtC0tiQfFFQ/495jyp2Wm9LFFlXJPVpKjxXKOmyv/iX4+mHufkt2REmPgSJ4/M7LVrs0Ba7KHxNiT5hJmhltL1yamThLEBQBbNq9Iori3+Q5UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=landisgyr.com; dmarc=pass action=none
 header.from=landisgyr.com; dkim=pass header.d=landisgyr.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landisgyr.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAMJ18vPZVTsNFCE9oG/RD7j5Pq0BcaVcgl5Dt78CwE=;
 b=Io3bLQoq84VwiuwpJBa7XfdmYXWCOTSS5sMknlZXnBi3+slmz+vCijPl64ks4m47EJaZsvKEqgoTnQUudpM9OuaH8rEgHzQxjUivsW1iR4i3tT9K+zimZS/YA7jeGBku8rgMeJVIqIq+C27BMBRp65pCt4U4XM880NrNx1xPuxY=
Received: from PAXPR01MB9217.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:2b1::18) by AM9PR01MB7186.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:2c1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.10; Fri, 8 Sep
 2023 14:01:55 +0000
Received: from PAXPR01MB9217.eurprd01.prod.exchangelabs.com
 ([fe80::5ac3:bc:cb37:d2ba]) by PAXPR01MB9217.eurprd01.prod.exchangelabs.com
 ([fe80::5ac3:bc:cb37:d2ba%7]) with mapi id 15.20.6768.024; Fri, 8 Sep 2023
 14:01:55 +0000
From: "Johnson, Bryce" <Bryce.Johnson@landisgyr.com>
To: James Prestwood <prestwoj@gmail.com>, Denis Kenzior <denkenz@gmail.com>,
        "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Subject: RE: [PATCH 1/2] handshake: include additional sha256 AKMs for PMKID
 generation
Thread-Topic: [PATCH 1/2] handshake: include additional sha256 AKMs for PMKID
 generation
Thread-Index: 
 AQHZZzVvQYjWUqqjnU+IQ/ZE0EEWB68jQOYAgAGPVICACWTDAIABxC6AgAmoioCA07oygIAACEYAgAAmWACAAVIvUIADBv6AgAAEUpA=
Date: Fri, 8 Sep 2023 14:01:54 +0000
Message-ID: 
 <PAXPR01MB9217F29A004603E62CF9FA2AF4EDA@PAXPR01MB9217.eurprd01.prod.exchangelabs.com>
References: <20230404203823.384260-1-prestwoj@gmail.com>
 <1d8a1939-93fe-12b6-5007-e6621dffa7f1@gmail.com>
 <f3259b4c-e8e3-8542-247b-9d6bd0ad00af@gmail.com>
 <05e63c78-5373-520c-15db-aa42cecd95b0@gmail.com>
 <3855c8ce-c2de-d1f3-e5d8-8c93610e4b22@gmail.com>
 <5789f7e4-793e-8e42-29d1-1a92696ec2f4@gmail.com>
 <PAXPR01MB921752F18978A3F5A5E53C91F4E8A@PAXPR01MB9217.eurprd01.prod.exchangelabs.com>
 <82109cb9-3264-4b99-a6f7-e3d71da45270@gmail.com>
 <c69115a4-858b-4602-acf7-f968be707ea4@gmail.com>
 <PAXPR01MB9217D3D30DCE9AB01A000F5AF4EEA@PAXPR01MB9217.eurprd01.prod.exchangelabs.com>
 <8ad9aec4-b72a-4838-aff4-cc52e6018dcf@gmail.com>
In-Reply-To: <8ad9aec4-b72a-4838-aff4-cc52e6018dcf@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_ActionId=c432ae2f-e19b-4ea2-b6ed-404b3db7f805;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_ContentBits=0;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_Enabled=true;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_Method=Standard;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_Name=724d29b2-602f-4b77-ba15-b7b42511c7c5;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_SetDate=2023-09-08T13:48:58Z;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_SiteId=ee2cd48b-958f-4be4-9852-b8f104c001b9;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR01MB9217:EE_|AM9PR01MB7186:EE_
x-ms-office365-filtering-correlation-id: 69e69c4e-9f84-4260-550f-08dbb07428ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 2JlgrgfyVfm02VD9bcJ+cdxb9EojsjiyXZndIcwNj21EcQfZ3iXlDRT0AkDfpP0bJrwWVvalbXbVFDES26/H35XHkFjrzyJRSOpShTha0IDL6jDl73d0Q1vjiiD3UNQLsha91mOC4dpp7CFYEDb14j3w+hYrMJ5+dPfIVOeeMdfDBrNfNIi4Cprszq+YGXEFEWVyy2pNKLgjSmnq9Chs6UIjmcLKMeR7Jisn1QTwE90cX/yY6QXywSy8mRdlGVRCyoYk2xy8qvhHE9IVRibU8reVw8Q9vpvnhWkqa8W9zQ0Z2Y+T44CG0U2qgSWk2j0macl134DBh56b+n6Hlc9BEgEF5cTIsFtL+70HPFr5XODYHl/wqy/QyHQeySvvKTN5fotLLPBLbX4zX0Dp7quLdnlYuGRzJRRQUeSavx3g+PaKTG906ILRlcc/8FOgX8K+Va/ftRlXyDWRDEr+MHeSo5D0u1dD4rpaXqAIlvCI+5WraeG0XePAsdTLmIOphtnxspk9XfctkVwE6K+MyLLkYQh1a3R2hnod/zTB4rKoue8oOJMkJHLUkFn+K1OWChhurKI02kAHxnmQxJWA4QCD3iYwV++VegcFgdf/C1amI2BlXlAM2TUuSLOgObl+svSk
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR01MB9217.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(136003)(346002)(1800799009)(186009)(451199024)(122000001)(38070700005)(38100700002)(55016003)(86362001)(33656002)(478600001)(2906002)(110136005)(9686003)(71200400001)(52536014)(6506007)(8936002)(8676002)(7696005)(5660300002)(66446008)(64756008)(66556008)(76116006)(316002)(66476007)(41300700001)(66946007)(83380400001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?OTk0NENEN29rWm9sa3U5V0UyNTZQdlRBQXc5a3k2WTdQV0hYaXE1NThaZnZt?=
 =?utf-8?B?ejFtT3N4cVh6TFowUFB2Q2JESVBjSGJYMm4xeXR6a29sOEdPZGpKR1RHcWJu?=
 =?utf-8?B?YVkrUHBud2gyK3g5TjV1V1FLTmRxV3VGV1lBR3JISWJLY3ZrOWpWMFRKeEF1?=
 =?utf-8?B?OEphWnptMGJVMFNXZDdMRXlxSFcxdmdQMFBDZjZvcm1ZbVlsQTlUVkNTd1Zs?=
 =?utf-8?B?ckxDek5BSUpZaTBnVTQ3V1lVZmpWSCsrYmppNHFwSnZVcmVqMGo0K1FHeE8z?=
 =?utf-8?B?ZjBSRFJVVHh5cERFaGMvWjVFUnBvZm9RcVFFYTRMQ2h2R21MZm5sV2JvQSsz?=
 =?utf-8?B?SWZDcStmMEVBU3lUczVpUzlsWFdPQXVEREF1SythS2ozVEl2bnFqZXBvRE5Q?=
 =?utf-8?B?T0Znenh0VWJPK0huTWQrTGxKL0VNRGloaU41Vm52VldJcTdRREVFSWt2RjV4?=
 =?utf-8?B?QjcxelNjbEJFTUt3UTlrWmFKYTNYdjlyNmhNUjBuSnRMSENyZHUxRVFSSnJH?=
 =?utf-8?B?aVNXWGVWTEtHbXR2OUJrUi8zU21WaXhvbWJsUS8yREJCeHpzMUlCaVRFcDl0?=
 =?utf-8?B?bitWLzFzT2JoL2Y1TWdkZGZiVjRUemJwL1dHQkR1U3o3SVhMendGVE1TVTJT?=
 =?utf-8?B?cVFXd2dkVmFpRVNEMnR6RlpTQ3htV0hDOGVwaXRnU2pZaVNrZW9BOXpFZmxZ?=
 =?utf-8?B?OE5rOXUyd1pLNTJTVjNycWYwL0M2YVpFdUdRaEtieGFEU2crMmRLelBtNmw0?=
 =?utf-8?B?MlV3RWhRL2pzZWZnNWdCTU4rT0xRUitmajZTSkdldFppUmZ1QS9UTDA4OVZT?=
 =?utf-8?B?NXZoQy9wU1B4VEVxdHNyQjNVc1FEbEZNUUxycFA4N2JWSktVcnN5RlJHeTJL?=
 =?utf-8?B?MkVRakMwQmpqc2Y1VktEd0ErMnNaRjdoYnFwN2ZCR245dWwydG9nVkxPSUtK?=
 =?utf-8?B?RlRHY2wwVDljQXRDZndicG16aDlYWjRuSEM3RWtNQlRvZ2RBY2xVSVQrU1JK?=
 =?utf-8?B?UjN2NEkxNnN5ZVY0NVlITGFodmYzQ1VjWmhsYXZnQU9ERkJTdlBaMUkrYVZU?=
 =?utf-8?B?eGtsWXZ6elM3TG15cEY5clRHN21NUDdGL3ByeFhmSWUvTGxvWUY3Z2dyakV0?=
 =?utf-8?B?UGE2MU85R0tFcDR4eG5McUdEdUtWUG9UbFc4amRPMlFKcUt6clA1WEFjS0pZ?=
 =?utf-8?B?MmJZWW9ZWTdxeGtZQXVIUU43Q093bDg2TURGRk16MDBXV2E1VzZjQXVwRVNh?=
 =?utf-8?B?MUpNcUxIbWRFUzl6OUZ3L0ZueHdnYkI2ZFl6elZ3VTFwR1ZJMFcvNW50dUxI?=
 =?utf-8?B?THlCOXRTVUpjYngvZWpUY1hyRnBLMUpzcFMySmJNTllIU2NVLzhYUno5enFr?=
 =?utf-8?B?M245ZEZXWkNOSlJjNy9HM3p1UDUwQXMvampoOGVtSVhPVFllWDVUcGR5aWdS?=
 =?utf-8?B?Qzh0aHovTEhQWXpoNGlZK2w0aE1wL3p6aGFpNnVIeldLUFZPY1JzeDYyNWRz?=
 =?utf-8?B?Nko1Qi9YU1FIcWxJUDhFMTI3eWJHNk9RaTlYUFpCcllQK3hpSnluNXh0WHFn?=
 =?utf-8?B?U2E1YXh6SklNTzVCbXJjWXFJRVRaU1dIK2VhK052S003Zm5FNC9XQ2I3RWJX?=
 =?utf-8?B?L0h4bFNFRHJBamJacDRLb041NFZTbVZPME9SckVlREE5RU4zdGxMZUtzTEsw?=
 =?utf-8?B?ZXlEb3FueDlzMndzaVpTTnc0aU1qMUdhd2FJWVhMVk1RWWZHYlB3R0VheW9N?=
 =?utf-8?B?ZDZRV1pEVU9qQjZhcHJacEdzUVlwak9uSFJNUGpSOFUyZGJab2Rzc1VyS0Rq?=
 =?utf-8?B?NUFLS2lTTnRMTDNtUWJSZm1aSE1pRVdpcjNHdGlSZjdTUngzVVNMOWhlT1da?=
 =?utf-8?B?KzREVy9ZVnpmdDVuQ2ZKTzhKRXhrTFFja1FwZXdPSGNiT1QzcWZtQ0ZUeGFy?=
 =?utf-8?B?SXZuK0NRSlRoVFB4K3hxWkxUZEdmL0JzN0Z4SDA1TUpZR2FaQUdDNlUxMC9n?=
 =?utf-8?B?L2s3dEZ6eC8vWm1uOWZlbDlkTnh3Z1Jva2lWa0Z1UmZVRkVDODBsOTJ6Vml6?=
 =?utf-8?B?ZXRUNmdmY2RKSjF1Y1BJT252dmxzZkc4anZBN1NrYWs3T3ltSVFlU1ZBSlpU?=
 =?utf-8?B?TkExYzVlUWN3dTFnSXJyYkpPek1lL2J6RDM1alRxYjVzQlVCVHZUaUFQZlFL?=
 =?utf-8?B?eFE9PQ==?=
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
	QZKDfTePnKZzIgi/IXO/I5Hj3EjZ9U+RxQNCLrV3PF1MFz2XcD7Be9+yjrjfYlR817bvAULf0wP5zqVVrR+UEouBYpNziZyaerAHtZWrn5o4M+g54Q0QwKPUOhhY9APNmFvsafXgFdN++SNVS5TCOoe7Am8G6GwxvNUGeLqNZaIqFjSNypZd6FmiZnL9WqCTwW/FVHOyNj9t5jGu3JTvuuaGOsgv2jJ2c6rUehV55QDvjLUUt2B2GTpRF4eaz+xImBtbD1w1msOM7ycsLfp9T2tEyxGJ+Bab8prh5cGCYv7f0eHv398AaSUqBzdqQkI/U5KJIVuBUFG7sXaOVcex0MHslKqEotUKfGmacrbynEZ5Kxx2JQLsW/0s2LZWDk4ApZHcTANuO8y1Va5UDwH4id93dUJ9A0ey/ZVnUvtX62/x09LF/2Rfn3B4zZaVEX5ptUaOdgwjFDdoluJB89X4qimxuBlwjKMRN29LFs2GqlfPHl5RdkaCbro2L3eC94jdVlSv//kMgEYbL7lpVMjmdSlI1DeEDfaWcxqdx8aD14VJBuGTBo7C6yWZ8Xk92VJ7E/S7h2QaitUXOn4YRJW0ZkQz0f3/zAp+LI5m/706jiZUQLDR8Fhj3fKuj5u+IuwTjJl0mvIUosr/1o8684deGNNE5kFsJxo5flHnxA2RGa9+DB/TjyC5yJHc2t/Ia88hvQPQeIghg70gsNaU9GmKfm+lV/bAXxSlA2CL373UY1upqYl6ZG5Cuexu9M3w1mUZcJOwMHX0DfzKGCY8639L072HSGJZlFG+O9TtPhQh6BtbXLE+nw60czhjiIXNhPvo
X-OriginatorOrg: landisgyr.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR01MB9217.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e69c4e-9f84-4260-550f-08dbb07428ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2023 14:01:54.9863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ee2cd48b-958f-4be4-9852-b8f104c001b9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0UFPBLeMCzk7j4EOEqeP+XMrLjejmJwg1ADX5GHJ5dUHEsCGS4bnO0fYzTRN2SiV2e+QUJMhI3eICorDXb930FAu+PDvgfbsKkPU/mJI2IY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR01MB7186
X-Proofpoint-GUID: 0AXuAhIccXHFmBka5bx4D05gmx1sMhwJ
X-Proofpoint-ORIG-GUID: 0AXuAhIccXHFmBka5bx4D05gmx1sMhwJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_10,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=893 clxscore=1015
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2309080130

SGkgSmFtZXMsDQoNCj5ZZXMgd2l0aG91dCBQTUtTQSBzdXBwb3J0IHRoZSBjbGllbnQgZGV2aWNl
L0lXRCB3aWxsIG5ldmVyICJyZWFzc29jaWF0ZSINCj5hZnRlciBiZWluZyBkZWF1dGhlbnRpY2F0
ZWQgc28geW91ciByaWdodCBjaGVja2luZyBmb3IgdGhlIGF1dGggYWxnID09IDANCj5pcyBub3Qg
Y29ycmVjdC4NCj4NCj5BZnRlciBiZWluZyBkaXNjb25uZWN0ZWQgSVdEIHdpbGwgZG8gYSBmdWxs
IGluaXRpYWwgYXNzb2NpYXRpb24sIHdoaWNoDQo+Zm9yIFNBRSBtZWFucyBhdXRoIGFsZyA9PSA0
Lg0KDQpKdXN0IGxvb2tpbmcgdGhyb3VnaCB0aGUgd2lyZXNoYXJrIGxvZ3MsIGp1c3QgdG8gZG91
YmxlIGNoZWNrIHlvdSBtZWFuIHRoZSBBdXRoZW50aWNhdGlvbiBBbGdvcml0aG0gaW4gdGhlIEF1
dGhlbnRpY2F0aW9uIG1lc3NhZ2UgKDB4MDAwYikuICBJIGFtIHNlZWluZyB0aGF0IGFzIEF1dGhl
bnRpY2F0aW9uIEFsZ29yaXRobTogU2ltdWx0YW5lb3VzIEF1dGhlbnRpY2F0aW9uIG9mIEVxdWFs
cyAoU0FFKSAoMykgICgweDAzIDAwKS4gIFNvIEF1dGggQWxnIG9mIDM/ICBPciBhbSBJIHJlZmVy
ZW5jaW5nIHRoZSB3cm9uZyB0aGluZz8NCg0KQWxzbyBhcyBhIHNpZGUgbm90ZSB3aGlsZSBsb29r
aW5nIGF0IHRoZSBsb2dzLiBSZWxhdGluZyB0byB5b3VyIG90aGVyIG1lc3NhZ2Ugd2l0aCBHcm91
cCBJRCwgdGhpcyBkZXZpY2UgaGFwcGVucyB0byBiZSB1c2luZyBncm91cCAyMC4gIEJ1dCBzaW5j
ZSB0aGlzIGlzIGF0IHRoZSB3aWZpIGNlcnQgbGFiLCB0aGV5IGFyZSBwcm9iYWJseSBzcGVjaWZp
Y2FsbHkgdGVzdGluZyBmb3IgdGhhdC4NCg0KQnJ5Y2UNCg0KUCBQTEVBU0UgQ09OU0lERVIgT1VS
IEVOVklST05NRU5UIEJFRk9SRSBQUklOVElORyBUSElTIEVNQUlMLg0KDQpUaGlzIGUtbWFpbCAo
aW5jbHVkaW5nIGFueSBhdHRhY2htZW50cykgaXMgY29uZmlkZW50aWFsIGFuZCBtYXkgYmUgbGVn
YWxseSBwcml2aWxlZ2VkLiBJZiB5b3UgYXJlIG5vdCBhbiBpbnRlbmRlZCByZWNpcGllbnQgb3Ig
YW4gYXV0aG9yaXplZCByZXByZXNlbnRhdGl2ZSBvZiBhbiBpbnRlbmRlZCByZWNpcGllbnQsIHlv
dSBhcmUgcHJvaGliaXRlZCBmcm9tIHVzaW5nLCBjb3B5aW5nIG9yIGRpc3RyaWJ1dGluZyB0aGUg
aW5mb3JtYXRpb24gaW4gdGhpcyBlLW1haWwgb3IgaXRzIGF0dGFjaG1lbnRzLiBJZiB5b3UgaGF2
ZSByZWNlaXZlZCB0aGlzIGUtbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVy
IGltbWVkaWF0ZWx5IGJ5IHJldHVybiBlLW1haWwgYW5kIGRlbGV0ZSBhbGwgY29waWVzIG9mIHRo
aXMgbWVzc2FnZSBhbmQgYW55IGF0dGFjaG1lbnRzLiBUaGFuayB5b3UuDQo=
