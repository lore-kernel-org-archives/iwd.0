Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FC41CBA1B
	for <iwd@lists.linux.dev>; Sat, 26 Oct 2024 08:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729931191; cv=none; b=U+SfLx0tqkjuQvCm7KRXGMTsurSoFceJqPdJD/q/7PeKUxnM55SByTomqDqPYWMGMe5Cp9vxABESNMf+fLf7wlXSDEXkTeG7inI9TycfVE6TBv8RPQIfaIHjDL3/zm8hNZVUgC/jswzvweSuq1Vp8S70zQif7HvOkKxP5aicC2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729931191; c=relaxed/simple;
	bh=Cc8YUuIM/P0aRqfNB1nt2DfCIyUfw/SsTpf0uk2S0uE=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=XDvoj/5fQ2bCKs6ov2Q3FYPbQg9ygMLz1mbaoJv8tURKKaz6bOlse7n9mXkEWWtCDcsPPqpyYe0AgNkQ+yE5lL+fSFTIBRr2kBjBg0YcfWW9YKvqVlImR6PgdEVV1EwBUXOIqPyL9F8EvBb8EiL4c/5bTK3ngVEiLh8e8I1NqcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UAE5TNv0; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UAE5TNv0"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9a26a5d6bfso406088666b.1
        for <iwd@lists.linux.dev>; Sat, 26 Oct 2024 01:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1729931185; x=1730535985; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YD9AV9V7Y7Iid5fGLUwefFk8IlLkHObAp3uHY2935SE=;
        b=UAE5TNv0SQov0pwuj3EwcP0uhyYBalwNxk+aDHFPMn15s026w15CPpq22Cc1mA4fNu
         BPKZb+VfxzcRLZFL4CFCXIiP17II3M63lFpTmBkE505nRLfY42rYKAbULYZqJMI8dAoN
         fVLnc3DhsKbI2f+L3hasB63uf/LSAY/f5onsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729931185; x=1730535985;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YD9AV9V7Y7Iid5fGLUwefFk8IlLkHObAp3uHY2935SE=;
        b=wVmYRC3OEdt3uerrA6h3p4CLQk0/86X1wQQBB6axQ9fimCG9ePtTy2JCR9J3oaWIwh
         r71wUb/CKH0S3cECmNO2plzvNljzy1nKrdLicS36YwS8jWJo5fS8A0HqRM+CstldkxF9
         gBQcSEqMrxD6Yl8dIM1pUvLcxT0NzYxiERKgPdDi/QLCClUqOhILxrJGkgl20HWElyPz
         MilTjUSBOajxTJXjUy0FrQnoWocmOjr73h+uIWU1orfIN2oZ47Cn9gi9oPzdxsrbtL52
         zEpKdMblE20KZ1GKzHGmTDIOVQHV6CHlkgLXdGSqigC0MtLAQKX33ZI+hFEaPQCaiuZ2
         /hFw==
X-Gm-Message-State: AOJu0YwlPCqbgDRKSQv4OslK6mn+5wKojzq2FomkmNl/cuCg2RfMbv7N
	q2icNAidl+/Tw63M/Raz0EeCUymJOzdc2GgvZ7oiKssSFnqSK0tCD6SlRCAjSjYS8RKwkzG7a6G
	HLg==
X-Google-Smtp-Source: AGHT+IE9DyEc8wj+46YbkUQy6yx95T1W3TmksfXNMrmQgXtsifygdZkgUK8J5rlnbzeu88BAlHbQ1Q==
X-Received: by 2002:a17:907:94d1:b0:a9a:161:7863 with SMTP id a640c23a62f3a-a9de61970f4mr110552866b.58.1729931184520;
        Sat, 26 Oct 2024 01:26:24 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb63475casm1349883a12.88.2024.10.26.01.26.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Oct 2024 01:26:23 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: James Prestwood <prestwoj@gmail.com>, Martin Petzold <martin.petzold@tavla.de>
CC: <iwd@lists.linux.dev>
Date: Sat, 26 Oct 2024 10:26:23 +0200
Message-ID: <192c7ef0398.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <a64c4733-9011-448c-ab75-8916ff339ac4@gmail.com>
References: <1147b5a6-883a-43be-a577-f16e9e6351ef@tavla.de>
 <7dbbd152-f251-414a-8d00-29c08bbb272e@tavla.de>
 <02bb45e1-cfef-433d-9a83-2b312c1ae064@gmail.com>
 <6d384377-ee6c-4a5d-8b67-75f367403acd@tavla.de>
 <d33154fa-9309-4285-a592-9e377e199f43@gmail.com>
 <57826e6a-8466-4e45-8906-6cb15968bcc8@tavla.de>
 <e19e7527-9cc1-4c84-95ac-dcb39f836d58@gmail.com>
 <78437e50-e6b1-4965-bd03-776fcf3c9801@tavla.de>
 <a64c4733-9011-448c-ab75-8916ff339ac4@gmail.com>
User-Agent: AquaMail/1.53.0 (build: 105300523)
Subject: Re: Connection loss (IWD HEAD with latest OWE / BSS selection patches) - brcmfmac driver
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On October 25, 2024 5:17:17 PM James Prestwood <prestwoj@gmail.com> wrote:

> On 10/25/24 8:03 AM, Martin Petzold wrote:
>> Hi James,
>>
>> Also, I have debugging for BRCM enabled (CONFIG_BRCMDBG=y and
>> CONFIG_DEBUG_FS=y). It sounds strange if there is no output, even not
>> before.
>
> Maybe Arend has some idea of why userspace could send a CMD_CONNECT and
> get no associated CMD_CONNECT event?
>
> The fact that even manually connecting didn't work after this happened
> tells me the driver is "stuck". Did you try cycling the driver with
> modprobe?

Do you boot your kernel with these options "debug ignore_level"? So 
CONFIG_BRCMDBG enables pr_debug() statement in the driver. However, you can 
select the type of debug messages with the "debug" module parameter. As 
mentioned earlier the bits are defined in debug.h.

#define BRCMF_TRACE_VAL 0x00000002
#define BRCMF_INFO_VAL 0x00000004
#define BRCMF_DATA_VAL 0x00000008
#define BRCMF_CTL_VAL 0x00000010
#define BRCMF_TIMER_VAL 0x00000020
#define BRCMF_HDRS_VAL 0x00000040
#define BRCMF_BYTES_VAL 0x00000080
#define BRCMF_INTR_VAL 0x00000100
#define BRCMF_GLOM_VAL 0x00000200
#define BRCMF_EVENT_VAL 0x00000400
#define BRCMF_BTA_VAL 0x00000800
#define BRCMF_FIL_VAL 0x00001000
#define BRCMF_USB_VAL 0x00002000
#define BRCMF_SCAN_VAL 0x00004000
#define BRCMF_CONN_VAL 0x00008000
#define BRCMF_BCDC_VAL 0x00010000
#define BRCMF_SDIO_VAL 0x00020000
#define BRCMF_MSGBUF_VAL 0x00040000
#define BRCMF_PCIE_VAL 0x00080000
#define BRCMF_FWCON_VAL 0x00100000

For this issue I suggest to use debug=0x9416. You could throw in FWCON bit 
to see error messages in firmware.

Regards,
Arend


