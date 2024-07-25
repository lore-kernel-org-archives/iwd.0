Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65DC1B7FD
	for <iwd@lists.linux.dev>; Thu, 25 Jul 2024 18:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721931368; cv=none; b=pagn5TfDeKaxWGssxEI3QP+BdeFfSp4+08P9dUSP7yQuC8gYpuohYpx2imDwjg/kSnOHRxtE/emxWl+tioEegn5CM0jfk8pJvny+f/lD7lyeC+HSFyrh7HUNgbgGI6TIwYlBL1VPl7yPnLe8IevlahZETHoCGxAGDI7GkyLGLZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721931368; c=relaxed/simple;
	bh=/UAcaSINnBBfTXkJ3jkja1Wt2L7QKUhobCYhhUJpJkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZeyUSww3k4Y6e+D7Np4WdjB/XLi+Y2dj2PD9Pebi1PKl6FeZdo2p0jRqMbuz4URmpp5L74xHLY6vw9GzIZias4qR7/qEcJ1n/3ZTxDEwz/zVl+T9ry50fq3D6wUmBYf5wuB4+mEAB2ZyBdtdbon+gDUpz9x+H4hEqBNx9FJdZm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFzPNUyh; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFzPNUyh"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5d5b22f97b7so98970eaf.2
        for <iwd@lists.linux.dev>; Thu, 25 Jul 2024 11:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721931366; x=1722536166; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etk+5VMwjtbgHhxC0ZV2L63oDOTikKzfQrLJ2wMFWn8=;
        b=YFzPNUyhshlRn4WqgLnMLRuMba+1DbHmqzmMpdlAGvfCAGaeBmZcU2U9+s4QoRsH4H
         +evpDm/dxCG3WzRJZrJYjYV0n8LH6OJ61MSjL4roYO2QTN9kHwJtxnyHdvzefuTEImtJ
         uj/Be/0eNyI2R98nzM/H20UXwoeVyBtFXpEOZGDwBuzk3i9+ZbBP7v0Nu05XguTfEvx6
         oqERxttWSyeex2xRmr9JajY//7tc8nnSl+7vcr7WjtagAyLWskXJM+Htdv3CKvk6dlv/
         96giILlNTVrAvB0DKlpesXOvdxQTVIQVgesG0U/irmhkd6wtTgCdVsP43UCXA5TRnphJ
         z8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721931366; x=1722536166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=etk+5VMwjtbgHhxC0ZV2L63oDOTikKzfQrLJ2wMFWn8=;
        b=TqQxS3aLJ7RalfvUtmT/5OIfpg4uA9+UPIYQ7/7kzmuSrXFMRpaaScr+zDphVu54TU
         REyX1NdyO4w7pUpiX9/B2YZeZAdkvmn4AUJv0Jewj63+V5k8LS8ngNzVK45Eg4OmsR/3
         X1s4IrheRR8p6huRekXCmqhQviD0BvC0+b4rEqVYbscUa8BzBJFRYovpFP2jW9/QuLKY
         B8xNLSgiuEUa6v0cZOFLS++wohJpQuOZ3PSvaUL6Mc0h2WuzJNqdZ7AoR3IF/OSQggY1
         pcIS2WwxQWs0Kmjww6TeRkYBfBTI359eE00D/cRrXr8m7TkOBGsIM6DfWXO2hkOIBEEi
         hp0w==
X-Gm-Message-State: AOJu0YxVsH6QKMUrdCfU+okXQjhUPsZIy+wunPv5OiparIpMqsFy3agt
	x9D0ZA4NufYotv2rceU8ZmiBR73m3VmAOr79RbCZo36FbstFsIZgJBGakOsTF1w1SW6JU/bAfG8
	fQzw4bCnvQ4+RDsQjnj7DYye6I7o=
X-Google-Smtp-Source: AGHT+IF9Lg7K25Mq4SIxGanxlLtzfHiLv8l0fQ+ZptrUZ5x8KV4CmfW+ImHxonMHoZdlP9ww8guMf0LLe5kG7SRMlRI=
X-Received: by 2002:a05:6358:71c3:b0:1ac:65e9:1678 with SMTP id
 e5c5f4694b2df-1acf8902879mr442299655d.22.1721931365462; Thu, 25 Jul 2024
 11:16:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CA+iibzCB-6wXch6yFu-4V9dKgz0sJRopsd7wXchccptT5hNB-A@mail.gmail.com>
 <444d59ad-9a07-4d2c-922b-e6c43b7d8cb0@gmail.com>
In-Reply-To: <444d59ad-9a07-4d2c-922b-e6c43b7d8cb0@gmail.com>
From: daniel antoine <univac55@gmail.com>
Date: Thu, 25 Jul 2024 20:15:54 +0200
Message-ID: <CA+iibzAq50zn7=J+XtH28T=XKbk_Ukoms-K4PYoTrRPEi0J1gg@mail.gmail.com>
Subject: Re: IWD CMD_SET_CQM failed: Operation not supported
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi James

I send you the lspci display for the wifi device

04:00.0 Network controller: MEDIATEK Corp. MT7921K (RZ608) Wi-Fi 6E 80MHz
Subsystem: MEDIATEK Corp. MT7921K (RZ608) Wi-Fi 6E 80MHz
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 68
IOMMU group: 14
Region 0: Memory at fe30300000 (64-bit, prefetchable) [size=3D1M]
Region 2: Memory at fe30400000 (64-bit, prefetchable) [size=3D16K]
Region 4: Memory at fe30404000 (64-bit, prefetchable) [size=3D4K]
Capabilities: [80] Express (v2) Endpoint, IntMsgNum 0
        DevCap:MaxPayload 128 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
                ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
SlotPowerLimit 75W TEE-IO-
        DevCtl:CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
                MaxPayload 128 bytes, MaxReadReq 512 bytes
        DevSta:CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-
        LnkCap:Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <2us, L1 <8us
                ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
        LnkCtl:ASPM L1 Enabled; RCB 64 bytes, LnkDisable- CommClk+
                ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:Speed 5GT/s, Width x1
                TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
                 10BitTagComp- 10BitTagReq- OBFF Not Supported,
ExtFmt+ EETLPPrefix-
                 EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
                 FRS- TPHComp- ExtTPHComp-
                 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
                 AtomicOpsCtl: ReqEn-
                 IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
                 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
        LnkCap2: Supported Link Speeds: 2.5-5GT/s, Crosslink- Retimer-
2Retimers- DRS-
        LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                 Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB presh=
oot
        LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete- EqualizationPhase1-
                 EqualizationPhase2- EqualizationPhase3-
LinkEqualizationRequest-
                 Retimer- 2Retimers- CrosslinkRes: unsupported
Capabilities: [e0] MSI: Enable+ Count=3D1/32 Maskable+ 64bit+
        Address: 00000000fee00000  Data: 0000
        Masking: fffffffe  Pending: 00000000
Capabilities: [f8] Power Management version 3
        Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [100 v1] Vendor Specific Information: ID=3D1556 Rev=3D1 Len=
=3D008 <?>
Capabilities: [108 v1] Latency Tolerance Reporting
        Max snoop latency: 1048576ns
        Max no snoop latency: 1048576ns
Capabilities: [110 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
L1_PM_Substates+
                  PortCommonModeRestoreTime=3D3us PortTPowerOnTime=3D28us
        L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
                   T_CommonMode=3D0us LTR1.2_Threshold=3D166912ns
        L1SubCtl2: T_PwrOn=3D150us
Capabilities: [200 v2] Advanced Error Reporting
        UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- Mal=
fTLP-
                ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP-
AtomicOpBlocked- TLPBlockedErr-
                PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP-
PCRC_CHECK- TLPXlatBlocked-
        UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- Mal=
fTLP-
                ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP-
AtomicOpBlocked- TLPBlockedErr-
                PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP-
PCRC_CHECK- TLPXlatBlocked-
        UESvrt:DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF- Mal=
fTLP+
                ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP-
AtomicOpBlocked- TLPBlockedErr-
                PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP-
PCRC_CHECK- TLPXlatBlocked-
        CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr- CorrIntErr- HeaderOF-
        CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+ CorrIntErr+ HeaderOF-
        AERCap:First Error Pointer: 00, ECRCGenCap- ECRCGenEn-
ECRCChkCap- ECRCChkEn-
                MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
        HeaderLog: 00000000 00000000 00000000 00000000
Kernel driver in use: mt7921e
Kernel modules: mt7921e

How to put iwd in debug mode, is it an option to add to the command
line ExecStart=3D/usr/lib/iwd/iwd
in the file iwd.service like -d ?

Best regards

Daniel

Le jeu. 25 juil. 2024 =C3=A0 18:41, James Prestwood <prestwoj@gmail.com> a =
=C3=A9crit :
>
> Hi Daniel,
>
> On 7/25/24 9:15 AM, daniel antoine wrote:
> > Hi
> >
> > I always have this error when iwd connect. It's not a problem, it
> > works perfectly. How to get rid of it.
> >
> > juil. 25 17:35:05 grat-os1 iwd[530]: Wireless daemon version 2.19
> > juil. 25 17:35:05 grat-os1 iwd[530]: station: Network configuration is =
disabled.
> > juil. 25 17:35:05 grat-os1 iwd[530]: Wiphy: 0, Name: phy0
> > juil. 25 17:35:05 grat-os1 iwd[530]:         Permanent Address:
> > 50:c2:e8:0b:58:bd
> > juil. 25 17:35:05 grat-os1 iwd[530]:         2.4GHz Band:
> > juil. 25 17:35:05 grat-os1 iwd[530]:                 Bitrates (non-HT):
> > juil. 25 17:35:05 grat-os1 iwd[530]:                          1.0 Mbps
> > juil. 25 17:35:05 grat-os1 iwd[530]:                          2.0 Mbps
> > juil. 25 17:35:05 grat-os1 iwd[530]:                          5.5 Mbps
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         11.0 Mbps
> > juil. 25 17:35:05 grat-os1 iwd[530]:                          6.0 Mbps
> > juil. 25 17:35:05 grat-os1 iwd[530]:                          9.0 Mbps
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         12.0 Mbps
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         18.0 Mbps
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         24.0 Mbps
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         36.0 Mbps
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         48.0 Mbps
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         54.0 Mbps
> > juil. 25 17:35:05 grat-os1 iwd[530]:                 HT Capabilities:
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         HT40
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         Short GI f=
or 20Mhz
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         Short GI f=
or 40Mhz
> > juil. 25 17:35:05 grat-os1 iwd[530]:                 HT RX MCS indexes:
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         0-15
> > juil. 25 17:35:05 grat-os1 iwd[530]:                 HE Capabilities
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         Interface =
Types: ap
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE RX
> > <=3D 80MHz MCS: 0-11 for NSS: 2
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE TX
> > <=3D 80MHz MCS: 0-11 for NSS: 2
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         Interface
> > Types: station
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE RX
> > <=3D 80MHz MCS: 0-11 for NSS: 2
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE TX
> > <=3D 80MHz MCS: 0-11 for NSS: 2
> > juil. 25 17:35:05 grat-os1 iwd[530]:         5GHz Band:
> > juil. 25 17:35:05 grat-os1 iwd[530]:                 Bitrates (non-HT):
> > juil. 25 17:35:05 grat-os1 iwd[530]:                          6.0 Mbps
> > juil. 25 17:35:05 grat-os1 iwd[530]:                          9.0 Mbps
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         12.0 Mbps
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         18.0 Mbps
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         24.0 Mbps
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         36.0 Mbps
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         48.0 Mbps
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         54.0 Mbps
> > juil. 25 17:35:05 grat-os1 iwd[530]:                 HT Capabilities:
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         HT40
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         Short GI f=
or 20Mhz
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         Short GI f=
or 40Mhz
> > juil. 25 17:35:05 grat-os1 iwd[530]:                 HT RX MCS indexes:
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         0-15
> > juil. 25 17:35:05 grat-os1 iwd[530]:                 VHT Capabilities:
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         Short GI f=
or 80Mhz
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         Max RX
> > MCS: 0-9 for NSS: 2
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         Max TX
> > MCS: 0-9 for NSS: 2
> > juil. 25 17:35:05 grat-os1 iwd[530]:                 HE Capabilities
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         Interface =
Types: ap
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE RX
> > <=3D 80MHz MCS: 0-11 for NSS: 2
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE TX
> > <=3D 80MHz MCS: 0-11 for NSS: 2
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         Interface
> > Types: station
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE RX
> > <=3D 80MHz MCS: 0-11 for NSS: 2
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE TX
> > <=3D 80MHz MCS: 0-11 for NSS: 2
> > juil. 25 17:35:05 grat-os1 iwd[530]:         6GHz Band:
> > juil. 25 17:35:05 grat-os1 iwd[530]:                 Bitrates (non-HT):
> > juil. 25 17:35:05 grat-os1 iwd[530]:                          6.0 Mbps
> > juil. 25 17:35:05 grat-os1 iwd[530]:                          9.0 Mbps
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         12.0 Mbps
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         18.0 Mbps
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         24.0 Mbps
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         36.0 Mbps
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         48.0 Mbps
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         54.0 Mbps
> > juil. 25 17:35:05 grat-os1 iwd[530]:                 HE Capabilities
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         Interface =
Types: ap
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE RX
> > <=3D 80MHz MCS: 0-11 for NSS: 2
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE TX
> > <=3D 80MHz MCS: 0-11 for NSS: 2
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         Interface
> > Types: station
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE RX
> > <=3D 80MHz MCS: 0-11 for NSS: 2
> > juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE TX
> > <=3D 80MHz MCS: 0-11 for NSS: 2
> > juil. 25 17:35:05 grat-os1 iwd[530]:         Ciphers: BIP-CMAC-256
> > BIP-GMAC-256 BIP-GMAC-128 CCMP-256
> > juil. 25 17:35:05 grat-os1 iwd[530]:                  GCMP-256
> > GCMP-128 BIP-CMAC-128 CCMP-128
> > juil. 25 17:35:05 grat-os1 iwd[530]:                  TKIP
> > juil. 25 17:35:05 grat-os1 iwd[530]:         Supported iftypes: station=
 ap
> > juil. 25 17:35:05 grat-os1 iwd[530]: udev interface=3Dwlan0 ifindex=3D3
> > juil. 25 17:35:05 grat-os1 iwd[530]: udev interface=3Dvirbr0 ifindex=3D=
4
> > juil. 25 17:35:06 grat-os1 iwd[530]: event: state, old: disconnected,
> > new: autoconnect_quick
> > juil. 25 17:35:06 grat-os1 iwd[530]: udev interface=3Dwlan0 ifindex=3D5
> > juil. 25 17:35:06 grat-os1 iwd[530]: event: state, old:
> > autoconnect_quick, new: autoconnect_full
> > juil. 25 17:35:06 grat-os1 iwd[530]: event: connect-info, ssid:
> > Livebox-XXXX xx.xx.xx.xx.xx.xx, signal: -45, load: 6/255
> > juil. 25 17:35:06 grat-os1 iwd[530]: event: state, old:
> > autoconnect_full, new: connecting
> > juil. 25 17:35:06 grat-os1 iwd[530]: CMD_SET_CQM failed: Operation not =
supported
> > juil. 25 17:35:10 grat-os1 iwd[530]: event: state, old: connecting,
> > new: connected
> > juil. 25 17:35:10 grat-os1 iwd[530]: event: roam-scan,
> > juil. 25 17:35:12 grat-os1 iwd[530]: event: roam-info, bss:
> > yy:yy:yy:yy:yy:yy, signal: -49, load: 1/255
> > juil. 25 17:35:12 grat-os1 iwd[530]: event: state, old: connected, new:=
 roaming
> > juil. 25 17:35:12 grat-os1 iwd[530]: CMD_SET_CQM failed: Operation not =
supported
> > juil. 25 17:35:13 grat-os1 iwd[530]: event: state, old: roaming, new: c=
onnected
> >
> > I have found one commit referring to CMD_SET_CQM it's the commit
> > 2dc785982d29ebd72b7cc6ed5548454f386ce222  netdev: Check
> > EXT_FEATURE_CQM_RSSI_LIST before sending CMD_SET_CQM
>
> There is that extended feature for RSSI lists, but most likely that's
> not the reason because IWD will only use a single threshold unless your
> using a signal agent, which I assume your not. Looking at the kernel I
> did find one case where driver support is checked, and if that fails it
> returns not supported:
>
> net/mac80211/cfg.c: ieee80211_set_cqm_rssi_config()
>
> if (sdata->vif.driver_flags & IEEE80211_VIF_BEACON_FILTER &&
>          !(sdata->vif.driver_flags & IEEE80211_VIF_SUPPORTS_CQM_RSSI))
>          return -EOPNOTSUPP;
>
> What hardware are you using? Also could you enable debugging because it
> would appear that CQM is still working as you are able to roam, so this
> error may be related to something else.
>
> Thanks,
>
> James
>
> >
> > Best regards
> >
> > Daniel
> >
