Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCD8111D
	for <iwd@lists.linux.dev>; Sun, 27 Aug 2023 19:19:21 +0000 (UTC)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5735282d713so1263322eaf.2
        for <iwd@lists.linux.dev>; Sun, 27 Aug 2023 12:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693163960; x=1693768760;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h4pTch1lvZjspJtJOo+fmxccXUyiEcFq1IQMrfgJ5wQ=;
        b=G329bsmuCfvE/ex1WTfwE2xmil/Oia8fB1nAGXckRWT67EA5N3CKCJ9vBxpVV03hyb
         zDT9AjEQNmOGMGrSeiQQRgeBkTX4ct1Hbnk9+8RYRURXAXh/EpXurKPgeI073tRhgyBp
         QWNrUvNzIlsgt7lohB2o5JPoyoqOZLHvs02DttnLJbJ5pHxrhYWZEnw3WtOcneXRO5Hc
         U8IWrK1LJcywTNFEEZ3XSvnIW+Wx7EaK1Glx/+OfQzIbNPMJVdWD4O96g1bvspQgomQI
         U/qXVnyMKoj2Kwslb7RTQ0jv/6TmpXlFE4yp+tYTqaUNtgCu3w5fOxRAdNL0v7IFou8q
         yq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693163960; x=1693768760;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h4pTch1lvZjspJtJOo+fmxccXUyiEcFq1IQMrfgJ5wQ=;
        b=MEyprz2MfVR+XFO7aAV4t6gHBmpXrIXgMAeWG4SwEwBQaYOQSBnIbWR94YEChh3RNj
         zIX9uXZ8LGX6wYGUAmwCoFgCQdHnRkj3jqB3Pmyxzq15vyFNZ1zRg8M+wTWTGCF0YW4P
         d+0+7lS+2jH4QyeyZybSG0Ucr2rPoywE5lIQMvxNAXDAfSoY0Keacod+CYsz68JupAXv
         E5bxGWfft45Y+qBaJ0JdobhvGuA4261z6owXLN7MfdzRw/CD1UD03zyXbhEnoLFa1Hoz
         /BpIbzgsSsrcj8n+735IgO6J0Fl8Z8frvwp55h8XZFejaMg0q/ueOqfHtDvbvf4zw4cp
         iBVw==
X-Gm-Message-State: AOJu0YyKbl93vfzgFN3qDx16ubhVD4OaBC3u7oeKHyPH6fL08VuzjPSD
	xCkA6+w7Iq7zXdaq+jmb7sA=
X-Google-Smtp-Source: AGHT+IHiS6qR1djYFjY66vy/OMjscf+KlsoQ0SU4qXyv9F+7zGI9lIE76Y5uVaqbNw1hwPy3UUT8Mw==
X-Received: by 2002:a4a:d1ca:0:b0:573:3fe0:cdd6 with SMTP id a10-20020a4ad1ca000000b005733fe0cdd6mr6578606oos.6.1693163960418;
        Sun, 27 Aug 2023 12:19:20 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 125-20020a4a0383000000b0057346742d82sm2721123ooi.6.2023.08.27.12.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Aug 2023 12:19:20 -0700 (PDT)
Message-ID: <4ed15cee-23cc-ded0-ef37-5e1f4424ddc6@gmail.com>
Date: Sun, 27 Aug 2023 14:19:19 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] station: fall back to reassociation under certain FT
 failures
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230822152931.276136-1-prestwoj@gmail.com>
 <20230822152931.276136-3-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230822152931.276136-3-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/22/23 10:29, James Prestwood wrote:
> The auth/action status is now tracked in ft.c. If an AP rejects the
> FT attempt with "Invalid PMKID" we can now assume this AP is either
> mis-configured for FT or is lagging behind getting the proper keys
> from neighboring APs (e.g. was just rebooted).
> 
> If we see this condition IWD can now fall back to reassociation in
> an attempt to still roam to the best candidate.
> 
> The motivation behind this isn't necissarily to always force a roam,

typo, 'necessarily'

> but instead to handle the case where there are no other BSS's
> around. Currently IWD can get into a situation where the current
> BSS link is very poor but the only cadidate is stuck in this state

typo, 'candidate'

> where its rejecting the PMKID. When this happens it eventually leads
> to a disconnect due to packet/beacon loss. Its a much better
> approach to at least try reassociation.

Okay, but you should really explain that what is the strategy if IWD has 
multiple FT candidates and the first (or many) reject the FT authentication step.

> ---
>   src/station.c | 129 ++++++++++++++++++++++++++++++++------------------
>   1 file changed, 82 insertions(+), 47 deletions(-)
> 
> diff --git a/src/station.c b/src/station.c
> index 2473de2a..733b4196 100644
> --- a/src/station.c
> +++ b/src/station.c
> @@ -147,15 +147,49 @@ struct roam_bss {
>   	uint8_t addr[6];
>   	uint16_t rank;
>   	int32_t signal_strength;
> +	bool reassoc: 1;
>   };
>   

<snip>

> -static void station_transition_start(struct station *station);
> +static void station_transition_start(struct station *station, bool no_ft);
>   
>   static bool station_ft_work_ready(struct wiphy_radio_work_item *item)
>   {
>   	struct station *station = l_container_of(item, struct station, ft_work);
> -	struct roam_bss *rbss = l_queue_pop_head(station->roam_bss_list);
> -	struct scan_bss *bss = network_bss_find_by_addr(
> -					station->connected_network, rbss->addr);
> +	L_AUTO_FREE_VAR(struct roam_bss *, rbss) = l_queue_pop_head(
> +							station->roam_bss_list);

_auto_(l_free) is prefered to L_AUTO_FREE_VAR

> +	struct scan_bss *bss;
>   	int ret;
>   
> -	l_free(rbss);
> +	/* Already failed FT, then failed reassociation, disregard this BSS */
> +	if (rbss->reassoc) {
> +		l_free(l_steal_ptr(rbss));
> +
> +		rbss = l_queue_pop_head(station->roam_bss_list);
> +		if (!rbss)
> +			goto assoc_failed;
> +	}
>   
>   	/* Very unlikely, but the BSS could have gone away */
> +	bss = network_bss_find_by_addr(station->connected_network, rbss->addr);
>   	if (!bss)
>   		goto try_next;
>   
>   	ret = ft_associate(netdev_get_ifindex(station->netdev), bss->addr);
> -	if (ret == -ENOENT) {
> +	if (ret > 0) {
> +		if (ret != MMPDU_STATUS_CODE_INVALID_PMKID) {
> +			station_debug_event(station, "ft-roam-failed");
> +			goto try_next;
> +		}
> +
> +		rbss->reassoc = true;
> +
> +		l_queue_push_head(station->roam_bss_list, rbss);
> +
> +		station_debug_event(station, "ft-fallback-to-reassoc");
> +
> +		/* FT failed, attempt reassociation as a last resort */
> +		station_transition_start(station, true);
> +		l_steal_ptr(rbss);
> +		return true;

So shouldn't you prefer FT over associate?  If there are multiple FT candidates, 
then should iwd try those first?

> +	} else if (ret == -ENOENT) {
>   		station_debug_event(station, "ft-roam-failed");
>   try_next:
> -		station_transition_start(station);
> +		station_transition_start(station, false);
>   		return true;
>   	} else if (ret < 0)
>   		goto assoc_failed;

Regards,
-Denis

