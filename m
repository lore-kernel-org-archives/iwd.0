Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4798C28DB1
	for <iwd@lists.linux.dev>; Thu,  4 Jan 2024 18:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+RM5OHA"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-204f50f305cso394190fac.3
        for <iwd@lists.linux.dev>; Thu, 04 Jan 2024 10:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704391225; x=1704996025; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Z1nWrrgQyld7YOF29aLPJHSs6SdGVxtNSrBg9ZvFlQ=;
        b=B+RM5OHAmSrxSGwaR0sOipm7Tll0YiX3O5fw2/TJQlMF2RPyGb0zowEoyWSE+SVzlQ
         VMdH+SPhqAYRV19ibseOuYnNHyVp5SRVI+8fufYh/OZD4i96yR+d3Vt+IPcbcabw5A/D
         k0QOcuSEjcAT5cPRpLobA3o0Pp6+4H2xNKcDHBooQppbt4kBIoSrhfpEv1yyXYSs40Og
         OI1pl/2kPF1TUbQcPB++57O9fSD2bcNtappxEWotf1qOpOd9XRV3g0tAZCzeApFKhplt
         xKM7YrrkcFkGWyjHx0ac/Obc3C7KL/FJ/x0ALaX0FllaSR9poQJU2LWpyyIp0S6fAZ5W
         0wYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704391225; x=1704996025;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Z1nWrrgQyld7YOF29aLPJHSs6SdGVxtNSrBg9ZvFlQ=;
        b=T3KVCeauvhkEIguoj730qzqqfZI4XLvKD5nXfYW+nauhJdSm9zszSOAkBIIyxzYA5i
         8ydWGOPT6cK14AC7M9t8/xVYL0j+/KKcoijhgZzvxcvqUAplQ8RebDCpnuvmDiME37kr
         Q5lMiZWGj5jMXr6+srZtLUa0gFiYr6A0HW/+/sEHKjlIe2uVNQ/+Vxz0X3dIpMUvj5t1
         AZ5P/jdUIVhaU10wqgbQ314JmnkjBy76PJQ1d/4BY/WFgn8kjLNzRWlrtKa2p9pHI/Wx
         aIzBurIqn2eT5yj+DVJ5IrHwkPUuNiCA0sMnGepRjnxulsIT+VYPuQMaXVwAtXCIqjOe
         knwA==
X-Gm-Message-State: AOJu0YyyuwJD6C3PATYvHqItFSY3IfhLb8lFgRGBwnu5HNMSouUZlwEl
	gpFnqO85WzzY+vKeLJdlpe9p8jSZacw=
X-Google-Smtp-Source: AGHT+IERJ99a4D3dOUVsy+Eun5LsEGZuwcRqMF5Ss7KCYqeVfiHj8BvJ8oxrHnQsWtE7iynqFPDQYw==
X-Received: by 2002:a05:6870:ae95:b0:203:dacd:d681 with SMTP id uw21-20020a056870ae9500b00203dacdd681mr960391oab.5.1704391225234;
        Thu, 04 Jan 2024 10:00:25 -0800 (PST)
Received: from [172.16.49.130] (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.googlemail.com with ESMTPSA id j25-20020a9d7f19000000b006dc004816b6sm2826072otq.74.2024.01.04.10.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 10:00:24 -0800 (PST)
Message-ID: <5d3e8db4-e848-40af-b760-00e5df64c8bc@gmail.com>
Date: Thu, 4 Jan 2024 12:00:24 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] auto-t: fix random testPSK-roam failure
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240103184638.533221-1-prestwoj@gmail.com>
 <20240103184638.533221-8-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240103184638.533221-8-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 1/3/24 12:46, James Prestwood wrote:
> This was caused by the unused hostapd instance running after being
> re-enabled by mistake. This cause an additional scan result with the
> same rank to be seen which would then be connected to by luck of the
> draw.
> ---
>   autotests/testPSK-roam/connection_test.py | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

