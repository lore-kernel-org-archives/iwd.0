Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C7320EB
	for <iwd@lists.linux.dev>; Thu, 25 Jul 2024 18:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721933144; cv=none; b=sr/b9+kou9fWriJm9f0t+KHy3A2gQ68FX5mZ8rWFUDlDDcGEBRCXlEJLFP25V1mj8CMJpuHAbnMlnpjV6OVyjFD1va6wC+kDwBuca6YZwsYr9YoCoxtc79OLel6UFpqgYoG+A24LYFLEszoZycaEckTByTWE+sNM+FxV2QyKU04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721933144; c=relaxed/simple;
	bh=KdBsfWa8RC0GleE5G32FQn2/mSvGokD9L0PQOI+TGQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gKIoJMKKf5FjefJjb8akodDgNJni4GdQlS6E16upk8DhSeVVcEzGwsUyFoPwzwrIYgEgeW0sFR1fcTIjtP/QFu0wanN6RVJDiAuq8B4vY75McfNbHJMGa68eOraEhnhTuP9qAsLNPaVg+7BS8q1yMCU4qkqMv6hiIcMvjTxvi5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=muDeVrO0; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muDeVrO0"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-44fe11dedb3so6477601cf.1
        for <iwd@lists.linux.dev>; Thu, 25 Jul 2024 11:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721933142; x=1722537942; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W+UyhAg0c2SnOdk7bIgQzpsaNG37bB2vcPjzRI/3a7g=;
        b=muDeVrO0VtSFpOprWJnuNWQKtlpqE77IEnpqZMhBi7+73Cu+JXzbKD3zBkS26hkQ6+
         v6UrLv+uDrTJzyxxRXqRdK/V5REziNArf6vs031/ZYoPh5kKwNo3W36qEjQZf9crJf4z
         C7a7k6Nn/PmAdE+wnqbTaKYnYz0oaM4FwqC5sqhFCRVISg1GrSi9TFozrX/Vvx01WWlz
         uM04uk4rsCti5DzfD27XRYa4nfnOcd/3tX+FYfffItD8sn/UhSowkdEVlQ0YAgy59q1w
         X25lLICACj1hnKsjBeNzzlGUyUO8dIz5l6accWK6sl0Xe+tKNtDFusu2ynGVCC0h83T1
         fRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721933142; x=1722537942;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W+UyhAg0c2SnOdk7bIgQzpsaNG37bB2vcPjzRI/3a7g=;
        b=lIStM5iFbt42GxwQ0Hkl1Cl2xTIg4EMREH/0yVZtGZBs3aA7hLqnevauLqMNx7hjmI
         LvC8Sj7sjQan5EsBOtjEG4/boHt/SnESvGmpI4zxQZVpG7M/CcB5LJ6U+CsUXZgTiKVW
         ZIsNKZEj4Y2Y78Ilc0GwzFXS+R0cBvl0cGs9aeGadyNr3/zrhzUxvzdUX5XA6KhwbY1a
         gFdNTjSBsvdP2vsM0QgFDpQ6U8/9M/vv5CXza6rD32FjT4jU+dxcbcKFQkW/KhRdb2IR
         O3HxEXYx5nnBWFCu0aj7uGnbCe0CY9O0iTQFqKmSdPBHuy46OoFiVp/+ppV+d7E4u8bJ
         voBA==
X-Gm-Message-State: AOJu0YwbM3U7grGjS7nfBFNBJxJUlHE+DNp1NjDp/PU91e8sAciXtMFe
	FN1eCPLX2ecmxDQWi+3JYWED8R+Po1nlgC1nLcs/Oh2VseXF9LzA
X-Google-Smtp-Source: AGHT+IHr8JUR38ckyotPDqs9LnDT9gnU4eRPtFSj1pbUM4hTTt8r7J5bZlV936qHD5xLzXo3tH+1Ew==
X-Received: by 2002:ac8:5d42:0:b0:444:fa36:3958 with SMTP id d75a77b69052e-44fe9150f75mr35571451cf.13.1721933141605;
        Thu, 25 Jul 2024 11:45:41 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe8416c80sm8192271cf.96.2024.07.25.11.45.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 11:45:41 -0700 (PDT)
Message-ID: <1c8086ac-1d28-4c02-8c21-c7a37148a9f1@gmail.com>
Date: Thu, 25 Jul 2024 11:45:39 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IWD CMD_SET_CQM failed: Operation not supported
To: daniel antoine <univac55@gmail.com>
Cc: iwd@lists.linux.dev
References: <CA+iibzCB-6wXch6yFu-4V9dKgz0sJRopsd7wXchccptT5hNB-A@mail.gmail.com>
 <444d59ad-9a07-4d2c-922b-e6c43b7d8cb0@gmail.com>
 <CA+iibzAq50zn7=J+XtH28T=XKbk_Ukoms-K4PYoTrRPEi0J1gg@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CA+iibzAq50zn7=J+XtH28T=XKbk_Ukoms-K4PYoTrRPEi0J1gg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Daniel,

On 7/25/24 11:15 AM, daniel antoine wrote:
> Hi James
>
> I send you the lspci display for the wifi device
>
> 04:00.0 Network controller: MEDIATEK Corp. MT7921K (RZ608) Wi-Fi 6E 80MHz
> Subsystem: MEDIATEK Corp. MT7921K (RZ608) Wi-Fi 6E 80MHz
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 68
> IOMMU group: 14
> Region 0: Memory at fe30300000 (64-bit, prefetchable) [size=1M]
> Region 2: Memory at fe30400000 (64-bit, prefetchable) [size=16K]
> Region 4: Memory at fe30404000 (64-bit, prefetchable) [size=4K]
> Capabilities: [80] Express (v2) Endpoint, IntMsgNum 0
>          DevCap:MaxPayload 128 bytes, PhantFunc 0, Latency L0s
> unlimited, L1 unlimited
>                  ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
> SlotPowerLimit 75W TEE-IO-
>          DevCtl:CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
>                  RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
>                  MaxPayload 128 bytes, MaxReadReq 512 bytes
>          DevSta:CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-
>          LnkCap:Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit
> Latency L0s <2us, L1 <8us
>                  ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
>          LnkCtl:ASPM L1 Enabled; RCB 64 bytes, LnkDisable- CommClk+
>                  ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>          LnkSta:Speed 5GT/s, Width x1
>                  TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>          DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
>                   10BitTagComp- 10BitTagReq- OBFF Not Supported,
> ExtFmt+ EETLPPrefix-
>                   EmergencyPowerReduction Not Supported,
> EmergencyPowerReductionInit-
>                   FRS- TPHComp- ExtTPHComp-
>                   AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>          DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
>                   AtomicOpsCtl: ReqEn-
>                   IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
>                   10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
>          LnkCap2: Supported Link Speeds: 2.5-5GT/s, Crosslink- Retimer-
> 2Retimers- DRS-
>          LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
>                   Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>                   Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
>          LnkSta2: Current De-emphasis Level: -3.5dB,
> EqualizationComplete- EqualizationPhase1-
>                   EqualizationPhase2- EqualizationPhase3-
> LinkEqualizationRequest-
>                   Retimer- 2Retimers- CrosslinkRes: unsupported
> Capabilities: [e0] MSI: Enable+ Count=1/32 Maskable+ 64bit+
>          Address: 00000000fee00000  Data: 0000
>          Masking: fffffffe  Pending: 00000000
> Capabilities: [f8] Power Management version 3
>          Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>          Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [100 v1] Vendor Specific Information: ID=1556 Rev=1 Len=008 <?>
> Capabilities: [108 v1] Latency Tolerance Reporting
>          Max snoop latency: 1048576ns
>          Max no snoop latency: 1048576ns
> Capabilities: [110 v1] L1 PM Substates
>          L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> L1_PM_Substates+
>                    PortCommonModeRestoreTime=3us PortTPowerOnTime=28us
>          L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>                     T_CommonMode=0us LTR1.2_Threshold=166912ns
>          L1SubCtl2: T_PwrOn=150us
> Capabilities: [200 v2] Advanced Error Reporting
>          UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
>                  ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP-
> AtomicOpBlocked- TLPBlockedErr-
>                  PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP-
> PCRC_CHECK- TLPXlatBlocked-
>          UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
>                  ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP-
> AtomicOpBlocked- TLPBlockedErr-
>                  PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP-
> PCRC_CHECK- TLPXlatBlocked-
>          UESvrt:DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP+
>                  ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP-
> AtomicOpBlocked- TLPBlockedErr-
>                  PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP-
> PCRC_CHECK- TLPXlatBlocked-
>          CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> AdvNonFatalErr- CorrIntErr- HeaderOF-
>          CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> AdvNonFatalErr+ CorrIntErr+ HeaderOF-
>          AERCap:First Error Pointer: 00, ECRCGenCap- ECRCGenEn-
> ECRCChkCap- ECRCChkEn-
>                  MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>          HeaderLog: 00000000 00000000 00000000 00000000
> Kernel driver in use: mt7921e
> Kernel modules: mt7921e
>
> How to put iwd in debug mode, is it an option to add to the command
> line ExecStart=/usr/lib/iwd/iwd
> in the file iwd.service like -d ?

Yeah -d in the service file would do it. I think this would be more of a 
linux-wireless question or question to mediatek. I believe this driver 
is hitting the case I described on my last email. I see one case it 
unsets it when power save is disabled so you could maybe try that. IWD 
can do that automatically with a main.conf option:

[DriverQuirks]
PowerSaveDisable=mt*

(mt* is just a glob match for something like mt7921e)

>
> Best regards
>
> Daniel
>
> Le jeu. 25 juil. 2024 à 18:41, James Prestwood <prestwoj@gmail.com> a écrit :
>> Hi Daniel,
>>
>> On 7/25/24 9:15 AM, daniel antoine wrote:
>>> Hi
>>>
>>> I always have this error when iwd connect. It's not a problem, it
>>> works perfectly. How to get rid of it.
>>>
>>> juil. 25 17:35:05 grat-os1 iwd[530]: Wireless daemon version 2.19
>>> juil. 25 17:35:05 grat-os1 iwd[530]: station: Network configuration is disabled.
>>> juil. 25 17:35:05 grat-os1 iwd[530]: Wiphy: 0, Name: phy0
>>> juil. 25 17:35:05 grat-os1 iwd[530]:         Permanent Address:
>>> 50:c2:e8:0b:58:bd
>>> juil. 25 17:35:05 grat-os1 iwd[530]:         2.4GHz Band:
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                 Bitrates (non-HT):
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                          1.0 Mbps
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                          2.0 Mbps
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                          5.5 Mbps
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         11.0 Mbps
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                          6.0 Mbps
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                          9.0 Mbps
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         12.0 Mbps
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         18.0 Mbps
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         24.0 Mbps
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         36.0 Mbps
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         48.0 Mbps
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         54.0 Mbps
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                 HT Capabilities:
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         HT40
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         Short GI for 20Mhz
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         Short GI for 40Mhz
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                 HT RX MCS indexes:
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         0-15
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                 HE Capabilities
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         Interface Types: ap
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE RX
>>> <= 80MHz MCS: 0-11 for NSS: 2
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE TX
>>> <= 80MHz MCS: 0-11 for NSS: 2
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         Interface
>>> Types: station
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE RX
>>> <= 80MHz MCS: 0-11 for NSS: 2
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE TX
>>> <= 80MHz MCS: 0-11 for NSS: 2
>>> juil. 25 17:35:05 grat-os1 iwd[530]:         5GHz Band:
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                 Bitrates (non-HT):
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                          6.0 Mbps
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                          9.0 Mbps
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         12.0 Mbps
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         18.0 Mbps
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         24.0 Mbps
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         36.0 Mbps
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         48.0 Mbps
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         54.0 Mbps
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                 HT Capabilities:
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         HT40
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         Short GI for 20Mhz
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         Short GI for 40Mhz
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                 HT RX MCS indexes:
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         0-15
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                 VHT Capabilities:
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         Short GI for 80Mhz
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         Max RX
>>> MCS: 0-9 for NSS: 2
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         Max TX
>>> MCS: 0-9 for NSS: 2
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                 HE Capabilities
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         Interface Types: ap
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE RX
>>> <= 80MHz MCS: 0-11 for NSS: 2
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE TX
>>> <= 80MHz MCS: 0-11 for NSS: 2
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         Interface
>>> Types: station
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE RX
>>> <= 80MHz MCS: 0-11 for NSS: 2
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE TX
>>> <= 80MHz MCS: 0-11 for NSS: 2
>>> juil. 25 17:35:05 grat-os1 iwd[530]:         6GHz Band:
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                 Bitrates (non-HT):
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                          6.0 Mbps
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                          9.0 Mbps
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         12.0 Mbps
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         18.0 Mbps
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         24.0 Mbps
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         36.0 Mbps
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         48.0 Mbps
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         54.0 Mbps
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                 HE Capabilities
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         Interface Types: ap
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE RX
>>> <= 80MHz MCS: 0-11 for NSS: 2
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE TX
>>> <= 80MHz MCS: 0-11 for NSS: 2
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         Interface
>>> Types: station
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE RX
>>> <= 80MHz MCS: 0-11 for NSS: 2
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE TX
>>> <= 80MHz MCS: 0-11 for NSS: 2
>>> juil. 25 17:35:05 grat-os1 iwd[530]:         Ciphers: BIP-CMAC-256
>>> BIP-GMAC-256 BIP-GMAC-128 CCMP-256
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                  GCMP-256
>>> GCMP-128 BIP-CMAC-128 CCMP-128
>>> juil. 25 17:35:05 grat-os1 iwd[530]:                  TKIP
>>> juil. 25 17:35:05 grat-os1 iwd[530]:         Supported iftypes: station ap
>>> juil. 25 17:35:05 grat-os1 iwd[530]: udev interface=wlan0 ifindex=3
>>> juil. 25 17:35:05 grat-os1 iwd[530]: udev interface=virbr0 ifindex=4
>>> juil. 25 17:35:06 grat-os1 iwd[530]: event: state, old: disconnected,
>>> new: autoconnect_quick
>>> juil. 25 17:35:06 grat-os1 iwd[530]: udev interface=wlan0 ifindex=5
>>> juil. 25 17:35:06 grat-os1 iwd[530]: event: state, old:
>>> autoconnect_quick, new: autoconnect_full
>>> juil. 25 17:35:06 grat-os1 iwd[530]: event: connect-info, ssid:
>>> Livebox-XXXX xx.xx.xx.xx.xx.xx, signal: -45, load: 6/255
>>> juil. 25 17:35:06 grat-os1 iwd[530]: event: state, old:
>>> autoconnect_full, new: connecting
>>> juil. 25 17:35:06 grat-os1 iwd[530]: CMD_SET_CQM failed: Operation not supported
>>> juil. 25 17:35:10 grat-os1 iwd[530]: event: state, old: connecting,
>>> new: connected
>>> juil. 25 17:35:10 grat-os1 iwd[530]: event: roam-scan,
>>> juil. 25 17:35:12 grat-os1 iwd[530]: event: roam-info, bss:
>>> yy:yy:yy:yy:yy:yy, signal: -49, load: 1/255
>>> juil. 25 17:35:12 grat-os1 iwd[530]: event: state, old: connected, new: roaming
>>> juil. 25 17:35:12 grat-os1 iwd[530]: CMD_SET_CQM failed: Operation not supported
>>> juil. 25 17:35:13 grat-os1 iwd[530]: event: state, old: roaming, new: connected
>>>
>>> I have found one commit referring to CMD_SET_CQM it's the commit
>>> 2dc785982d29ebd72b7cc6ed5548454f386ce222  netdev: Check
>>> EXT_FEATURE_CQM_RSSI_LIST before sending CMD_SET_CQM
>> There is that extended feature for RSSI lists, but most likely that's
>> not the reason because IWD will only use a single threshold unless your
>> using a signal agent, which I assume your not. Looking at the kernel I
>> did find one case where driver support is checked, and if that fails it
>> returns not supported:
>>
>> net/mac80211/cfg.c: ieee80211_set_cqm_rssi_config()
>>
>> if (sdata->vif.driver_flags & IEEE80211_VIF_BEACON_FILTER &&
>>           !(sdata->vif.driver_flags & IEEE80211_VIF_SUPPORTS_CQM_RSSI))
>>           return -EOPNOTSUPP;
>>
>> What hardware are you using? Also could you enable debugging because it
>> would appear that CQM is still working as you are able to roam, so this
>> error may be related to something else.
>>
>> Thanks,
>>
>> James
>>
>>> Best regards
>>>
>>> Daniel
>>>
