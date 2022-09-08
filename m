Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD6E3D65
	for <iwd@lists.linux.dev>; Thu,  8 Sep 2022 16:02:19 +0000 (UTC)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-11e9a7135easo45547199fac.6
        for <iwd@lists.linux.dev>; Thu, 08 Sep 2022 09:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=rI7iJ6YfXj8N64m9DBtFc7/aeA/N7GkdRmMJ221B4JY=;
        b=NrXrTFSu51BJb3VPMh1epAT1M4kXwMZBx4PIYi6AvvGU7D0WdoNFS4GVKBiBz1UrfU
         Vc/bncJki3NtCGvrza10vo7ZVktTtzV4A072Jha+r+9W5gf+z3YP9WMoAAFIk2upE2gd
         yi6Xz797M0I/Lpvi9W3WSiHAwGLDN4yuQLmP9zpZfVMqGKV4LRHpzkiNYZc2+sAthIgK
         4t1qGMD+fNPBCqvREMWaop3RGN3X3gl/Ew3ERU89pQ2PPlAyq+QokTYMPkSkkQRbmt/b
         638oX70PFK9L7TrqARyO9r1om+B5w+ZVYUTr417Z2ctj94bqeMZkLTZz4U8MDj1en6AG
         D8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=rI7iJ6YfXj8N64m9DBtFc7/aeA/N7GkdRmMJ221B4JY=;
        b=mrlnspFKkCm13hCG1DzLLER+aJNEBtFJb0eJfoUy6RxB3Xgr4UBfuLao/bxmG+R6dO
         gzForuyRK+IXu8/52ag+rffMV1VPa5HJZOaUlBvwZK/Ol0H4nXSgPmtBz3VLpUvHpg3C
         uAu8wJmlYnzHntScrsLQoJqZ3BaLBdQ1FPqB7yLOtTbKs648zdp+oOUUmg6JgMcEalnE
         lAz7Af02O3u5k3KzbxoVnBnEfm0gMMfVf9NBugj14dOqsUo96rhNTjFUwsNrQAaEv+gg
         58hm8MJeM8wwDmo+Jxs6mUR3g6iNtLMxvStHV7VkFWIluFtCzWuq5ix96cnVVKGxDL7y
         0GlQ==
X-Gm-Message-State: ACgBeo2cf1RZkZyQjVtn2oUCm9IYfMrvcFfOs5sBGqyz4qytmQ2SFANI
	vopRYSLbuOvLqm+k9MPKeVePj2kHVAM=
X-Google-Smtp-Source: AA6agR5yKIR4DYRzCfaIzpEyIxYsLiZ9BNOP4ZR5pSpIc/S0MykY4c6sTxHJgtBWMmFZpbtLazf9cw==
X-Received: by 2002:a05:6808:1b0c:b0:345:2df:b297 with SMTP id bx12-20020a0568081b0c00b0034502dfb297mr1918433oib.236.1662652938717;
        Thu, 08 Sep 2022 09:02:18 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id z1-20020a544581000000b00344fd6af70fsm7622066oib.14.2022.09.08.09.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 09:02:18 -0700 (PDT)
Message-ID: <d48235f0-3251-0726-8dba-cf5f91f8b2da@gmail.com>
Date: Thu, 8 Sep 2022 10:55:57 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/4] wiphy: only do global GET_REG once
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220907233201.227577-1-prestwoj@gmail.com>
 <20220907233201.227577-3-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220907233201.227577-3-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/7/22 18:32, James Prestwood wrote:
> Getting the regulatory domain for self-managed wiphys requires
> providing the wiphy ID, but this is not the case for any device
> under the global regulatory domain. This is not tied to any
> specific wiphy so there is no need to supply a wiphy ID or do
> a dump for each wiphy.

Are you sure?  I have an ath9k which isn't self-managed, but doesn't fall under 
the global regulatory domain:

denkenz@iwd-test ~/iwd $ iw reg get
global
country US: DFS-FCC
	(902 - 904 @ 2), (N/A, 30), (N/A)
	(904 - 920 @ 16), (N/A, 30), (N/A)
	(920 - 928 @ 8), (N/A, 30), (N/A)
	(2400 - 2472 @ 40), (N/A, 30), (N/A)
	(5150 - 5250 @ 80), (N/A, 23), (N/A), AUTO-BW
	(5250 - 5350 @ 80), (N/A, 24), (0 ms), DFS, AUTO-BW
	(5470 - 5730 @ 160), (N/A, 24), (0 ms), DFS
	(5730 - 5850 @ 80), (N/A, 30), (N/A), AUTO-BW
	(5850 - 5895 @ 40), (N/A, 27), (N/A), NO-OUTDOOR, AUTO-BW, PASSIVE-SCAN
	(5925 - 7125 @ 320), (N/A, 12), (N/A), NO-OUTDOOR, PASSIVE-SCAN
	(57240 - 71000 @ 2160), (N/A, 40), (N/A)

phy#3
country 99: DFS-UNSET
	(2402 - 2472 @ 40), (N/A, 20), (N/A)
	(2457 - 2482 @ 40), (N/A, 20), (N/A), PASSIVE-SCAN
	(5140 - 5360 @ 80), (N/A, 30), (N/A), PASSIVE-SCAN
	(5460 - 5860 @ 80), (N/A, 30), (N/A), PASSIVE-SCAN

> 
> Now GET_REG will be tracked globally if its a global call and
> will only be called once.

GET_REG acts like a dump.  Is there really any harm in using the wiphy id?

> ---
>   src/wiphy.c | 35 ++++++++++++++++++++++++++++-------
>   1 file changed, 28 insertions(+), 7 deletions(-)
> 
> diff --git a/src/wiphy.c b/src/wiphy.c
> index f295d87d..af675694 100644
> --- a/src/wiphy.c
> +++ b/src/wiphy.c
> @@ -64,6 +64,7 @@ static struct l_hwdb *hwdb;
>   static char **whitelist_filter;
>   static char **blacklist_filter;
>   static int mac_randomize_bytes = 6;
> +static unsigned int get_reg_id;
>   static char regdom_country[2];
>   static uint32_t work_ids;
>   static unsigned int wiphy_dump_id;
> @@ -2076,7 +2077,10 @@ static void wiphy_get_reg_cb(struct l_genl_msg *msg, void *user_data)
>   	uint32_t tmp;
>   	bool global;
>   
> -	wiphy->get_reg_id = 0;
> +	if (wiphy)
> +		wiphy->get_reg_id = 0;
> +	else
> +		get_reg_id = 0;
>   
>   	/*
>   	 * NL80211_CMD_GET_REG contains an NL80211_ATTR_WIPHY iff the wiphy
> @@ -2091,16 +2095,28 @@ static void wiphy_get_reg_cb(struct l_genl_msg *msg, void *user_data)
>   static void wiphy_get_reg_domain(struct wiphy *wiphy)
>   {
>   	struct l_genl_msg *msg;
> +	unsigned int id;
> +
> +	/* Already doing a global dump */
> +	if (!wiphy && get_reg_id)
> +		return;
>   
>   	msg = l_genl_msg_new(NL80211_CMD_GET_REG);
> -	l_genl_msg_append_attr(msg, NL80211_ATTR_WIPHY, 4, &wiphy->id);
>   
> -	wiphy->get_reg_id = l_genl_family_send(nl80211, msg, wiphy_get_reg_cb,
> -						wiphy, NULL);
> -	if (!wiphy->get_reg_id) {
> -		l_error("Error sending NL80211_CMD_GET_REG for %s", wiphy->name);
> +	if (wiphy)
> +		l_genl_msg_append_attr(msg, NL80211_ATTR_WIPHY, 4, &wiphy->id);
> +
> +	id = l_genl_family_send(nl80211, msg, wiphy_get_reg_cb, wiphy, NULL);
> +	if (!id) {
> +		l_error("Error sending NL80211_CMD_GET_REG for %s",
> +				wiphy ? wiphy->name : "(global)");
>   		l_genl_msg_unref(msg);
>   	}
> +
> +	if (wiphy)
> +		wiphy->get_reg_id = id;
> +	else
> +		get_reg_id = id;
>   }
>   
>   void wiphy_create_complete(struct wiphy *wiphy)
> @@ -2117,7 +2133,7 @@ void wiphy_create_complete(struct wiphy *wiphy)
>   
>   	wiphy_set_station_capability_bits(wiphy);
>   	wiphy_setup_rm_enabled_capabilities(wiphy);
> -	wiphy_get_reg_domain(wiphy);
> +	wiphy_get_reg_domain(wiphy->self_managed ? wiphy : NULL);
>   
>   	wiphy_print_basic_info(wiphy);
>   }
> @@ -2519,6 +2535,11 @@ static void wiphy_exit(void)
>   		wiphy_dump_id = 0;
>   	}
>   
> +	if (get_reg_id) {
> +		l_genl_family_cancel(nl80211, get_reg_id);
> +		get_reg_id = 0;
> +	}
> +
>   	l_queue_destroy(wiphy_list, wiphy_free);
>   	wiphy_list = NULL;
>   

Regards,
-Denis
