Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE3430677
	for <iwd@lists.linux.dev>; Thu, 16 Nov 2023 15:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/zqNT6q"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5872b8323faso456215eaf.1
        for <iwd@lists.linux.dev>; Thu, 16 Nov 2023 07:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700149864; x=1700754664; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FVpMnurLoAMDWkonM6+vBwwM3uWZ0RmRQYpgytCtN+M=;
        b=k/zqNT6qFiD8jAo9vACyQgH7w4STuaZtLUOWdswzkkpx3de867upXokSC4YFpF4gsQ
         cp3jmC6HwspUwboVapTG6v46CzBQl2Zx6zEnONeWHQGMH/vRdI64yXAhLbSY0+glo49A
         u87R5AzPBIL7lhsp/StNdfrnr/u0+5k3fr2XSXBMY+zZycezmSZc9FmN6ObrCP+JPyuY
         DxTwuINhYL/cGw8nKD3iOeFYisktC1K1N7gVupJgSST8iOXkALBkmafRVCAWwgEzFLN+
         SDdtB0PAulLs6Tq9gmprr16xVGBJlg1vr5Bp65pNHWKF+wlm90hG0gdE1PhI+94TyI4w
         S2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700149864; x=1700754664;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FVpMnurLoAMDWkonM6+vBwwM3uWZ0RmRQYpgytCtN+M=;
        b=wzHZ9Z7wI1Ibm3CNNpFlXASuqOczTC0uXHUFEQXFVFVI0AwDbqLeMx3L+Wou9lBTHD
         fmc/R5kx0aSJhPmh2bYng5HDTW3XxO38Xa1N+GG20/MZ/28JQBemLRZd3yLtLGsRMHvT
         p06AiLKmc64+anlN6AekhY+DwO+l3Ky3XGH0m4ocrx+rfH3QNlAP6y2ulbxNOfJclQtM
         ODcXrZSHLFQ5NxV1aaX14iuTfGBVgDLxSlieKg/Eg29pzcbhS93VwdTIBSTIAxQm+4k9
         7kQnHxG9FS+22tV1N/riuu41JxE20/uxE+PvY0V/l9Fl7jlgyDdVmhY/4huZewUAaKYb
         1Dgg==
X-Gm-Message-State: AOJu0YzCFhRG2jeCG/Q/Ecimp0W5rwVEw9nOdqRmf7XJINBqFtMj8fqL
	KNiShxIk0OlB1IiIn2TanXOV4hqXa8A=
X-Google-Smtp-Source: AGHT+IGJmnId/2bd1zhOZOq9tumggSRGRyTbpurTfg0KjA725FMZYfCwFAkrSEn4yif8U6Hf+cwoUQ==
X-Received: by 2002:a4a:ea0f:0:b0:587:2b3c:e11f with SMTP id x15-20020a4aea0f000000b005872b3ce11fmr18267681ood.0.1700149864117;
        Thu, 16 Nov 2023 07:51:04 -0800 (PST)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id a2-20020a4ad5c2000000b00586d187ed06sm1089648oot.48.2023.11.16.07.51.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 07:51:03 -0800 (PST)
Message-ID: <210c60de-f02c-4ba4-bb66-17c54a2f0f29@gmail.com>
Date: Thu, 16 Nov 2023 09:51:01 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dpp: check for non-utf8 SSID's in scan results
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231116154439.33880-1-prestwoj@gmail.com>
 <20231116154439.33880-2-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231116154439.33880-2-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 11/16/23 09:44, James Prestwood wrote:
> In theory this shouldn't be possible because the configuration object
> validates that the SSID is utf-8. But it doesn't hurt to check
> especially since we can't control what the kernel sends us.
> ---
>   src/dpp.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/src/dpp.c b/src/dpp.c
> index 18b2a7c6..8da79603 100644
> --- a/src/dpp.c
> +++ b/src/dpp.c
> @@ -884,6 +884,9 @@ static bool dpp_scan_results(int err, struct l_queue *bss_list,
>   	/* Purely for grabbing the SSID */
>   	bss = l_queue_peek_head(bss_list);
>   
> +	if (L_WARN_ON(!util_ssid_is_utf8(bss->ssid_len, bss->ssid)))
> +		goto reset;
> +

This still seems brittle.  You have the validated SSID from the DPP session, 
shouldn't you be storing that and using it to filter the scan results?  There's 
no guarantee that a filtered active scan is going to return only the SSID you 
asked for (lets say a misbehaving or malicious AP), so assuming that the first 
BSS in the scan results list is the SSID you want isn't really guaranteed.

>   	memcpy(ssid, bss->ssid, bss->ssid_len);
>   	ssid[bss->ssid_len] = '\0';
>   

Regards,
-Denis
