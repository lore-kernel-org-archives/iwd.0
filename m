Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B20423A1
	for <iwd@lists.linux.dev>; Fri,  5 Aug 2022 17:21:54 +0000 (UTC)
Received: by mail-oi1-f174.google.com with SMTP id h125so3326894oif.8
        for <iwd@lists.linux.dev>; Fri, 05 Aug 2022 10:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=SZnjJC2ayGvomkdgyej8wAXYy2f2lLLKqGgRD8+xfnU=;
        b=YozjCi/OKOtKIKIH8XOlNBwWAfFqmOnDS8Yqu2AcUe1r4GD//qA/f/m4DJSmYtSktM
         75A0W2pjxAMazjE7jIQPG12ofmN27dNcQeweIN8oI6amxlyBrJmIYI4mljrhPV8q4NYI
         eHXzh/XXq10JwgW1QWb++kA673Uq+/MwEYWZKYpISmWGPGoSnQ5qw2I+BrdRG8Ye398z
         gF6bfxIVXgvhlnXUXOyPeVVCLUotBt976l5Y5IxUq6Kt5yz/iiSp/rYuG5lEiYs0Kvkh
         g/rOTCujY0ZiUFyWnxofDEQ+OwpXDo1BIlyjBcttfzI7bD/DrvAKAa1CudxLo5vj5upE
         Wwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=SZnjJC2ayGvomkdgyej8wAXYy2f2lLLKqGgRD8+xfnU=;
        b=4fTvFiHmfbkvLI+yvT8p+PdxaoANiFC5W0hunfTX35pGBmjydW1h0QleSVMwaQeuiG
         HPdFIQLsK2Lw6gC9t0cIltc4nIlV3vIKMXPdcxce22gn695Ymt9ce16coyZWwKS8JCB/
         aLt9yzIAgnJYVZ43yIRH0tyvSHjBidNOZ0okQLRR4o8SLTRwDyjIliIUu0qGoNAuMuxy
         LZS/+yKra3uklV+/9FS1saDdhxKanVtLjM9+eC/Vayt8kmqloR0P/bX1LckL8rQ05r84
         pcfz6kpDn2/S7w6luiPg66DBp1tzMeHBbUVrm/nqkXEUuOiCl4g30/T3O1MCAWU/Dm9U
         g49w==
X-Gm-Message-State: ACgBeo3K6rJhYCjyYjovOp/EfCNB/tIXU9eKgbAx2+KS2/48bDd2+haU
	8nFk7x/YUTUt9kDVV7Pbl64=
X-Google-Smtp-Source: AA6agR4WkoNLDQDi0RP4ys6sxU1J8jjUScU/CGZ1MThJb1K0GsoCjZJmBm79dmemtjbMp6XZbZJwRw==
X-Received: by 2002:a05:6808:ec8:b0:2f9:6119:d6ed with SMTP id q8-20020a0568080ec800b002f96119d6edmr6475378oiv.215.1659720113468;
        Fri, 05 Aug 2022 10:21:53 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id o2-20020a4a4402000000b00435a59fba01sm795510ooa.47.2022.08.05.10.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 10:21:53 -0700 (PDT)
Message-ID: <3397e656-b6ed-1fce-8be9-8b7a72caa48e@gmail.com>
Date: Fri, 5 Aug 2022 12:03:35 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 2/3] scan: split full scans by band to enable 6GHz
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220804220249.508207-1-prestwoj@gmail.com>
 <20220804220249.508207-2-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220804220249.508207-2-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/4/22 17:02, James Prestwood wrote:
> The kernel's regulatory domain updates after some number of beacons
> are processed. This triggers a regulatory domain update (and wiphy
> dump) but only after a scan request. This means a full scan started
> prior to the regdom being set will not include any 6Ghz BSS's even
> if the regdom was unlocked during the scan.
> 
> This can be worked around by splitting up a large scan request into
> multiple requests allowing one of the first commands to trigger a
> regdom update. Once the regdom updates (and wiphy dumps) we are
> hopefully still scanning and could append an additional request to
> scan 6GHz.
> ---
>   src/scan.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++------
>   1 file changed, 76 insertions(+), 9 deletions(-)
> 

<snip>

> +	/*
> +	 * Otherwise a full spectrum scan will likely open up the 6GHz
> +	 * band. The problem is the regdom update occurs after an
> +	 * individual scan request so a single request isn't going to
> +	 * include potential 6GHz results.
> +	 *
> +	 * Instead we can break this full scan up into individual bands
> +	 * and increase our chances of the regdom updating after one of
> +	 * the earlier requests. If it does update to allow 6GHz an
> +	 * extra 6GHz-only passive scan can be appended to this request
> +	 * at that time.
> +	 */
> +	subsets[0] = scan_freq_set_copy_bands(allowed, BAND_FREQ_2_4_GHZ);
> +	subsets[1] = scan_freq_set_copy_bands(allowed, BAND_FREQ_5_GHZ);

I updated these to use _clone() and ...

> +
> +	scan_freq_set_free(allowed);
> +
> +	for(i = 0; i < L_ARRAY_SIZE(subsets); i++) {
> +		scan_build_next_cmd(sr->cmds, sc, passive, params,
> +					subsets[i]);

added a scan_freq_set_isempty() check here to skip building the command in the 
unlikely event that the set is empty.

> +		scan_freq_set_free(subsets[i]);
> +	}
> +
> +	sr->split = true;
> +}
> +
>   static int scan_request_send_trigger(struct scan_context *sc,
>   					struct scan_request *sr)
>   {

Applied, thanks!

Regards,
-Denis
