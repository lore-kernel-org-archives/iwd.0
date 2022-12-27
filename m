Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549C733D1
	for <iwd@lists.linux.dev>; Tue, 27 Dec 2022 17:22:51 +0000 (UTC)
Received: by mail-ot1-f42.google.com with SMTP id x25-20020a056830115900b00670932eff32so8547746otq.3
        for <iwd@lists.linux.dev>; Tue, 27 Dec 2022 09:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wdmyu5Nb1mc2838xwrsY12vonS9y5dKxjsb/bRBY4M4=;
        b=LYnR0b/NdAs0VcxLamG7rTs+M8wj7emUMs1gvVLnm67oRpDMpGlVvT9lrS80UZBCdC
         FYZ1awYGBA0na77QuvZFbIeHTMYkELtRV+NVWdXByK8CBm9DtXOYWjzOlopVTLJmQfLz
         DUpz8cr+YPsiEcd+BzGx7IPE60a6jbM9lOCZWrgCrcrP/3t3hz7FTgQjUIhtQpgPaYbM
         Xu+kUH2NdvFvND0W7lTB5EqiM6zDYK+toTKud8PE2jEw2nQTEX7b58Yfdf5o/mkVLNwM
         DQbjAYofgU4RTFADUry0xQwe22XAl4mcEtSdycuaXzMDxK5MidqYRqxznA3K+WzwvqYr
         Pq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wdmyu5Nb1mc2838xwrsY12vonS9y5dKxjsb/bRBY4M4=;
        b=EkB7DFyVN4y+ZEbWSc5BuWOmePas1kKp74ZXNlMe/X/tlcEAsW4xVJrOkUkt3T2K2g
         dcF+t/NdKUZvYWQ9DZJWyn2lVXa1j+lYVHcPwXY5s8r+nt/2lcAeXbhscpgPknirGJii
         4puxCBU0HKCLdzUJGoMi448SzmOx8fTI/wmK5vmXEMs1rlz/Jb3yvlUY01oOHDFBPZBK
         Cybh4ujSmS0Gc9FCcvmF0zhgSKWUNGI6Y+yRZXgafzVdrvQM1LR6MEf73azP35rBzR+0
         0VwjyowPxN3tAMMNhca6e6qw4CgXfXqch+TUM4nugYbDePGPGllFrwLMRZaNJ7ne7BEK
         casA==
X-Gm-Message-State: AFqh2kpBv+Ru1yz9uG8umvL4YGxFGILGGPQAyuAqwn7aeXYsfh7G7hdF
	P52qKzeB8VhkzkrVpMqnPJA=
X-Google-Smtp-Source: AMrXdXsRaTRZvPp60YSZuqAT61ecNpE6DYKTPKLA0HVgcysKWYFeDMhwlo894VlQ89zPtblK4q9gNQ==
X-Received: by 2002:a9d:4ef:0:b0:670:583a:467e with SMTP id 102-20020a9d04ef000000b00670583a467emr9863897otm.13.1672161770472;
        Tue, 27 Dec 2022 09:22:50 -0800 (PST)
Received: from [10.0.2.15] (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.googlemail.com with ESMTPSA id q10-20020a9d7c8a000000b0066e64c59bbcsm6733516otn.6.2022.12.27.09.22.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Dec 2022 09:22:49 -0800 (PST)
Message-ID: <43d0a0c2-dcee-8d88-8145-972e48fba124@gmail.com>
Date: Tue, 27 Dec 2022 11:22:03 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 04/10] wiphy: add getter for HT capabilities
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20221220214318.2041986-1-prestwoj@gmail.com>
 <20221220214318.2041986-4-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221220214318.2041986-4-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 12/20/22 15:43, James Prestwood wrote:
> This adds some additional parsing to obtain the AMPDU parameter
> byte as well as wiphy_get_ht_capabilities() which returns the
> complete IE (combining the 3 separate kernel attributes).
> ---
>   src/wiphy.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   src/wiphy.h |  3 +++
>   2 files changed, 56 insertions(+)
> 

<snip>

> @@ -1617,6 +1653,23 @@ static void parse_supported_bands(struct wiphy *wiphy,
>   				memcpy(band->ht_capabilities, data, len);
>   				band->ht_supported = true;
>   				break;
> +			/*
> +			 * AMPDU factor/density are part of A-MPDU Parameters,
> +			 * 802.11-2020 Section 9.4.2.55.3.
> +			 */
> +			case NL80211_BAND_ATTR_HT_AMPDU_FACTOR:
> +				if (L_WARN_ON(len != 1))
> +					continue;
> +
> +				band->ht_ampdu_params |= l_get_u8(data) & 0x3;
> +				break;
> +			case NL80211_BAND_ATTR_HT_AMPDU_DENSITY:
> +				if (L_WARN_ON(len != 1))
> +					continue;
> +
> +				band->ht_ampdu_params |=
> +						(l_get_u8(data) & 0x7) >> 2;

So I think you meant to shift left here, i.e. ' << 2'.  I made amended this 
patch to reflect that.  Let me know if I'm incorrect about this.

> +				break;
>   			case NL80211_BAND_ATTR_IFTYPE_DATA:
>   				if (!l_genl_attr_recurse(&attr, &nested))
>   					continue;

Applied, thanks.

Regards,
-Denis
