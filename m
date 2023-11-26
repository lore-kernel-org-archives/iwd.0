Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B570377
	for <iwd@lists.linux.dev>; Sun, 26 Nov 2023 00:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfOogUBb"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-db37c6a4d48so2874613276.2
        for <iwd@lists.linux.dev>; Sat, 25 Nov 2023 16:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700958767; x=1701563567; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FeCIjEmYFjRPPtdpTZZbqLK1kcD30Nd694QI5L4OXyY=;
        b=MfOogUBbVlexHaNkA1erN5uP6ozDHnZd0SvXqYoSWIPimvaSYPXXyrtjWpbKwpCotA
         ueou79pp6QinkMCK0jO66QK9Y1hEjuk+9bPCvAWKt7pnxiIwPVYNl0yBlhdZjBo/6e5z
         FJp0Q1YDC9jlp+6m5dq0v/PSjw/iLnf3GxGbRJYAPk75fRfBtAnN1JTtjlsrWsybHPFb
         h1xL2++uDey+ru7SBcEmeLOjiFOlbZlyRFPtxgwtURRbz6iY08hEgmGPOuI6RVu+vD6A
         6o2kN6Xlelc8MJLqS7qQagp9CFxTprZvnyBKqSZcbH9ToKMo9kejrJrS21a0BDMiqJLn
         zvyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700958767; x=1701563567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FeCIjEmYFjRPPtdpTZZbqLK1kcD30Nd694QI5L4OXyY=;
        b=GBIJS67ytxEf6fGOoHIC2CrTP2k7CjraPRmlvv4p0yIieIjWaPbqRIcsdL1d+zLtZy
         v4wVTpXngoL6N15OsqeYw9NUXfV6ge1cN9y00u04PhhyyGrPodswZQOOcrJhDzl0HkgN
         4Z0vb4AsbUSAr6JNlxs3jxGw+E+aZ388duodLftorGwPFE4DY9qymB5LY15oabRQjKt+
         IMdoiJBPJm0TSNWcUJIFGZJKngexPcDsNWDA/dGK+1PFvbmY51vqv7eSyALV91EwXlBP
         JzkOKI3lFduOfnYKmAta0edw5umAli1rh1dQ1s5NhFeoYwfNL2lAdB3/UdJHF/M9qQhV
         fZpg==
X-Gm-Message-State: AOJu0YzChD02cywrs7cT0oEyEAgGCDIDorO8FMrVArklbGkJEm8ePWF7
	LZ7CJ8le5gixsJqdO9N6T8/N45hEWtYzGLzommNp/rmj0wY=
X-Google-Smtp-Source: AGHT+IF8KoupITtkc2qByZJ0sbpaXITisjiQd2/zI0pJMRJpbasWYQFDd8qMjEjmuWlMqABCuCwNEQZAEC50RKCi+Is=
X-Received: by 2002:a25:d8c3:0:b0:da0:447a:e9d8 with SMTP id
 p186-20020a25d8c3000000b00da0447ae9d8mr6417112ybg.10.1700958767048; Sat, 25
 Nov 2023 16:32:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAJODeCBYQ3bwRjZjZoZ+AX+QG84U=VO_UEoa0AuWmFAqxunn4Q@mail.gmail.com>
 <0331a3f5-7d04-49d0-b569-3e5fa5b4514d@gmail.com>
In-Reply-To: <0331a3f5-7d04-49d0-b569-3e5fa5b4514d@gmail.com>
From: Daniel Barter <danielbarter@gmail.com>
Date: Sat, 25 Nov 2023 16:32:35 -0800
Message-ID: <CAJODeCDu-85P54m16FanJftz2mC-fVGN-PXrwk4q+yS8n6mwFQ@mail.gmail.com>
Subject: Re: roaming issues on a residential LAN with multiple APs
To: Denis Kenzior <denkenz@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

here are my logs:
https://gist.github.com/danielbarter/65ddf6aee78546a0e8f9e2d3af65308c

notice that this is a mix of iwd 2.4 (my distro default) and iwd 2.8.

Default roaming thresholds are in the 70s right? I am getting down to
-90dBm without a roam happening.

kernel version is 6.6.0.

here is everything lspci will tell me about the wifi card:

aa:00.0 Network controller: Intel Corporation Wi-Fi 6
AX210/AX211/AX411 160MHz (rev 1a)
    Subsystem: Intel Corporation Wi-Fi 6 AX210 160MHz
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 17
    IOMMU group: 18
    Region 0: Memory at 7a200000 (64-bit, non-prefetchable) [size=3D16K]
    Capabilities: [c8] Power Management version 3
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
    Capabilities: [d0] MSI: Enable- Count=3D1/1 Maskable- 64bit+
        Address: 0000000000000000  Data: 0000
    Capabilities: [40] Express (v2) Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<512ns, L1 unlimited
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit =
0W
        DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+ FLReset-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransP=
end-
        LnkCap:    Port #0, Speed 5GT/s, Width x1, ASPM L1, Exit Latency L1=
 <8us
            ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
        LnkCtl:    ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
            ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 5GT/s, Width x1
            TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Range B, TimeoutDis+ NROPrPrP- LTR+
             10BitTagComp- 10BitTagReq- OBFF Via WAKE#, ExtFmt- EETLPPrefix=
-
             EmergencyPowerReduction Not Supported, EmergencyPowerReduction=
Init-
             FRS- TPHComp- ExtTPHComp-
             AtomicOpsCap: 32bit- 64bit- 128bitCAS-
        DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis- LTR+
10BitTagReq- OBFF Disabled,
             AtomicOpsCtl: ReqEn-
        LnkCap2: Supported Link Speeds: 2.5-5GT/s, Crosslink- Retimer-
2Retimers- DRS-
        LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
        LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete- EqualizationPhase1-
             EqualizationPhase2- EqualizationPhase3- LinkEqualizationReques=
t-
             Retimer- 2Retimers- CrosslinkRes: unsupported
    Capabilities: [80] MSI-X: Enable+ Count=3D16 Masked-
        Vector table: BAR=3D0 offset=3D00002000
        PBA: BAR=3D0 offset=3D00003000
    Capabilities: [100 v1] Advanced Error Reporting
        UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr=
-
        CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr=
+
        AERCap:    First Error Pointer: 00, ECRCGenCap- ECRCGenEn-
ECRCChkCap- ECRCChkEn-
            MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
        HeaderLog: 00000000 00000000 00000000 00000000
    Capabilities: [14c v1] Latency Tolerance Reporting
        Max snoop latency: 3145728ns
        Max no snoop latency: 3145728ns
    Capabilities: [154 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
L1_PM_Substates+
              PortCommonModeRestoreTime=3D30us PortTPowerOnTime=3D18us
        L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
               T_CommonMode=3D0us LTR1.2_Threshold=3D96256ns
        L1SubCtl2: T_PwrOn=3D44us
    Kernel driver in use: iwlwifi
    Kernel modules: iwlwifi


On Sat, Nov 25, 2023 at 3:29=E2=80=AFPM Denis Kenzior <denkenz@gmail.com> w=
rote:
>
> Hi Daniel,
>
> >
> > iwd[32079]: src/station.c:station_early_neighbor_report_cb() ifindex:
> > 5, error: -110(Connection timed out)
>
> Shouldn't preclude a roam, just won't use the neighbor report information=
.  Hard
> to say anything more without seeing logs.  It could be that the roaming
> threshold is never reached, or your kernel driver isn't reporting CQM
> notifications properly, or many other reasons.  What hardware / driver is=
 it?
> Kernel version?
>
> https://iwd.wiki.kernel.org/debugging
>
> Regards,
> -Denis
