Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1994CB2B
	for <iwd@lists.linux.dev>; Tue,  3 Sep 2024 15:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376542; cv=none; b=HBDRCS7D/k4A9fsApxsLf+H5siB/6yzKaS7XaFvBDMxgF3NOI+h+DU21AUJ4MeOn5pj9NViQMiRU6IbiABRQAFDixweYNJAvJ2EnF0uXuO+GHjIhO5j1ml1JHw1ArY6JPuCXFb8BVz4jnpd89jXtZOdVwo9amaV1UUVpPwg4jzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376542; c=relaxed/simple;
	bh=C6g5hD9E41fc7lWyCEPrrB6Ac5lI/I64i640hbxL0DA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LksOCPOj5DMhvR/zCjJ7hHl59IaDMh6cXva7zJy8s9qhrz1JF479ihwyJ6G+vLN8IdD09mAeUXlgIOzcdXVUC7LmIHtRyUOOzCuwYLLP3VcgBREvsb2s9HSfnm9nviTwPw3OHzycpEjGuLBteoWrrbgFmYaxz94efjPfgOP9WGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fh7jl9Ci; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fh7jl9Ci"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3df03d1f1ddso3096483b6e.0
        for <iwd@lists.linux.dev>; Tue, 03 Sep 2024 08:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725376539; x=1725981339; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w/EGd0I2BEZ1oClXCnfudI+MmzH1w+9RVvBnq9DxSDs=;
        b=fh7jl9CiIIgtFA+roffj31h1ZTbZDGB2Cz4io6oFjrIraSacH5SdBoZgavR9XBVV0V
         0bdbvKSDiVxD2qyPav2yGqHCuGxfzFzDE5IoDbm5QYyodz1quwzb9jP5uz/oPZrMctW/
         9P79kNcsRcjsOUN5kE7tCbDxk0rOaITtlKM3nyNxmc25ZHVxPnQL7LuZtJ6TgV1cj2wt
         6+12wsF2BXlkJTNyx6l4l8pBB9or63gTLKcLw9R0Gux2XRndfMOC3zu98pXa2vD1s4YT
         uTx38s890gSc06XE4iuQeGmgNSX92aLlsSdbOYA60kysJ5BLYRNo8aaCzP4aUAGRhNTY
         2shA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725376539; x=1725981339;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w/EGd0I2BEZ1oClXCnfudI+MmzH1w+9RVvBnq9DxSDs=;
        b=XgJ5fMKHagcZd272Svedqpzv7fNnWRwPyrVC9k772avOyYC4iSiyGkne63OX43ttVc
         VJKiuy3OxXHy6BohugVX22PpMadOH7RXfnnY827tK82knEBmcfedptK+xDnt5ZylQzBo
         45WANcdDKouJhEQiS4i75HI1aWBi22rTGhfAQv0Vx9tgIrWcTAAMvdoX2naY1/W2tNT3
         SJ76pqTm4t0w9lShZxuPIMWXraWDkWlQxyi1vT4e8CddovnJ4i9FrgIOdZWFZBEfdAY/
         F+czSMYFUAV9eSVgb1rHuEWVIZ2NMj2UhIrb4FnWUX8PfzjFvyivlMgJaH4NoLxKCaCJ
         8dgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYWHANADydepwsfc5fw0cibI/QCiAz2VEgi4h1Pa+kjAuRNZy+DwDqHDNvLyQZQ3z9JRk=@lists.linux.dev
X-Gm-Message-State: AOJu0YySA+69psdMdB84Baat8peje6JwF8I/tyS72sOrQJ+mf5/lng8+
	V3xm0GXn7G9s0wAr/R3hN4pDAu6WHrfM+I7Z3v1xCra5LBkSqGbc4hmi1A==
X-Google-Smtp-Source: AGHT+IHR8KaoXa9UOU+f9f3mVQNnipGYL2Iq1ZOhi7K8KtA1S26TgnYPDLXUVqVKDI1bGeWCHsb5YQ==
X-Received: by 2002:a05:6808:309e:b0:3da:c428:1c51 with SMTP id 5614622812f47-3df05c302c8mr19069375b6e.8.1725376539498;
        Tue, 03 Sep 2024 08:15:39 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3df117c4c6esm2348292b6e.22.2024.09.03.08.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 08:15:39 -0700 (PDT)
Message-ID: <810c7737-2a26-4296-9ace-55b8d767cea8@gmail.com>
Date: Tue, 3 Sep 2024 10:15:38 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] netdev: fall back to RSSI polling if SET_CQM fails
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240829114102.56284-1-prestwoj@gmail.com>
 <20240829114102.56284-3-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240829114102.56284-3-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/29/24 6:41 AM, James Prestwood wrote:
> Some drivers fail to set a CQM threshold and report not supported.
> Its unclear exactly why but if this happens roaming is effectively
> broken.
> 
> To work around this enable RSSI polling if -ENOTSUP is returned.
> The polling callback has been changed to emit the HIGH/LOW signal
> threshold events instead of just the RSSI level index, just as if
> a CQM event came from the kernel.
> ---
>   src/netdev.c | 142 ++++++++++++++++++++++++++++++++++-----------------
>   1 file changed, 94 insertions(+), 48 deletions(-)
> 
> v3:
>   * Rebaed on top of upstream
> 

<snip>

> @@ -3672,7 +3718,7 @@ static int netdev_cqm_rssi_update(struct netdev *netdev)
>   		return -EINVAL;
>   
>   	if (!l_genl_family_send(nl80211, msg, netdev_cmd_set_cqm_cb,
> -				NULL, NULL)) {
> +				netdev, NULL)) {
>   		l_genl_msg_unref(msg);
>   		return -EIO;
>   	}
> @@ -5310,7 +5356,7 @@ int netdev_set_rssi_report_levels(struct netdev *netdev, const int8_t *levels,
>   		return -EINVAL;
>   
>   	if (!l_genl_family_send(nl80211, cmd_set_cqm, netdev_cmd_set_cqm_cb,
> -				NULL, NULL)) {
> +				netdev, NULL)) {
>   		l_genl_msg_unref(cmd_set_cqm);
>   		return -EIO;
>   	}

Since userdata is now used in these l_genl_family_send callbacks, you really 
should track the command id in case netdev gets removed.  Alternatively, switch 
netdev to start using a dedicated l_genl_family handle so that all outstanding 
requests get auto-canceled.

Regards,
-Denis
