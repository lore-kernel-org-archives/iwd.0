Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8044204E
	for <iwd@lists.linux.dev>; Sun,  8 Sep 2024 22:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725834448; cv=none; b=u/cpesVslN4W9w3qqyxtpPkPVpXw6Ddao+I1pZiN0tDquikUbhdkBG/ZCcijlqayh+LjtvITffMvnoKjPrsRvr1V4ZAhjzSnMB/TJm/5plv0Fs4qKcQDbaDTplkQis/cdXV0ubYkqNmndud1xjDLiaYSm2wRgY4B6xJp7vhrHgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725834448; c=relaxed/simple;
	bh=kqwYE3hdSWWr5eQQtbHBXkuE+YIOI8+EOP2onKEYgkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SKsi5fGEPaG4W8ssShCQiFJYuEo+dv50cVVG5zZYhPEoSOVsksKoIfc2ThE9J5+XIm9mmE1NnJgss1dqyNpTFDKb1J830n/hUNB2/8mFA6VVSCWXoQ9BpEdMaq22nfGNuz5inNVz1V/8En15M+UFwsO8TlQ4v6zQrAAnfkqeXw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3NngkGT; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3NngkGT"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-710de2712eeso532455a34.3
        for <iwd@lists.linux.dev>; Sun, 08 Sep 2024 15:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725834446; x=1726439246; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WGuFajmKtRJQgp+T9UYtxeaRLJ2r7u6Anym/Ij+kKxA=;
        b=k3NngkGT8v6I/lEbk24CvEVbZ4OGncEVQSJL05/Dk4E0w3J5j9+kdYXKsIjzI15tpL
         g+pjWKNl6Y/DqV4jefZCncbPkDdry/mZWfbKm1fqk0d3UGtA+AHBr+BHMfFSKHV1gSft
         gUV3fm0CuEwMVRIr7jvaKRMr8BSa6ZWItsoTiR5irNgfmZK8+jxmYnjrnvZajEUYbr7O
         4NedeeA32suXNpKGocZeIn2sT0HOGs9My/oXhlBTBWskZ1lbVL5mxZrBmCbwlNl+vvB1
         V59HxC8IKUH1G8jQVTsnJEdfSZkM959jW5BDwenWJNmPbkX/ixijseH2DaHs27Zpy89E
         Xv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725834446; x=1726439246;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WGuFajmKtRJQgp+T9UYtxeaRLJ2r7u6Anym/Ij+kKxA=;
        b=PqSmsTzFIHsKUKcnaPqOtFMzlhxzdkQ4PcplZvhGtDGVRPu5OFjl/ayDe29RJBjt2l
         8g7lKiWMBTj9wtpZRyBK5KWeKmmfGtPauQAsQK8HPQTx3f0NNfDnzhh5tw7dz+cuVE3W
         o+UAXyq2sHh04flZM0cQSX2DyTIwhuT739mehkhaYhtdfG+rqZsqZY+XviHme5Yj8ci+
         un2sj795Ug9tuKAFJ9xDQjRJxFPLukX0rVIucz7178nZWRGjYKJMg2YQurhHE3TPG+0q
         OARYcdWVZLSf1cG9X//gjIyZeofLJIGDt2tS7oUzIpmuSMPKaZXy3W/W4yfHNMqVqbdC
         b9iA==
X-Forwarded-Encrypted: i=1; AJvYcCX47XU4pSOhwV8DZX4t2hOTiKA53VUBs18bZu9wuo3Mv+nsPoDKSE1Poty7jCQJluV53v8=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywux3ugkDUz2jex66hBj0dR09hincwys91CJkVnmWqy/5FXQmLD
	bpolGIactj7bsFxCOkSiGmcSCNv/fE8sy+8qDia7aCUq04Oky9Tt
X-Google-Smtp-Source: AGHT+IHgIZOD5gAsE7nfcM1s84PKdVD7gxIJ6q8PtKTOxdIOkrCIaFyjVCU9Nm41M4lVK3bBYxzQYA==
X-Received: by 2002:a05:6830:210c:b0:70b:354f:333a with SMTP id 46e09a7af769-710d5d0d563mr8218555a34.30.1725834446338;
        Sun, 08 Sep 2024 15:27:26 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-710d9d21074sm1063150a34.12.2024.09.08.15.27.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Sep 2024 15:27:26 -0700 (PDT)
Message-ID: <81a8c066-cd47-4c42-9c51-6862fb446f9e@gmail.com>
Date: Sun, 8 Sep 2024 17:27:25 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dpp: set cap on the PKEX timeout, and reduce once PKEX
 finishes
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240906190514.620603-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240906190514.620603-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/6/24 2:05 PM, James Prestwood wrote:
> If we scan a huge number of frequencies the PKEX timeout can get
> rather large. This was overlooked in a prior patch who's intent
> was to reduce the PKEX time, but in these cases it increased it.
> Now the timeout will be capped at 2 minutes, but will still be
> as low as 10 seconds for a single frequency.
> 
> In addition there was no timer reset once PKEX was completed.
> This could cause excessive waits if, for example, the peer left
> the channel mid-authentication. IWD would just wait until the
> long PKEX timeout to eventually reset DPP. Once PKEX completes
> we can assume that this peer will complete authentication quickly
> and if not, we can fail.
> ---
>   src/dpp.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

