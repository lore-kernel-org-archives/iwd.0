Received: from sewfire.sew-eurodrive.com (sewfire.sew-eurodrive.com [194.180.1.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060141BFDF7
	for <iwd@lists.linux.dev>; Thu, 10 Oct 2024 14:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.180.1.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728568842; cv=none; b=ZEVbhFfaT83SMGNjaoCD/6lWJOgyMrg17qQ1Uk8a1nqNnbdRXJ48dv+yOalSONFsGhxBpZz//Pg4v/UCS/jcqU/Ag1yREynyi+lgnvkgSJrngw9QITRWpWyDdiE2LTo0EVo781bfG0qrWKUcndxsqcHeQds+UKH7+XUvwrXfQTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728568842; c=relaxed/simple;
	bh=Q9jLjvCn9lSM/sN01LVeWg3ILCBVzGETwC7HAixtApM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XdG7JqcmSjTNagCbqlvcsyENAtTL9b8arB7il77xb5YG3QK0P6tgVm/ESyjDsbnbYxA6zeuE2YoMcwi3Z2Y8ZdZQKw5OfZyA6olArTAfu3fRNidqdyGnvbZjfHnkK6UStwdfvFma2O3oOt4ufSkmbAI0BwOhiz96lSgA87KUUdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sew-eurodrive.de; spf=pass smtp.mailfrom=sew-eurodrive.de; dkim=pass (2048-bit key) header.d=sew-eurodrive.de header.i=@sew-eurodrive.de header.b=Me8SWWhN; arc=none smtp.client-ip=194.180.1.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sew-eurodrive.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sew-eurodrive.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sew-eurodrive.de header.i=@sew-eurodrive.de header.b="Me8SWWhN"
Received: from pps.filterd (sewfire.sew-eurodrive.com [127.0.0.1])
	by sewfire.sew-eurodrive.com (8.18.1.2/8.18.1.2) with ESMTP id 49AChDaI025418
	for <iwd@lists.linux.dev>; Thu, 10 Oct 2024 15:49:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sew-eurodrive.de;
 h=content-transfer-encoding : content-type : date : from : message-id :
 mime-version : subject : to; s=sew1;
 bh=lWouNVMT8zAqghOqVNJTZ9AkoTlgoZgErIqWgKJhNCs=;
 b=Me8SWWhN4Vk72qx/W4W3OmyCBgN/kkyfSiTYBtEBIaI8AijlYoiKlSw/tYHeNOUTxjo9
 AM8xDt1GQfc+UharO4fWHH61eTzzwONap5B1Q3SZmDW+LvNMLy6sJe7KgksDv4bex0xw
 yL4qFq7bkUTlh+Bz30Jdo3qmmUw3bisvZxxr5E/5H6TThOUT1PCwdtrbrvf5Ups9D7Az
 1tk31RnF2Sr5L/d7NQk1Gsid5VLr3ZJS2IGEZ6J6Su2eTWmj4xSX5Je4mwTuXbeahg4h
 1LtS6AWb7/yKgoDdkQApGwDbUA9mVyD10ECBAAd52hnbxa89L+1f2fJe5eAmxnO4Wy1Y rA== 
X-PGP-Universal: processed;
	by brudepgp2.de.eu.sew on Thu, 10 Oct 2024 15:49:55 +0200
From: <Dierk.Modrow@sew-eurodrive.de>
To: <prestwoj@gmail.com>, <iwd@lists.linux.dev>
Subject: AW: IWD 2.20 does not support Fast Roaming with NXP 88W9098 chipset
Thread-Topic: IWD 2.20 does not support Fast Roaming with NXP 88W9098 chipset
Thread-Index: Adsa51JuwNri5SA8SMa+fbi0XqaCYwACprlQAABF/rAACglzwA==
Date: Thu, 10 Oct 2024 13:49:54 +0000
Message-ID: <5c65040719764a49a48846ea11c535a7@sew-eurodrive.de>
Accept-Language: de-DE, en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-organizationbypassclutter: true
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OLX-Disclaimer: DEBRUMSX24.DE.EU.SEW
Content-Language: de-DE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_11,2024-10-10_01,2024-09-30_01

Hello James,

we tried to implement 802.11r roaming with IWD 2.20 using a NXP 88W9098 chi=
pset from H&D Wireless as client (using out of kernel tree driver of NXP mo=
al/mlan -> FULLMAC) and failed.

First problem seems to be an error 'iwd[28112]: Could not register frame wa=
tch type 00b0: -22'
It's the call netdev[5540]:       frame_watch_add(wdev, 0, 0x00b0, auth_ft_=
response_prefix,
                                                sizeof(auth_ft_response_pre=
fix),
                                                netdev_ft_auth_response_fra=
me_event, netdev, NULL);

I traced it through kernel /net/wireless to cfg802_11 and the NXP driver an=
d found a problem in the driver capabilities setting so that NL8011CMD_REGI=
STER request was already denied in the kernel.
(see analysis_register_frame_type.txt). Having applied the patch zz_ft_auth=
_register_bug.patch to the driver the error above has gone.

PROBLEM

The first association with the FT-enabled AP is ok, but when the first FT-a=
uthentication occurs, it fails with

Sep 26 13:00:34 sew-mnc-51321 iwd[28112]: ../iwd/src/ft.c:ft_send_authentic=
ate()
Sep 26 13:00:34 sew-mnc-51321 iwd[28112]: ../iwd/src/netdev.c:netdev_ft_fra=
me_cb() Failed to send FT-Frame

In IWMON-log the NL8011CMD_FRAME with the FT authentication.req fails with =
EINVAL:

Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]: < Request: Frame (0x3b) len 200=
 [ack]                                 30.060808
Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:     Interface Index: 9 (0x00000=
009)
Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:     Wiphy Frequency: 5240 (0x00=
001478)
Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:     Frame: len 173
Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:         Frame Type: 0x00b0
Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:             Type: Management (0=
)
Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:             Authentication:
Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:                 Frame Control: =
protocol: 00 type: 00 subtype: 11 to: 00 from: 00 more_frags: 00
Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:                     retry: 00 p=
ower_mgmt: 00 more_data: 00 protected: 00 order: 00
Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:                 Duration: 0
Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:                 Address 1 (RA):=
 38:4B:24:96:05:38
Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:                 Address 2 (TA):=
 78:C4:0E:E0:18:60
Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:                 Address 3: 38:4=
B:24:96:05:38
Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:                 Fragment Number=
: 0
Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:                 Sequence Number=
: 0
Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:                 Algorithm: FT (=
seq: 1, status: 0)
Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:         b0 00 00 00 38 4b 24 96=
 05 38 78 c4 0e e0 18 60  ....8K$..8x....`
Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:         38 4b 24 96 05 38 00 00=
 02 00 01 00 00 00 30 26  8K$..8........0&
Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:         01 00 00 0f ac 04 01 00=
 00 0f ac 04 01 00 00 0f  ................
Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:         ac 04 00 00 01 00 18 8c=
 0a 27 37 f5 7d a2 6d 33  .........'7.}.m3
Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:         53 fc 7b 8e 83 e1 36 03=
 00 01 00 37 60 00 00 00  S.{...6....7`...
Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:         00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00  ................
Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:         00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00  ................
Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:         00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 24  ...............$
Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:         ca bc 3e 62 db c6 0f c5=
 23 8a 7d f9 cf 68 d3 fb  ..>b....#.}..h..
Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:         08 14 16 34 4c 12 86 66=
 b0 c4 82 fe 54 fb e7 03  ...4L..f....T...
Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:         0c 33 38 34 62 32 34 39=
 36 30 35 32 30           .384b24960520
Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:     Offchannel TX OK: true
Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]: > Response: Frame (0x3b) len 4 =
                                       30.060851
Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:     Status: Invalid argument (2=
2)

A concurrent setup with wpa_supplicant V2.10 does work, but a look on IWMON=
 yielded, that wpa_supplicant uses NL8011CMD_AUTHENTICATE with different NL=
80211 attributes whilst iwd uses NL8011CMD_FRAME with the full 802.11 ft_au=
thenticate_frame as value of ATTR_FRAME.

Does wpa_supplicant use another NL8011 API for FT-Authenticate / FT-Associa=
te than iwd?

Another short try with a QCA chipset using ath11k (SOFTMAC) seems to be wor=
king with IWD 2.20 and FT-transition ...

I have attached different IWMON logs as PCAP files:
nl80211#wpa-supplicant-good.pcap              Good: FT-transition with wpa_=
supplicant V2.10  -> Frame 200: ft_authenticate, Frame: 201: Response to ft=
_authenticate, Frame 204: ft_associate, Frame 208: Response to ft_associate

nl80211#iwd_register_fail_ft_fail.pcap          Bad: frame registration in =
iwd 2.20 fails, FT-transition fails -> Frame 90: register_frame type auth, =
Frame 91: Response to register (EINVAL), Frame 294: ft_authenticate, Frame:=
 295: Response to ft_authenticate (EINVAL)

nl80211#iwd_register_ok_ft_fail.pcap           Bad: frame registration in i=
wd 2.20 succeeds, FT-transition fails -> Frame 158: register_frame type aut=
h, Frame 159: Response to register (SUCCESS), Frame 531: ft_authenticate, F=
rame 532: Response to ft_authenticate (EINVAL)

I also added a sorted log file containing iwd traces, iwmon text logs and k=
ernel msgs (of the NXP driver): resorted_logs_of_iwd_ft_connection_trial#3.=
txt


We would like to use iwd instead of wpa_supplicant so any help would be app=
reciated!

With best regards
Dipl.-Ing. Dierk Modrow
Development Engineer
Development Electronics -
Industrial Controller & Communication 2 (DE-ICC2)

SEW-EURODRIVE GmbH & Co KG
Ernst-Blickle-Str. 42
76646 Bruchsal

T +49 7251 75-5123
F +49 7251 75-505123
mailto:dierk.modrow@sew-eurodrive.de

https://www.sew-eurodrive.de


________________________________


SEW-EURODRIVE GmbH & Co KG
Kommanditgesellschaft, Sitz: Bruchsal, RG Mannheim HRA 230970
Komplement=E4rin: SEW-EURODRIVE Verwaltungs-GmbH, Sitz: Bruchsal, RG Mannhe=
im HRB 230207

Gesch=E4ftsf=FChrender Gesellschafter: J=FCrgen Blickle
Gesch=E4ftsf=FChrung: J=FCrgen Blickle (Vorsitzender), Dr. J=F6rg Hermes, D=
r. Hans Krattenmacher, Christian Mayer, Johann Soder
