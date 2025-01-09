Received: from mx0b-008cba01.pphosted.com (mx0b-008cba01.pphosted.com [148.163.139.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CC121D598
	for <iwd@lists.linux.dev>; Thu,  9 Jan 2025 15:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.151
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435424; cv=fail; b=SqkK5VeamNaxNQbAizz7jSqRb8ce5nTEBj0NqyaCkUf0bdmIJpWJYTsQUpqv97YXk8OdwO+XPj8FarEN/rPkoKOC6r2wvPwpPoi5sgteDL5bgcGFyfEcFZE80LqwKE3Ewa4ZLYQyvmXtABElP7cqo8l/SYjep4QZuKMUwamSNL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435424; c=relaxed/simple;
	bh=pC3rzdL+smvQiuyyCHp0AlPzEkWW08kFQ30Fk8et2xU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FxpMAKzdH3ph1SEU1DIUm1rUfgCthUPp9wSRDAumussoD7gDFC/cMdyYb5mqHrVzl0rOxS37cZT6MB2ukpHsr3MF+5U7Oe8RCfwDaaHnLxn9DZJXfiy7dxtkdL/CAan/zmK+y27ECeNee/ilZnXCV/HIm0tKRtAqYa0+7IAC280=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=midmark.com; spf=pass smtp.mailfrom=midmark.com; dkim=pass (2048-bit key) header.d=midmark.com header.i=@midmark.com header.b=LJPCBZge; arc=fail smtp.client-ip=148.163.139.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=midmark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=midmark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=midmark.com header.i=@midmark.com header.b="LJPCBZge"
Received: from pps.filterd (m0372075.ppops.net [127.0.0.1])
	by mx0b-008cba01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509ED7DR002318;
	Thu, 9 Jan 2025 09:41:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=midmark.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps1; bh=gCG5/
	scS6CgHZ+CN2rO7/r/nRFlHjWvkewnDeMVrKd8=; b=LJPCBZgeGnkSRhOSYzl96
	8J+lMR1Y6a5yQD1E9lw80llrsb8IYfwBC73MhDBucWqL4ZNpMfdjRKGk7pszqe0q
	r77z6pFwPBZi46SHZwXo3ovRySSix0HAikyPI9ixTdZJFagQquXEJP3LzCoTebgd
	rUZry52GXIzcIPFdwdZ8OyFsjzqlRNr15KaOkTi7cABFuEg29IJJeE/73yxjkB1U
	HEmI4YBwGl32Sh1Z0Ikq8DAhZTy+XI6VhNtpW31N+5VmGtBLgBJJVU87RlAiDgiv
	2RvSyPQqtRwO3Rtpp25g7Y4lG++khZFRjxv5TvEAqxd3vwdnLAZ40EJ1a2nbjJmP
	g==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
	by mx0b-008cba01.pphosted.com (PPS) with ESMTPS id 43ynud39wb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 09:41:02 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WdYkmkVWkcaJRp2NCvrfcVqXbtb1wQNPL5xqm5CuOBYEaf/c4yHR8/CROd3DecGSJy4KBObac+QC0U15xwJ+m6hY+tuSyAaJp5XAzCRwQV5ewcICPR5WtIOQzxcI3m+gFWI7Rbi/R1oXo3l8sEKDFA20oMiCTjSKEqBXKEhogVShbjlFPoKAzglUKToEcOSdztqTftazWHRZ6EwKiqSdm7i6hijW3sjx8Sv2iB8omrBrvJQg0ZMdJbEBrhV+yUBqzR3eAGbbO3ooBV1DaJ9BJ8cqx2Y9mqZXUqq79SHPrGeEFWmxPm8IVpkLQBXSoKzLBtKshrjgEtmyONE3sMrKgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCG5/scS6CgHZ+CN2rO7/r/nRFlHjWvkewnDeMVrKd8=;
 b=F1/Ih+o7xQMxak9Za5uvI4k7VUH4kR03AiS8b/E+3WI3dA7BuGvSd1LTGQ/OlfI+S2x8+zejzroAZqpeXeOner6dJo7m3Ey5z7JI4ncK0ji7JEOSivdfcxeFpwavzWh97353i0s+iJ2r/lGKEG7Tc+lvm65+x0jpnwtI4Slq+tnrjqlvyn4LRY5aKj0r/U4jTzwqEotsIFTNzXh63jNb2S207yqgOyUcVWWNiWQpQk8zcXIF8uoDY391MMFlMOE+twGmDDdIjX/NLCBX/bfnRBWR6j9hR4z1f1BGiCkw6Ho16z+KnzTJ439PDoPhOCmo1WHBLHzbQQzNsJ4ZXfAVIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=midmark.com; dmarc=pass action=none header.from=midmark.com;
 dkim=pass header.d=midmark.com; arc=none
Received: from LV8PR08MB9350.namprd08.prod.outlook.com (2603:10b6:408:1f9::14)
 by PH0PR08MB7194.namprd08.prod.outlook.com (2603:10b6:510:99::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 14:41:00 +0000
Received: from LV8PR08MB9350.namprd08.prod.outlook.com
 ([fe80::7973:5566:a047:872b]) by LV8PR08MB9350.namprd08.prod.outlook.com
 ([fe80::7973:5566:a047:872b%7]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 14:41:00 +0000
From: Michael John <MJohn@midmark.com>
To: James Prestwood <prestwoj@gmail.com>,
        "iwd@lists.linux.dev"
	<iwd@lists.linux.dev>
Subject: Re: support for multiple EAP methods in one config?
Thread-Topic: support for multiple EAP methods in one config?
Thread-Index: AQHbYpr0HESdrSz770WlUjABs2nCe7MOf6+AgAAAqTQ=
Date: Thu, 9 Jan 2025 14:40:59 +0000
Message-ID:
 <LV8PR08MB93501EF78BD49426D4C39D18AE132@LV8PR08MB9350.namprd08.prod.outlook.com>
References:
 <LV8PR08MB9350114FC7C034E2E52F199BAE132@LV8PR08MB9350.namprd08.prod.outlook.com>
 <fcd2ddec-e21c-4a4c-9d28-c9c8bce8e6d5@gmail.com>
In-Reply-To: <fcd2ddec-e21c-4a4c-9d28-c9c8bce8e6d5@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR08MB9350:EE_|PH0PR08MB7194:EE_
x-ms-office365-filtering-correlation-id: 3fbd3754-32a0-49d7-3f57-08dd30bba280
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?q+RpIJv63TViTS/jFTMKyleU8I+SMbNXcn7xfJr9eUmU6dMX3ddFxYsmay?=
 =?iso-8859-1?Q?RANjb4RMZVC7FntNz8qpLxNTLAHzXyegqnW6QfM77Uu1flfb2u3Jr7YJwZ?=
 =?iso-8859-1?Q?4NWGXj4d/BIAUIGqaxH/3Avp6V7eSPpbNZbiuoqMmN2mEz+AzNELzRfB+l?=
 =?iso-8859-1?Q?eHQPuKDVFbnNiYNYEf7yNtX5yfL/gjjzu+pXByFcD2XrxNKYqCm2u64/Eh?=
 =?iso-8859-1?Q?FPx5jDgZpS3+xkeM7z7QbaHivkUuznMJm6QIqrKb9kRcUeEumyVOjntqbj?=
 =?iso-8859-1?Q?hnpgD3pjNT1Mop1NqNAbeM0s5T1d/VKxv21z+AsBtpyZqi135Q31IVt/pM?=
 =?iso-8859-1?Q?WTfShLdMGdrCUPQp61LzWyH7TB217UGHV6fzDthaVTxDulvbEI2C+jxUzM?=
 =?iso-8859-1?Q?jTcUcbQvP9CVTm60eOZ/+SJi8F+I5/NspIPJKAgHZ9HfPV7sl50tSQuZX3?=
 =?iso-8859-1?Q?Kc7j3nhC3lyaxQ1vZIB/8Z8d8ugA1DLTfLQgeS/KyOkbYdySWT6Pvr6fEE?=
 =?iso-8859-1?Q?pbgXRDzOAdwh0iV9dOT/2ai1sFrLGMAUO3lItk6RVB0qdrJNwHzk3ZDKYK?=
 =?iso-8859-1?Q?f5+LfyKn/jRGloXjTY0xpjo2rDU3PV62X5pjcVxlF0mZlLUt71UE0fh3pD?=
 =?iso-8859-1?Q?W4ivZalYza54V7vfVZmvHMz29GQ0NUcdgwc9Cya1GZEZUd/bSE9DR/st1M?=
 =?iso-8859-1?Q?xUnIFcZIj3CyyCtZi+aw4iNMGK+ZeezYNJuXmMl/58MxVIhxi43vGS4814?=
 =?iso-8859-1?Q?q5HZuNLShh3XR9NI+0G78/6bJ83nzlWiRnEODL/WsxGJ3R3es9mm50IFDg?=
 =?iso-8859-1?Q?YdVD6BQU5Fh5fi8gGclTLNp8Nxyoh1bFcjQ5ZtKyWEMDAKs5DQ13GklKQz?=
 =?iso-8859-1?Q?hy7dFUF84wrO4OkA52g1EnAqrD7VeCL076cGdPq9wNS/mo9zknTA+kRR0N?=
 =?iso-8859-1?Q?Yy+luZg8XUjxgwIi/yPkxW/vqW6G4FfrTY78VeiAiaCTkjFbn0MfjHAHFI?=
 =?iso-8859-1?Q?RrvZRi8zdp92BA4hxf7L7Qshb420ySZCTBJc9QqBgh6kXuJ5TVUM+t9OOB?=
 =?iso-8859-1?Q?8QtXTJjGEZOZZ++nJeEJqAvZw6LhwYcIBg+A0ToF7rX9Homc89Cp8Cks4W?=
 =?iso-8859-1?Q?CBCQCWgtDNAHby1aq2WxSAubfF909UZEahBh3nU59OzTUiTSrTu2arJ9er?=
 =?iso-8859-1?Q?7EY9ulwqEs7wUIhXs+gPSLYXx+QdnLfx5Sg0uvXs3MIio+r0QfsG863/Bu?=
 =?iso-8859-1?Q?gKrrRlhn1ueLzMs1MivdOqWVdX16b5a2rFsfX26TXp0lS547grKQZ2g7E9?=
 =?iso-8859-1?Q?gnEW6Whx40zLm5S8N7K1juFiIvtxBxpGv6xdDSXa3WqMRMZNILW6ygDfTZ?=
 =?iso-8859-1?Q?jHZ39KmC6oIQk2hNjBSyl3ZfAqWOuEG047UyfNPV4cF+sdLnZs8ItZ8vik?=
 =?iso-8859-1?Q?eoKWDRH2kz1nPNCjYKH2akwsjzHh+jEHL1u9w2nQE0sFUfCiqtOnPwkMhv?=
 =?iso-8859-1?Q?etLJdYWhYNT1l7WzGHKT7t?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR08MB9350.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?0Hb0OsRpYsa00yi20nSveiKtfAqjUO5+gcP5vAyFmJxr5uJDr2fvc2W5s4?=
 =?iso-8859-1?Q?iHHrQj2fgtZPglX2wXGPcEtB33k7SsCgQRfNRqeEpRylGHZljoh2FvdAxA?=
 =?iso-8859-1?Q?YpOQKk/VXkfL04tAhngXDLvH0DvbmXoI586gFBs7QDQ/w7/p9j8Ci5z9Jd?=
 =?iso-8859-1?Q?iu1qoDp4lB+cO2ZrqNlPN5bN3keKTGbjNqkvP4oMNdQiDhd2OzRLV/bUuO?=
 =?iso-8859-1?Q?i6XsKRYr1niYmykg4UCSqAW3Gtr8DTAjhbF55sWjYg0y7cO+fBwlTurvwH?=
 =?iso-8859-1?Q?PoybB1Cb+wK9a+tXcesyqtakem9607SrCsGam24OcNspcDetlN5qBW/dG6?=
 =?iso-8859-1?Q?nzBGzljjya2A8ayWoscvhev4DF2DnSIGOKVL3gqolxtaGXvh56Kua0qGdA?=
 =?iso-8859-1?Q?wGXhz4AeXfnNUBcKBKWdsJhMzWtnTyiGVepq4u0dOCDd35Rx0ipHutInOT?=
 =?iso-8859-1?Q?b7jwfKP1Y0WvApOiAS8W+gZzqoN3RyMzlxN9De+r/4jLa6p1dU+LZkXw3N?=
 =?iso-8859-1?Q?Uynfh5sLns0bdYLQCzfSt9tR6xgdZIwFOLf05/JZdDBOaJb0lIOsMgCJFS?=
 =?iso-8859-1?Q?HMGSd3ykfdd6HYJdtg+SAplZ2M0SGLJaVjRyuuf8i3Gd2LotDkEW1o+ke+?=
 =?iso-8859-1?Q?+LlweckFDrCY/NE7+jF58hJzDQ/2EjPTOfWX/AckPnKvwJ6cCxe9iD2sPC?=
 =?iso-8859-1?Q?QxFuDrU9clmeHIrrrgiM92ilFdA3B2VR/6vecvPh1qZvQ5d7GcqAOB2Naq?=
 =?iso-8859-1?Q?P2gpNAMTRoDNtiezWBPGYLaRw6TJq7A75Vq/uNnkM7lBecYli+OPWdPS1X?=
 =?iso-8859-1?Q?IVCzEgQ10YU8VjVI20NoV0rgilMSpfYgUD1bEQhgKa6efCMcIGTNYLBbkC?=
 =?iso-8859-1?Q?skyyexhYHIAxZAbHx/SFPvjG1wqmLhZqYjttkG1EdCE6DWlbD1B76PNb1x?=
 =?iso-8859-1?Q?snoD6oaRTI6G2nvQpNYdwr++5ooYe3pCLpmV4wkt+Gapn81AzZgafHnCLk?=
 =?iso-8859-1?Q?bHgNegxUDnY5QzMCft7Jn78V0TbszEUqLJHdSW7F2MwA7igm5Dkrax5Ffk?=
 =?iso-8859-1?Q?dNAM71J6K2t7G7kTMhI7+zTchET3a8gFCeMlp+ZvUoQqwYMpdwb45jNFoH?=
 =?iso-8859-1?Q?umEBoIZrwPaRZ3LhObUEofsSS8SiNEqxe9WQa4xd+DC3HaVXC9l0wSWxi5?=
 =?iso-8859-1?Q?psby8WhSut39jycCIxlZ1Zbdvid5FZNk8BSaUTD2jbldggljR1oWsKtCC/?=
 =?iso-8859-1?Q?uIStOdGkPnzdQz57DrQalaQYezyh6wBSP/8vjCfRDBTBa08rHaaP5R2Nop?=
 =?iso-8859-1?Q?FUFeC3JiE3BrHnQYKqICcVkk1LxAef0dPUimtsVXDzZgqUZrZGGYstwBAd?=
 =?iso-8859-1?Q?r7+ysiCR35Kuqb1mffcu+LFdHYB737UP+gPdfRqCJ41s+MNKQ+CVrQ5ih/?=
 =?iso-8859-1?Q?uOtYujJkq+EdkQzyiSDQDJplONch5vVfdj2+wxBPAVUKNUi2ahgyLPxhwM?=
 =?iso-8859-1?Q?ilJsS4K+WUv3JQfab7GyOwzp7SPRo4RelE+aLa+/zX9CG0KkezQn9KiKza?=
 =?iso-8859-1?Q?+kLsYXQdJ+O55n28uMF/47PlKhucC3AlshbOfhOMFwxsutAjTYVaQgldI3?=
 =?iso-8859-1?Q?3enTgjwDMQ6MA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: midmark.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR08MB9350.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fbd3754-32a0-49d7-3f57-08dd30bba280
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2025 14:40:59.9667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3c2a020d-f343-4ca1-b6ef-91768380352f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jcRlKmhnNLUaBe8JFetieqASulrNtcD2cbsjbnwsQeI+FlL1DpSxPSqvZj+b9xhp8slpZhWbSVKL2H2ebKNTuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR08MB7194
X-Proofpoint-ORIG-GUID: KFJJRaRsfjEjUji4fnotUIz3FFWnwOWF
X-Proofpoint-GUID: KFJJRaRsfjEjUji4fnotUIz3FFWnwOWF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Hi James,

> Hi Michael,

> On 1/9/25 5:37 AM, Michael John wrote:
>> Hello,
>>
>> I'm looking to see if IWD supports the ability to support multiple EAP m=
ethod, like what can be done in wpa_supplicant.
>At the moment no, there is no way to configure this.
>>
>> network=3D{
>>      ssid=3D"example"
>>      key_mgmt=3DWPA-EAP
>>      eap=3DTTLS PEAP
>>      identity=3D"username"
>>      password=3D"password"
>>      # Try basically every common inner method
>>      phase2=3D"autheap=3DMSCHAPV2 autheap=3DMD5 autheap=3DGTC autheap=3D=
OTP autheap=3DTLS auth=3DMSCHAPV2 auth=3DMSCHAP auth=3DPAP auth=3DCHAP auth=
=3DGTC"
>> }
>>
>> My use case is that I'm given a username and password for a network but =
don't know the outer or inner protocols (or even if its personal or enterpr=
ise but I can determine that from the broadcast beacon).
>
> So does the network actually support multiple inner methods? or is this
> just more of a "debugging" feature to determine which (single) method it
> supports. I'd be interested in the motivation for a feature like this.
> Is it:
>
>   - There are _real_ networks that exist which support multiple EAP
> methods, or...
>
>   - Your network administrators are not providing their clients with
> enough information.
>

I don't have enough information. The product I'm working on would go into m=
edical offices and could be connected by a range of users and the username =
and password is all the information that is provided. So the user connectin=
g the product will likely not know anything further about the network confi=
guration.

I can determine PSK and Enterprise via the beacon, yes. For Enterprise with=
 wpa_supplicant it allows multiple outer and inner methods to be supported.=
 My understanding is the client sends the EAP-Request to the AP and then th=
e AP proposes the EAP method to use and the client can decide to accept or =
reject the method, and when defining the multi 'eap' methods in wpa_supplic=
ant you're defining which methods to accept. Allowing the configuration to =
work with multiple methods and not requiring the user from needing to know =
this information.

> I do know its possible to configure/allow multiple EAP methods with
> hostapd at least, so it is _possible_ that networks like this exist. I'm
> more just curious if its done ever in practice, and if so I guess that's
> something IWD might want to support.
>
> Also, you should be able to determine at least if its PSK or enterprise
> based on the AKM in the beacon. And IWD will also print this in the
> debug logs when it scans.
>
> Thanks,
>
> James
>
>
>> Thanks,
>>
>> Michael John
>> Midmark Corporation
>>

Thanks,
Michael

CONFIDENTIALITY NOTICE: This message, including any attachments, contains c=
onfidential information intended for a specific individual and purpose. If =
you are not the intended recipient, you should delete this message and any =
disclosure, copying, or distribution of this message, or the taking of any =
action based on it, by you is strictly prohibited.
