Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A063717996
	for <iwd@lists.linux.dev>; Mon, 22 Jul 2024 11:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721647538; cv=none; b=b0qwEGGoAreJxeU9y8GNos9fY15st++RaHx9MSmAmdLprdUj3zAf4D8tU8eY8NNVIeNGob5GCDnEmqeW45kzmrVjJ8Y3D2/7jJ+Vg449UXTtRGz/GxiYDs5cAO+BDH8Wluu34iz1YTilCfRmwjPsZq8Y+ROjxhGhMhKbI39jBh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721647538; c=relaxed/simple;
	bh=6uIS7OIbQYr0Vl16kVLtxctEatD9OTz0hojKIPsZL7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=n9Eg2y2IKhBb/73xgaiG5vlf0mR4e2h4wupfUZznEY7T/sP2EagLA4/QquHB+S0PtKDrwtHPOGGPEksqr/8PkASH2tRtT2eqQUGrouL4wKiL2f2XGuTFLoPpnG3kfazeZABRGoCDKlr170D7LlKusPSnJFe2rTTsMsZzenx9EiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgjzWyEG; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgjzWyEG"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70d1d6369acso774554b3a.0
        for <iwd@lists.linux.dev>; Mon, 22 Jul 2024 04:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721647536; x=1722252336; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LJBA/UU2HmYUWnYJzC8kzIeBduKc1IcxxcJMR7S9EK0=;
        b=WgjzWyEGGXO/iMDx9b5lOweHs76cVNQLM17SkE9DoBU/rUyxbHow1oPdgJ0vt4c7Mq
         mOVYejzdu43Qg0J9k67/1i/NvIWb8adkqyD60ldkuVi0OTXUChbpeMKEqHoIt+4kwe3R
         cLM9vGqdVqTBK6UYyElsqloxBi3TIbc6HqdIrEr0PPMMzP9qOSxPWsknKPF4hHsAjw0u
         HcD0B+KyOwIBhtlWFhsSdUOzBCk7NT48EiYmTcg3bHgLC4bS98sycnY6mOr9kxmSMJBX
         9wn5QsEIAYQ3i4QMQQyboXHXZKseQ6HCct/A2b1h+m7TmxSwW9SkF+kqBIoyziltmYf/
         SWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721647536; x=1722252336;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LJBA/UU2HmYUWnYJzC8kzIeBduKc1IcxxcJMR7S9EK0=;
        b=Qgs7ptMfH1vtfIuKJ1cYDTakzwB4IxLoQZncJszDh1r6LvvQAI3kllEf5wykyX3qxD
         DGzKKeWyXY9j0lJriiGHxoQB4cAE2kjNlQhbce3n/FpXsHUp8VpUtrcmaAY25lhknF9n
         43AZiatvCwj0gWDdGZ3YgBKUaLbGUJYpsDFmxqPCC01bz+cGv33W4SkJgpBhBOuvvjqC
         v7LLa9Rglt0/1OCvTsaAx/DhcF89zBDY3lGuPNk7iAevEt3lXqziwDcUWceLKYGALATn
         bvvgFbwRPsKaYiGL3pihfVtLd3KF1jN3V/4JHUFUOpcn9jPRB4FP1bFEafpLhepBOMYY
         nSiA==
X-Forwarded-Encrypted: i=1; AJvYcCUukkVN08v8eG3/GeCUjSJWFWY/iYAtmVh+LDe6mHhFwK0iiBai8tLMwQgoLt377tYWImg8XyslTa0sWc037gCH/bvd
X-Gm-Message-State: AOJu0YwVnADL19uEYfcZoc0MVOrwB3f6XvSUBxsCiUI5MVYOn9SUtXLs
	RyUVvZmjkhXnDFrmJuPJwWA3sJWGRxEoEZAzqgwKS6VbdgpNK8i8ddezgA==
X-Google-Smtp-Source: AGHT+IENX3iagk2QqaUiNYFDb3hqe5i6zyWBsZSVuaA8h+UyfdIZv5YQtsvJo+VLSGn10e/+fXIZiA==
X-Received: by 2002:a17:903:187:b0:1f7:1bf3:db10 with SMTP id d9443c01a7336-1fd74d9d873mr141028215ad.20.1721647535680;
        Mon, 22 Jul 2024 04:25:35 -0700 (PDT)
Received: from [192.168.1.164] (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f434943sm52454615ad.200.2024.07.22.04.25.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 04:25:35 -0700 (PDT)
Message-ID: <d571910b-77c8-4e47-8741-01867c535398@gmail.com>
Date: Mon, 22 Jul 2024 04:25:34 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iwd 2.19 segfault?
To: Mogens Jensen <mogj@fastmail.com>, iwd@lists.linux.dev
References: <3554030d-7309-459c-8e91-ee34a0fe677b@app.fastmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <3554030d-7309-459c-8e91-ee34a0fe677b@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mogens,

On 7/19/24 10:45 PM, Mogens Jensen wrote:
> Hi,
>
> I'm using iwd 2.19 on kernel 6.6.40. Yesterday, after booting the
> system, no wlan interface was found. I have never experienced this
> situation before, system had not been updated recently and no recent
> configuration changes.
>
> Following was found in kernel message buffer:
>
> [   13.585766] wlan0: send auth to 00:16:3e:21:cf:ab (try 1/3)
> [   13.585997] traps: iwd[2446] general protection fault ip:55c8166f5107 sp:7ffde5888d90 error:0 in iwd[55c8166c8000+ea000]
> [   13.613989] wlan0: aborting authentication with 00:16:3e:21:cf:ab by local choice (Reason: 3=DEAUTH_LEAVING)
>
> Rebooting system and wlan interface was missing again. This time
> the message was different:
>
> [   11.623212] wlan0: send auth to 00:16:3e:21:cf:ab (try 1/3)
> [   11.623519] iwd[2443]: segfault at 1411 ip 0000000000001411 sp 00007ffc64376348 error 14 in iwd[55e26592f000+3000] likely on CPU 2 (core 2, socket 0)
> [   11.623558] Code: Unable to access opcode bytes at 0x13e7.
> [   11.657372] wlan0: aborting authentication with 00:16:3e:21:cf:ab by local choice (Reason: 3=DEAUTH_LEAVING)
>
> Rebooting system again and problem still persists:
>
> [   11.981208] wlan0: send auth to 00:16:3e:21:cf:ab (try 1/3)
> [   11.981515] traps: iwd[2442] general protection fault ip:558bac8fe107 sp:7ffdab42aca0 error:0 in iwd[558bac8d1000+ea000]
> [   11.997438] wlan0: aborting authentication with 00:16:3e:21:cf:ab by local choice (Reason: 3=DEAUTH_LEAVING)
>
> After a third reboot, the wlan interface was available again and
> everything works as normal. I have rebooted many times since, but the
> problem has not occured again.
>
> Any ideas on why this occured out of nowhere? Have you seen something
> like this before?

This really isn't much to go on. Are there any IWD logs? A stack trace? 
Core dump? etc.

Thanks,

James

>
> Thanks in advance.
>
>
> Regards,
> Mogens Jensen
>
