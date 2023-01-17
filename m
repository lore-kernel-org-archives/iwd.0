Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2052.outbound.protection.outlook.com [40.107.6.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B6F23A8
	for <iwd@lists.linux.dev>; Tue, 17 Jan 2023 10:56:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1Qv13uGxNcLSNb6w06TGZ1YrIRvsGGAWPjweouClMW4IqiiIiK5hTLxGK/+7VEHbdkch8OseNH6pmLaU0f5NMZ/dbJFquHuoS5rNbcRJWDau6ctDUTdxct5vBaGfyhVVq/kpKPS9ckfQaD1pTxSxgn5N9/D0oey1uPv77CgSxr8fx15bMQzJG96mirhO73drawjvgaje5Po9hzeg+mns0k6avndkiW2Ed0oojhysr1Y1ZBXkp17qPTcVjC68uwFzPoSRkxFjWauaVhUrQwEfu3m2aqqEEOyys5QcCf9SfGJ2EDFx0LHV24WFLi8OnqWPko48jKJLdlinMzEKML2QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EqvAfzIS+yn9O8bTix2d6gHXk89ZKMsTHPOnxt0MCY=;
 b=D/uB/VZdwcROVhmeRjzw7P7J+LgOnFVg/CL0vAvuTLyGQrG9HhjhaIKdg2oQWWNdHBN1mTMm9cA80u8mFNuBDWlnQbC00Ol0fhzhH35HiGNinafEQMX4s+uWYALsllAeA9Jlqzc0G11S5uwv5M+VIfHSyu2jxGsnZ1DryhpuuNvlv8/QKBIAfpHUq596U++nVnm/iSJ0EaZOduOl1a3izTct/eyVlnxIiZfiG7rdrDiAIjXIr5Cw7WSs+yFz7vqvli+Qe+wlNeM+FgoaUzWxiO//uoRb37oW1gVKAHSLnneTKXdsjBdl4j14b+K9wk9Q/P8yU46Tt+eP2as8eoia6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-camera.com; dmarc=pass action=none
 header.from=leica-camera.com; dkim=pass header.d=leica-camera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LCAG365.onmicrosoft.com; s=selector1-LCAG365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EqvAfzIS+yn9O8bTix2d6gHXk89ZKMsTHPOnxt0MCY=;
 b=piZjbMJtRY2rkLuLSw2RhYj1mBNPO30BpT7WI8Ih2UiQ06YvKTfCMhpHdfu1SnEM0l9DrfLfjPg4DGud03de8pEpL5zUfYsSZeY/8oEpbNYF/eqEl4DT74eWKMlOOXyiBNLiPrDzC9984FQeJf08Ubg0QjhS+osu5Cy7Njm//JM=
Received: from AM7PR01MB6724.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:18f::10) by PA4PR01MB9924.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:269::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.22; Tue, 17 Jan
 2023 10:55:58 +0000
Received: from AM7PR01MB6724.eurprd01.prod.exchangelabs.com
 ([fe80::38b:1804:168c:e497]) by AM7PR01MB6724.eurprd01.prod.exchangelabs.com
 ([fe80::38b:1804:168c:e497%9]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 10:55:58 +0000
From: "Altous, Salahaldeen" <Salahaldeen.Altous@leica-camera.com>
To: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Subject: IWD AP is not working with NXP (88W8997/88Q9098),  START_AP failed:
 -14
Thread-Topic: IWD AP is not working with NXP (88W8997/88Q9098),  START_AP
 failed: -14
Thread-Index: AQHZKX2YcWvbpYcoB0WREIMN2jhfmq6icOyu
Date: Tue, 17 Jan 2023 10:55:58 +0000
Message-ID:
 <AM7PR01MB67244F63EBEAB9A65D965BEAADC69@AM7PR01MB6724.eurprd01.prod.exchangelabs.com>
References:
 <AM7PR01MB672451F58D20BA27F874E4B2ADC19@AM7PR01MB6724.eurprd01.prod.exchangelabs.com>
In-Reply-To:
 <AM7PR01MB672451F58D20BA27F874E4B2ADC19@AM7PR01MB6724.eurprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-camera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR01MB6724:EE_|PA4PR01MB9924:EE_
x-ms-office365-filtering-correlation-id: db8496b9-9014-41a2-0023-08daf8796a86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 hZcfI3MzClVWv8uQhJVc768KsRCVb3ROAOzFgLsRzyJE01X0Jk9eBI2CTSvScixumg7YW6nqdhxmrd+/yd6TRGMPr3b72ASMcgYgc3NTBCXAp1I3tjuWaDjFjDsY6H3tyxcpMpO0d/OhShj4ejX8ELugLzLA5HsaHdbJADY2twjrwi+GRVIQC+cB/PQaNJpwGiOTkfGnnlkX9HJYLEvpG0sMTVAxJLtk9Lb6TERBKj8Drk7t3bW1R6Z4ezZkSaho8gkmgEd75ukzojyXk4WryJQhWrl+A4d72bWg2XHUH+PZ3sH7JTEUZ91UPhV4R6eVSBfPVN3sxg+zCGzBDHHR3HDnBvp1j/jexBA1dns+nSmiLRwxd9FOmtM4s0te9g//InlYN39s/uZVl05eb73m1Kq6nK64xUySwPtQtgNfTlNm8OncYUvlMmFJYR+nNk9mQAD0MTRIQGRqg7tmCl71lZXqIy6/zwFWFcLjMWuDD5EpO+5+WZpvwCKWpPDXU8JzqjcNau//ACBwQ4NyPz3OhaRHGLIQh7A/HVWGIUpb9UNwGcyx0eFoW6+Y2Iq6QkMU6g0oA4E2ifUhMIphvdqqVqF+idSuj2B543e1OTVXZTHMFJP276ZLkGGRaQD4SBeVqgs8DXxiacjQRTRv2Kii0ozZcdeweRba0iJWUYQpwVsua0HerN3PW/cKeB3AWl4p7Q+TwMWwCw0tYqGEYovh2w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR01MB6724.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(136003)(396003)(346002)(39850400004)(451199015)(33656002)(71200400001)(316002)(41300700001)(26005)(8676002)(66946007)(6916009)(64756008)(66556008)(66446008)(91956017)(76116006)(86362001)(83380400001)(66476007)(38070700005)(38100700002)(55016003)(478600001)(99936003)(122000001)(9686003)(7696005)(6506007)(186003)(19627405001)(2906002)(52536014)(8936002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?SXdZan8912bxzHIesPyn8MFIILJnWhxC1nLuLV/7QNTFW3BwMHcgZ4blBQ?=
 =?iso-8859-1?Q?UFkstUR9mZYwofxMH/w3pvR3SwYuDoWVVWX+ouSBst+pEhikm291t5gUtt?=
 =?iso-8859-1?Q?jIdcJpc28inDC2kRLS67pk1KqWcuWd7o7LKYbYJe67xUXYabdCdm0+/dk+?=
 =?iso-8859-1?Q?X/kbcEyANZyDMqKYloVc5jiTGKnC35aLoHse5pwHOLodozlKbGguesb3KH?=
 =?iso-8859-1?Q?wMiZf1FbY3X/CrJZrxYLDWtXee8O86Dq5079DVTg8qOW2YhGTFOjAIzTdw?=
 =?iso-8859-1?Q?avSLW1G+40S/HLs0uZSCKfRmUHh5N/Db/EUDY5Gqv/mfERb5tG+h9VTuCZ?=
 =?iso-8859-1?Q?i/i+8K/8bAsjlW/3oqJ6sufYq7Gctm0Prv5wjhvQ2UIsw/YOsbidaDprWj?=
 =?iso-8859-1?Q?PBekEtKLLxVm1Yw6DFB6ROy5ECCF8drQncmfvhVT81DMo9mjj+QyJK8MAa?=
 =?iso-8859-1?Q?zPI1vaA0M0k1FwzWa0c6wbGLO2g27NcKPOoI9kXt63dOxHklmTaon0oWKd?=
 =?iso-8859-1?Q?y1ikHJU5uWCcg8zmS2jrHuVS3qc+8TdT1PGtvyBO4nOv5qHBoInpLpr3CD?=
 =?iso-8859-1?Q?8JzqOfUKzzZR5SC5p1Gn9rzJHOME8JfedLFR31ZGPN125lPYgZKAzG5vDh?=
 =?iso-8859-1?Q?Q6lna1TBAenEdQWH37pwFmeVkObAqzx8TAp7GFTuKdyARw1yIhw6GFF7KT?=
 =?iso-8859-1?Q?x513KXlx7ADqkgZB2RViYvbEuNcBhnXN/wg2n+qUt234inwiCdUfw4KVJA?=
 =?iso-8859-1?Q?ReW6W2vELhXIMhjAupxnBPSnLYLZCWNZddDNzmnJGwZl2IdvHXhHaozj+c?=
 =?iso-8859-1?Q?xaXkXCwTDDVi9bxbMRgOCg2EjmF7mmzey0xQVlVpWzBkxdjegWhpya9S6k?=
 =?iso-8859-1?Q?vtTiYPYXz/n9JYT49/Cz7yG79yIBUQ8J9ZUoSpP3z6wLKEhfAg3aqgakWA?=
 =?iso-8859-1?Q?EAe/zUH2pcwl2xY9lHmYso4yc1znKxf/4YmtoVfsh9q+SjN6n7btAvASCe?=
 =?iso-8859-1?Q?evjRMAvZh7hAg+qZM/k2AP/Vw79siTcvcL2x8DcBWIFuhta7ozE5s/jtli?=
 =?iso-8859-1?Q?e0coBmj3aLz6OBG5CddiSlRlNmEAc9ssTN4YwSpkOovmd0P0CduOpcVZQT?=
 =?iso-8859-1?Q?kvDGUoIEqHj7zuk3nQ68SkvPIE2QC/f1tjYzLk23yyz0tL+hLy1NbMaJAj?=
 =?iso-8859-1?Q?YGF0LC0iirEHkS4Eo3isk2u2OG/JVFyJWlNLbYdwww8syOsv9R1STMogJ5?=
 =?iso-8859-1?Q?uvNxzvMIzdSQlFanvkyynE2XQAU8zySGVtuPh+Rrqy2yvZG5JlK4mo2ovF?=
 =?iso-8859-1?Q?zGyQFTX6hopKg5jrpsQpE37YGR9e2fSWQD3GMOuc7GIdM0eDLG6yuWOAyi?=
 =?iso-8859-1?Q?bA6MtfmIbvemcZSfjaP4So44YgjLdMEUUmGXGfKzkmeu1k2IsbqiJjDbP2?=
 =?iso-8859-1?Q?Buj8mQK4vdXmWwAgTN8j/lG1fCJOoW5KFOqNbhLb32Aw36TtzHyM2KHQae?=
 =?iso-8859-1?Q?xyiYzoCiWHbuyzh1GFeGkBY3QDmD6dpLUBweIV9QAKeAGuaaPPHZ5iS+La?=
 =?iso-8859-1?Q?92v8Rc9wtY8enhcdtIvpMVMdRy4aa+7jaWy7cLxAsXrFfLMxx+kel2x4Wb?=
 =?iso-8859-1?Q?AwnAZUL3rtUz/Zl007jKi7e/eYTMs5Hy+NNw5LYOQB1EP2krFhVMaGBXl/?=
 =?iso-8859-1?Q?iGCy/fsC5+im3VENdTA=3D?=
Content-Type: multipart/mixed;
	boundary="_004_AM7PR01MB67244F63EBEAB9A65D965BEAADC69AM7PR01MB6724eurp_"
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: leica-camera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR01MB6724.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db8496b9-9014-41a2-0023-08daf8796a86
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 10:55:58.7775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2f1272e4-e56c-4f8b-a516-94002dc07e0a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nxsD5K1GLcql+jZvaZcFCFYtRMQXsMcOO84Z/YbXbxL5/2wT4o6L6qE0L1++41kH0zdU7XaS+8Sl+O9Yfh2gTI5MFF1NHTBk+8yF4ytUHzv5NOTjPjjSiXolGakh2iGM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR01MB9924

--_004_AM7PR01MB67244F63EBEAB9A65D965BEAADC69AM7PR01MB6724eurp_
Content-Type: multipart/alternative;
	boundary="_000_AM7PR01MB67244F63EBEAB9A65D965BEAADC69AM7PR01MB6724eurp_"

--_000_AM7PR01MB67244F63EBEAB9A65D965BEAADC69AM7PR01MB6724eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,

I am testing now IWD-2.0 with an ublox module Jody-W377 (chipset NXP-Q9098)=
 and using the open-source driver from NXP (mwifiex), station mode is worki=
ng fine but I have problem with starting AP (CMD_RESP: cmd 0xb1 error, resu=
lt=3D0x1; START_AP failed: -14). I have in the past used the iwd with Qualc=
omm/Intel chipset with no problem. Does IWD support NXP-Q9098?
attached you can find the log from iwd and iwctl

can you please check what is the needed information from wlan driver and is=
 missing (not set) in mwifiex driver?

Also using 2 interfaces will fail when starting iwd and only one interface =
will be listed with device list

# /usr/libexec/iwd -i mlan0 -i uap0 &
Wireless daemon version 1.12
station: Network configuration is disabled.
Wiphy: 0, Name: mwiphy0
          Permanent Address: 20:4e:f6:bb:0c:2f
          Bands: 2.4 GHz 5 GHz
          Ciphers: CCMP TKIP BIP
          Supported iftypes: station ap p2p-client p2p-go
Wiphy mwiphy0 will only use the default interface

[Note]
If only starting iwd with uap0 , uap0 can be listed

[iwd]# device list
                                    Devices
---------------------------------------------------------------------------=
-----
  Name                  Address               Powered     Adapter     Mode
---------------------------------------------------------------------------=
-----
  uap0                  00:50:43:20:13:34     on          mwiphy0     ap


Best Regards,
Salahaldeen

--
Mit freundlichen Gruessen / kind regards

M.Sc Salahaldeen Altous
Senior Embedded Linux Developer

Leica Camera AG | Registergericht | District Court of Wetzlar: HRB966
Vorstand | Executive Board: Matthias Harsch (CEO) I Michael Grimm (CFO)
Aufsichtsratsvorsitzender | Chairman of the Supervisory Board: Dr. Andreas =
Kaufmann

This message may contain confidential and privileged information. If it has=
 been sent to you in error, please notify the sender immediately by replyin=
g to the message and please delete it from your computer.

--_000_AM7PR01MB67244F63EBEAB9A65D965BEAADC69AM7PR01MB6724eurp_
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
<div><span dir=3D"ltr" class=3D"x_uiOutputText x_FluidPluginCopy x_elementT=
oProof"><span class=3D"x_FluidPluginCopy x_ContentPasted0 x_elementToProof =
elementToProof" style=3D"color:rgb(29,28,29); font-family:Slack-Lato,Slack-=
Fractions,appleLogo,sans-serif; font-size:15px; font-variant-ligatures:comm=
on-ligatures; orphans:2; text-align:left; widows:2; background-color:rgb(25=
5,255,255); display:inline!important">Hi
 all, </span></span><br>
</div>
<div dir=3D"ltr">
<div><span dir=3D"ltr" class=3D"x_uiOutputText x_FluidPluginCopy x_elementT=
oProof"><span class=3D"x_FluidPluginCopy x_ContentPasted0 x_elementToProof =
elementToProof" style=3D"color:rgb(29,28,29); font-family:Slack-Lato,Slack-=
Fractions,appleLogo,sans-serif; font-size:15px; font-variant-ligatures:comm=
on-ligatures; orphans:2; text-align:left; widows:2; background-color:rgb(25=
5,255,255); display:inline!important"><br>
</span></span></div>
<div class=3D"x_elementToProof"><span dir=3D"ltr" class=3D"x_uiOutputText x=
_FluidPluginCopy x_elementToProof"><span class=3D"x_FluidPluginCopy x_Conte=
ntPasted0 x_elementToProof" style=3D"color:rgb(29,28,29); font-family:Slack=
-Lato,Slack-Fractions,appleLogo,sans-serif; font-size:15px; font-variant-li=
gatures:common-ligatures; orphans:2; text-align:left; widows:2; background-=
color:rgb(255,255,255); display:inline!important">I
 am testing now IWD-2.0 with an ublox module Jody-W377 (chipset NXP-Q9098) =
and using the open-source driver from NXP (mwifiex),
<b>station</b> mode is working fine but I have problem with starting AP (<b=
>CMD_RESP: cmd 0xb1 error, result=3D0x1; START_AP failed: -14</b>). I have =
in the past used the iwd with Qualcomm/Intel chipset with no problem. Does =
IWD support NXP-Q9098?
<br>
attached you can find the log from iwd and iwctl<br>
<br>
can you please check what is the needed information from wlan driver and is=
 missing (not set) in mwifiex driver?<br>
<br>
Also using 2 interfaces will fail when starting iwd and only one interface =
will be listed with device list<br>
<pre class=3D"x_c-mrkdwn__pre x_FluidPluginCopy x_ContentPasted1" data-stri=
ngify-type=3D"pre" style=3D"margin:4px 0px; padding:8px; font-size:12px; fo=
nt-variant-ligatures:none; line-height:1.50001; tab-size:4; font-family:Mon=
aco,Menlo,Consolas,&quot;Courier New&quot;,monospace!important; border-radi=
us:4px; counter-reset:list-0 0 list-1 0 list-2 0 list-3 0 list-4 0 list-5 0=
 list-6 0 list-7 0 list-8 0 list-9 0; orphans:2; widows:2"># /usr/libexec/i=
wd -i mlan0 -i uap0 &amp;=0A=
Wireless daemon version 1.12=0A=
station: Network configuration is disabled.=0A=
Wiphy: 0, Name: mwiphy0=0A=
          Permanent Address: 20:4e:f6:bb:0c:2f=0A=
          Bands: 2.4 GHz 5 GHz=0A=
          Ciphers: CCMP TKIP BIP=0A=
          Supported iftypes: station ap p2p-client p2p-go=0A=
<b>Wiphy mwiphy0 will only use the default interface</b></pre>
<div class=3D"x_p-rich_text_section x_FluidPluginCopy x_ContentPasted1" sty=
le=3D"counter-reset:list-0 0 list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 l=
ist-6 0 list-7 0 list-8 0 list-9 0; font-variant-ligatures:common-ligatures=
; orphans:2; widows:2; background-color:rgb(255,255,255)">
<span class=3D"x_c-mrkdwn__br" data-stringify-type=3D"paragraph-break" styl=
e=3D"display:block; height:8px"></span>[Note]<br class=3D"x_ContentPasted1"=
>
If only starting iwd with uap0 , uap0 can be listed<br class=3D"x_ContentPa=
sted1">
</div>
<pre class=3D"x_c-mrkdwn__pre x_FluidPluginCopy x_ContentPasted1" data-stri=
ngify-type=3D"pre" style=3D"margin:4px 0px; padding:8px; font-size:12px; fo=
nt-variant-ligatures:none; line-height:1.50001; tab-size:4; font-family:Mon=
aco,Menlo,Consolas,&quot;Courier New&quot;,monospace!important; border-radi=
us:4px; counter-reset:list-0 0 list-1 0 list-2 0 list-3 0 list-4 0 list-5 0=
 list-6 0 list-7 0 list-8 0 list-9 0; orphans:2; widows:2">[iwd]# device li=
st =0A=
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Devices &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=0A=
---------------------------------------------------------------------------=
-----=0A=
&nbsp; Name &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;A=
ddress &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Powered &nbsp; &nbs=
p; Adapter &nbsp; &nbsp; Mode &nbsp; &nbsp; &nbsp;=0A=
---------------------------------------------------------------------------=
-----=0A=
&nbsp; uap0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0=
0:50:43:20:13:34 &nbsp; &nbsp; on &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;mwiphy0=
 &nbsp; &nbsp; ap &nbsp; </pre>
<br>
</span></span></div>
<div class=3D"x_elementToProof"><span dir=3D"ltr" class=3D"x_uiOutputText x=
_FluidPluginCopy x_elementToProof"><span class=3D"x_FluidPluginCopy x_Conte=
ntPasted0 x_elementToProof" style=3D"color:rgb(29,28,29); font-family:Slack=
-Lato,Slack-Fractions,appleLogo,sans-serif; font-size:15px; font-variant-li=
gatures:common-ligatures; orphans:2; text-align:left; widows:2; background-=
color:rgb(255,255,255); display:inline!important"><br>
Best Regards,<br>
Salahaldeen<br>
</span></span></div>
<div class=3D"x_elementToProof">
<div class=3D"x_elementToProof" style=3D"font-family:Calibri,Arial,Helvetic=
a,sans-serif; font-size:12pt; color:rgb(0,0,0)">
<br>
</div>
<div id=3D"x_Signature">
<div><span dir=3D"ltr" style=3D"font-size:12pt; color:#000000; font-family:=
Calibri,Helvetica,sans-serif"><font size=3D"2"><span style=3D"font-size:10p=
t">--
<br>
</span></font></span>
<div dir=3D"ltr" style=3D"font-size:12pt; color:#000000; font-family:Calibr=
i,Helvetica,sans-serif">
<font size=3D"2"><span style=3D"font-size:10pt">Mit freundlichen Gruessen /=
 kind regards<br>
<br>
M.Sc Salahaldeen Altous<br>
Senior Embedded Linux Developer<br>
</span></font></div>
</div>
</div>
</div>
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

--_000_AM7PR01MB67244F63EBEAB9A65D965BEAADC69AM7PR01MB6724eurp_--

--_004_AM7PR01MB67244F63EBEAB9A65D965BEAADC69AM7PR01MB6724eurp_
Content-Type: text/plain; name="AP-failed-NXP-Q9098PCIe-iwd2.0.txt"
Content-Description: AP-failed-NXP-Q9098PCIe-iwd2.0.txt
Content-Disposition: attachment;
	filename="AP-failed-NXP-Q9098PCIe-iwd2.0.txt"; size=8489;
	creation-date="Mon, 16 Jan 2023 07:45:34 GMT";
	modification-date="Tue, 17 Jan 2023 10:53:37 GMT"
Content-Transfer-Encoding: base64

c2gtNS4wIyBsc3BjaSAtawowMDAwOjAwOjAwLjAgUENJIGJyaWRnZTogRGV2aWNlIDUwYzE6MDAw
MCAocmV2IDAxKQogICAgICAgIEtlcm5lbCBkcml2ZXIgaW4gdXNlOiBwY2llcG9ydAowMDAxOjAw
OjAwLjAgUENJIGJyaWRnZTogRGV2aWNlIDUwYzE6MDAwMCAocmV2IDAxKQogICAgICAgIEtlcm5l
bCBkcml2ZXIgaW4gdXNlOiBwY2llcG9ydAowMDAxOjAxOjAwLjAgRXRoZXJuZXQgY29udHJvbGxl
cjogTWFydmVsbCBUZWNobm9sb2d5IEdyb3VwIEx0ZC4gRGV2aWNlIDJiNDMgKHJldiAwMykKICAg
ICAgICBTdWJzeXN0ZW06IE1hcnZlbGwgVGVjaG5vbG9neSBHcm91cCBMdGQuIERldmljZSAyYjQz
CiAgICAgICAgS2VybmVsIGRyaXZlciBpbiB1c2U6IHdsYW5fcGNpZQowMDAxOjAxOjAwLjEgRXRo
ZXJuZXQgY29udHJvbGxlcjogTWFydmVsbCBUZWNobm9sb2d5IEdyb3VwIEx0ZC4gRGV2aWNlIDJi
NDQgKHJldiAwMykKICAgICAgICBTdWJzeXN0ZW06IE1hcnZlbGwgVGVjaG5vbG9neSBHcm91cCBM
dGQuIERldmljZSAyYjQ0CiAgICAgICAgS2VybmVsIGRyaXZlciBpbiB1c2U6IHdsYW5fcGNpZQow
MDAxOjAxOjAwLjIgQmx1ZXRvb3RoOiBNYXJ2ZWxsIFRlY2hub2xvZ3kgR3JvdXAgTHRkLiBEZXZp
Y2UgMmI0NSAocmV2IDAzKQogICAgICAgIFN1YnN5c3RlbTogTWFydmVsbCBUZWNobm9sb2d5IEdy
b3VwIEx0ZC4gRGV2aWNlIDJiNDUKc2gtNS4wIyB1bmFtZSAtYQpMaW51eCBtbGJlbCA0LjE5LjEy
NCAjOSBTTVAgRnJpIEphbiAxMyAwOTowODozOCBDRVQgMjAyMyBhYXJjaDY0IEdOVS9MaW51eApz
aC01LjAjIApzaC01LjAjIApzaC01LjAjIGlmY29uZmlnIApsbyAgICAgICAgTGluayBlbmNhcDpM
b2NhbCBMb29wYmFjayAgCiAgICAgICAgICBpbmV0IGFkZHI6MTI3LjAuMC4xICBNYXNrOjI1NS4w
LjAuMAogICAgICAgICAgaW5ldDYgYWRkcjogOjoxLzEyOCBTY29wZTpIb3N0CiAgICAgICAgICBV
UCBMT09QQkFDSyBSVU5OSU5HICBNVFU6NjU1MzYgIE1ldHJpYzoxCiAgICAgICAgICBSWCBwYWNr
ZXRzOjAgZXJyb3JzOjAgZHJvcHBlZDowIG92ZXJydW5zOjAgZnJhbWU6MAogICAgICAgICAgVFgg
cGFja2V0czowIGVycm9yczowIGRyb3BwZWQ6MCBvdmVycnVuczowIGNhcnJpZXI6MAogICAgICAg
ICAgY29sbGlzaW9uczowIHR4cXVldWVsZW46MTAwMCAKICAgICAgICAgIFJYIGJ5dGVzOjAgKDAu
MCBCKSAgVFggYnl0ZXM6MCAoMC4wIEIpCgptbGFuMCAgICAgTGluayBlbmNhcDpFdGhlcm5ldCAg
SFdhZGRyIDAwOjUwOjQzOjIwOjEyOjM0ICAKICAgICAgICAgIFVQIEJST0FEQ0FTVCBNVUxUSUNB
U1QgIE1UVToxNTAwICBNZXRyaWM6MQogICAgICAgICAgUlggcGFja2V0czowIGVycm9yczowIGRy
b3BwZWQ6MCBvdmVycnVuczowIGZyYW1lOjAKICAgICAgICAgIFRYIHBhY2tldHM6MCBlcnJvcnM6
MCBkcm9wcGVkOjAgb3ZlcnJ1bnM6MCBjYXJyaWVyOjAKICAgICAgICAgIGNvbGxpc2lvbnM6MCB0
eHF1ZXVlbGVuOjEwMDAgCiAgICAgICAgICBSWCBieXRlczowICgwLjAgQikgIFRYIGJ5dGVzOjAg
KDAuMCBCKQoKbW1sYW4wICAgIExpbmsgZW5jYXA6RXRoZXJuZXQgIEhXYWRkciAwMDo1MDo0Mzoy
MDo1Mjo1NiAgCiAgICAgICAgICBVUCBCUk9BRENBU1QgTVVMVElDQVNUICBNVFU6MTUwMCAgTWV0
cmljOjEKICAgICAgICAgIFJYIHBhY2tldHM6MCBlcnJvcnM6MCBkcm9wcGVkOjAgb3ZlcnJ1bnM6
MCBmcmFtZTowCiAgICAgICAgICBUWCBwYWNrZXRzOjAgZXJyb3JzOjAgZHJvcHBlZDowIG92ZXJy
dW5zOjAgY2FycmllcjowCiAgICAgICAgICBjb2xsaXNpb25zOjAgdHhxdWV1ZWxlbjoxMDAwIAog
ICAgICAgICAgUlggYnl0ZXM6MCAoMC4wIEIpICBUWCBieXRlczowICgwLjAgQikKCm11YXAwICAg
ICBMaW5rIGVuY2FwOkV0aGVybmV0ICBIV2FkZHIgMDA6NTA6NDM6MjA6NTM6NTYgIAogICAgICAg
ICAgVVAgQlJPQURDQVNUIE1VTFRJQ0FTVCAgTVRVOjE1MDAgIE1ldHJpYzoxCiAgICAgICAgICBS
WCBwYWNrZXRzOjAgZXJyb3JzOjAgZHJvcHBlZDowIG92ZXJydW5zOjAgZnJhbWU6MAogICAgICAg
ICAgVFggcGFja2V0czowIGVycm9yczowIGRyb3BwZWQ6MCBvdmVycnVuczowIGNhcnJpZXI6MAog
ICAgICAgICAgY29sbGlzaW9uczowIHR4cXVldWVsZW46MTAwMCAKICAgICAgICAgIFJYIGJ5dGVz
OjAgKDAuMCBCKSAgVFggYnl0ZXM6MCAoMC4wIEIpCgptd2ZkMCAgICAgTGluayBlbmNhcDpFdGhl
cm5ldCAgSFdhZGRyIDAyOjUwOjQzOjIwOjUyOjU2ICAKICAgICAgICAgIFVQIEJST0FEQ0FTVCBN
VUxUSUNBU1QgIE1UVToxNTAwICBNZXRyaWM6MQogICAgICAgICAgUlggcGFja2V0czowIGVycm9y
czowIGRyb3BwZWQ6MCBvdmVycnVuczowIGZyYW1lOjAKICAgICAgICAgIFRYIHBhY2tldHM6MCBl
cnJvcnM6MCBkcm9wcGVkOjAgb3ZlcnJ1bnM6MCBjYXJyaWVyOjAKICAgICAgICAgIGNvbGxpc2lv
bnM6MCB0eHF1ZXVlbGVuOjEwMDAgCiAgICAgICAgICBSWCBieXRlczowICgwLjAgQikgIFRYIGJ5
dGVzOjAgKDAuMCBCKQoKdWFwMCAgICAgIExpbmsgZW5jYXA6RXRoZXJuZXQgIEhXYWRkciAwMDo1
MDo0MzoyMDoxMzozNCAgCiAgICAgICAgICBVUCBCUk9BRENBU1QgTVVMVElDQVNUICBNVFU6MTUw
MCAgTWV0cmljOjEKICAgICAgICAgIFJYIHBhY2tldHM6MCBlcnJvcnM6MCBkcm9wcGVkOjAgb3Zl
cnJ1bnM6MCBmcmFtZTowCiAgICAgICAgICBUWCBwYWNrZXRzOjAgZXJyb3JzOjAgZHJvcHBlZDow
IG92ZXJydW5zOjAgY2FycmllcjowCiAgICAgICAgICBjb2xsaXNpb25zOjAgdHhxdWV1ZWxlbjox
MDAwIAogICAgICAgICAgUlggYnl0ZXM6MCAoMC4wIEIpICBUWCBieXRlczowICgwLjAgQikKCndm
ZDAgICAgICBMaW5rIGVuY2FwOkV0aGVybmV0ICBIV2FkZHIgMDI6NTA6NDM6MjA6MTI6MzQgIAog
ICAgICAgICAgVVAgQlJPQURDQVNUIE1VTFRJQ0FTVCAgTVRVOjE1MDAgIE1ldHJpYzoxCiAgICAg
ICAgICBSWCBwYWNrZXRzOjAgZXJyb3JzOjAgZHJvcHBlZDowIG92ZXJydW5zOjAgZnJhbWU6MAog
ICAgICAgICAgVFggcGFja2V0czowIGVycm9yczowIGRyb3BwZWQ6MCBvdmVycnVuczowIGNhcnJp
ZXI6MAogICAgICAgICAgY29sbGlzaW9uczowIHR4cXVldWVsZW46MTAwMCAKICAgICAgICAgIFJY
IGJ5dGVzOjAgKDAuMCBCKSAgVFggYnl0ZXM6MCAoMC4wIEIpCgpzaC01LjAjIC91c3IvbGliZXhl
Yy9pd2QgLWkgdWFwMCAmClsxXSAxNzYKc2gtNS4wIyBObyBhc3ltbWV0cmljIGtleSBzdXBwb3J0
IGZvdW5kLgpUTFMgYmFzZWQgV1BBLUVudGVycHJpc2UgYXV0aGVudGljYXRpb24gbWV0aG9kcyB3
aWxsIG5vdCBmdW5jdGlvbi4KS2VybmVsIDQuMjArIGlzIHJlcXVpcmVkIGZvciB0aGlzIGZlYXR1
cmUuClRoZSBmb2xsb3dpbmcgb3B0aW9ucyBhcmUgbWlzc2luZyBpbiB0aGUga2VybmVsOgogICAg
ICAgIENPTkZJR19BU1lNTUVUUklDX0tFWV9UWVBFCiAgICAgICAgQ09ORklHX0FTWU1NRVRSSUNf
UFVCTElDX0tFWV9TVUJUWVBFCiAgICAgICAgQ09ORklHX1BLQ1M3X01FU1NBR0VfUEFbICAgNTEu
NDMyNzIyXSBJUHY2OiBBRERSQ09ORihORVRERVZfVVApOiB1YXAwOiBsaW5rIGlzIG5vdCByZWFk
eQpSU0VSCiAgICAgICAgQ09ORklHX1g1MDlfQ0VSVElGSUNBVEVfUEFSU0VSCiAgICAgICAgQ09O
RklHX1BLQ1M4X1BSSVZBVEVfS0VZX1BBUlNFUgpXaXJlbGVzcyBkYWVtb24gdmVyc2lvbiAyLjAK
TG9hZGVkIGNvbmZpZ3VyYXRpb24gZnJvbSAvZXRjL2l3ZC9tYWluLmNvbmYKV2lwaHk6IDEsIE5h
bWU6IG13aXBoeTEKICAgICAgICBQZXJtYW5lbnQgQWRkcmVzczogNjA6MDk6YzM6ODA6MzQ6OGUK
ICAgICAgICAyLjRHaHogQmFuZDoKICAgICAgICAgICAgICAgIEJpdHJhdGVzIChub24tSFQpOgog
ICAgICAgICAgICAgICAgICAgICAgICAgMS4wIE1icHMKICAgICAgICAgICAgICAgICAgICAgICAg
IDIuMCBNYnBzCiAgICAgICAgICAgICAgICAgICAgICAgICA1LjUgTWJwcwogICAgICAgICAgICAg
ICAgICAgICAgICAxMS4wIE1icHMKICAgICAgICAgICAgICAgICAgICAgICAgIDYuMCBNYnBzCiAg
ICAgICAgICAgICAgICAgICAgICAgICA5LjAgTWJwcwogICAgICAgICAgICAgICAgICAgICAgICAx
Mi4wIE1icHMKICAgICAgICAgICAgICAgICAgICAgICAgMTguMCBNYnBzCiAgICAgICAgICAgICAg
ICAgICAgICAgIDI0LjAgTWJwcwogICAgICAgICAgICAgICAgICAgICAgICAzNi4wIE1icHMKICAg
ICAgICAgICAgICAgICAgICAgICAgNDguMCBNYnBzCiAgICAgICAgICAgICAgICAgICAgICAgIDU0
LjAgTWJwcwogICAgICAgICAgICAgICAgSFQgQ2FwYWJpbGl0aWVzOgogICAgICAgICAgICAgICAg
ICAgICAgICBIVDQwCiAgICAgICAgICAgICAgICAgICAgICAgIFNob3J0IEdJIGZvciAyME1oegog
ICAgICAgICAgICAgICAgICAgICAgICBTaG9ydCBHSSBmb3IgNDBNaHoKICAgICAgICAgICAgICAg
IEhUIFJYIE1DUyBpbmRleGVzOgogICAgICAgICAgICAgICAgICAgICAgICAwLTE1CiAgICAgICAg
ICAgICAgICAgICAgICAgIDMyCiAgICAgICAgICAgICAgICBWSFQgQ2FwYWJpbGl0aWVzOgogICAg
ICAgICAgICAgICAgICAgICAgICBTaG9ydCBHSSBmb3IgODBNaHoKICAgICAgICAgICAgICAgICAg
ICAgICAgTWF4IFJYIE1DUzogMC05IGZvciBOU1M6IDIKICAgICAgICAgICAgICAgICAgICAgICAg
TWF4IFRYIE1DUzogMC05IGZvciBOU1M6IDIKICAgICAgICA1R2h6IEJhbmQ6CiAgICAgICAgICAg
ICAgICBCaXRyYXRlcyAobm9uLUhUKToKICAgICAgICAgICAgICAgICAgICAgICAgIDYuMCBNYnBz
CiAgICAgICAgICAgICAgICAgICAgICAgICA5LjAgTWJwcwogICAgICAgICAgICAgICAgICAgICAg
ICAxMi4wIE1icHMKICAgICAgICAgICAgICAgICAgICAgICAgMTguMCBNYnBzCiAgICAgICAgICAg
ICAgICAgICAgICAgIDI0LjAgTWJwcwogICAgICAgICAgICAgICAgICAgICAgICAzNi4wIE1icHMK
ICAgICAgICAgICAgICAgICAgICAgICAgNDguMCBNYnBzCiAgICAgICAgICAgICAgICAgICAgICAg
IDU0LjAgTWJwcwogICAgICAgICAgICAgICAgSFQgQ2FwYWJpbGl0aWVzOgogICAgICAgICAgICAg
ICAgICAgICAgICBIVDQwCiAgICAgICAgICAgICAgICAgICAgICAgIFNob3J0IEdJIGZvciAyME1o
egogICAgICAgICAgICAgICAgICAgICAgICBTaG9ydCBHSSBmb3IgNDBNaHoKICAgICAgICAgICAg
ICAgIEhUIFJYIE1DUyBpbmRleGVzOgogICAgICAgICAgICAgICAgICAgICAgICAwLTE1CiAgICAg
ICAgICAgICAgICAgICAgICAgIDMyCiAgICAgICAgICAgICAgICBWSFQgQ2FwYWJpbGl0aWVzOgog
ICAgICAgICAgICAgICAgICAgICAgICBTaG9ydCBHSSBmb3IgODBNaHoKICAgICAgICAgICAgICAg
ICAgICAgICAgTWF4IFJYIE1DUzogMC05IGZvciBOU1M6IDIKICAgICAgICAgICAgICAgICAgICAg
ICAgTWF4IFRYIE1DUzogMC05IGZvciBOU1M6IDIKICAgICAgICBDaXBoZXJzOiBCSVAtR01BQy0y
NTYgQklQLUdNQUMtMTI4IENDTVAtMjU2IEdDTVAtMjU2CiAgICAgICAgICAgICAgICAgR0NNUC0x
MjggQklQLUNNQUMtMTI4IENDTVAtMTI4IFRLSVAKICAgICAgICBTdXBwb3J0ZWQgaWZ0eXBlczog
c3RhdGlvbiBhcCBwMnAtY2xpZW50IHAycC1nbwpXaXBoeSBtd2lwaHkxIHdpbGwgb25seSB1c2Ug
dGhlIGRlZmF1bHQgaW50ZXJmYWNlCldpcGh5OiAwLCBOYW1lOiBtd2lwaHkwCiAgICAgICAgUGVy
bWFuZW50IEFkZHJlc3M6IDYwOjA5OmMzOjgwOjM0OjhkCiAgICAgICAgMi40R2h6IEJhbmQ6CiAg
ICAgICAgICAgICAgICBCaXRyYXRlcyAobm9uLUhUKToKICAgICAgICAgICAgICAgICAgICAgICAg
IDEuMCBNYnBzCiAgICAgICAgICAgICAgICAgICAgICAgICAyLjAgTWJwcwogICAgICAgICAgICAg
ICAgICAgICAgICAgNS41IE1icHMKICAgICAgICAgICAgICAgICAgICAgICAgMTEuMCBNYnBzCiAg
ICAgICAgICAgICAgICAgICAgICAgICA2LjAgTWJwcwogICAgICAgICAgICAgICAgICAgICAgICAg
OS4wIE1icHMKICAgICAgICAgICAgICAgICAgICAgICAgMTIuMCBNYnBzCiAgICAgICAgICAgICAg
ICAgICAgICAgIDE4LjAgTWJwcwogICAgICAgICAgICAgICAgICAgICAgICAyNC4wIE1icHMKICAg
ICAgICAgICAgICAgICAgICAgICAgMzYuMCBNYnBzCiAgICAgICAgICAgICAgICAgICAgICAgIDQ4
LjAgTWJwcwogICAgICAgICAgICAgICAgICAgICAgICA1NC4wIE1icHMKICAgICAgICAgICAgICAg
IEhUIENhcGFiaWxpdGllczoKICAgICAgICAgICAgICAgICAgICAgICAgSFQ0MAogICAgICAgICAg
ICAgICAgICAgICAgICBTaG9ydCBHSSBmb3IgMjBNaHoKICAgICAgICAgICAgICAgICAgICAgICAg
U2hvcnQgR0kgZm9yIDQwTWh6CiAgICAgICAgICAgICAgICBIVCBSWCBNQ1MgaW5kZXhlczoKICAg
ICAgICAgICAgICAgICAgICAgICAgMC0xNQogICAgICAgICAgICAgICAgICAgICAgICAzMgogICAg
ICAgICAgICAgICAgVkhUIENhcGFiaWxpdGllczoKICAgICAgICAgICAgICAgICAgICAgICAgU2hv
cnQgR0kgZm9yIDgwTWh6CiAgICAgICAgICAgICAgICAgICAgICAgIE1heCBSWCBNQ1M6IDAtOSBm
b3IgTlNTOiAyCiAgICAgICAgICAgICAgICAgICAgICAgIE1heCBUWCBNQ1M6IDAtOSBmb3IgTlNT
OiAyCiAgICAgICAgNUdoeiBCYW5kOgogICAgICAgICAgICAgICAgQml0cmF0ZXMgKG5vbi1IVCk6
CiAgICAgICAgICAgICAgICAgICAgICAgICA2LjAgTWJwcwogICAgICAgICAgICAgICAgICAgICAg
ICAgOS4wIE1icHMKICAgICAgICAgICAgICAgICAgICAgICAgMTIuMCBNYnBzCiAgICAgICAgICAg
ICAgICAgICAgICAgIDE4LjAgTWJwcwogICAgICAgICAgICAgICAgICAgICAgICAyNC4wIE1icHMK
ICAgICAgICAgICAgICAgICAgICAgICAgMzYuMCBNYnBzCiAgICAgICAgICAgICAgICAgICAgICAg
IDQ4LjAgTWJwcwogICAgICAgICAgICAgICAgICAgICAgICA1NC4wIE1icHMKICAgICAgICAgICAg
ICAgIEhUIENhcGFiaWxpdGllczoKICAgICAgICAgICAgICAgICAgICAgICAgSFQ0MAogICAgICAg
ICAgICAgICAgICAgICAgICBTaG9ydCBHSSBmb3IgMjBNaHoKICAgICAgICAgICAgICAgICAgICAg
ICAgU2hvcnQgR0kgZm9yIDQwTWh6CiAgICAgICAgICAgICAgICBIVCBSWCBNQ1MgaW5kZXhlczoK
ICAgICAgICAgICAgICAgICAgICAgICAgMC0xNQogICAgICAgICAgICAgICAgICAgICAgICAzMgog
ICAgICAgICAgICAgICAgVkhUIENhcGFiaWxpdGllczoKICAgICAgICAgICAgICAgICAgICAgICAg
U2hvcnQgR0kgZm9yIDgwTWh6CiAgICAgICAgICAgICAgICAgICAgICAgIE1heCBSWCBNQ1M6IDAt
OSBmb3IgTlNTOiAyCiAgICAgICAgICAgICAgICAgICAgICAgIE1heCBUWCBNQ1M6IDAtOSBmb3Ig
TlNTOiAyCiAgICAgICAgQ2lwaGVyczogQklQLUdNQUMtMjU2IEJJUC1HTUFDLTEyOCBDQ01QLTI1
NiBHQ01QLTI1NgogICAgICAgICAgICAgICAgIEdDTVAtMTI4IEJJUC1DTUFDLTEyOCBDQ01QLTEy
OCBUS0lQCiAgICAgICAgU3VwcG9ydGVkIGlmdHlwZXM6IHN0YXRpb24gYXAgcDJwLWNsaWVudCBw
MnAtZ28KV2lwaHkgbXdpcGh5MCB3aWxsIG9ubHkgdXNlIHRoZSBkZWZhdWx0IGludGVyZmFjZQpO
byBkZWZhdWx0IGludGVyZmFjZSBmb3Igd2lwaHkgMQoKc2gtNS4wIyAKc2gtNS4wIyBpd2N0bCAK
QXV0by1yZWZyZXNoIGlzIGRpc2FibGVkLiBFbmxhcmdlIHdpbmRvdyB3aWR0aCB0byBhdCBsZWFz
dCA4MCB0byBlbmFibGUuCk5ldHdvcmtDb25maWd1cmF0aW9uRW5hYmxlZDogZW5hYmxlZApTdGF0
ZURpcmVjdG9yeTogL3Zhci9saWIvaXdkClZlcnNpb246IDIuMApbaXdkXSMgZGV2aWNlIGxpc3Qg
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIERldmljZXMgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KICBOYW1lICAg
ICAgICAgICAgICAgICAgQWRkcmVzcyAgICAgICAgICAgICAgIFBvd2VyZWQgICAgIEFkYXB0ZXIg
ICAgIE1vZGUgICAgICAKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KICB1YXAwICAgICAgICAgICAg
ICAgICAgMDA6NTA6NDM6MjA6MTM6MzQgICAgIG9uICAgICAgICAgIG13aXBoeTAgICAgIGFwICAg
ICAgICAgIAoKW2l3ZF0jIGFwIHVhcDAgc3RhcnQgVEVTVCAxMjM0NTY3OApbaXdkXSMgWyAgIDgx
LjU2NTM3OV0gd2xhbjogU3RhcnRpbmcgQVAKWyAgIDgxLjU3NjAzOV0gQ01EX1JFU1A6IGNtZCAw
eGIxIGVycm9yLCByZXN1bHQ9MHgxClsgICA4MS41ODA1NDJdIElPQ1RMIGZhaWxlZDogMDAwMDAw
MDA5NjllMTFlMCBpZD0weDIwMDAwLCBzdWJfaWQ9MHgyMDAwMSBhY3Rpb249MSwgc3RhdHVzX2Nv
ZGU9MHgxClNUQVJUX0FQIGZhaWxlZDogLTE0Ck9wZXJhdGlvbiBmYWlsZWQKW2l3ZF0jIAo=

--_004_AM7PR01MB67244F63EBEAB9A65D965BEAADC69AM7PR01MB6724eurp_--
