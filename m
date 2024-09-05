Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F5A145B2D
	for <iwd@lists.linux.dev>; Thu,  5 Sep 2024 03:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725506811; cv=none; b=MFMzArwJRXw2CSgTfTFv560cQmOlJDQ0dQLs5i18QL76bg0nvsGQCEViyzhNs4eVMd9DlKCDkj4FopyvD6ilEilRJMVOoDRE6YCdeM81/8WGrXTrvbP6p+ZVUEZYHxFKOvCPw35Oor6K8TiE6igvRXC5oZqgi0xkpsgaxphX3x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725506811; c=relaxed/simple;
	bh=1mo29bzW1nv8FQUG7hPMDGWIRR4nfw/Yusql04BF17g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fwgAeEtMX2Uwr2esRWCsaz8diWX1QyyOo8iIdvPKehYs+ZJlPhKBzYvp8puzXiQeyBOLibIfb9QzuFzPPwKiDERLGpw7WPzuOyJoscMgj3cmvyAOezGUXRMxW+Q0FYNDuqrosYPK8/3Kpd4vV4RDGZ9GoWH7fgCNxTA1C+kOfSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwZ/Rknt; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwZ/Rknt"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5df9dec9c0eso191091eaf.2
        for <iwd@lists.linux.dev>; Wed, 04 Sep 2024 20:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725506809; x=1726111609; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0wBz/vXk0Q3SNhOslAFGKEyTLG/FkTLKqaiFhzyh4bU=;
        b=KwZ/Rknt6sMsV5ICNEgckRjQeMkfC110avUY+3hKBj0LHDOIzF4+2Q2Y3k+tpavNI1
         5Qte5rpFknHKMPRf39X8rDYGOjnAqiitEd0RiShPMrsx3VnYpSBRC4+k+JnYP8ICADxl
         IQzwtJR8dqJQ9iBx8xgbRW2IeAlLu53pX/dTaXgPsP3ehycXK/Ll3rbKg9z92xN/My/a
         bPkX+J+NK/NyL7XxpGJSy6xRynjRPW4hsAK0kjNKTAwCrfM/iLAWUsynJfHcTXIhbozv
         /riuqsCtNWDWsKyStLc+I7lBuLuD9AMMwVI4a36n2ekRxbBKhQGyXNQ7Dr++FjJGqCC5
         bUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725506809; x=1726111609;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0wBz/vXk0Q3SNhOslAFGKEyTLG/FkTLKqaiFhzyh4bU=;
        b=cxPFMBa1paTqbG5cQFyf6gAEb5j8Qb5ga0n32GgLZH91j3777fhX9unOwrImC1O3fu
         fU3wdz4ypwdmV8SxfKgve9yIgWP+RH6bm3attyRao/58zJ045ggMA2mL3vcG0wXPGsTr
         A0mOryXlBKpmqLJdlACQD24zZx/Lg2T0WgQR6geajaQ5vVLlx+ncCtc2oD5BMZwLdWo3
         Sqq3onP9tU1Aldj0gSe0+pN9OUfA/DelaRbhbjPmlBxb6488cQXa0bNfLYFg+cK5iklC
         62UTau2hbWj6QFkrnO0Bg0xV8NuFNhKZwmVSA0ZIf49eNnBdfrXetGr5+eiBE6ekn8Eq
         oVPg==
X-Forwarded-Encrypted: i=1; AJvYcCXVvOlXTO9xwJ4doMhgbAbWM5KrqUUUuNo6qZifg3/7CCDt5pi4jWUV8TJZ0AEvm227MJ4=@lists.linux.dev
X-Gm-Message-State: AOJu0YyKTW4Jt2GCV6OOd32dV672zFXGGxulqZPfcvM3nOQc7B++515k
	p/LJpKusTKnqx6vs2SuAdqGV/rpT4q0GkLAppI3E73n8bFSTZAGP
X-Google-Smtp-Source: AGHT+IEh5Y1SmATvgNMvgAgXGjEgdezt4N8MpimSLaw6ti/eUwwfoMl4vif8NwanmAB+nA7fLvGTlg==
X-Received: by 2002:a05:6820:1b84:b0:5c4:2497:c92d with SMTP id 006d021491bc7-5dfacddf986mr21199623eaf.2.1725506809442;
        Wed, 04 Sep 2024 20:26:49 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-5dfa05805bbsm2603727eaf.45.2024.09.04.20.26.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 20:26:49 -0700 (PDT)
Message-ID: <4df9a767-f56a-44d1-a3d5-c9dd6e28fbe3@gmail.com>
Date: Wed, 4 Sep 2024 22:26:48 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] netdev: fall back to RSSI polling if SET_CQM fails
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240903180653.205405-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240903180653.205405-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/3/24 1:06 PM, James Prestwood wrote:
> Some drivers fail to set a CQM threshold and report not supported.
> Its unclear exactly why but if this happens roaming is effectively
> broken.
> 
> To work around this enable RSSI polling if -ENOTSUP is returned.
> The polling callback has been changed to emit the HIGH/LOW signal
> threshold events instead of just the RSSI level index, just as if
> a CQM event came from the kernel.
> ---
>   src/netdev.c | 158 +++++++++++++++++++++++++++++++++++----------------
>   1 file changed, 108 insertions(+), 50 deletions(-)
> 
> v4:
>   * Track the command IDs for SET_CQM
> 

Both applied, thanks.

Regards,
-Denis

