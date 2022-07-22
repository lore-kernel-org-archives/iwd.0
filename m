Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBFA4A2C
	for <iwd@lists.linux.dev>; Fri, 22 Jul 2022 18:12:41 +0000 (UTC)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-10d9137bd2eso7252639fac.3
        for <iwd@lists.linux.dev>; Fri, 22 Jul 2022 11:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=zPvDJxSqKvxbNWXGm7lax/1XAuopqUfsEtLWJ9PTyi4=;
        b=XeytMiX/17F53bHEycEhfcyj+xQsf7HWNocJWe4p7jGw28pd1azC6pL70qFveXAY3+
         hp4/2gH1nqP/hJ3GW18aeDLYEEzzSzIeSa2rA3l1wVHuLgHjmHkwfBITdXCilATCHD2i
         iOQR829Lt8NIHgKSr9VcADhWX0yCjAeghyVwpkDykMZ50lSlOmcIk3Yq2mBCugtEJUEJ
         N8n0msgAiPfjL64PFyvcDMMZ/Yi7XcVIhx69L0bs/uNcChzmClpstM8AlVv2kNgBdgYH
         NGjIhGNOGaa2Q2QIKtf6Y9UlmJIhxyQrAk4qu97buIHGl5cmWo2oZL6BR+ZDOidu6BN+
         fGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zPvDJxSqKvxbNWXGm7lax/1XAuopqUfsEtLWJ9PTyi4=;
        b=cxRnOmdTAwOrZqrEANV81orzC1XQGKRGYP9pvKmKAY2Jl9xQQb798sHhGRttuBMni6
         1wTfnHDaecwpIxwC6jt6l0jKDJ6x/mBY5Z6obvK4p/nT6tb8RO54jnX0AvsBvk7wmMhW
         QcrcSGBGB759/b17s6fA2dIKLDRsD7ZWVy3u9+llBlPDaI+0qTDWaRkd9aV9qezQAk62
         oqUFipRBxdaohHyBCRY3Vt/1D7TBxuSTrLRa0qM1/7f2VtN6Rfal21lJaDfXPjaCYaaX
         RTPgnRsvCoBBTazmO+l4hwhlVsyaCzOKvKZrS3QQ57+2boUgQomrn53XnjKoyqMmnLCN
         nRxg==
X-Gm-Message-State: AJIora/NuQO+jT5jJkqLNDrZbG1ieA6u+lw1NbMY7IhyVLR6zDqjNi0+
	30Yn50gtLQctdGFKWGG/+GBH8bCGs5o=
X-Google-Smtp-Source: AGRyM1tZeZdxPdWBH/EJDHEVjBCWW/i7rH9+IHpPQbjVfpD2GFKUD9llWMasdjmJ5+a74VQG51ZI9w==
X-Received: by 2002:a05:6870:c227:b0:10b:f184:e12 with SMTP id z39-20020a056870c22700b0010bf1840e12mr677256oae.199.1658513560403;
        Fri, 22 Jul 2022 11:12:40 -0700 (PDT)
Received: from [10.0.2.15] ([136.32.1.70])
        by smtp.googlemail.com with ESMTPSA id ca23-20020a056830611700b0061c7ac52b75sm2367764otb.26.2022.07.22.11.12.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 11:12:40 -0700 (PDT)
Message-ID: <3e06e40c-d82d-d00a-5050-080668b68216@gmail.com>
Date: Fri, 22 Jul 2022 13:08:47 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 6/7] wiphy: track disabled frequencies on multiple dumps
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220722163417.1119334-1-prestwoj@gmail.com>
 <20220722163417.1119334-6-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220722163417.1119334-6-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 7/22/22 11:34, James Prestwood wrote:
> If a frequency is disabled, it should not be added to the supported list which
> it previously was. In this case its added to the (new) disabled_freqs list.
> 
> Now that wiphy's are dumped on regulatory changes frequencies may be added or
> removed from either the supported or disabled frequency list. These changes
> are now tracked to keep the lists accurate.
> ---
>   src/wiphy.c | 35 ++++++++++++++++++++++++++++++++---
>   src/wiphy.h |  1 +
>   2 files changed, 33 insertions(+), 3 deletions(-)
> 

<snip>

> +		/*
> +		 * Wiphy is dumped again on every regulatory domain change which
> +		 * may contain disabled frequencies which were previously
> +		 * allowed. If disabled, remove from supported. If supported,
> +		 * remove from disabled.
> +		 */

I would do this differently and leave 'supported_freqs' alone and only track the 
disabled freqs.

> +		if (disabled) {
> +			scan_freq_set_add(wiphy->disabled_freqs, freq);
> +			scan_freq_set_remove(wiphy->supported_freqs, freq);
> +		} else {
> +			scan_freq_set_add(wiphy->supported_freqs, freq);
> +			scan_freq_set_remove(wiphy->disabled_freqs, freq);
> +		}

Also you can simply clear the 'disabled_freqs' set on reg change, before parsing 
the disabled flags.

Then make sure wiphy_constrain_freq_set() takes everything into account. 
Perhaps we need a new scan_freq_set_* API?


>   	}
>   }
>   

Regards,
-Denis
