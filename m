Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7693F26ACD
	for <iwd@lists.linux.dev>; Mon, 21 Oct 2024 14:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729521651; cv=none; b=Q3kc7k5Bo4XI5S3VC07pM6gzqF4bXvGQYqqcKNbpRi437Bx9LN6VEUqVDmLz3aRpFj2vkILecIw6IwiZUiA0WG0FEx4jPnR7ouc9SVk7IWYtM1LBV8Np3SQVlYJEe1dh45cm/gBgDyIDet1KMjEZOZtCn4K9HH9Tlt+QK6ueQ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729521651; c=relaxed/simple;
	bh=wTR29KwvpbwezFX/EHTFKSbVKDf5yti3cNi6a7RseLw=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=MYJFg2jaQA+KwZolExawQOEjA2cHH2tLGR7x94itl90rpBMGhRxzvqbtub7teSDG+zPn6Jtvmdc0YaJ2FlTQJ5VjcijnbZqZ8XoywShFPFEcegnP3LYJ5526mscJZ2RtcLz5fBPJOyIWOshtD83gOR3iLAmo8U1Vzv7qB8v6iTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Yiz5ZVjg; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Yiz5ZVjg"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a998a5ca499so577589666b.0
        for <iwd@lists.linux.dev>; Mon, 21 Oct 2024 07:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1729521648; x=1730126448; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IeTxmJDZTS5EbgGRKFcNGECfxkseMXJ4DVPhQPLI2IE=;
        b=Yiz5ZVjgjGcN79O/jP7c5ZwxfwCLdc+lAQL3qbM8lymSsLAeCPwyxX2epsKTcZcj0b
         Qu+ikK46f4cg95BwhxQoFhSGDRvAeeLCr1alm04kwabSs5l2N7Rj6toiLP8ZAPDbc7vc
         PsiDyJ9ZliBSGIYDTKEILCXx4F1e9m1ZIjppQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729521648; x=1730126448;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IeTxmJDZTS5EbgGRKFcNGECfxkseMXJ4DVPhQPLI2IE=;
        b=B/uNm21OvBNkOgJMrHkAfBertnFJUS6+2dptxcl1tA8TODA1b2e6C2G73s3QxyRozz
         lTDGdSW2qqW9Db9CRineQGsppOO5tCOopdniJE/+vBgEBSklsazAtP47dFJqe0KnxIRK
         SWtFSiUcnN+11tJdHPLH1V/71BPu00TZIrEkbejkaxYcuDAQqx8o+LjfRfotsw2VUxiN
         ZxKWechbvwyKwaaVvwm7q5q0zbRdquk07KBxJR1wYIDXr4PpReYz2dkRZNx4FLuf1/Dm
         YL+riX+GWOFnGxbVt7ttg0pl8vf+/OVy2D1Fz76JQAsn20L0i3m29pRmnyp91NdxQh46
         deNQ==
X-Gm-Message-State: AOJu0YyGH8fj3Uq1gA5UI6czfuqTzpghhR9uCKp94ttKGqvrVLzO+iWC
	3oYvSTh/P5zeN79qxQ2RGUP0gxkjv7mnZXvdVcXKfPTpQpQdd66aPWIAIMBhDX/0eCegMvAgbzA
	8lQ==
X-Google-Smtp-Source: AGHT+IHDzy0MVYMluUHTRrViB/DFFUITPrD/W6nFhYq1+pwI9QMQKrNXLp7l073v2BXWvoKA4Ayk4Q==
X-Received: by 2002:a17:907:9345:b0:a99:46dd:f397 with SMTP id a640c23a62f3a-a9a69caa3f8mr1050598166b.64.1729521647532;
        Mon, 21 Oct 2024 07:40:47 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912edfd0sm211914866b.67.2024.10.21.07.40.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 07:40:47 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Martin Petzold <martin.petzold@tavla.de>, Denis Kenzior <denkenz@gmail.com>
CC: <iwd@lists.linux.dev>
Date: Mon, 21 Oct 2024 16:40:45 +0200
Message-ID: <192af85f1e0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <2dacc589-9927-40f7-85ed-5f6b2afbbd41@tavla.de>
References: <a99e0ef1-8f97-4c1d-9aa5-5a07c87782a5@tavla.de>
 <d91f33df-e9d7-430a-b1ca-13cd1dee973a@gmail.com>
 <c5e790a5-2854-47a6-9431-e02a0f9e6676@tavla.de>
 <5efc11fc-9c21-44a0-b282-5d41bfb96a8c@gmail.com>
 <f496ad63-e2a6-46cb-b7d6-1a084523c7d9@broadcom.com>
 <1761198e-9f41-4e5a-b2b9-a1652732346d@gmail.com>
 <6898cd84-c7b9-4fa0-aeb5-c7a90d81b58b@tavla.de>
 <b0afc4f1-6496-48a4-a11c-789ee08368e4@tavla.de>
 <5a128900-432f-439e-9008-3b303ee72eb1@gmail.com>
 <2dacc589-9927-40f7-85ed-5f6b2afbbd41@tavla.de>
User-Agent: AquaMail/1.53.0 (build: 105300523)
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On October 21, 2024 3:34:46 PM Martin Petzold <martin.petzold@tavla.de> wrote:

> Hi Denis,
>
> Am 19.10.24 um 16:41 schrieb Denis Kenzior:
>>
>>>
>>> This is a more or less common setup for embedded environments. Would
>>> be glad if you could double-check if this could cause wrong initial
>>> connection (weaker AP).
>>
>> We can't help you unless you provide logs.
>
> We are now in an enterprise grade Cisco roaming environment. Initial
> connection to the (open) network was possible and routable with
> connection to our servers (!). However after like an hour or so the
> connection was lost. And then re-connection was NOT possible (both
> autoconnect and also not manual connect via iwctl fail).
>
> Please find attached the log output: logfile_tavla.txt (with brcm and

The log output is not hard to read. The brcmfmac indicates it does not 
support the requested akm suite 00-0F-AC:12 (Suite B 192b).

What capabilities does iw command show for the wifi device? Maybe the 
driver announces something which the firmware does not support.

Regards,
Arend
> iwd - no debug) and logfile_tavla_debug.txt (iwd with debug and manual
> re-connect attempt).
>
> I have now enabled "--debug" and it would also be possible to remove the
> network and do another full reproduction with initial connection.
>
> SETUP:
>
> SoM: Variscite DART-IMX8M-PLUS
> SoC: NXP i.MX8M Plus
> Wi-Fi Chip: Laird Sterling LWB5 (Infineon CYW43353)
> Antenna: Laird FlexPIFA
> RootFS: Debian bookworm
> Kernel: NXP Kernel 6.1.36 (with Variscite patches)
> Driver: brcmfmac (from Kernel, only minor patches - device tree)
> Firmware: Laird 12.29.0.22 (loaded via scripts)
> Network Daemon: systemd-networkd 252.30
> Wi-Fi Daemon: IWD 2.22+ (c459dc75c080dcbff6f9b9389344e11328dec411) + ELL
> 0.69 (7bed251f8020ef896043f008276f41cd13fdd43f)
>
> KERNEL:
>
> REPOSITORY=https://github.com/tavla/linux-imx.git (fork from
> https://github.com/varigit/linux-imx)
> BRANCH=lf-6.1.y_var03
> COMMIT=a4b3cc1dbbb396284e501b938aa79d2dfd4f1a98
>
> FIRMWARE:
>
> summit-lwb5-etsi-firmware-12.29.0.22.tar.bz2
>
> From:
> https://github.com/LairdCP/Sterling-LWB-and-LWB5-Release-Packages/releases/



