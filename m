Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8839610E5
	for <iwd@lists.linux.dev>; Fri,  3 Nov 2023 01:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRBsrP7D"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6ce2eaf7c2bso921116a34.0
        for <iwd@lists.linux.dev>; Thu, 02 Nov 2023 18:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698975653; x=1699580453; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BU7pTo0IJKOO8RGhemhzlVDQ1La5dS5TInf8eXAQoJo=;
        b=nRBsrP7DhZUEJFDINZMVsLS18ntDMsgfUiipcYq7FsH77Xx7vz62KAc9BtXKW6LdxF
         jiLu+NimLOpkEwwEmMGEHgC5Mr5oOSm0la5jlzf0dtw3d4GNbjRojrPmgg1fYF37MJsU
         V9f5Ee772DdcFYw+QMhcf/4zgit03BvWbydC6CE+ez01D8K3P9a3s5Ptq7M9lC5OnvkK
         mrJwhEVEMLgcoeQACCfoEghFgdxHBCn/f67jUs/aKb5Zms9/5blu3UBs5+Q52fRvxkkS
         kwvheKWpvI2wUsfy6zzsVCCY8wyblD75tHP4dJ8sWORh4aV9a61dK43qZpsQbiJVZat6
         k7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698975653; x=1699580453;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BU7pTo0IJKOO8RGhemhzlVDQ1La5dS5TInf8eXAQoJo=;
        b=HUaQWbBMVDy1zf2PqUvtM0lkdp+M1bp8liuIGTy4Ejd5y8+fL+cWuyTtwlxNdYDnJr
         3WsutRp6aerrbRROjoa13d4H0EvoOtOXGqKqL7J+IXxsyUsuxkow3NHGCH0/KVdKf2N6
         BnyC9kdUAHFG6kRhtaqx8R7po8YsomKYsT7udDQD6rov4+tSlx5POKIAUpuqgNQJAxIy
         5jIMPJfh0Ae7DOjyrpOprzsudESdjOQZKDgnJPnls1heUSn7JRaMrzz4ZPvst7YmZQpP
         8wvDSPVrONvfMvdKIqMvweJNOv44dMsGUQwMZ/GNnH7WBDTss6oRQ3U3l+eOclBE8gcJ
         CZDw==
X-Gm-Message-State: AOJu0YzvZgwaNmMoVdyjzK5wgpaNHZPmYYEJUkixDUpRzPQP2Z4VV8CK
	dl+FflCRk/gs0iaV8Mj4UGQ=
X-Google-Smtp-Source: AGHT+IHdeiOgOwQWAvvNK3UuhTtpnCXjCF1p94CIrOTwlRQ1kf+AipwOokxyTOkBa2xUYQ2XOGzNiA==
X-Received: by 2002:a05:6830:2693:b0:6b9:14bf:7097 with SMTP id l19-20020a056830269300b006b914bf7097mr23726872otu.9.1698975653621;
        Thu, 02 Nov 2023 18:40:53 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id c4-20020a9d6844000000b006cd0a56c406sm133829oto.60.2023.11.02.18.40.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 18:40:53 -0700 (PDT)
Message-ID: <35831f95-1271-411d-b875-40c3447c2b6c@gmail.com>
Date: Thu, 2 Nov 2023 20:40:51 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] dpp: remove scan_periodic_stop calls
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231031184750.722404-1-prestwoj@gmail.com>
 <20231031184750.722404-2-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231031184750.722404-2-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/31/23 13:47, James Prestwood wrote:
> Stopping periodic scans and not restarting them prevents autoconnect
> from working again if DPP (or the post-DPP connect) fails. Since
> the DPP offchannel work is at a higher priority than scanning (and
> since new offchannels are queue'd before canceling) there is no risk
> of a scan happening during DPP so its safe to leave periodic scans
> running.
> ---
>   src/dpp.c | 4 ----
>   1 file changed, 4 deletions(-)
> 

Patches 1 - 5 applied, thanks.

Regards,
-Denis

