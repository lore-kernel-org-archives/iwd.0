Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2054.outbound.protection.outlook.com [40.107.15.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB99A940
	for <iwd@lists.linux.dev>; Fri,  4 Aug 2023 12:53:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ieGIjHrho6Ssbv4htjoLVOkg98vjkeOJtgnP/DVmX+Om0d9Nc7Ly5Cey2mvjh3AVlcpdZI6Qm1yYf/7Bu/JmiSPCGy+Wp0yg0NfpIbdDt4/6aYEBT3vGXAQgLIjzgU02jn+z5gb42TeZu4H9Rkf0/LM51diNC10aEinjtStRBzVAlI9n3um04AfaapKa31DoDSRKVvbbkifD+FMJI6jlTRLI5vxC1v8fUUmVwpl/r3XO7ahhIwQLth/oVzG0MEU4FihxUvb7EUdO8dqqdf61PSTxSe42xC+YStKcufB71+ZHJoMrEoU/M79RXx6d8dG2q+yWO/KVPxIc1s6V43e75Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rfula/+62eps/MlhcwaCiw32xny8Omrz+02m/1foHxc=;
 b=gPAgerla3nbhyghdGMoQgE/rdg6eqt6c3p+1FmHoAman1O3yoEyoOS3k45+snCOs89XWTUy1XZKbX7TewmaKr5K4yM5qzxWrEt2jwjNfcCy2bLv42D3nlJ74AQUJP7/VLHQH0MSILqTo/GO09+RMc8J0LPpwZYdHRahaVMT03iqueNrCTm5xrqt2YSQjr3APHv2i/+2RKkSYQixbx+/8p494TDvJQ3vgp5Nn2HlsaXnOyS2A2xt5Bdm72liEaQn3BHzfv7JdasPub8Dt52pHy1fB9AV6IGLR0nWx7tcKe3GdZEJOFzofqYwtIxrD+HaBBT2tsBarsZ3uu7Oo2CZIZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-camera.com; dmarc=pass action=none
 header.from=leica-camera.com; dkim=pass header.d=leica-camera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LCAG365.onmicrosoft.com; s=selector1-LCAG365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rfula/+62eps/MlhcwaCiw32xny8Omrz+02m/1foHxc=;
 b=BRx/XlUfZm92RNq+fjaei1OHz4cfN9lsKzpZOC76xug/f8t0YAVU7xSudBthjezYx6s2l9mEvHcw6+kChhSHvpf/Q36NgdQuSnR06680SdvGeHyy1x/A3WLl55CTU0iVUwiZ1l0bUXExCr+Uq6TKaXKVA4go6Cm7/yhK+kJ+1Q4=
Received: from AM7PR01MB6724.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:18f::10) by PAXPR01MB8906.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:2bc::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 12:53:22 +0000
Received: from AM7PR01MB6724.eurprd01.prod.exchangelabs.com
 ([fe80::35c2:9f44:930a:6543]) by AM7PR01MB6724.eurprd01.prod.exchangelabs.com
 ([fe80::35c2:9f44:930a:6543%7]) with mapi id 15.20.6652.021; Fri, 4 Aug 2023
 12:53:22 +0000
From: "Altous, Salahaldeen" <Salahaldeen.Altous@leica-camera.com>
To: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
CC: James Prestwood <prestwoj@gmail.com>
Subject: doc: APRanges is deprecated (use APAddressPool instead)
Thread-Topic: doc: APRanges is deprecated (use APAddressPool instead)
Thread-Index: AQHZxtIcEHkQ8AZZA0Kkx5uovedwXQ==
Date: Fri, 4 Aug 2023 12:53:22 +0000
Message-ID:
 <AM7PR01MB6724106B9A0D096464D1DFA4AD09A@AM7PR01MB6724.eurprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-camera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR01MB6724:EE_|PAXPR01MB8906:EE_
x-ms-office365-filtering-correlation-id: 55143857-832d-40ae-d771-08db94e9c939
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ZulJKxbSU124HPBkJNsrivJ+fDSTefmlMSZW9QqL19dD5Kv2KVNCA8MUd4elkrJWcaGrdpbd+AdecDpI+a7knRDJvtZlKKkEqJnI66QEfAdr18Lm3nm33E3UGctRJqTZNZyQnJr7jTQWtcUssiwXNNONrU6BIRbZSEzkR5Gxx5ewUfilfFewhZhxtlLFPf6+f213V8SNPeb73C3lTlCEy8dQSlQYB6Zx0RMJH69vyg8xRTQdniN95gPzcQvxf2enDbRcBVF5gTMfejOds5nUvCJUHYNyhRgU1+b4QqhgSRYXpJl6L7AdXipnbUf+PgUMSl6FPxwICN6QaSzivEjp8PLmxdrF5FYPDihbrJ+Af5YHwqIRuRCZSfHMfUBurNoZeF12nNG6VdNQ3Ai1IRKmGkmEz2LLEFf+c8TXYaTqJ7lYTt0T519o8GH9w3Zggwh3j4pKBlbn9H22xMF3NhHa6FAuhzI8zrR0s/btBZm7vcsCWX8s8xsV36s/HnF/Q/6yi+g+jkCqsde1qHXOC1VZOrXgw4yWJyL8khIakV2XfvHsLvjA1o4pYKvRHZUo16aBd36sVcrsVvLDJ19mTtBO+4Et9bx6hVk4aG8AomJMDUstKUTxt/CtfiCTG9CE75Va
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR01MB6724.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(366004)(136003)(396003)(376002)(346002)(1800799003)(186006)(451199021)(8676002)(26005)(6506007)(83380400001)(4326008)(2906002)(66476007)(316002)(91956017)(76116006)(4744005)(66946007)(5660300002)(6916009)(66446008)(64756008)(66556008)(8936002)(41300700001)(7696005)(71200400001)(52536014)(9686003)(478600001)(55016003)(38100700002)(122000001)(99936003)(33656002)(86362001)(38070700005)(19627405001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?+ovv6YJVF7B9xNQvlz5OEUv62aFR8VyxOWBGSy1RG5K9WS8KNd8Hg5+PjH?=
 =?iso-8859-1?Q?N0QIx/wJNyLHU99Rt0GbpgqdjFgrluu4Xr7HJtyHZGXhbLQ9Ze/Djtf3LT?=
 =?iso-8859-1?Q?xTJFN8CHCdFUEp3kAv1a4XGqql1MlW1erE1uYRPzEBA09HQnW4EwXGIh7X?=
 =?iso-8859-1?Q?L/TjQsQp9tkEDAAhJxsyIe3c4i1eeGvZMoPJK+QrQd9yCoJk9tS6FeaMgz?=
 =?iso-8859-1?Q?PfRRiUcJxPw+XtpyY3CTuUCQdj7rzAgBnosU8TZaCaPkvTGWGIZrzs64iO?=
 =?iso-8859-1?Q?cPwVncrXJMpIUxnpYxc1Vk3GLW9qlfID6hCEamg0g9wHKdBEc1FrDy1Sry?=
 =?iso-8859-1?Q?5CGYBJV4P7GGU8JtT4eu1gPASw+samtXpXH0byIMQ6E9AI5xq0ZofpuyZ9?=
 =?iso-8859-1?Q?zcg3V/iYTTwvL7e8a1NXy0327B/n+9jAlgb+NB+uSzbh3fTsLIaA/HFXHI?=
 =?iso-8859-1?Q?SFciIwBckreoh8ac5iUWlQkXDZFNekKbQYx2EuFxsH0AhGy9NteNEXzwUJ?=
 =?iso-8859-1?Q?nN3q95t8NUHSZTPrBw+sp8E/4IAY2gC6IJaOEuG0lL5GLbArRL0p6cuNQp?=
 =?iso-8859-1?Q?SKetUN8wLNH0LlhQVNSC/2MZfN4OXmMHPBlDOlCWZP8wUQGZ1fWaI5U4mm?=
 =?iso-8859-1?Q?OFFYpBifR8CCXYjCJvCG53t1v1mAeadsYzeinf4BkBrsjmf3fUiEe0WYuY?=
 =?iso-8859-1?Q?YZOE1buBaPu2fxHQv+f0uFwkTSnQuhK8nQ+xJzTrmllS6NGGC0+HIYEIoI?=
 =?iso-8859-1?Q?jvKgWTPokN1KgzrGthSutk8KFbIjN7okMzomLbT1fN2GqCL3NlnYKMKLCn?=
 =?iso-8859-1?Q?gVbRDpjXo0yr+9TrECK2tE+gzNxRevTiRZj/291dcS5y+6wlZQPM/CBSaF?=
 =?iso-8859-1?Q?k4MoVOahsbjbouW/bs+DjwUSdVttb+wPRWpRCA5Bl8hH2c5CZWlMSfF9jJ?=
 =?iso-8859-1?Q?KZyKEyKlb7mgLS4KYQi5F1O8errvWIlIMp3U1QlJVNAcVCeXkDA2MmU1YZ?=
 =?iso-8859-1?Q?cQeyL0Jy/GcGZyHAfzZ/uFxv0u6gTWs1yRk/WF56QAfzkz8DaToEmNrvm1?=
 =?iso-8859-1?Q?l03iPVcPy/8jVvoK2t7h/iuj2+nN+4UGoJ+lo8Wt7HCcqWCxKmblm6DRND?=
 =?iso-8859-1?Q?J339sbPYrMvMpuDqDkKr8hzuin3f4s+UmOzZOMz25tEt+0AKjXT4t580Xs?=
 =?iso-8859-1?Q?1V1DeFpSI+rc2f3LbJh8WE6iwiAUZssDd+C0TPNTNbuupV5jL+6YZU8iLj?=
 =?iso-8859-1?Q?bvq7i5CaWcf/kvvlOKXdaCWISFBBLOmgmsuoFSWaKg272X3Ql1pZlpEbkZ?=
 =?iso-8859-1?Q?WKxRuvswZF/oPrzCMAXlzto3YSIvTGZRUcDBOtsiNe6YzOxPyoFAphsu6G?=
 =?iso-8859-1?Q?YU1l58xA3dvwXd5tOMYr6qknU3sXWjst2NkBefNTnCCLznKSkJGRryMqMu?=
 =?iso-8859-1?Q?WOJ1PyQrD8U912VQEGxQVmR+yYiFAm180ATi5x1fOMQmehIdODmanAEuew?=
 =?iso-8859-1?Q?AbqQR10vE7Kal8d52Q+XyGl+TLIQaQhrBoQ4x2GCPPyMfcw9inpCa6yx1s?=
 =?iso-8859-1?Q?1qyTufsEsojMmp0OcQ258FFG0bAvIlGwGqPGgW+WC3sJ4f8bzlCwUaYNxs?=
 =?iso-8859-1?Q?P2I1ga+Wt5LLmlyPOrLl180pVenmltB63PE4H5nRJt95uXomWfbUASNw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: multipart/mixed;
	boundary="_004_AM7PR01MB6724106B9A0D096464D1DFA4AD09AAM7PR01MB6724eurp_"
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: leica-camera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR01MB6724.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55143857-832d-40ae-d771-08db94e9c939
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 12:53:22.6774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2f1272e4-e56c-4f8b-a516-94002dc07e0a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qYrC13KinTEAI7WCFwjVS1y2LjLpnID/N9xvSPqWy1kiIBAi6Yw01Mu4B94dtR0CG0gLH+yZZX7XGLA1EQmAqhL6+L1qemu8dDOcXUFOQ0glulZuwU/grWt4wS15laOa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR01MB8906

--_004_AM7PR01MB6724106B9A0D096464D1DFA4AD09AAM7PR01MB6724eurp_
Content-Type: multipart/alternative;
	boundary="_000_AM7PR01MB6724106B9A0D096464D1DFA4AD09AAM7PR01MB6724eurp_"

--_000_AM7PR01MB6724106B9A0D096464D1DFA4AD09AAM7PR01MB6724eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi James,

I have updated from iwd-1.13 to iwd-2.3 and I was wondering why the APRange=
s is not working (in main.conf). After checking the source code, I have not=
iced that APRanges is deprecated, and I have to use APAddressPool.
The doc is outdated.

Regards,
Salahaldeen Altous


Leica Camera AG | Registergericht | District Court of Wetzlar: HRB966
Vorstand | Executive Board: Matthias Harsch (CEO) I Michael Grimm (CFO)
Aufsichtsratsvorsitzender | Chairman of the Supervisory Board: Dr. Andreas =
Kaufmann

This message may contain confidential and privileged information. If it has=
 been sent to you in error, please notify the sender immediately by replyin=
g to the message and please delete it from your computer.

--_000_AM7PR01MB6724106B9A0D096464D1DFA4AD09AAM7PR01MB6724eurp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0">
Hi James, <br>
<br>
I have updated from iwd-1.13 to iwd-2.3 and I was wondering why the APRange=
s is not working (in main.conf). After checking the source code, I have not=
iced&nbsp;that APRanges is deprecated, and I have to use APAddressPool.<br>
The doc is outdated.<br>
<br>
Regards,
<div>Salahaldeen Altous<br>
</div>
<br>
</div>
<p style=3D"border:1px dashed #A7A7A7;border-width:1px 0px 0px 0px;font:nor=
mal 11pt Calibri, sans-serif;color:#A7A7A7;">
<strong>Leica Camera AG</strong> | Registergericht | District Court of Wetz=
lar: HRB966
<br>
<strong>Vorstand</strong> | Executive Board: Matthias Harsch (CEO) I Michae=
l Grimm (CFO)
<br>
<strong>Aufsichtsratsvorsitzender</strong> | Chairman of the Supervisory Bo=
ard: Dr. Andreas Kaufmann
</p>
<p style=3D"font : normal 11pt Calibri, sans-serif;color:#A7A7A7;">This mes=
sage may contain confidential and privileged information. If it has been se=
nt to you in error, please notify the sender immediately by replying to the=
 message and please delete it from
 your computer. </p>
</body>
</html>

--_000_AM7PR01MB6724106B9A0D096464D1DFA4AD09AAM7PR01MB6724eurp_--

--_004_AM7PR01MB6724106B9A0D096464D1DFA4AD09AAM7PR01MB6724eurp_
Content-Type: text/x-patch;
	name="0001-doc-APRanges-is-deprecated-use-APAddressPool-instead.patch"
Content-Description:
 0001-doc-APRanges-is-deprecated-use-APAddressPool-instead.patch
Content-Disposition: attachment;
	filename="0001-doc-APRanges-is-deprecated-use-APAddressPool-instead.patch";
	size=1216; creation-date="Fri, 04 Aug 2023 12:51:25 GMT";
	modification-date="Fri, 04 Aug 2023 12:51:31 GMT"
Content-Transfer-Encoding: base64

RnJvbSBmMDA0ZTY3OTYxMDQ2OWY4YmVmYmFmYzBmZGUwNmI1NDE4NWJjMzA1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYWxhaGFsZGVlbiBBbHRvdXMgPHNhbGFoYWxkZWVuLmFsdG91
c0BsZWljYS1jYW1lcmEuY29tPgpEYXRlOiBGcmksIDQgQXVnIDIwMjMgMTE6NTY6MDggKzAyMDAK
U3ViamVjdDogW1BBVENIXSBkb2M6IEFQUmFuZ2VzIGlzIGRlcHJlY2F0ZWQgKHVzZSBBUEFkZHJl
c3NQb29sIGluc3RlYWQpCgotLS0KIHNyYy9pd2QuY29uZmlnLnJzdCB8IDEwIC0tLS0tLS0tLS0K
IDEgZmlsZSBjaGFuZ2VkLCAxMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zcmMvaXdkLmNv
bmZpZy5yc3QgYi9zcmMvaXdkLmNvbmZpZy5yc3QKaW5kZXggMDBlMzFiNzIuLmVhMzY2YTgzIDEw
MDY0NAotLS0gYS9zcmMvaXdkLmNvbmZpZy5yc3QKKysrIGIvc3JjL2l3ZC5jb25maWcucnN0CkBA
IC03NCwxNiArNzQsNiBAQCBUaGUgZ3JvdXAgYGBbR2VuZXJhbF1gYCBjb250YWlucyBnZW5lcmFs
IHNldHRpbmdzLgogICAgICAgIGBgW05ldHdvcmtdYGAgc2V0dGluZ3MgZm9yIGFkZGl0aW9uYWwg
c2V0dGluZ3MgcmVsYXRlZCB0byBuZXR3b3JrCiAgICAgICAgY29uZmlndXJhdGlvbi4KIAotICAg
KiAtIEFQUmFuZ2VzCi0gICAgIC0gVmFsdWVzOiA8SVAgaW4gcHJlZml4IG5vdGF0aW9uPgotCi0g
ICAgICAgU2V0cyB0aGUgcmFuZ2Ugb2YgSVAncyB1c2VkIGZvciBESENQIHNlcnZlciAoQVAgbW9k
ZSkuIFRoZSBJUCBzaG91bGQgYmUKLSAgICAgICBpbiBwcmVmaXggbm90YXRpb24gZS5nLiAxOTIu
MTY4LjEuMC8yNC4gQVAncyB3aGljaCBhcmUgc3RhcnRlZCBpbiBhCi0gICAgICAgcHJvZmlsZS1s
ZXNzIGNvbmZpZ3VyYXRpb24gd2lsbCB1c2UgdGhpcyBwb29sIG9mIElQJ3MgdG8gc2V0IHRoZSBB
UCdzCi0gICAgICAgaW50ZXJmYWNlIGFkZHJlc3MgYXMgd2VsbCBhcyBkZWZhdWx0IERIQ1Agc2Vy
dmVyIG9wdGlvbnMuIEVhY2ggQVAgd2lsbAotICAgICAgIGdldCBhIG5ldyBzdWJuZXQgZnJvbSB0
aGUgcmFuZ2UgYW5kIGNsaWVudHMgd2lsbCBiZSBhZGRyZXNzZWQgaW4gdGhhdAotICAgICAgIHN1
Ym5ldCB0byBhdm9pZCBJUCBjb25mbGljdHMgaWYgbXVsdGlwbGUgQVAncyBhcmUgc3RhcnRlZC4K
LQogICAgKiAtIFVzZURlZmF1bHRJbnRlcmZhY2UKICAgICAgLSBWYWx1ZXM6IHRydWUsICoqZmFs
c2UqKgogCi0tIAoyLjI1LjEKCg==

--_004_AM7PR01MB6724106B9A0D096464D1DFA4AD09AAM7PR01MB6724eurp_--
